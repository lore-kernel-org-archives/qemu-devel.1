Received: from eggs.gnu.org ([2001:4830:134:3::10]:34988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxkr-0006fS-0b
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxkp-0001j9-NK
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:01:17 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:32928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHxkp-0001ia-8a
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:01:15 -0500
Received: by mail-ua0-x229.google.com with SMTP id b35so19255938uaa.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 11:01:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161209114830.9158-5-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
	<20161209114830.9158-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 19:00:53 +0000
Message-ID: <CAFEAcA8cnxe6+3L2EBvavLbbWgiWN7r=rvjn-Vav7oJZBXEi-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v3 04/10] risu: add simple trace and
 replay support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

On 9 December 2016 at 11:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> This adds a very dumb and easily breakable trace and replay support. In
> --master mode the various risu ops trigger a write of register/memory
> state into a binary file which can be played back to an apprentice.
> Currently there is no validation of the image source so feeding the
> wrong image will fail straight away.
>
> The trace files will get very big for any appreciable sized test file
> and this will be addressed in later patches.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Most of this looks good.

> ---
>
> v2
>   - moved read/write functions into main risu.c
>   - cleaned up formatting
>   - report more in apprentice --trace mode
> v3
>   - fix options parsing
>   - re-factored so no need for copy & paste
> ---
>  risu.c         | 108 +++++++++++++++++++++++++++++++++++++++++++++++----=
------
>  risu_aarch64.c |   5 ++-
>  risu_arm.c     |   4 +--
>  3 files changed, 93 insertions(+), 24 deletions(-)
>
> diff --git a/risu.c b/risu.c
> index 22571cd..173dd3c 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -31,6 +31,7 @@
>  void *memblock =3D 0;
>
>  int apprentice_socket, master_socket;
> +int trace_file =3D 0;
>
>  sigjmp_buf jmpbuf;
>
> @@ -40,10 +41,12 @@ int test_fp_exc =3D 0;
>  long executed_tests =3D 0;
>  void report_test_status(void *pc)
>  {
> -   executed_tests +=3D 1;
> -   if (executed_tests % 100 =3D=3D 0) {
> -      fprintf(stderr,"Executed %ld test instructions (pc=3D%p)\r",
> -              executed_tests, pc);
> +   if (ismaster || trace_file) {
> +      executed_tests +=3D 1;
> +      if (executed_tests % 100 =3D=3D 0) {
> +         fprintf(stderr,"Executed %ld test instructions (pc=3D%p)\r",
> +                 executed_tests, pc);
> +      }
>     }
>  }
>
> @@ -54,6 +57,12 @@ int read_sock(void *ptr, size_t bytes)
>     return recv_data_pkt(master_socket, ptr, bytes);
>  }
>
> +int write_trace(void *ptr, size_t bytes)
> +{
> +   size_t res =3D write(trace_file, ptr, bytes);
> +   return (res =3D=3D bytes) ? 0 : 1;
> +}
> +
>  void respond_sock(int r)
>  {
>     send_response_byte(master_socket, r);
> @@ -66,26 +75,62 @@ int write_sock(void *ptr, size_t bytes)
>     return send_data_pkt(apprentice_socket, ptr, bytes);
>  }
>
> +int read_trace(void *ptr, size_t bytes)
> +{
> +   size_t res =3D read(trace_file, ptr, bytes);
> +   return (res =3D=3D bytes) ? 0 : 1;
> +}
> +
> +void respond_trace(int r)
> +{
> +   switch (r) {
> +      case 0: /* test ok */
> +      case 1: /* end of test */
> +         break;
> +      default:
> +         fprintf(stderr,"%s: got response of %d\n", __func__, r);

Is this a "something is broken/can't happen" case?

Anyway, you're in a signal handler so shouldn't use fprintf.

> +         break;
> +   }
> +}
> +
>  void master_sigill(int sig, siginfo_t *si, void *uc)
>  {
> -   switch (recv_and_compare_register_info(read_sock, respond_sock, uc))
> +   int r;
> +
> +   if (trace_file) {
> +      r =3D send_register_info(write_trace, uc);
> +   } else {
> +      r =3D recv_and_compare_register_info(read_sock, respond_sock, uc);
> +   }
> +
> +   switch (r)
>     {
>        case 0:
> -         /* match OK */
> +         /* All OK */
>           advance_pc(uc);
>           return;
>        default:
>           /* mismatch, or end of test */
>           siglongjmp(jmpbuf, 1);
> +         /* never */
> +         return;

Is your compiler complaining about this? You should probably
get a better compiler (others will likely complain that the
return is dead, because siglongjmp is marked 'noreturn' in the
system headers).

>     }
>  }
>
>  void apprentice_sigill(int sig, siginfo_t *si, void *uc)
>  {
> -   switch (send_register_info(write_sock, uc))
> +   int r;
> +
> +   if (trace_file) {
> +      r =3D recv_and_compare_register_info(read_trace, respond_trace, uc=
);
> +   } else {
> +      r =3D send_register_info(write_sock, uc);
> +   }
> +
> +   switch (r)
>     {
>        case 0:
> -         /* match OK */
> +         /* All OK */
>           advance_pc(uc);
>           return;
>        case 1:
> @@ -94,6 +139,9 @@ void apprentice_sigill(int sig, siginfo_t *si, void *u=
c)
>           exit(0);
>        default:
>           /* mismatch */
> +         if (trace_file) {
> +            report_match_status();
> +         }
>           exit(1);
>     }
>  }
> @@ -155,7 +203,13 @@ int master(int sock)
>  {
>     if (sigsetjmp(jmpbuf, 1))
>     {
> -      return report_match_status();
> +      if (trace_file) {
> +         close(trace_file);
> +         fprintf(stderr,"\nDone...\n");
> +         return 0;
> +      } else {
> +         return report_match_status();
> +      }
>     }
>     master_socket =3D sock;
>     set_sigill_handler(&master_sigill);
> @@ -184,6 +238,7 @@ void usage (void)
>     fprintf(stderr, "between master and apprentice risu processes.\n\n");
>     fprintf(stderr, "Options:\n");
>     fprintf(stderr, "  --master          Be the master (server)\n");
> +   fprintf(stderr, "  -t, --trace=3DFILE  Record/playback trace file\n")=
;
>     fprintf(stderr, "  -h, --host=3DHOST   Specify master host machine (a=
pprentice only)\n");
>     fprintf(stderr, "  -p, --port=3DPORT   Specify the port to connect to=
/listen on (default 9191)\n");
>  }
> @@ -194,6 +249,7 @@ int main(int argc, char **argv)
>     uint16_t port =3D 9191;
>     char *hostname =3D "localhost";
>     char *imgfile;
> +   char *trace_fn =3D NULL;
>     int sock;
>
>     // TODO clean this up later
> @@ -204,13 +260,14 @@ int main(int argc, char **argv)
>           {
>              { "help", no_argument, 0, '?'},
>              { "master", no_argument, &ismaster, 1 },
> +            { "trace", required_argument, 0, 't' },
>              { "host", required_argument, 0, 'h' },
>              { "port", required_argument, 0, 'p' },
>              { "test-fp-exc", no_argument, &test_fp_exc, 1 },
>              { 0,0,0,0 }
>           };
>        int optidx =3D 0;
> -      int c =3D getopt_long(argc, argv, "h:p:", longopts, &optidx);
> +      int c =3D getopt_long(argc, argv, "h:p:t:", longopts, &optidx);
>        if (c =3D=3D -1)
>        {
>           break;
> @@ -223,6 +280,11 @@ int main(int argc, char **argv)
>              /* flag set by getopt_long, do nothing */
>              break;
>           }
> +         case 't':
> +         {
> +           trace_fn =3D optarg;
> +           break;
> +         }
>           case 'h':
>           {
>              hostname =3D optarg;
> @@ -253,18 +315,28 @@ int main(int argc, char **argv)
>     }
>
>     load_image(imgfile);
> -
> +
>     if (ismaster)
>     {
> -      fprintf(stderr, "master port %d\n", port);
> -      sock =3D master_connect(port);
> -      return master(sock);
> +     if (trace_fn)
> +       {
> +         trace_file =3D open(trace_fn, O_WRONLY|O_CREAT, S_IRWXU);
> +       } else {
> +         fprintf(stderr, "master port %d\n", port);
> +         sock =3D master_connect(port);
> +       }

GNU coding standards indentation ? I know risu's indenting
is a bit of a mess but we have not quite sunk that low yet :-)

> +     return master(sock);
>     }
>     else
> -   {
> -      fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
> -      sock =3D apprentice_connect(hostname, port);
> -      return apprentice(sock);
> +     {
> +     if (trace_fn)
> +       {
> +         trace_file =3D open(trace_fn, O_RDONLY);
> +       } else {
> +         fprintf(stderr, "apprentice host %s port %d\n", hostname, port)=
;
> +         sock =3D apprentice_connect(hostname, port);
> +       }
> +     return apprentice(sock);
>     }
>  }
>
> diff --git a/risu_aarch64.c b/risu_aarch64.c
> index c4c0d4d..7f9f612 100644
> --- a/risu_aarch64.c
> +++ b/risu_aarch64.c
> @@ -13,6 +13,7 @@
>  #include <stdio.h>
>  #include <ucontext.h>
>  #include <string.h>
> +#include <unistd.h>

