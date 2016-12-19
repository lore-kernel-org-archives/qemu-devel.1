Received: from eggs.gnu.org ([2001:4830:134:3::10]:55636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cIz6K-000615-Gx
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cIz6F-0000uR-V0
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:39:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cIz6F-0000tb-Lg
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:39:35 -0500
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1478077718-37424-9-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20161219114241.GD4927@redhat.com>
	<91437232-cb48-18e1-672f-d2d04a780169@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1dbf5452-49c2-a2cb-c71f-b11b13c4f7da@redhat.com>
Date: Mon, 19 Dec 2016 15:39:29 +0100
MIME-Version: 1.0
In-Reply-To: <91437232-cb48-18e1-672f-d2d04a780169@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 08/11] x86,
 kvm/x86.c: support vcpu preempted check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, rkrcmar@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 19/12/2016 14:56, Pan Xinhui wrote:
> hi, Andrea
>     thanks for your reply. :)
>=20
> =E5=9C=A8 2016/12/19 19:42, Andrea Arcangeli =E5=86=99=E9=81=93:
>> Hello,
>>
>> On Wed, Nov 02, 2016 at 05:08:35AM -0400, Pan Xinhui wrote:
>>> Support the vcpu_is_preempted() functionality under KVM. This will
>>> enhance lock performance on overcommitted hosts (more runnable vcpus
>>> than physical cpus in the system) as doing busy waits for preempted
>>> vcpus will hurt system performance far worse than early yielding.
>>>
>>> Use one field of struct kvm_steal_time ::preempted to indicate that i=
f
>>> one vcpu is running or not.
>>>
>>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  arch/x86/include/uapi/asm/kvm_para.h |  4 +++-
>>>  arch/x86/kvm/x86.c                   | 16 ++++++++++++++++
>>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>>
>> [..]
>>> +static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
>>> +{
>>> +    if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
>>> +        return;
>>> +
>>> +    vcpu->arch.st.steal.preempted =3D 1;
>>> +
>>> +    kvm_write_guest_offset_cached(vcpu->kvm, &vcpu->arch.st.stime,
>>> +            &vcpu->arch.st.steal.preempted,
>>> +            offsetof(struct kvm_steal_time, preempted),
>>> +            sizeof(vcpu->arch.st.steal.preempted));
>>> +}
>>> +
>>>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>>>  {
>>> +    kvm_steal_time_set_preempted(vcpu);
>>>      kvm_x86_ops->vcpu_put(vcpu);
>>>      kvm_put_guest_fpu(vcpu);
>>>      vcpu->arch.last_host_tsc =3D rdtsc();
>>
>> You can't call kvm_steal_time_set_preempted in atomic context (neither
>> in sched_out notifier nor in vcpu_put() after
>> preempt_disable)). __copy_to_user in kvm_write_guest_offset_cached
>> schedules and locks up the host.
>>
> yes, you are right! :) we have known the problems.
> I am going to introduce something like kvm_write_guest_XXX_atomic and
> use them instead of kvm_write_guest_offset_cached.
> within pagefault_disable()/enable(), we can not call __copy_to_user I
> think.

Since I have already botched the revert and need to resend the fix, I'm
going to apply Andrea's patches.  The preempted flag is only advisory
anyway.

Thanks,

Paolo

