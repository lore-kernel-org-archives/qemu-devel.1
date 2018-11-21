Received: from eggs.gnu.org ([2001:4830:134:3::10]:56213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gPJyo-0007AB-2n
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 23:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gPJlV-0007gk-AT
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 23:05:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gPJlV-0007YZ-5G
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 23:05:25 -0500
From: Bandan Das <bsd@redhat.com>
References: <1235.1542559249@dschgrazlin2.units.it>
	<jpgefbgag1q.fsf@linux.bootlegged.copy>
	<20181119230054.GI3807@habkost.net>
	<824b8c1e-ee32-411b-53b3-68cd76fe0641@redhat.com>
	<20181120184845.GQ4755@habkost.net>
	<04d022e0-2408-0a2f-b2ef-171d1d9017d7@redhat.com>
Date: Tue, 20 Nov 2018 23:05:21 -0500
In-Reply-To: <04d022e0-2408-0a2f-b2ef-171d1d9017d7@redhat.com> (Paolo
	Bonzini's message of "Tue, 20 Nov 2018 20:34:12 +0100")
Message-ID: <jpgo9aj3wji.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>, balducci@units.it, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:
...
>>>>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>>>>> index f524e7d929..4878ffb90b 100644
>>>>> --- a/target/i386/kvm.c
>>>>> +++ b/target/i386/kvm.c
>>>>> @@ -2002,14 +2002,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>>>>>  #endif
>>>>>  
>>>>>      /* If host supports feature MSR, write down. */
>>>>> -    if (kvm_feature_msrs) {
>>>>> -        int i;
>>>>> -        for (i = 0; i < kvm_feature_msrs->nmsrs; i++)
>>>>> -            if (kvm_feature_msrs->indices[i] == MSR_IA32_ARCH_CAPABILITIES) {
>>>>> -                kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
>>>>> +    if (kvm_arch_get_supported_msr_feature(kvm_state, MSR_IA32_ARCH_CAPABILITIES)) {
>>>>> +        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
>>>>>                                env->features[FEAT_ARCH_CAPABILITIES]);
>>>>
>>>> kvm_arch_get_supported_msr_feature() will return the value of the
>>>> MSR on the host side (kvm/x86.c:kvm_get_msr_feature()).  Having
>>>> it return non-zero doesn't mean KVM's
>>>> svm_set_msr(MSR_IA32_ARCH_CAPABILITIES) will work.
>>>>
>>>> If the MSR doesn't work on KVM_SET_MSRS, it is not supposed to
>>>> appear on KVM_GET_MSR_INDEX_LIST (even if it appears on
>>>> KVM_GET_MSR_FEATURE_INDEX_LIST).  QEMU must check
>>>> KVM_GET_MSR_INDEX_LIST too before including the MSR on the
>>>> KVM_SET_MSRS call.
>>>
>>> Yes, this is a KVM bug.  For 3.1, making it "writable if nonzero" is a
>>> valid workaround, because AMD processors always return 0. It's not the
>>> prettiest thing, but it works.
>> 
>> So it looks like we have 2 bugs?  Is KVM incorrectly returning
>> the MSR on KVM_GET_MSR_INDEX_LIST?
>> 
>> I thought the bug was only in QEMU, which is supposed to be
>> checking KVM_GET_MSR_INDEX_LIST before setting the MSR (it is
>> only checking KVM_GET_MSR_FEATURE_INDEX_LIST).
>
> Oh, wait.  I didn't understand that.  Then yeah, fixing QEMU is enough.
>  KVM is not reporting the MSR in the list on AMD, but it should (and it
> should implement the MSR, of course!).
>

Until AMD implements somethinig, on the KVM side, shouldn't we let
kvm_x86_ops->get_msr_feature(msr)) handle MSR_IA32_ARCH_CAPABILITIES ?

> Paolo
