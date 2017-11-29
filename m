Received: from eggs.gnu.org ([2001:4830:134:3::10]:34038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK4db-00051z-Nh
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK4dW-0003un-NU
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:51:03 -0500
Date: Wed, 29 Nov 2017 16:50:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171129165049.1c446263.cohuck@redhat.com>
In-Reply-To: <20171128203326.6062-8-david@redhat.com>
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 07/15] s390x: handle exceptions
 during s390_cpu_virt_mem_rw() correctly (TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Tue, 28 Nov 2017 21:33:17 +0100
David Hildenbrand <david@redhat.com> wrote:

> s390_cpu_virt_mem_rw() must always return, so callers can react on
> an exception (e.g. see ioinst_handle_stcrw()). For TCG, there was one
> case where a cpu loop exit was triggered. Fix that up.
> 
> However, for TCG we always have to exit the cpu loop (and restore the
> cpu state before that) if we injected a program interrupt. So let's
> introduce and use s390_cpu_virt_mem_handle_exc() in code that is not
> purely KVM.
> 
> Directly pass the retaddr we already have available in these functions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-inst.c  |  7 +++++++
>  target/s390x/cpu.h        |  1 +
>  target/s390x/ioinst.c     | 21 ++++++++++++++++++---
>  target/s390x/mmu_helper.c | 19 ++++++++++++++++++-
>  4 files changed, 44 insertions(+), 4 deletions(-)
> 

> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index 4b6d38f946..0851bf6fef 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c

> @@ -243,6 +248,8 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
>           */
>          if (!s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib))) {
>              program_interrupt_ra(env, PGM_OPERAND, 4, ra);
> +        } else {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);

This looks a bit odd if you don't realize that kvm already handled the
exception. But I don't really have a better idea.

>          }
>          return;
>      }

> @@ -645,9 +657,12 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
>      if (!s390_cpu_virt_mem_write(cpu, addr + len, reg, res,
>                                   be16_to_cpu(res->len))) {
>          setcc(cpu, 0);    /* Command execution complete */
> +    } else {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>      }
>  }
>  
> +

unrelated whitespace

>  #define SCHM_REG1_RES(_reg) (_reg & 0x000000000ffffffc)
>  #define SCHM_REG1_MBK(_reg) ((_reg & 0x00000000f0000000) >> 28)
>  #define SCHM_REG1_UPD(_reg) ((_reg & 0x0000000000000002) >> 1)
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 31e3f3f415..39da9aeef4 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -22,6 +22,7 @@
>  #include "internal.h"
>  #include "kvm_s390x.h"
>  #include "sysemu/kvm.h"
> +#include "exec/exec-all.h"
>  #include "trace.h"
>  #include "hw/s390x/storage-keys.h"
>  
> @@ -458,7 +459,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
>          }
>          if (!address_space_access_valid(&address_space_memory, pages[i],
>                                          TARGET_PAGE_SIZE, is_write)) {
> -            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
> +            trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);

Why did you change this?

>              return -EFAULT;
>          }
>          addr += TARGET_PAGE_SIZE;
> @@ -478,6 +479,9 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
>   *
>   * Copy from/to guest memory using logical addresses. Note that we inject a
>   * program interrupt in case there is an error while accessing the memory.
> + *
> + * This function will always return (also for TCG), make sure to call
> + * s390_cpu_virt_mem_handle_exc() to properly exit the CPU loop.
>   */
>  int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
>                           int len, bool is_write)
> @@ -514,6 +518,19 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
>      return ret;
>  }
>  
> +void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra)
> +{
> +    /* KVM will handle the interrupt automatically, TCG has to exit the TB */
> +    #ifdef CONFIG_TCG

Please move the #ifdef/#endif to the beginning of the line.

> +    if (tcg_enabled()) {
> +        if (ra) {
> +            cpu_restore_state(CPU(cpu), ra);
> +        }
> +        cpu_loop_exit(CPU(cpu));
> +    }
> +    #endif
> +}
> +
>  /**
>   * Translate a real address into a physical (absolute) address.
>   * @param raddr  the real address