Why this include?

>
>  #include "risu.h"
>  #include "risu_reginfo_aarch64.h"
> @@ -28,9 +29,7 @@ void advance_pc(void *vuc)
>  {
>      ucontext_t *uc =3D vuc;
>      uc->uc_mcontext.pc +=3D 4;
> -    if (ismaster) {
> -      report_test_status((void *) uc->uc_mcontext.pc);
> -    }
> +    report_test_status((void *) uc->uc_mcontext.pc);
>  }
>
>  static void set_x0(void *vuc, uint64_t x0)
> diff --git a/risu_arm.c b/risu_arm.c
> index 474729c..77bdcac 100644
> --- a/risu_arm.c
> +++ b/risu_arm.c
> @@ -50,9 +50,7 @@ void advance_pc(void *vuc)
>  {
>     ucontext_t *uc =3D vuc;
>     uc->uc_mcontext.arm_pc +=3D insnsize(uc);
> -   if (ismaster) {
> -      report_test_status((void *) uc->uc_mcontext.arm_pc);
> -   }
> +   report_test_status((void *) uc->uc_mcontext.arm_pc);
>  }

These bits should just vanish if you fix or drop the
earlier patch that added report_test_status() calls here.

>
>  static void set_r0(void *vuc, uint32_t r0)
> --
> 2.11.0

thanks
-- PMM
