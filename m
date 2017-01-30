Received: from eggs.gnu.org ([2001:4830:134:3::10]:36450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYA6F-00065r-49
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 06:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYA6A-0002gP-5x
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 06:26:19 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cYA69-0002gI-Um
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 06:26:14 -0500
Received: by mail-wm0-x22f.google.com with SMTP id v77so43051807wmv.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 03:26:13 -0800 (PST)
References: <1485744457-10324-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1485744457-10324-2-git-send-email-joserz@linux.vnet.ibm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1485744457-10324-2-git-send-email-joserz@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 11:26:10 +0000
Message-ID: <877f5c7prh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com> writes:

> Qemu linux-user doesn't fill uc_mcontext completely like full emul.
> does.

Are you going to submit a fix for QEMU for this? Is there a reason it
doesn't do it correctly?

> For instance, uc->uc_mcontext.regs->nip is an invalid so this
> commit replaces it by uc->uc_mcontext.gp_regs[PT_NIP]
>
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
>  li 10, 10
>  li 11, 11
>  li 12, 12
> -li 13, 13
>  li 14, 14
>  li 15, 15
>  li 16, 16


--
Alex Bennée
