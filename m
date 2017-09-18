Received: from eggs.gnu.org ([2001:4830:134:3::10]:55074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dtxBe-0004bh-4w
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dtxBa-00056Z-55
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:38:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mgamal@redhat.com>) id 1dtxBZ-000563-Vq
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:38:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF37863E12
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 14:38:08 +0000 (UTC)
From: Mohammed Gamal <mgamal@redhat.com>
Date: Mon, 18 Sep 2017 16:37:47 +0200
Message-Id: <1505745470-12208-1-git-send-email-mgamal@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/3] x86_iommu: Fix segfault when starting
 on non-PCI machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, thuth@redhat.com, peterx@redhat.com, pbonzini@redhat.com, Mohammed Gamal <mgamal@redhat.com>

Starting qemu with
qemu-system-x86_64 -S -M isapc -device {amd|intel}-iommu
leads to a segfault. The code assume PCI bus is present and
tries to access the bus structure without checking.

The patch series moves the error checks from vtd_realize()
and amdvi_realize() to the generic x86_iommu_realize() and
adds a check for PCI bus presence.

v3 --> v4:
  * Restore correct object_dynamic_cast() in x86_iommu_realize()
  * Remove redundant casting in callee functions. Implemented in
    a new patch

Mohammed Gamal (3):
  x86_iommu: Move machine check to x86_iommu_realize()
  intel_iommu, amd_iommu: Remove redundant object_dynamic_cast calls
  x86_iommu: check if machine has PCI bus

 hw/i386/amd_iommu.c   | 13 ++-----------
 hw/i386/intel_iommu.c | 13 ++-----------
 hw/i386/x86-iommu.c   | 13 +++++++++++++
 3 files changed, 17 insertions(+), 22 deletions(-)

-- 
1.8.3.1
