Received: from eggs.gnu.org ([2001:4830:134:3::10]:40607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYAT7-0003uY-Cn
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 06:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYAT6-0008Nx-CM
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 06:49:57 -0500
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:33358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYAT6-0008Nn-6y
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 06:49:56 -0500
Received: by mail-ua0-x230.google.com with SMTP id i68so247480329uad.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 03:49:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485744457-10324-2-git-send-email-joserz@linux.vnet.ibm.com>
References: <1485744457-10324-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1485744457-10324-2-git-send-email-joserz@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jan 2017 11:49:34 +0000
Message-ID: <CAFEAcA_juuc1jxnLqE6BFOcROM7uR_UEkY+d1Zrh2b17CiaVjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH Risu 1/2] risu_ppc64: Fix Risu to run under
 qemu linux user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 January 2017 at 02:47, Jose Ricardo Ziviani
<joserz@linux.vnet.ibm.com> wrote:
> Qemu linux-user doesn't fill uc_mcontext completely like full emul. does.
> For instance, uc->uc_mcontext.regs->nip is an invalid so this
> commit replaces it by uc->uc_mcontext.gp_regs[PT_NIP]

It's not clear to me from this commit message whether this is
a bug in QEMU's userspace emulation which this is trying to work
around (in which case we should just fix it in QEMU), or a
bug in risu where we were incorrectly relying on something the
kernel doesn't actually guarantee. Which is it?

Also, looking at the kernel source and headers as far
as I can see uc_context.regs is a pointer set up such that
uc->uc_mcontext.regs->nip is pointing at the same bit of
memory where uc->uc_mcontext.gp_regs[PT_NIP] is,
and the QEMU code does similar, so I don't see how you can
get two different values from the two things.

(It is certainly the case that risu is quite good at exercising
odd corner cases of the signal handling code in QEMU which most
normal programs don't care about...)

> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  risu_ppc64le.c         |  2 +-
>  risu_reginfo_ppc64le.c | 11 ++++++-----
>  test_ppc64le.s         | 20 +++++++++-----------
>  3 files changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/risu_ppc64le.c b/risu_ppc64le.c
> index 9c1fafd..773d14c 100644
> --- a/risu_ppc64le.c
> +++ b/risu_ppc64le.c
> @@ -27,7 +27,7 @@ uint8_t apprentice_memblock[MEMBLOCKLEN];
>  void advance_pc(void *vuc)
>  {
>      ucontext_t *uc = (ucontext_t*)vuc;
> -    uc->uc_mcontext.regs->nip += 4;
> +    uc->uc_mcontext.gp_regs[PT_NIP] += 4;
>  }
>
>  void set_x0(void *vuc, uint64_t x0)
> diff --git a/risu_reginfo_ppc64le.c b/risu_reginfo_ppc64le.c
> index 7a54eab..4dc509c 100644
> --- a/risu_reginfo_ppc64le.c
> +++ b/risu_reginfo_ppc64le.c
> @@ -28,8 +28,9 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
>      int i;
>      memset(ri, 0, sizeof(*ri));
>
> -    ri->faulting_insn = *((uint32_t *)uc->uc_mcontext.regs->nip);
> -    ri->nip = uc->uc_mcontext.regs->nip - image_start_address;
> +    ri->faulting_insn = *((uint32_t *)uc->uc_mcontext.gp_regs[PT_NIP]);
> +    ri->prev_insn = *((uint32_t *)(uc->uc_mcontext.gp_regs[PT_NIP] - 4));
> +    ri->nip = uc->uc_mcontext.gp_regs[PT_NIP] - image_start_address;
>
>      for (i = 0; i < NGREG; i++) {
>          ri->gregs[i] = uc->uc_mcontext.gp_regs[i];
> @@ -105,9 +106,9 @@ void reginfo_dump(struct reginfo *ri, int is_master)
>  {
>      int i;
>      if (is_master) {
> -        fprintf(stderr, "  faulting insn \e[1;101;37m0x%x\e[0m\n", ri->faulting_insn);
> -        fprintf(stderr, "  prev insn     \e[1;101;37m0x%x\e[0m\n", ri->prev_insn);
> -        fprintf(stderr, "  prev addr     \e[1;101;37m0x%" PRIx64 "\e[0m\n\n", ri->prev_addr);
> +        fprintf(stderr, "  faulting insn 0x%x\n", ri->faulting_insn);
> +        fprintf(stderr, "  prev insn     0x%x\n", ri->prev_insn);
> +        fprintf(stderr, "  prev addr    0x%" PRIx64 "\n\n", ri->nip);

This seems to be fixing two unrelated things:
 * escape sequences in the output (which we should indeed get rid of)
 * printing an uninitialized and unused prev_addr field
   (which we should fix and also drop the unneeded field from reginfo)

>      }
>
>      for (i = 0; i < 16; i++) {
> diff --git a/test_ppc64le.s b/test_ppc64le.s
> index 4321751..4af770c 100644
> --- a/test_ppc64le.s
> +++ b/test_ppc64le.s
> @@ -12,20 +12,18 @@
>   *****************************************************************************/
>
>  /* Initialise the gp regs */
> -li 0,0
> -li 1,1
> -li 2,2
> -li 3,3
> -li 4,4
> -li 5,5
> -li 6,6
> -li 7,7
> -li 8,8
> -li 9,9
> +li 0, 0
> +li 2, 2
> +li 3, 3
> +li 4, 4
> +li 5, 5
> +li 6, 6
> +li 7, 7
> +li 8, 8
> +li 9, 9

This appears to be unrelated changes to whitespace...

>  li 10, 10
>  li 11, 11
>  li 12, 12
> -li 13, 13
>  li 14, 14
>  li 15, 15
>  li 16, 16

thanks
-- PMM
