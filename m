Received: from eggs.gnu.org ([2001:4830:134:3::10]:56621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dxDly-0000UC-7V
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dxDlu-0001Xl-HT
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:57:14 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 27 Sep 2017 16:56:42 +0200
Message-Id: <1506524205-20763-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 0/3] vITS Reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, wanghaibin.wang@huawei.com
Cc: vijay.kilari@gmail.com, drjones@redhat.com, wei@redhat.com, quintela@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org, wu.wubin@huawei.com

At the moment the ITS is not properly reset. On System reset or
reboot, previous ITS register values and caches are left
unchanged. Some of the registers might point to some guest RAM
tables which are not provisionned. This leads to state
inconsistencies that are detected by the kernel save/restore
code. And eventually this may cause qemu abort on source or
destination.

The 1st patch, suggested to be cc'ed stable proposes to remove
the abort in case of table save/restore failure. This is
definitively not ideal but looks the most reasonable until we
get a proper way to reset the ITS. Still a message is emitted
to report the save/restore did not happen correctly.

Subsequent patches add the support of explicit reset using
a new kvm device group/attribute combo. The associated kernel
series is not upstream [1], hence the RFC.

ITS specification is not very clear about reset. There is no
reset wire. Some register fields are documented to have
architecturally defined reset values and we use those here:
Most importantly the Valid bit of GITS_CBASER and GITS_BASER
are cleared and the GITS_CTLR.Enabled bit is cleared as well.

Best Regards

Eric

Host Kernel dependencies:
- [1] [PATCH 0/10 v2] vITS Migration fixes and reset

The series is available at:
https://github.com/eauger/qemu/tree/v2.10-its-reset-v1


Eric Auger (3):
  hw/intc/arm_gicv3_its: Don't abort on table save/restore
  linux-headers: Partial header update for ITS reset
  hw/intc/arm_gicv3_its: Implement reset

 hw/intc/arm_gicv3_its_common.c         |  5 ++---
 hw/intc/arm_gicv3_its_kvm.c            | 37 ++++++++++++++++++++++++----------
 include/hw/intc/arm_gicv3_its_common.h |  1 +
 linux-headers/asm-arm/kvm.h            |  1 +
 linux-headers/asm-arm64/kvm.h          |  1 +
 5 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.5.5
