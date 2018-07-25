Received: from eggs.gnu.org ([2001:4830:134:3::10]:50051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fiPIA-0003in-77
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fiPI7-0005bt-6E
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:17:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49748 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fiPI6-0005aV-Uf
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:17:43 -0400
Date: Wed, 25 Jul 2018 20:17:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180725191736.GE2365@work-vm>
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
	<20180629115359.GH2568@work-vm> <20180725101836.GI2479@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725101836.GI2479@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v0 0/7] Background snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>, aarcange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Jun 29, 2018 at 12:53:59PM +0100, Dr. David Alan Gilbert wrote:
> > * Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
> > > The patch set adds the ability to make external snapshots while VM is running.
> > 
> > cc'ing in Andrea since this uses sigsegv's to avoid userfault-wp that
> > isn't there yet.
> > 
> > Hi Denis,
> >   How robust are you finding this SEGV based trick; for example what
> > about things like the kernel walking vhost queues or similar kernel
> > nasties?
> 
> (I'm commenting on this old series to keep the discussion together)
> 
> If we want to make this series really work for people, we should
> possibly need to know whether it could work with vhost (otherwise we
> might need to go back to userfaultfd write-protection).
> 
> I digged a bit on the vhost-net IO, it should be using two ways to
> write to guest memory:
> 
> - copy_to_user(): this should possibly still be able to be captured by
>   mprotect() (after some confirmation from Paolo, but still we'd
>   better try it out)

What confuses me here is who is going to get the signal from this and
how we recover from the signal - or does it come back as an error
on the vhost fd somehow?

Dave

> - kmap_atomic(): this is used to log dirty pages, this seems to be
>   incompatible with mprotect() but I think we can just make sure dirty
>   page tracking is disabled when live snapshot is enabled (please
>   refer to the code clip below as a referece)
> 
> So IMHO this series should work with vhost if with logging off, but we
> need to confirm...  Denis, do you want to do some more test with vhost
> when you do your next post (possibly with changes like below)?
> 
> =====================
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 24dea2730c..a3fa256143 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1605,6 +1605,10 @@ static void migration_bitmap_sync(RAMState *rs)
>      int64_t end_time;
>      uint64_t bytes_xfer_now;
>  
> +    if (live_snapshot) {
> +        return;
> +    }
> +
>      ram_counters.dirty_sync_count++;
>  
>      if (!rs->time_last_bitmap_sync) {
> @@ -2952,7 +2956,10 @@ static void ram_init_bitmaps(RAMState *rs)
>      rcu_read_lock();
>  
>      ram_list_init_bitmaps();
> -    memory_global_dirty_log_start();
> +
> +    if (!live_snapshot) {
> +        memory_global_dirty_log_start();
> +    }
>      migration_bitmap_sync(rs);
>  
>      rcu_read_unlock();
> 
> 
> > 
> > Dave
> > 
> > > The workflow to make a snapshot is the following:
> > > 1. Pause the vm
> > > 2. Make a snapshot of block devices using the scheme of your choice
> > > 3. Turn on background-snapshot migration capability
> > > 4. Start the migration using the destination (migration stream) of your choice.
> > >    The migration will resume the vm execution by itself
> > >    when it has the devices' states saved  and is ready to start ram writing
> > >    to the migration stream.
> > > 5. Listen to the migration finish event
> > > 
> > > The feature relies on KVM unapplied ability to report the faulting address.
> > > Please find the KVM patch snippet to make the patchset work below:
> > > 
> > > +++ b/arch/x86/kvm/vmx.c
> > > @@ -XXXX,X +XXXX,XX @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
> > >  
> > >         vcpu->arch.exit_qualification = exit_qualification;
> > >  
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
> > > 
> > > The patch to KVM can be sent if the patch set approved
> > > 
> > > Denis Plotnikov (7):
> > >   migration: add background snapshot capability
> > >   bitops: add some atomic versions of bitmap operations
> > >   threads: add infrastructure to process sigsegv
> > >   migration: add background snapshot infrastructure
> > >   kvm: add failed memeory access exit reason
> > >   kvm: add vCPU failed memeory access processing
> > >   migration: add background snapshotting
> > > 
> > >  include/exec/ram_addr.h   |   7 +
> > >  include/exec/ramlist.h    |   4 +-
> > >  include/qemu/bitops.h     |  24 +++
> > >  include/qemu/thread.h     |   5 +
> > >  linux-headers/linux/kvm.h |   5 +
> > >  migration/migration.c     | 141 +++++++++++++++-
> > >  migration/migration.h     |   1 +
> > >  migration/ram.c           | 333 ++++++++++++++++++++++++++++++++++++--
> > >  migration/ram.h           |  11 +-
> > >  migration/savevm.c        |  91 ++++++-----
> > >  migration/savevm.h        |   2 +
> > >  qapi/migration.json       |   6 +-
> > >  target/i386/kvm.c         |  18 +++
> > >  util/qemu-thread-posix.c  |  50 ++++++
> > >  14 files changed, 635 insertions(+), 63 deletions(-)
> > > 
> > > -- 
> > > 2.17.0
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
> Regards,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
