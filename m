Received: from eggs.gnu.org ([2001:4830:134:3::10]:37243)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1eZXum-0001XU-SW
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1eZXuh-0004Sf-Oy
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:08:44 -0500
Received: from verein.lst.de ([213.95.11.211]:47962 helo=newverein.lst.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hch@lst.de>) id 1eZXuh-0004Qr-HF
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:08:39 -0500
Date: Thu, 11 Jan 2018 09:08:38 +0100
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20180111080838.GB32651@lst.de>
References: <1515628000-93285-1-git-send-email-mjc@sifive.com>
	<1515628000-93285-6-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515628000-93285-6-git-send-email-mjc@sifive.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/21] RISC-V CPU Helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches+subscribe@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

#ifdef CONFIG_USER_ONLY
int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
{
    return 0;
}

bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
{
    return false;
}

int riscv_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
        int access_type, int mmu_idx)
{
    cs->exception_index = QEMU_USER_EXCP_FAULT;
    return TRANSLATE_FAIL;
}

void riscv_cpu_do_interrupt(CPUState *cs)
{
    cs->exception_index = EXCP_NONE; /* mark handled to qemu */
}
#else
... real implementation here ...
#endif

To keep the code flow straight?

> +int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return 0;
> +#else

Can you do a large section of USER ONLY stubs instead of sprinkling
the ifdefs?  E.g.

> +static int get_physical_address(CPURISCVState *env, hwaddr *physical,
> +                                int *prot, target_ulong address,
> +                                int access_type, int mmu_idx)
> +{
> +    /* NOTE: the env->pc value visible here will not be
> +     * correct, but the value visible to the exception handler
> +     * (riscv_cpu_do_interrupt) is correct */
> +
> +    const int mode = mmu_idx;

Why don't you just name the actual argument mode and mark it const
if really needed?

> +
> +    *prot = 0;
> +    CPUState *cs = CPU(riscv_env_get_cpu(env));

Clearing out prot just before declaring cs looks a little odd.  Especially
the prot clearing can easily be moved past the next branch.

> +    if (access_type == MMU_INST_FETCH) { /* inst access */
> +        exception = page_fault_exceptions ?
> +            RISCV_EXCP_INST_PAGE_FAULT : RISCV_EXCP_INST_ACCESS_FAULT;
> +        env->badaddr = address;
> +    } else if (access_type == MMU_DATA_STORE) { /* store access */
> +        exception = page_fault_exceptions ?
> +            RISCV_EXCP_STORE_PAGE_FAULT : RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> +        env->badaddr = address;
> +    } else if (access_type == MMU_DATA_LOAD) { /* load access */
> +        exception = page_fault_exceptions ?
> +            RISCV_EXCP_LOAD_PAGE_FAULT : RISCV_EXCP_LOAD_ACCESS_FAULT;
> +        env->badaddr = address;
> +    } else {
> +        g_assert_not_reached();

Why isn't this a switch statement?

> +    if (access_type == MMU_INST_FETCH) {
> +        cs->exception_index = RISCV_EXCP_INST_ADDR_MIS;
> +        env->badaddr = addr;
> +    } else if (access_type == MMU_DATA_STORE) {
> +        cs->exception_index = RISCV_EXCP_STORE_AMO_ADDR_MIS;
> +        env->badaddr = addr;
> +    } else if (access_type == MMU_DATA_LOAD) {
> +        cs->exception_index = RISCV_EXCP_LOAD_ADDR_MIS;
> +        env->badaddr = addr;
> +    } else {
> +        g_assert_not_reached();
> +    }

Same here.

> +    case CSR_SPTBR:

And just as comment on V2:  please don't use CSR_SPTBR here, but
CSR_SAPT, and don't even define the CSR_SPTBR cpp symbol.
