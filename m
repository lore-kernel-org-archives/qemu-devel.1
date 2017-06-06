Received: from eggs.gnu.org ([2001:4830:134:3::10]:49590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIEiF-00018p-V6
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIEiE-00066d-EI
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:39:59 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIEiE-00065x-4M
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:39:58 -0400
Received: by mail-wm0-x236.google.com with SMTP id d73so49175337wma.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 06:39:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170602160848.4913-8-alex.bennee@linaro.org>
References: <20170602160848.4913-1-alex.bennee@linaro.org>
	<20170602160848.4913-8-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 14:39:35 +0100
Message-ID: <CAFEAcA-8wW2qBEsk-awcsRsaAKdnERmYTfwsoSMBwQqiahDfnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v4 07/10] risu: add simple trace and
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 June 2017 at 17:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
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
>
> ---
> v4
>   - fix formatting mess
>   - abort() instead of reporting de-sync
>   - don't fake return for compiler
> v3
>   - fix options parsing
>   - re-factored so no need for copy & paste
> v2
>   - moved read/write functions into main risu.c
>   - cleaned up formatting
>   - report more in apprentice --trace mode
> ---
>  risu.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 84 insertions(+), 13 deletions(-)
>
> diff --git a/risu.c b/risu.c
> index 22571cd..137cbbf 100644
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
> @@ -66,9 +75,36 @@ int write_sock(void *ptr, size_t bytes)
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
> +         /* should not get here */
> +         abort();
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

It's a bit weird that in the trace file case we send the data
from the master, but in the normal case we send it from
the apprentice end.

> +
> +   switch (r)
>     {
>        case 0:
>           /* match OK */
> @@ -82,7 +118,15 @@ void master_sigill(int sig, siginfo_t *si, void *uc)
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
>           /* match OK */
> @@ -94,6 +138,9 @@ void apprentice_sigill(int sig, siginfo_t *si, void *u=
c)
>           exit(0);
>        default:
>           /* mismatch */
> +         if (trace_file) {
> +            report_match_status();
> +         }

report_match_status() uses stdio, you can't call it from a signal handler.

>           exit(1);
>     }
>  }
> @@ -155,7 +202,13 @@ int master(int sock)
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
> @@ -184,6 +237,7 @@ void usage (void)
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
> @@ -194,6 +248,7 @@ int main(int argc, char **argv)
>     uint16_t port =3D 9191;
>     char *hostname =3D "localhost";
>     char *imgfile;
> +   char *trace_fn =3D NULL;
>     int sock;
>
>     // TODO clean this up later
> @@ -204,13 +259,14 @@ int main(int argc, char **argv)
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
> @@ -223,6 +279,11 @@ int main(int argc, char **argv)
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
> @@ -253,17 +314,27 @@ int main(int argc, char **argv)
>     }
>
>     load_image(imgfile);
> -
> +
>     if (ismaster)
>     {
> -      fprintf(stderr, "master port %d\n", port);
> -      sock =3D master_connect(port);
> +      if (trace_fn)
> +      {
> +         trace_file =3D open(trace_fn, O_WRONLY|O_CREAT, S_IRWXU);
> +      } else {
> +         fprintf(stderr, "master port %d\n", port);
> +         sock =3D master_connect(port);
> +      }
>        return master(sock);

Doesn't this call master() with an uninitialized sock if
the trace file is in use ?

>     }
>     else
>     {
> -      fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
> -      sock =3D apprentice_connect(hostname, port);
> +      if (trace_fn)
> +      {
> +         trace_file =3D open(trace_fn, O_RDONLY);
> +      } else {
> +         fprintf(stderr, "apprentice host %s port %d\n", hostname, port)=
;
> +         sock =3D apprentice_connect(hostname, port);
> +      }
>        return apprentice(sock);
>     }
>  }
> --
> 2.13.0
>

thanks
-- PMM
