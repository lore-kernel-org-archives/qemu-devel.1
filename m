Received: from eggs.gnu.org ([2001:4830:134:3::10]:51093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cP4zf-0007iO-Hc
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cP4za-0002Pz-Ft
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:09:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cP4za-0002Pc-Al
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:09:54 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 620AB2E2430
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 10:09:54 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  5 Jan 2017 18:09:45 +0800
Message-Id: <1483610987-24331-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] VT-d migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Amit Shah <amit.shah@redhat.com>

This series enables VT-d IOMMU migration.

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

 hw/i386/intel_iommu.c       | 21 ++++++++++++++++++++-
 include/migration/vmstate.h |  1 +
 migration/savevm.c          | 27 +++++++++++++++++++++++----
 3 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.7.4
