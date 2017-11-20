Received: from eggs.gnu.org ([2001:4830:134:3::10]:38790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGljo-0004PL-Pl
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:03:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGljk-00064T-66
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:03:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35686
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eGljk-00064I-0U
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:03:44 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAKCxCNF118109
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 08:03:43 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ebwjdqm2w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 08:03:43 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 20 Nov 2017 13:03:35 -0000
References: <20171120123525.147663-1-borntraeger@de.ibm.com>
	<20171120123525.147663-2-borntraeger@de.ibm.com>
	<20171120135734.23a4e4a1.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Nov 2017 14:03:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171120135734.23a4e4a1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6e479813-043f-af53-26f9-3382b68ab570@de.ibm.com>
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



On 11/20/2017 01:57 PM, Cornelia Huck wrote:
> On Mon, 20 Nov 2017 13:35:24 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> valgrind pointed out that we call KVM_S390_GET_IRQ_STATE with an
>> undefined value for flags. Right now this is unused, but we
>> better play safe.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/kvm.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 343fcec..b0439a1 100644
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
> 
> I'm wondering why it does not also complain for KVM_S390_SET_IRQ_STATE?

I guess that my tests do not having peding interrupts during migration and we exit early in

int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
{
    CPUState *cs = CPU(cpu);
    struct kvm_s390_irq_state irq_state;
    int r;

-->    if (cpu->irqstate_saved_size == 0) {
-->        return 0;
    }




> It would make sense to use a struct initializer there as well.

Yes, I think you are right.
> 
