Received: from eggs.gnu.org ([2001:4830:134:3::10]:33459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZenN-0001ZM-9K
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZenK-0003BV-4r
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:29:33 -0500
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:42061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZenJ-0003AC-Rl
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:29:30 -0500
Received: by mail-pg0-x235.google.com with SMTP id q67so2379263pga.9
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 07:29:29 -0800 (PST)
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-6-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <41a5696b-905d-9081-0b1d-cfe16d89f9cd@linaro.org>
Date: Thu, 11 Jan 2018 07:29:25 -0800
MIME-Version: 1.0
In-Reply-To: <1515637324-96034-6-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/21] RISC-V CPU Helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 01/10/2018 06:21 PM, Michael Clark wrote:
> +    int ptshift = (levels - 1) * ptidxbits;
> +    int i;
> +    for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
> +        target_ulong idx = (addr >> (PGSHIFT + ptshift)) &
> +                           ((1 << ptidxbits) - 1);
> +
> +        /* check that physical address of PTE is legal */
> +        target_ulong pte_addr = base + idx * ptesize;
> +        target_ulong pte = ldq_phys(cs->as, pte_addr);
> +        target_ulong ppn = pte >> PTE_PPN_SHIFT;
> +
> +        if (PTE_TABLE(pte)) { /* next level of page table */
> +            base = ppn << PGSHIFT;
> +        } else if ((pte & PTE_U) ? (mode == PRV_S) && !sum : !(mode == PRV_S)) {
> +            break;
> +        } else if (!(pte & PTE_V) || (!(pte & PTE_R) && (pte & PTE_W))) {
> +            break;

It might be clearer to return TRANSLATION_FAILED directly here.

> +        } else if (access_type == MMU_INST_FETCH ? !(pte & PTE_X) :
> +                  access_type == MMU_DATA_LOAD ?  !(pte & PTE_R) &&
> +                  !(mxr && (pte & PTE_X)) : !((pte & PTE_R) && (pte & PTE_W))) {
> +            break;

It might be clearer to pre-compute the access required and the access granted
by this page table level.  E.g. before the loop

  access_requested = (access_type == MMU_INST_FETCH ? PTE_X
                      : access_type == MMU_DATA_LOAD ? PTE_R : PTE_W);

and then here

  access_granted = pte & (PTE_X | PTE_R | PTE_W);
  if (mxr && (pte & PTE_X)) {
    access_granted |= PTE_R;
  }
  if ((access_requested & access_granted) == 0) {
    return TRANSLATION_FAILED;
  }

> +            /* set accessed and possibly dirty bits.
> +               we only put it in the TLB if it has the right stuff */
> +            stq_phys(cs->as, pte_addr, ldq_phys(cs->as, pte_addr) | PTE_A |
> +                    ((access_type == MMU_DATA_STORE) * PTE_D));

Surely you only want to do this if the bits in question are not already set.

You want

    set_bits = PTE_A + (access_type == MMU_DATA_STORE) * PTE_D);
    if ((pte & set_bits) != set_bits) {
        stq_phys(...);
        pte |= set_bits;  /* see below */
    }

> +            /* we do not give all prots indicated by the PTE
> +             * this is because future accesses need to do things like set the
> +             * dirty bit on the PTE
> +             *
> +             * at this point, we assume that protection checks have occurred */
> +            if (mode == PRV_S) {
> +                if ((pte & PTE_X) && access_type == MMU_INST_FETCH) {
> +                    *prot |= PAGE_EXEC;
> +                } else if ((pte & PTE_W) && access_type == MMU_DATA_STORE) {
> +                    *prot |= PAGE_WRITE;
> +                } else if ((pte & PTE_R) && access_type == MMU_DATA_LOAD) {
> +                    *prot |= PAGE_READ;
> +                } else {
> +                    g_assert_not_reached();
> +                }
> +            } else {
> +                if ((pte & PTE_X) && access_type == MMU_INST_FETCH) {
> +                    *prot |= PAGE_EXEC;
> +                } else if ((pte & PTE_W) && access_type == MMU_DATA_STORE) {
> +                    *prot |= PAGE_WRITE;
> +                } else if ((pte & PTE_R) && access_type == MMU_DATA_LOAD) {
> +                    *prot |= PAGE_READ;
> +                } else {
> +                    g_assert_not_reached();
> +                }
> +            }

This is wrong.  First, it isn't taking MXR into account.  Second, you don't
want to only grant what is required by the access, but also what is allowable.
Otherwise we will keep coming back to this routine any different kind of
access.  Third, what has PRV_S got to do with it?

You want

  /* If the dirty bit is not yet set, remove write permission from
     the page so that we come back here to set it.  */
  if ((pte & PTE_D) == 0) {
    access_granted &= ~PTE_W;
  }

  *prot = (access_granted & PTE_X ? PAGE_EXEC : 0)
        | (access_granted & PTE_R ? PAGE_READ : 0)
        | (access_granted & PTE_W ? PAGE_WRITE : 0);


Did I miss the check for misaligned superpages (step 6 in 4.3.2
Virtual Address Translation Process)?


> +/*
> + * Handle writes to CSRs and any resulting special behavior
> + *
> + * Adapted from Spike's processor_t::set_csr
> + */
> +inline void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
> +        target_ulong csrno)

Again, drop the inline.  (This is a huge function anyway, why would you want that?)

> +inline target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)

Likewise.

> +target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
> +{
> +    if (!(env->priv >= PRV_S)) {
> +        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
> +    }

Again, I strongly suspect that you need to be using an unwinding exception
here, and elsewhere within this file.  Otherwise the PC against which the
exception is reported will be wrong.


r~