>> kvm->srcu (or kvm->slots_lock) is also not taken and
>> kvm_write_guest_offset_cached needs to call kvm_memslots which
>> requires it.
>>
> let me check the details later. thanks for pointing it out.
>=20
>> This I think is why postcopy live migration locks up with current
>> upstream, and it doesn't seem related to userfaultfd at all (initially
>> I suspected the vmf conversion but it wasn't that) and in theory it
>> can happen with heavy swapping or page migration too.
>>
>> Just the page is written so frequently it's unlikely to be swapped
>> out. The page being written so frequently also means it's very likely
>> found as re-dirtied when postcopy starts and that pretty much
>> guarantees an userfault will trigger a scheduling event in
>> kvm_steal_time_set_preempted in destination. There are opposite
>> probabilities of reproducing this with swapping vs postcopy live
>> migration.
>>
>=20
> Good analyze. :)
>=20
>> For now I applied the below two patches, but this just will skip the
>> write and only prevent the host instability as nobody checks the
>> retval of __copy_to_user (what happens to guest after the write is
>> skipped is not as clear and should be investigated, but at least the
>> host will survive and not all guests will care about this flag being
>> updated). For this to be fully safe the preempted information should
>> be just an hint and not fundamental for correct functionality of the
>> guest pv spinlock code.
>>
>> This bug was introduced in commit
>> 0b9f6c4615c993d2b552e0d2bd1ade49b56e5beb in v4.9-rc7.
>>
>> From 458897fd44aa9b91459a006caa4051a7d1628a23 Mon Sep 17 00:00:00 2001
>> From: Andrea Arcangeli <aarcange@redhat.com>
>> Date: Sat, 17 Dec 2016 18:43:52 +0100
>> Subject: [PATCH 1/2] kvm: fix schedule in atomic in
>>  kvm_steal_time_set_preempted()
>>
>> kvm_steal_time_set_preempted() isn't disabling the pagefaults before
>> calling __copy_to_user and the kernel debug notices.
>>
>> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
>> ---
>>  arch/x86/kvm/x86.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 1f0d238..2dabaeb 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -2844,7 +2844,17 @@ static void kvm_steal_time_set_preempted(struct
>> kvm_vcpu *vcpu)
>>
>>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>>  {
>> +    /*
>> +     * Disable page faults because we're in atomic context here.
>> +     * kvm_write_guest_offset_cached() would call might_fault()
>> +     * that relies on pagefault_disable() to tell if there's a
>> +     * bug. NOTE: the write to guest memory may not go through if
>> +     * during postcopy live migration or if there's heavy guest
>> +     * paging.
>> +     */
>> +    pagefault_disable();
>>      kvm_steal_time_set_preempted(vcpu);
>> +    pagefault_enable();
> can we just add this?
> I think it is better to modify kvm_steal_time_set_preempted() and let i=
t
> run correctly in atomic context.
>=20
> thanks
> xinhui
>=20
>>      kvm_x86_ops->vcpu_put(vcpu);
>>      kvm_put_guest_fpu(vcpu);
>>      vcpu->arch.last_host_tsc =3D rdtsc();
>>
>>
>> From 2845eba22ac74c5e313e3b590f9dac33e1b3cfef Mon Sep 17 00:00:00 2001
>> From: Andrea Arcangeli <aarcange@redhat.com>
>> Date: Sat, 17 Dec 2016 19:13:32 +0100
>> Subject: [PATCH 2/2] kvm: take srcu lock around
>> kvm_steal_time_set_preempted()
>>
>> kvm_memslots() will be called by kvm_write_guest_offset_cached() so
>> take the srcu lock.
>>
>> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
>> ---
>>  arch/x86/kvm/x86.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 2dabaeb..02e6ab4 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -2844,6 +2844,7 @@ static void kvm_steal_time_set_preempted(struct
>> kvm_vcpu *vcpu)
>>
>>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>>  {
>> +    int idx;
>>      /*
>>       * Disable page faults because we're in atomic context here.
>>       * kvm_write_guest_offset_cached() would call might_fault()
>> @@ -2853,7 +2854,13 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>>       * paging.
>>       */
>>      pagefault_disable();
>> +    /*
>> +     * kvm_memslots() will be called by
>> +     * kvm_write_guest_offset_cached() so take the srcu lock.
>> +     */
>> +    idx =3D srcu_read_lock(&vcpu->kvm->srcu);
>>      kvm_steal_time_set_preempted(vcpu);
>> +    srcu_read_unlock(&vcpu->kvm->srcu, idx);
>>      pagefault_enable();
>>      kvm_x86_ops->vcpu_put(vcpu);
>>      kvm_put_guest_fpu(vcpu);
>>
>>
>=20
