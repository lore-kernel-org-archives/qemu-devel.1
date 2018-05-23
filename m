Received: from eggs.gnu.org ([2001:4830:134:3::10]:55863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLcI1-0002Rd-RG
	for qemu-devel@nongnu.org; Wed, 23 May 2018 18:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLcHz-00026s-B1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 18:31:25 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLcHz-00026A-0O
	for qemu-devel@nongnu.org; Wed, 23 May 2018 18:31:23 -0400
Received: by mail-oi0-x242.google.com with SMTP id n65-v6so20996557oig.6
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 15:31:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-3-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-3-git-send-email-mjc@sifive.com>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 24 May 2018 10:31:21 +1200
Message-ID: <CAHNT7NtMt5gtgv_EGTi=r=N6NMFUtes+LBd8sJO3N-MunU+RiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 02/30] RISC-V: Improve page table walker
 spec compliance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <Alistair.Francis@wdc.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: RISC-V Patches <patches@groups.riscv.org>, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

Hi Phil, Alastair, Richard, et al...

Apologies if I'm slow to respond to your other review emails. I'm going to
go through all of them and address each of them one by one.

Currently, I want to either get some MMU tests from the verification team
or separately write tests for the newly added comments in the page walker.

1). +            /* Invalid PTE */
2). +            /* Inner PTE, continue walking */
3). +            /* Reserved leaf PTE flags: PTE_W */
4). +            /* Reserved leaf PTE flags: PTE_W + PTE_X */
5). +            /* User PTE flags when not U mode and mstatus.SUM is not
set,
6). +            /* Supervisor PTE flags when not S mode */
7). +            /* Misasligned PPN */
8). +            /* Read access check failed */
9). +            /* Write access check failed */
10). +            /* Fetch access check failed */
11).             /* if necessary, set accessed and dirty bits. */

That's why I might be slow to respond to the other emails but I will get to
them in due course.

SiFive has internal verification tests which require RTL test harness.
Currently, the open source MMU tests need expanding. It might be better
that we expand the latter as it will be helpful for other implementations
to test their page walkers (hardware and emulators alike):

- https://github.com/riscv/riscv-tests/tree/master/isa/rv64si/

I can then compare master vs this patch. I think master may fail Misasligned
PPN. I may just test critical function such as U-mode can't access U=0.
That's pretty easy as linux-kernel has a shared kernel address space and
riscv-linux doesn't yet have ASLR so I can just try to deref a kernel
address in userspace. In fact we still need to implement kernel memory
protection for riscv-linux i.e. .rodata +R, .text +RX and .data +RW (W^X)
before we add ASLR. The linux kernel port is indeed quite new but this
patch does not regress any user-facing functionality.

One of the goals with this patch is to make the logical clauses and
comments match the English text in the RISC-V Privileged ISA v1.10 with
respect to the MMU.

Michael.

On Wed, May 23, 2018 at 12:14 PM, Michael Clark <mjc@sifive.com> wrote:

> - Inline PTE_TABLE check for better readability
> - Change access checks from ternary operator to if
> - Improve readibility of User page U mode and SUM test
> - Disallow non U mode from fetching from User pages
> - Add reserved PTE flag check: W or W|X
> - Add misaligned PPN check
> - Set READ protection for PTE X flag and mstatus.mxr
> - Use memory_region_is_ram in pte update
>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_bits.h |  2 --
>  target/riscv/helper.c   | 64 ++++++++++++++++++++++++++++++
> ++++---------------
>  2 files changed, 45 insertions(+), 21 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 64aa097181fa..12b4757088f4 100644
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
> index 95889f23b94d..3b57e1360549 100644
> --- a/target/riscv/helper.c
> +++ b/target/riscv/helper.c
> @@ -185,16 +185,39 @@ restart:
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
> +        } else if (!(pte & PTE_U) && (mode != PRV_S)) {
> +            /* Supervisor PTE flags when not S mode */
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
> @@ -202,16 +225,19 @@ restart:
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
>                      &addr1, &l, false);
> -                if (memory_access_is_direct(mr, true)) {
> +                if (memory_region_is_ram(mr)) {
>                      target_ulong *pte_pa =
>                          qemu_map_ram_ptr(mr->ram_block, addr1);
>  #if TCG_OVERSIZED_GUEST
> @@ -239,15 +265,15 @@ restart:
>              target_ulong vpn = addr >> PGSHIFT;
>              *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
>
> -            if ((pte & PTE_R)) {
> +            /* set permissions on the TLB entry */
> +            if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
>                  *prot |= PAGE_READ;
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
