Received: from eggs.gnu.org ([2001:4830:134:3::10]:53029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu977-0000Lw-9V
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 22:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu975-0007b0-QF
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 22:54:37 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:46699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu975-0007ak-I3
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 22:54:35 -0500
Received: by mail-ot0-x232.google.com with SMTP id g97so7534962otg.13
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 19:54:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520369037-37977-12-git-send-email-mjc@sifive.com>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
	<1520369037-37977-12-git-send-email-mjc@sifive.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 9 Mar 2018 16:54:33 +1300
Message-ID: <CAHNT7NuwqMY9WVsBoWCcDbEZ3gNwo-nwuDZPXD+FwZ+5oBv6Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 11/22] RISC-V: Improve page table walker
 spec compliance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

On Wed, Mar 7, 2018 at 9:43 AM, Michael Clark <mjc@sifive.com> wrote:

> - Inline PTE_TABLE check for better readability
> - Improve readibility of User page U mode and SUM test
> - Disallow non U mode from fetching from User pages
> - Add reserved PTE flag check: W or W|X
> - Add misaligned PPN check
> - Change access checks from ternary operator to if statements
> - Improves page walker comments
> - No measurable performance impact on dd test
>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  target/riscv/cpu_bits.h |  2 --
>  target/riscv/helper.c   | 57 ++++++++++++++++++++++++++++++
> ++++---------------
>  2 files changed, 40 insertions(+), 19 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 64aa097..12b4757 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -407,5 +407,3 @@
>  #define PTE_SOFT  0x300 /* Reserved for Software */
>
>  #define PTE_PPN_SHIFT 10
> -
> -#define PTE_TABLE(PTE) (((PTE) & (PTE_V | PTE_R | PTE_W | PTE_X)) ==
> PTE_V)
> diff --git a/target/riscv/helper.c b/target/riscv/helper.c
> index 228933c..2165ecb 100644
> --- a/target/riscv/helper.c
> +++ b/target/riscv/helper.c
> @@ -185,16 +185,36 @@ restart:
>  #endif
>          target_ulong ppn = pte >> PTE_PPN_SHIFT;
>
> -        if (PTE_TABLE(pte)) { /* next level of page table */
> +        if (!(pte & PTE_V)) {
> +            /* Invalid PTE */
> +            return TRANSLATE_FAIL;
> +        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
> +            /* Inner PTE, continue walking */
>              base = ppn << PGSHIFT;
> -        } else if ((pte & PTE_U) ? (mode == PRV_S) && !sum : !(mode ==
> PRV_S)) {
> -            break;
> -        } else if (!(pte & PTE_V) || (!(pte & PTE_R) && (pte & PTE_W))) {
> -            break;
> -        } else if (access_type == MMU_INST_FETCH ? !(pte & PTE_X) :
> -                  access_type == MMU_DATA_LOAD ?  !(pte & PTE_R) &&
> -                  !(mxr && (pte & PTE_X)) : !((pte & PTE_R) && (pte &
> PTE_W))) {
> -            break;
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
> +            /* Reserved leaf PTE flags: PTE_W */
> +            return TRANSLATE_FAIL;
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
> +            /* Reserved leaf PTE flags: PTE_W + PTE_X */
> +            return TRANSLATE_FAIL;
> +        } else if ((pte & PTE_U) && ((mode != PRV_U) &&
> +                   (!sum || access_type == MMU_INST_FETCH))) {
> +            /* User PTE flags when not U mode and mstats.SUM is not set,
> +               or the access type is an instruction fetch */
> +            return TRANSLATE_FAIL;
> +        } else if (ppn & ((1ULL << ptshift) - 1)) {
> +            /* Misasligned PPN */
> +            return TRANSLATE_FAIL;
> +        } else if (access_type == MMU_DATA_LOAD && !((pte & PTE_R) ||
> +                   ((pte & PTE_X) && mxr))) {
>

This should only honor the mstatus.MXR flags if mode != PRV_U

+            /* Read access check failed */
> +            return TRANSLATE_FAIL;
> +        } else if (access_type == MMU_DATA_STORE && !(pte & PTE_W)) {
> +            /* Write access check failed */
> +            return TRANSLATE_FAIL;
> +        } else if (access_type == MMU_INST_FETCH && !(pte & PTE_X)) {
> +            /* Fetch access check failed */
> +            return TRANSLATE_FAIL;
>          } else {
>              /* if necessary, set accessed and dirty bits. */
>              target_ulong updated_pte = pte | PTE_A |
> @@ -202,11 +222,14 @@ restart:
>
>              /* Page table updates need to be atomic with MTTCG enabled */
>              if (updated_pte != pte) {
> -                /* if accessed or dirty bits need updating, and the PTE is
> -                 * in RAM, then we do so atomically with a compare and
> swap.
> -                 * if the PTE is in IO space, then it can't be updated.
> -                 * if the PTE changed, then we must re-walk the page table
> -                   as the PTE is no longer valid */
> +                /*
> +                 * - if accessed or dirty bits need updating, and the PTE
> is
> +                 *   in RAM, then we do so atomically with a compare and
> swap.
> +                 * - if the PTE is in IO space or ROM, then it can't be
> updated
> +                 *   and we return TRANSLATE_FAIL.
> +                 * - if the PTE changed by the time we went to update it,
> then
> +                 *   it is no longer valid and we must re-walk the page
> table.
> +                 */
>                  MemoryRegion *mr;
>                  hwaddr l = sizeof(target_ulong), addr1;
>                  rcu_read_lock();
> @@ -243,15 +266,15 @@ restart:
>              target_ulong vpn = addr >> PGSHIFT;
>              *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
>
> +            /* set permissions on the TLB entry */
>              if ((pte & PTE_R)) {
>                  *prot |= PAGE_READ;
>              }
>

There is a logic bug here, but it is pre-existing. If mxr and mode is not
U, the X flag needs to make the page readable i.e. (MXR) Make eXecute
Readable.


>              if ((pte & PTE_X)) {
>                  *prot |= PAGE_EXEC;
>              }
> -           /* only add write permission on stores or if the page
> -              is already dirty, so that we don't miss further
> -              page table walks to update the dirty bit */
> +            /* add write permission on stores or if the page is already
> dirty,
> +               so that we TLB miss on later writes to update the dirty
> bit */
>              if ((pte & PTE_W) &&
>                      (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
>                  *prot |= PAGE_WRITE;
> --
> 2.7.0
>
>
