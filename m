Received: from eggs.gnu.org ([2001:4830:134:3::10]:35362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPBn3-0006cY-Ha
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPBn1-0001bP-E3
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:34:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gPBmv-0001Uq-DS
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:34:23 -0500
References: <1235.1542559249@dschgrazlin2.units.it>
	<jpgefbgag1q.fsf@linux.bootlegged.copy>
	<20181119230054.GI3807@habkost.net>
	<824b8c1e-ee32-411b-53b3-68cd76fe0641@redhat.com>
	<20181120184845.GQ4755@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04d022e0-2408-0a2f-b2ef-171d1d9017d7@redhat.com>
Date: Tue, 20 Nov 2018 20:34:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181120184845.GQ4755@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Bandan Das <bsd@redhat.com>, balducci@units.it, qemu-devel@nongnu.org, Robert Hoo <robert.hu@linux.intel.com>

On 20/11/18 19:48, Eduardo Habkost wrote:
> On Tue, Nov 20, 2018 at 07:40:01PM +0100, Paolo Bonzini wrote:
>> On 20/11/18 00:00, Eduardo Habkost wrote:
>>> On Mon, Nov 19, 2018 at 04:55:13PM -0500, Bandan Das wrote:
>>>> balducci@units.it writes:
>>>>
>>>>> hello
>>>>>
>>>>> I'm building qemu from source and happily using it since a bit
>>>>> (2.3.0)
>>>>>
>>>>> Since 3.1.0-rc0 (including latest 3.1.0-rc1) I'm no more able to start
>>>>> qemu, getting:
>>>>>
>>>>>     ----8<----
>>>>>     install:115> qemu
>>>>>     qemu: error: failed to set MSR 0x10a to 0x0
>>>>>     qemu: /home/balducci/tmp/install-us-d/qemu-3.1.0-rc1.d/qemu-3.1.0-rc0/target/i386/kvm.c:2185: kvm_put_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
>>>>>     Aborted
>>>>>     ---->8----
>>>>>
>>>> I believe the check on whether MSR_IA32_ARCH_CAPABILITIES is present is
>>>> incomplete because it can return 0 for data. Can you try this:
>>>>
>>>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>>>> index f524e7d929..4878ffb90b 100644
>>>> --- a/target/i386/kvm.c
>>>> +++ b/target/i386/kvm.c
>>>> @@ -2002,14 +2002,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>>>>  #endif
>>>>  
>>>>      /* If host supports feature MSR, write down. */
>>>> -    if (kvm_feature_msrs) {
>>>> -        int i;
>>>> -        for (i = 0; i < kvm_feature_msrs->nmsrs; i++)
>>>> -            if (kvm_feature_msrs->indices[i] == MSR_IA32_ARCH_CAPABILITIES) {
>>>> -                kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
>>>> +    if (kvm_arch_get_supported_msr_feature(kvm_state, MSR_IA32_ARCH_CAPABILITIES)) {
>>>> +        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
>>>>                                env->features[FEAT_ARCH_CAPABILITIES]);
>>>
>>> kvm_arch_get_supported_msr_feature() will return the value of the
>>> MSR on the host side (kvm/x86.c:kvm_get_msr_feature()).  Having
>>> it return non-zero doesn't mean KVM's
>>> svm_set_msr(MSR_IA32_ARCH_CAPABILITIES) will work.
>>>
>>> If the MSR doesn't work on KVM_SET_MSRS, it is not supposed to
>>> appear on KVM_GET_MSR_INDEX_LIST (even if it appears on
>>> KVM_GET_MSR_FEATURE_INDEX_LIST).  QEMU must check
>>> KVM_GET_MSR_INDEX_LIST too before including the MSR on the
>>> KVM_SET_MSRS call.
>>
>> Yes, this is a KVM bug.  For 3.1, making it "writable if nonzero" is a
>> valid workaround, because AMD processors always return 0. It's not the
>> prettiest thing, but it works.
> 
> So it looks like we have 2 bugs?  Is KVM incorrectly returning
> the MSR on KVM_GET_MSR_INDEX_LIST?
> 
> I thought the bug was only in QEMU, which is supposed to be
> checking KVM_GET_MSR_INDEX_LIST before setting the MSR (it is
> only checking KVM_GET_MSR_FEATURE_INDEX_LIST).

Oh, wait.  I didn't understand that.  Then yeah, fixing QEMU is enough.
 KVM is not reporting the MSR in the list on AMD, but it should (and it
should implement the MSR, of course!).

Paolo
