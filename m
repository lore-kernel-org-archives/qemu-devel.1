Received: from eggs.gnu.org ([2001:4830:134:3::10]:40963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dtt4d-0003NS-7D
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dtt4X-0002r1-Ni
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:14:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mgamal@redhat.com>) id 1dtt4X-0002qb-J5
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:14:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C42E6883BA
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 10:14:35 +0000 (UTC)
From: Mohammed Gamal <mgamal@redhat.com>
Date: Mon, 18 Sep 2017 12:14:07 +0200
Message-Id: <1505729649-11943-1-git-send-email-mgamal@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] x86_iommu: Fix segfault when starting
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

v2 --> v3:
* Use PC_MACHINE macro directly

Mohammed Gamal (2):
  x86_iommu: Move machine check to x86_iommu_realize()
  x86_iommu: check if machine has PCI bus

 hw/i386/amd_iommu.c   | 10 +---------
 hw/i386/intel_iommu.c | 10 +---------
 hw/i386/x86-iommu.c   | 12 ++++++++++++
 3 files changed, 14 insertions(+), 18 deletions(-)

-- 
1.8.3.1
