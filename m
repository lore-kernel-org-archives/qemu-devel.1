Received: from eggs.gnu.org ([2001:4830:134:3::10]:43452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dssBH-0005Gk-8d
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dssBB-0002ju-Ew
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:05:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mgamal@redhat.com>) id 1dssBB-0002je-8U
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FCEBC047B9B
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 15:05:16 +0000 (UTC)
From: Mohammed Gamal <mgamal@redhat.com>
Date: Fri, 15 Sep 2017 17:04:35 +0200
Message-Id: <1505487877-22799-1-git-send-email-mgamal@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] x86_iommu: Fix segfault when starting
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

v1 --> v2:
* Change error message with capitalized acronym

Mohammed Gamal (2):
  x86_iommu: Move machine check to x86_iommu_realize()
  x86_iommu: check if machine has PCI bus

 hw/i386/amd_iommu.c   | 10 +---------
 hw/i386/intel_iommu.c | 10 +---------
 hw/i386/x86-iommu.c   | 13 +++++++++++++
 3 files changed, 15 insertions(+), 18 deletions(-)

-- 
1.8.3.1
