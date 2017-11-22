Received: from eggs.gnu.org ([2001:4830:134:3::10]:48085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHWMe-0003bL-D4
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHWMb-0007TK-Cm
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:51:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45772
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eHWMb-0007Pi-7g
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:50:57 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAMEminP079121
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:50:47 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2edb8j0fxh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:50:46 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 22 Nov 2017 14:50:41 -0000
References: <20171122142627.73170-1-borntraeger@de.ibm.com>
	<20171122142627.73170-2-borntraeger@de.ibm.com>
	<20171122154309.27027346.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 22 Nov 2017 15:50:36 +0100
MIME-Version: 1.0
In-Reply-To: <20171122154309.27027346.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c2d0c560-99bf-7d7b-cb88-05e76cb416e7@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/migration: use zero flag
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>



On 11/22/2017 03:43 PM, Cornelia Huck wrote:
> On Wed, 22 Nov 2017 15:26:26 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> valgrind pointed out that we call KVM_S390_GET_IRQ_STATE with an
>> undefined value for flags. Right now this is unused, but we
>> better play safe.
>> The same is true for SET_IRQ_STATE. While QEMU is now fixed in
>> that regard, we should make sure to not use the flag and pad
>> fields in the kernel. A corresponding kernel documentation patch
>> will be submitted later.
> 
> I'd reword this a bit; it is confusing to read changelogs describing a
> then-future change which already happened. (I assume that we will do
> the kernel sanitizing for 4.15?)
> 
> "valgrind pointed out that we call KVM_S390_GET_IRQ_STATE with an
> undefined value for flags. Kernels prior to 4.15 did not use that
> field, and later kernels ignore it for compatibility reasons, but we
> better play safe.
> 
> The same is true for SET_IRQ_STATE. We should make sure to not use the
> flag field, either."
> 
> [I do not see a 'pad' field in the structure; that is a bug in the
> kernel documentation.]

Would be ok for me. Can you take the patch and change the wording yourself?


> 
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/kvm.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 343fcec..76065ec 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -2069,7 +2069,10 @@ int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
>>  
>>  void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
>>  {
>> -    struct kvm_s390_irq_state irq_state;
>> +    struct kvm_s390_irq_state irq_state = {
>> +        .buf = (uint64_t) cpu->irqstate,
>> +        .len = VCPU_IRQ_BUF_SIZE,
>> +    };
>>      CPUState *cs = CPU(cpu);
>>      int32_t bytes;
>>  
>> @@ -2077,9 +2080,6 @@ void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
>>          return;
>>      }
>>  
>> -    irq_state.buf = (uint64_t) cpu->irqstate;
>> -    irq_state.len = VCPU_IRQ_BUF_SIZE;
>> -
>>      bytes = kvm_vcpu_ioctl(cs, KVM_S390_GET_IRQ_STATE, &irq_state);
>>      if (bytes < 0) {
>>          cpu->irqstate_saved_size = 0;
>> @@ -2093,7 +2093,10 @@ void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
>>  int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
>>  {
>>      CPUState *cs = CPU(cpu);
>> -    struct kvm_s390_irq_state irq_state;
>> +    struct kvm_s390_irq_state irq_state = {
>> +        .buf = (uint64_t) cpu->irqstate,
>> +        .len = cpu->irqstate_saved_size,
>> +    };
>>      int r;
>>  
>>      if (cpu->irqstate_saved_size == 0) {
>> @@ -2104,9 +2107,6 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
>>          return -ENOSYS;
>>      }
>>  
>> -    irq_state.buf = (uint64_t) cpu->irqstate;
>> -    irq_state.len = cpu->irqstate_saved_size;
>> -
>>      r = kvm_vcpu_ioctl(cs, KVM_S390_SET_IRQ_STATE, &irq_state);
>>      if (r) {
>>          error_report("Setting interrupt state failed %d", r);
> 
> Patch looks good.
> 
