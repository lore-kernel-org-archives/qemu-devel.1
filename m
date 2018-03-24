Received: from eggs.gnu.org ([2001:4830:134:3::10]:56584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezp29-0002Qh-JB
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezp15-0006ik-K5
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:40:57 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:34727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ezp15-0006i4-7H
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:39:51 -0400
Received: by mail-oi0-x235.google.com with SMTP id u141-v6so13035313oif.1
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:39:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521915220-65389-4-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<1521915220-65389-4-git-send-email-mjc@sifive.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 12:39:49 -0700
Message-ID: <CAHNT7NttCSz+QLFvix=zwtqiU6c=_gvXYKQ7aMvbsizV1FsPiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 10/26] RISC-V: Improve page table walker
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
Cc: RISC-V Patches <patches@groups.riscv.org>, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

On Sat, Mar 24, 2018 at 11:13 AM, Michael Clark <mjc@sifive.com> wrote:

> - Inline PTE_TABLE check for better readability
> - Improve readibility of User page U mode and SUM test
> - Disallow non U mode from fetching from User pages
> - Add reserved PTE flag check: W or W|X
> - Add misaligned PPN check
> - Set READ flag for PTE X flag if mstatus.mxr is in effect
> - Change access checks from ternary operator to if statements
> - Improves page walker comments
> - No measurable performance impact on dd test
>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  target/riscv/cpu_bits.h |  2 --
>  target/riscv/helper.c   | 59 ++++++++++++++++++++++++++++++
> ++++---------------
>  2 files changed, 41 insertions(+), 20 deletions(-)
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
> index 02cbcea..9010620 100644
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
> +            /* User PTE flags when not U mode and mstatus.SUM is not set,
> +               or the access type is an instruction fetch */
> +            return TRANSLATE_FAIL;
> +        } else if (ppn & ((1ULL << ptshift) - 1)) {
> +            /* Misasligned PPN */
> +            return TRANSLATE_FAIL;
> +        } else if (access_type == MMU_DATA_LOAD && !((pte & PTE_R) ||
> +                   ((pte & PTE_X) && mxr))) {
> +            /* Read access check failed */
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
>                  mr = address_space_translate(cs->as, pte_addr,
> @@ -239,15 +262,15 @@ restart:
>              target_ulong vpn = addr >> PGSHIFT;
>              *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
>
> -            if ((pte & PTE_R)) {
> +            /* set permissions on the TLB entry */
> +            if ((pte & PTE_R) || (mode != PRV_U && (pte & PTE_X) && mxr))
> {
>

The mode check for mxr is incorrect. This should be:

        if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {

Page 20 Volume II: RISC-V Privileged Architectures V1.10

3.1.9 Memory Privilege in mstatus Register

"For simplicity, MPRV and MXR are in e ect regardless of privilege mode,
but in normal
use will only be enabled for short sequences in machine mode."

The bug is harmless because no Supervisor never would enable MXR for user
mode. This patch in fact makes mstatus.MXR work, however the check for mode
was overconstrained. A previous update to this patch to ignore the
privilege mode missed removing the mode check in the subsequent check for
mstatus.MXR when setting page protections.

Fixed in the riscv.org branch here:

- https://github.com/riscv/riscv-qemu/tree/qemu-2.12-fixes

                 *prot |= PAGE_READ;
>              }
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
