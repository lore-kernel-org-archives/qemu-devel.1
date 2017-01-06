Received: from eggs.gnu.org ([2001:4830:134:3::10]:57584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPLnM-0007Q6-Ol
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 23:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPLnJ-0001Mq-Ea
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 23:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cPLnJ-0001Mm-8k
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 23:06:21 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C3F4C01C787
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 04:06:21 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  6 Jan 2017 12:06:11 +0800
Message-Id: <1483675573-12636-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] VT-d migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This series enables VT-d IOMMU migration.

v3:
- save/load for csr [Jason]

v2:
- remove SaveStateEntry.priority, let priority store only in one
  place, which is VMStateDescription. Meanwhile, provide another
  helper to fetch the priority.
- add enum MigrationPriority to unify the ordering, rather than use
  magic numbers like 100 everywhere [Dave]
- fix commit log where proper

First patch is an enhancement to current migration framework to allow
prioritized save state entry. This is required to let VT-d migrate
properly.

The second patch enables the migration for the vIOMMU.

Please check commit message for more information.

Test done:

Smoke test is done with parameter:

  $qemu -M q35,kernel-irqchip=off -enable-kvm \
        -device intel-iommu,intremap=on \
        -netdev user,id=net0 \
        -device e1000,netdev=net0 \
        -m 512M -monitor stdio \
        $param /var/lib/libvirt/images/vm1.qcow2

Please review, thanks.

(P.S. I found that split irqchip cannot work well with migration. Is
 this an known issue?)

Peter Xu (2):
  migration: allow to prioritize save state entries
  intel_iommu: allow migration

 hw/i386/intel_iommu.c       | 22 +++++++++++++++++++++-
 include/migration/vmstate.h |  7 +++++++
 migration/savevm.c          | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 58 insertions(+), 5 deletions(-)

-- 
2.7.4
