Received: from eggs.gnu.org ([2001:4830:134:3::10]:60017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diJoE-0005sJ-6h
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diJoD-0005dp-46
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:21:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diJoC-0005cV-QU
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:21:57 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-10-david@redhat.com>
	<f2b025c6-bfd9-2b01-497c-d08f262bd0d5@amsat.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1a09b39a-3dfb-67fc-5b5c-851ddeee83cb@redhat.com>
Date: Thu, 17 Aug 2017 14:21:53 +0200
MIME-Version: 1.0
In-Reply-To: <f2b025c6-bfd9-2b01-497c-d08f262bd0d5@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 09/10] s390x/kvm: move KVM
 declarations and stubs to separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net


>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +#include "cpu.h"
>> +#include "kvm_s390x.h"
> 
> here goes the:
> 
> struct kvm_s390_irq {};

As we don't have a stub using kvm_s390_irq, I guess I can just drop this
for now.
[...]

> 
> change by
> 
> typedef struct kvm_s390_irq kvm_s390_irq_t;
> 
>> +
>> +void kvm_s390_floating_interrupt(struct kvm_s390_irq *irq);
>> +void kvm_s390_service_interrupt(uint32_t parm);
>> +void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s390_irq *irq);
> 
> change these to use 'kvm_s390_irq_t *irq' arg
> 
>> +void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code);
>> +int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
>> +                    int len, bool is_write);
>> +void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
>> +void kvm_s390_io_interrupt(uint16_t subchannel_id,
>> +                           uint16_t subchannel_nr, uint32_t io_int_parm,
>> +                           uint32_t io_int_word);
>> +void kvm_s390_crw_mchk(void);
>> +int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
>> +void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
>> +int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
>> +int kvm_s390_get_ri(void);
>> +int kvm_s390_get_gs(void);
>> +int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
>> +int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_clock);
>> +void kvm_s390_enable_css_support(S390CPU *cpu);
>> +int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
>> +                                    int vq, bool assign);
>> +int kvm_s390_cpu_restart(S390CPU *cpu);
>> +int kvm_s390_get_memslot_count(KVMState *s);
>> +int kvm_s390_cmma_active(void);
>> +void kvm_s390_cmma_reset(void);
>> +void kvm_s390_reset_vcpu(S390CPU *cpu);
>> +int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit);
>> +void kvm_s390_crypto_reset(void);
>> +
>> +/* implemented outside of target/s390x/ */
>> +int kvm_s390_inject_flic(struct kvm_s390_irq *irq);
> 
> also change this to use 'kvm_s390_irq_t *irq' arg here and in hw/intc/
> 

Yes, this seems to compile!


-- 

Thanks,

David
