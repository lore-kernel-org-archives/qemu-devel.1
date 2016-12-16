Received: from eggs.gnu.org ([2001:4830:134:3::10]:55972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxEs-0000yg-JZ
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxEr-0003NP-FN
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:28:14 -0500
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:32866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHxEr-0003Mk-Bd
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:28:13 -0500
Received: by mail-vk0-x233.google.com with SMTP id 137so93196531vkl.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 10:28:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161209114830.9158-2-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
	<20161209114830.9158-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 18:27:51 +0000
Message-ID: <CAFEAcA_ZzZzYahd7Lnswh3Ld9tRR562iS_VDeYYmSxaWXZ__6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v3 01/10] risu: a bit more verbosity
 when running
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
> Before this is could seem a little quite when running as you had no
> indication stuff was happening (or how fast). I only dump on the master
> side as I want to minimise the amount of qemu logs to sift through.

Yeah, more progress info would be good. (I used to have a patchset
that made risu print '.' every so often but I dunno where
that disappeared to.)

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> --
> v3
>   - use portable fmt string for image_start_address
>   - include arm dumping position
> ---
>  risu.c         | 15 +++++++++++++--
>  risu.h         |  3 +++
>  risu_aarch64.c |  3 +++
>  risu_arm.c     |  3 +++
>  4 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/risu.c b/risu.c
> index 7e42160..bcdc219 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -37,6 +37,16 @@ sigjmp_buf jmpbuf;
>  /* Should we test for FP exception status bits? */
>  int test_fp_exc =3D 0;
>
> +long executed_tests =3D 0;
> +void report_test_status(void *pc)
> +{
> +   executed_tests +=3D 1;
> +   if (executed_tests % 100 =3D=3D 0) {
> +      fprintf(stderr,"Executed %ld test instructions (pc=3D%p)\r",
> +              executed_tests, pc);
> +   }

I think this is too much info to be printing every 100
instructions, though. We should either just print '.'s or
print info less often.

Also, you're inside a signal handler, so trying to use
libc stdio is probably a bad idea. With '.' you can at
least stick to write() which is OK inside signal handlers.

> +}
> +
>  void master_sigill(int sig, siginfo_t *si, void *uc)
>  {
>     switch (recv_and_compare_register_info(master_socket, uc))
> @@ -61,6 +71,7 @@ void apprentice_sigill(int sig, siginfo_t *si, void *uc=
)
>           return;
>        case 1:
>           /* end of test */
> +         fprintf(stderr, "\nend of test\n");
>           exit(0);

This is also inside a signal handler. (If that's too annoying
you can do what master_sigill() does for this, and siglongjmp()
out to somewhere more convenient.)

>        default:
>           /* mismatch */

The default case is about to do 'exit(1);' -- should we print
something there too?

> @@ -129,7 +140,7 @@ int master(int sock)
>     }
>     master_socket =3D sock;
>     set_sigill_handler(&master_sigill);
> -   fprintf(stderr, "starting image\n");
> +   fprintf(stderr, "starting master image at 0x%"PRIxPTR"\n", image_star=
t_address);
>     image_start();
>     fprintf(stderr, "image returned unexpectedly\n");
>     exit(1);
> @@ -139,7 +150,7 @@ int apprentice(int sock)
>  {
>     apprentice_socket =3D sock;
>     set_sigill_handler(&apprentice_sigill);
> -   fprintf(stderr, "starting image\n");
> +   fprintf(stderr, "starting apprentice image at 0x%"PRIxPTR"\n", image_=
start_address);
>     image_start();
>     fprintf(stderr, "image returned unexpectedly\n");
>     exit(1);
> diff --git a/risu.h b/risu.h
> index 26ed834..e4bb323 100644
> --- a/risu.h
> +++ b/risu.h
> @@ -26,6 +26,7 @@ extern uintptr_t image_start_address;
>  extern void *memblock;
>
>  extern int test_fp_exc;
> +extern int ismaster;
>
>  /* Ops code under test can request from risu: */
>  #define OP_COMPARE 0
> @@ -59,6 +60,8 @@ int recv_and_compare_register_info(int sock, void *uc);
>   */
>  int report_match_status(void);
>
> +void report_test_status(void *pc);
> +
>  /* Move the PC past this faulting insn by adjusting ucontext
>   */
>  void advance_pc(void *uc);
> diff --git a/risu_aarch64.c b/risu_aarch64.c
> index 547f987..1595604 100644
> --- a/risu_aarch64.c
> +++ b/risu_aarch64.c
> @@ -28,6 +28,9 @@ void advance_pc(void *vuc)
>  {
>      ucontext_t *uc =3D vuc;
>      uc->uc_mcontext.pc +=3D 4;
> +    if (ismaster) {
> +      report_test_status((void *) uc->uc_mcontext.pc);
> +    }
>  }

I think it would be nicer to do the progress info
directly from master_sigill()/apprentice_sigill(). That
means that you don't have to change the advance_pc() function for
every architecture, and you don't need a global for ismaster either,
because you know by virtue of which function you were in.
(If you're dead set on printing the guest PC we should add a
uint64_t get_guest_pc(void *vuc) function for the progress info
function to use, but I'd rather not bother.)

>  static void set_x0(void *vuc, uint64_t x0)
> diff --git a/risu_arm.c b/risu_arm.c
> index bdfb59b..c3fe3d3 100644
> --- a/risu_arm.c
> +++ b/risu_arm.c
> @@ -50,6 +50,9 @@ void advance_pc(void *vuc)
>  {
>     ucontext_t *uc =3D vuc;
>     uc->uc_mcontext.arm_pc +=3D insnsize(uc);
> +   if (ismaster) {
> +      report_test_status((void *) uc->uc_mcontext.arm_pc);
> +   }
>  }
>
>  static void set_r0(void *vuc, uint32_t r0)
> --
> 2.11.0

thanks
-- PMM
