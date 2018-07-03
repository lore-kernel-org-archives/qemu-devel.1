Received: from eggs.gnu.org ([2001:4830:134:3::10]:39098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1faEHD-0001uk-JJ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1faEH8-0004LT-Mz
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:54:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33372 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1faEH8-0004LL-Go
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:54:54 -0400
Date: Tue, 3 Jul 2018 13:54:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180703055447.GQ2455@xz-mi>
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
	<20180702112308.GO2455@xz-mi>
	<e935a3ea-6714-8f92-fe67-9f820646efc3@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e935a3ea-6714-8f92-fe67-9f820646efc3@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v0 0/7] Background snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Mon, Jul 02, 2018 at 03:40:31PM +0300, Denis Plotnikov wrote:
> 
> 
> On 02.07.2018 14:23, Peter Xu wrote:
> > On Fri, Jun 29, 2018 at 11:03:13AM +0300, Denis Plotnikov wrote:
> > > The patch set adds the ability to make external snapshots while VM is running.
> > 
> > Hi, Denis,
> > 
> > This work is interesting, though I have a few questions to ask in
> > general below.
> > 
> > > 
> > > The workflow to make a snapshot is the following:
> > > 1. Pause the vm
> > > 2. Make a snapshot of block devices using the scheme of your choice
> > 
> > Here you explicitly took the snapshot for the block device, then...
> > 
> > > 3. Turn on background-snapshot migration capability
> > > 4. Start the migration using the destination (migration stream) of your choice.
> > 
> > ... here you started the VM snapshot.  How did you make sure that the
> > VM snapshot (e.g., the RAM data) and the block snapshot will be
> > aligned?
> As the VM has been paused before making an image(disk) snapshot, there
> should be no requests to the original image done ever since. All the later
> request's goes to the disk snapshot.
> 
> At the point we have a disk image and its snapshot.
> In the image we have kind of checkpoint-ed state which won't (shouldn't) be
> changed because all the writing requests should go to the image snapshot.
> 
> Then we start the background snapshot which marks all the memory as
> read-only and writing the part of VM state to the VM snapshot file.
> By making the memory read-only we kind of freeze the state of the RAM.
> 
> At that point we have an original image and the VM memory content which
> corresponds to each other because the VM isn't running.
> 
> Then, the background snapshot thread continues VM execution with the
> read-only-marked memory which is being written to the external VM snapshot
> file. All the write accesses to the memory are intercepted and the memory
> pages being accessed are written to the VM snapshot (VM state) file in
> priority. Having marked as read-write right after the writing, the memory
> pages aren't tracked for later accesses.
> 
> This is how we guarantee that the VM snapshot (state) file has the memory
> content corresponding to the moment when the disk snapshot is created.
> 
> When the writing ends, we have the VM snapshot (VM state) file which has the
> memory content saved by the moment of the image snapshot creating.
> 
> So, to restore the VM from "the snapshot" we need to use the original image
> disk (not the disk snapshot) and the VM snapshot (VM state with saved
> memory) file.

My bad to have not noticed about the implication of vm_stop() as the
first step.  Your explanation is clear.  Thank you!

> 
> > 
> > For example, in current save_snapshot() we'll quiesce disk IOs before
> > migrating the last pieces of RAM data to make sure they are aligned.
> > I didn't figure out myself on how that's done in this work.
> > 
> > >     The migration will resume the vm execution by itself
> > >     when it has the devices' states saved  and is ready to start ram writing
> > >     to the migration stream.
> > > 5. Listen to the migration finish event
> > > 
> > > The feature relies on KVM unapplied ability to report the faulting address.
> > > Please find the KVM patch snippet to make the patchset work below:
> > > 
> > > +++ b/arch/x86/kvm/vmx.c
> > > @@ -XXXX,X +XXXX,XX @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
> > >          vcpu->arch.exit_qualification = exit_qualification;
> > > -       return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
> > > +       r = kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
> > > +        if (r == -EFAULT) {
> > > +               unsigned long hva = kvm_vcpu_gfn_to_hva(vcpu, gpa >> PAGE_SHIFT);
> > > +
> > > +               vcpu->run->exit_reason = KVM_EXIT_FAIL_MEM_ACCESS;
> > > +               vcpu->run->hw.hardware_exit_reason = EXIT_REASON_EPT_VIOLATION;
> > > +               vcpu->run->fail_mem_access.hva = hva | (gpa & (PAGE_SIZE-1));
> > > +               r = 0;
> > > +
> > > +       }
> > > +       return r;
> > 
> > Just to make sure I fully understand here: so this is some extra KVM
> > work just to make sure the mprotect() trick will work even for KVM
> > vcpu threads, am I right?
> 
> That's correct!
> > 
> > Meanwhile, I see that you only modified EPT violation code, then how
> > about the legacy hardwares and softmmu case?
> 
> Didn't check thoroughly but the scheme works in TCG mode.

Yeah I guess TCG will work since the SIGSEGV handler will work with
that.  I meant the shadow MMU implementation in KVM when
kvm_intel.ept=0 is set on the host.  But of course that's not a big
deal for now since that can be discussed in the kvm counterpart of the
work.  Meanwhile, considering that this series seems to provide a
general framework for live snapshot, this work is meaningful no matter
what backend magic is used (either mprotect, or userfaultfd in the
future).

Thanks,

-- 
Peter Xu
