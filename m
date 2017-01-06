Received: from eggs.gnu.org ([2001:4830:134:3::10]:40767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPUYd-0008CL-H1
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPUYZ-0007sq-Jq
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:27:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cPUYZ-0007se-EZ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:27:43 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4B4A61976
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 13:27:43 +0000 (UTC)
Date: Fri, 6 Jan 2017 13:27:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170106132738.GD2461@work-vm>
References: <1483675573-12636-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483675573-12636-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] VT-d migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit.shah@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> This series enables VT-d IOMMU migration.
> 
> v3:
> - save/load for csr [Jason]
> 
> v2:
> - remove SaveStateEntry.priority, let priority store only in one
>   place, which is VMStateDescription. Meanwhile, provide another
>   helper to fetch the priority.
> - add enum MigrationPriority to unify the ordering, rather than use
>   magic numbers like 100 everywhere [Dave]
> - fix commit log where proper
> 
> First patch is an enhancement to current migration framework to allow
> prioritized save state entry. This is required to let VT-d migrate
> properly.
> 
> The second patch enables the migration for the vIOMMU.
> 
> Please check commit message for more information.
> 
> Test done:
> 
> Smoke test is done with parameter:
> 
>   $qemu -M q35,kernel-irqchip=off -enable-kvm \
>         -device intel-iommu,intremap=on \
>         -netdev user,id=net0 \
>         -device e1000,netdev=net0 \
>         -m 512M -monitor stdio \
>         $param /var/lib/libvirt/images/vm1.qcow2
> 
> Please review, thanks.
> 
> (P.S. I found that split irqchip cannot work well with migration. Is
>  this an known issue?)

How did it fail?

Dave

> Peter Xu (2):
>   migration: allow to prioritize save state entries
>   intel_iommu: allow migration
> 
>  hw/i386/intel_iommu.c       | 22 +++++++++++++++++++++-
>  include/migration/vmstate.h |  7 +++++++
>  migration/savevm.c          | 34 ++++++++++++++++++++++++++++++----
>  3 files changed, 58 insertions(+), 5 deletions(-)
> 
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
