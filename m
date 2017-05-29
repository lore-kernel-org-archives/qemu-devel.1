Received: from eggs.gnu.org ([2001:4830:134:3::10]:56997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG71-0005gv-GX
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG6y-0004sF-Dm
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:62237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhi.a.wang@intel.com>)
	id 1dFG6y-0004s0-5c
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:12 -0400
From: Zhi Wang <zhi.a.wang@intel.com>
Date: Tue, 30 May 2017 01:30:30 +0800
Message-Id: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
Subject: [Qemu-devel] [RFC 0/6] Refine IGD stolen memory support in VFIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: chuanxiao.dong@intel.com, daniel.vetter@ffwll.ch, xiong.y.zhang@intel.com, joonas.lahtinen@linux.intel.com, zhiyuan.lv@intel.com, zhenyuw@linux.intel.com, kevin.tian@intel.com, Zhi Wang <zhi.a.wang@intel.com>

This patch series are aim to refine the IGD stolen memory support in QEMU.

Some features of Intel HW relies on the stolen memory to work, but some of
registers used to indicate the base address of stolen memory can only be
programmed once after system is powered-up. This will cause problems if
the base of the stolen memory is changed during IGD passthrough.

The solution of this patch series is allocating a new VM dedicated memory
as "guest stolen memory" in QEMU for isolation and let the "guest stolen
memory" sits in the same PA as host.

Also it introduces Intel platform definitions and clears some old funtions
and definitions.

Zhi Wang (6):
  vfio: Add Intel platform definitions
  vfio: Setup IGD quirks earlier
  vfio: Setup IGD stolen memory
  vfio: Refine GGTT clearing
  vfio: Remove extra quirks and old definitions
  vfio: Setup IGD stolen memory under secondary mode

 hw/vfio/Makefile.objs    |   2 +-
 hw/vfio/intel-platform.c | 366 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/intel-platform.h |  38 +++++
 hw/vfio/pci-quirks.c     | 322 ++++++++---------------------------------
 4 files changed, 463 insertions(+), 265 deletions(-)
 create mode 100644 hw/vfio/intel-platform.c
 create mode 100644 hw/vfio/intel-platform.h

-- 
2.7.4
