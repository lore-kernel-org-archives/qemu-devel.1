Received: from eggs.gnu.org ([2001:4830:134:3::10]:44602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xinhui@linux.vnet.ibm.com>) id 1cIyRD-0004Nu-Ge
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xinhui@linux.vnet.ibm.com>) id 1cIyRA-0006wF-Bk
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:57:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42155
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xinhui@linux.vnet.ibm.com>)
	id 1cIyRA-0006w8-6K
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:57:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBJDsO6V081517
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 08:57:07 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27ee9w936v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 08:57:06 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <xinhui@linux.vnet.ibm.com>;
	Mon, 19 Dec 2016 23:57:03 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7C0DC357805A
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 00:56:56 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	uBJDuuQa9502838
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 00:56:56 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	uBJDuuOI018426
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 00:56:56 +1100
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1478077718-37424-9-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20161219114241.GD4927@redhat.com>
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Mon, 19 Dec 2016 21:56:58 +0800
MIME-Version: 1.0
In-Reply-To: <20161219114241.GD4927@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <91437232-cb48-18e1-672f-d2d04a780169@linux.vnet.ibm.com>
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
To: Andrea Arcangeli <aarcange@redhat.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

hi, Andrea
	thanks for your reply. :)

=E5=9C=A8 2016/12/19 19:42, Andrea Arcangeli =E5=86=99=E9=81=93:
> Hello,
>
> On Wed, Nov 02, 2016 at 05:08:35AM -0400, Pan Xinhui wrote:
>> Support the vcpu_is_preempted() functionality under KVM. This will
>> enhance lock performance on overcommitted hosts (more runnable vcpus
>> than physical cpus in the system) as doing busy waits for preempted
>> vcpus will hurt system performance far worse than early yielding.
>>
>> Use one field of struct kvm_steal_time ::preempted to indicate that if
>> one vcpu is running or not.
>>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  arch/x86/include/uapi/asm/kvm_para.h |  4 +++-
>>  arch/x86/kvm/x86.c                   | 16 ++++++++++++++++
>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>
> [..]
>> +static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
>> +{
>> +	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
>> +		return;
>> +
>> +	vcpu->arch.st.steal.preempted =3D 1;
>> +
>> +	kvm_write_guest_offset_cached(vcpu->kvm, &vcpu->arch.st.stime,
>> +			&vcpu->arch.st.steal.preempted,
>> +			offsetof(struct kvm_steal_time, preempted),
>> +			sizeof(vcpu->arch.st.steal.preempted));
>> +}
>> +
>>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>>  {
>> +	kvm_steal_time_set_preempted(vcpu);
>>  	kvm_x86_ops->vcpu_put(vcpu);
>>  	kvm_put_guest_fpu(vcpu);
>>  	vcpu->arch.last_host_tsc =3D rdtsc();
>
> You can't call kvm_steal_time_set_preempted in atomic context (neither
> in sched_out notifier nor in vcpu_put() after
> preempt_disable)). __copy_to_user in kvm_write_guest_offset_cached
> schedules and locks up the host.
>
yes, you are right! :) we have known the problems.
I am going to introduce something like kvm_write_guest_XXX_atomic and use=
 them instead of kvm_write_guest_offset_cached.
within pagefault_disable()/enable(), we can not call __copy_to_user I thi=
nk.

> kvm->srcu (or kvm->slots_lock) is also not taken and
> kvm_write_guest_offset_cached needs to call kvm_memslots which
> requires it.
>
let me check the details later. thanks for pointing it out.

> This I think is why postcopy live migration locks up with current
> upstream, and it doesn't seem related to userfaultfd at all (initially
> I suspected the vmf conversion but it wasn't that) and in theory it
> can happen with heavy swapping or page migration too.
>
> Just the page is written so frequently it's unlikely to be swapped
> out. The page being written so frequently also means it's very likely
> found as re-dirtied when postcopy starts and that pretty much
> guarantees an userfault will trigger a scheduling event in
> kvm_steal_time_set_preempted in destination. There are opposite
> probabilities of reproducing this with swapping vs postcopy live
> migration.
>

Good analyze. :)

> For now I applied the below two patches, but this just will skip the
> write and only prevent the host instability as nobody checks the
> retval of __copy_to_user (what happens to guest after the write is
> skipped is not as clear and should be investigated, but at least the
> host will survive and not all guests will care about this flag being
> updated). For this to be fully safe the preempted information should
> be just an hint and not fundamental for correct functionality of the
> guest pv spinlock code.
>
> This bug was introduced in commit
> 0b9f6c4615c993d2b552e0d2bd1ade49b56e5beb in v4.9-rc7.
>
> From 458897fd44aa9b91459a006caa4051a7d1628a23 Mon Sep 17 00:00:00 2001
> From: Andrea Arcangeli <aarcange@redhat.com>
> Date: Sat, 17 Dec 2016 18:43:52 +0100
> Subject: [PATCH 1/2] kvm: fix schedule in atomic in
>  kvm_steal_time_set_preempted()
>
> kvm_steal_time_set_preempted() isn't disabling the pagefaults before
> calling __copy_to_user and the kernel debug notices.
>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1f0d238..2dabaeb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2844,7 +2844,17 @@ static void kvm_steal_time_set_preempted(struct =
kvm_vcpu *vcpu)
>
>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  {
> +	/*
> +	 * Disable page faults because we're in atomic context here.
> +	 * kvm_write_guest_offset_cached() would call might_fault()
> +	 * that relies on pagefault_disable() to tell if there's a
> +	 * bug. NOTE: the write to guest memory may not go through if
> +	 * during postcopy live migration or if there's heavy guest
> +	 * paging.
> +	 */
> +	pagefault_disable();
>  	kvm_steal_time_set_preempted(vcpu);
> +	pagefault_enable();
can we just add this?
I think it is better to modify kvm_steal_time_set_preempted() and let it =
run correctly in atomic context.

thanks
xinhui

>  	kvm_x86_ops->vcpu_put(vcpu);
>  	kvm_put_guest_fpu(vcpu);
>  	vcpu->arch.last_host_tsc =3D rdtsc();
>
>
> From 2845eba22ac74c5e313e3b590f9dac33e1b3cfef Mon Sep 17 00:00:00 2001
> From: Andrea Arcangeli <aarcange@redhat.com>
> Date: Sat, 17 Dec 2016 19:13:32 +0100
> Subject: [PATCH 2/2] kvm: take srcu lock around kvm_steal_time_set_pree=
mpted()
>
> kvm_memslots() will be called by kvm_write_guest_offset_cached() so
> take the srcu lock.
>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2dabaeb..02e6ab4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2844,6 +2844,7 @@ static void kvm_steal_time_set_preempted(struct k=
vm_vcpu *vcpu)
>
>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  {
> +	int idx;
>  	/*
>  	 * Disable page faults because we're in atomic context here.
>  	 * kvm_write_guest_offset_cached() would call might_fault()
> @@ -2853,7 +2854,13 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  	 * paging.
>  	 */
>  	pagefault_disable();
> +	/*
> +	 * kvm_memslots() will be called by
> +	 * kvm_write_guest_offset_cached() so take the srcu lock.
> +	 */
> +	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
>  	kvm_steal_time_set_preempted(vcpu);
> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
>  	pagefault_enable();
>  	kvm_x86_ops->vcpu_put(vcpu);
>  	kvm_put_guest_fpu(vcpu);
>
>
