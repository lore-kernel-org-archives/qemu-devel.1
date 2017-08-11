Received: from eggs.gnu.org ([2001:4830:134:3::10]:59602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dgAiE-0000qR-Cr
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dgAiB-0006yd-P8
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:14:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dgAiB-0006yB-GJ
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:14:51 -0400
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f5080f25-54d9-0a63-db7d-507d64b3d7a1@redhat.com>
Date: Fri, 11 Aug 2017 16:14:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170811074652.31474-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/5] target/s390x: introduce internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 11.08.2017 09:46, David Hildenbrand wrote:
> cpu.h should only contain what really has to be accessed outside of
> target/s390x/. Add internal.h which can only be used inside target/s390x/.
> 
> Move everything that isn't fast enough to run away and restructure it
> right away.
> 
> Minor style fixes to avoid checkpatch warning to:
> - struct Lowcore: "{" goes into same line as typedef
> - struct LowCore: add spaces around "-" in array length calculations
> - time2tod() and tod2time(): move "{" to separate line
> - get_per_atmid(): add space between ")" and "?". Move cases by one char.
> - get_per_atmid(): drop extra paremthesis around (1 << 6)
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
[...]
> +/* kvm.c */
> +#ifdef CONFIG_KVM
> +void kvm_s390_floating_interrupt(struct kvm_s390_irq *irq);
> +void kvm_s390_service_interrupt(uint32_t parm);
> +void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s390_irq *irq);
> +void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code);
> +int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
> +                    int len, bool is_write);
> +void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
> +void kvm_s390_io_interrupt(uint16_t subchannel_id,
> +                           uint16_t subchannel_nr, uint32_t io_int_parm,
> +                           uint32_t io_int_word);
> +void kvm_s390_crw_mchk(void);
> +int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
> +void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
> +int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
> +int kvm_s390_get_ri(void);
> +int kvm_s390_get_gs(void);
> +#else
> +static inline void kvm_s390_service_interrupt(uint32_t parm)
> +{
> +}
> +static inline void kvm_s390_access_exception(S390CPU *cpu, uint16_t code,
> +                                             uint64_t te_code)
> +{
> +}
> +static inline int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar,
> +                                  void *hostbuf, int len, bool is_write)
> +{
> +    return -ENOSYS;
> +}
> +static inline void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code)
> +{
> +}
> +static inline void kvm_s390_io_interrupt(uint16_t subchannel_id,
> +                                        uint16_t subchannel_nr,
> +                                        uint32_t io_int_parm,
> +                                        uint32_t io_int_word)
> +{
> +}
> +static inline void kvm_s390_crw_mchk(void)
> +{
> +}
> +static inline int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
> +{
> +    return -ENOSYS;
> +}
> +static inline void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
> +{
> +}
> +static inline int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
> +{
> +    return 0;
> +}
> +static inline int kvm_s390_get_ri(void)
> +{
> +    return 0;
> +}
> +static inline int kvm_s390_get_gs(void)
> +{
> +    return 0;
> +}
> +#endif /* CONFIG_KVM */

By the way, all the other targets that have KVM have a separate header
for things like this: kvm_arm.h, kvm_ppc.h, kvm_mips.h, kvm_i386.h
... maybe it's time for kvm_s390x.h now?

 Thomas
