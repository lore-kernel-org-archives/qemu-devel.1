Received: from eggs.gnu.org ([2001:4830:134:3::10]:44853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fZwvM-0006Fu-KU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fZwvL-0000jj-7V
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:23:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fZwvL-0000jO-2L
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:23:15 -0400
Date: Mon, 2 Jul 2018 19:23:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180702112308.GO2455@xz-mi>
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
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

On Fri, Jun 29, 2018 at 11:03:13AM +0300, Denis Plotnikov wrote:
> The patch set adds the ability to make external snapshots while VM is running.

Hi, Denis,

This work is interesting, though I have a few questions to ask in
general below.

> 
> The workflow to make a snapshot is the following:
> 1. Pause the vm
> 2. Make a snapshot of block devices using the scheme of your choice

Here you explicitly took the snapshot for the block device, then...

> 3. Turn on background-snapshot migration capability
> 4. Start the migration using the destination (migration stream) of your choice.

... here you started the VM snapshot.  How did you make sure that the
VM snapshot (e.g., the RAM data) and the block snapshot will be
aligned?

For example, in current save_snapshot() we'll quiesce disk IOs before
migrating the last pieces of RAM data to make sure they are aligned.
I didn't figure out myself on how that's done in this work.

>    The migration will resume the vm execution by itself
>    when it has the devices' states saved  and is ready to start ram writing
>    to the migration stream.
> 5. Listen to the migration finish event
> 
> The feature relies on KVM unapplied ability to report the faulting address.
> Please find the KVM patch snippet to make the patchset work below:
> 
> +++ b/arch/x86/kvm/vmx.c
> @@ -XXXX,X +XXXX,XX @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
>  
>         vcpu->arch.exit_qualification = exit_qualification;
>  
> -       return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
> +       r = kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
> +        if (r == -EFAULT) {
> +               unsigned long hva = kvm_vcpu_gfn_to_hva(vcpu, gpa >> PAGE_SHIFT);
> +
> +               vcpu->run->exit_reason = KVM_EXIT_FAIL_MEM_ACCESS;
> +               vcpu->run->hw.hardware_exit_reason = EXIT_REASON_EPT_VIOLATION;
> +               vcpu->run->fail_mem_access.hva = hva | (gpa & (PAGE_SIZE-1));
> +               r = 0;
> +
> +       }
> +       return r;

Just to make sure I fully understand here: so this is some extra KVM
work just to make sure the mprotect() trick will work even for KVM
vcpu threads, am I right?

Meanwhile, I see that you only modified EPT violation code, then how
about the legacy hardwares and softmmu case?

Thanks,

> 
> The patch to KVM can be sent if the patch set approved
> 
> Denis Plotnikov (7):
>   migration: add background snapshot capability
>   bitops: add some atomic versions of bitmap operations
>   threads: add infrastructure to process sigsegv
>   migration: add background snapshot infrastructure
>   kvm: add failed memeory access exit reason
>   kvm: add vCPU failed memeory access processing
>   migration: add background snapshotting
> 
>  include/exec/ram_addr.h   |   7 +
>  include/exec/ramlist.h    |   4 +-
>  include/qemu/bitops.h     |  24 +++
>  include/qemu/thread.h     |   5 +
>  linux-headers/linux/kvm.h |   5 +
>  migration/migration.c     | 141 +++++++++++++++-
>  migration/migration.h     |   1 +
>  migration/ram.c           | 333 ++++++++++++++++++++++++++++++++++++--
>  migration/ram.h           |  11 +-
>  migration/savevm.c        |  91 ++++++-----
>  migration/savevm.h        |   2 +
>  qapi/migration.json       |   6 +-
>  target/i386/kvm.c         |  18 +++
>  util/qemu-thread-posix.c  |  50 ++++++
>  14 files changed, 635 insertions(+), 63 deletions(-)
> 
> -- 
> 2.17.0
> 
> 

-- 
Peter Xu
