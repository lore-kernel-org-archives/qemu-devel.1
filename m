Received: from eggs.gnu.org ([2001:4830:134:3::10]:48891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIBDq-0007qY-Ew
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIBDp-0007xJ-EI
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:56:22 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIBDp-0007xA-7f
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:56:21 -0400
Received: by mail-wm0-x22e.google.com with SMTP id x70so33225176wme.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 02:56:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170602160848.4913-5-alex.bennee@linaro.org>
References: <20170602160848.4913-1-alex.bennee@linaro.org>
	<20170602160848.4913-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 10:55:59 +0100
Message-ID: <CAFEAcA9hJYecyXxAvvKfyG5G67YAYd6YV-Y9iOfTNK3njd0+kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v4 04/10] risu: a bit more verbosity
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 June 2017 at 17:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Before this is could seem a little quite when running as you had no
> indication stuff was happening (or how fast). I only dump on the master
> side as I want to minimise the amount of qemu logs to sift through.
>
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

This gets called from signal handlers, so you can't use stdio.

> +   }
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

Can't use stdio in a signal handler.

>           exit(0);
>        default:
>           /* mismatch */
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
> index 883bcf7..1eeb885 100644
> --- a/risu.h
> +++ b/risu.h
> @@ -37,6 +37,7 @@ extern uintptr_t image_start_address;
>  extern void *memblock;
>
>  extern int test_fp_exc;
> +extern int ismaster;
>
>  /* Ops code under test can request from risu: */
>  #define OP_COMPARE 0
> @@ -72,6 +73,8 @@ int recv_and_compare_register_info(int sock, void *uc);
>   */
>  int report_match_status(void);
>
> +void report_test_status(void *pc);
> +
>  /* Interface provided by CPU-specific code: */
>
>  /* Move the PC past this faulting insn by adjusting ucontext
> diff --git a/risu_aarch64.c b/risu_aarch64.c
> index 9c6809d..5625979 100644
> --- a/risu_aarch64.c
> +++ b/risu_aarch64.c
> @@ -16,6 +16,9 @@ void advance_pc(void *vuc)
>  {
>      ucontext_t *uc =3D vuc;
>      uc->uc_mcontext.pc +=3D 4;
> +    if (ismaster) {
> +      report_test_status((void *) uc->uc_mcontext.pc);
> +    }

If we're going to print something we should do it in the
arch-independent code that calls advance_pc(), rather than
duplicating the code in each arch backend.

>  }
>
>  void set_ucontext_paramreg(void *vuc, uint64_t value)
> diff --git a/risu_arm.c b/risu_arm.c
> index f570828..eaf4f6c 100644
> --- a/risu_arm.c
> +++ b/risu_arm.c
> @@ -44,6 +44,9 @@ void advance_pc(void *vuc)
>  {
>     ucontext_t *uc =3D vuc;
>     uc->uc_mcontext.arm_pc +=3D insnsize(uc);
> +   if (ismaster) {
> +      report_test_status((void *) uc->uc_mcontext.arm_pc);
> +   }
>  }

thanks
-- PMM
