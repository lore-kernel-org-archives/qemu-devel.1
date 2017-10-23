Received: from eggs.gnu.org ([2001:4830:134:3::10]:57215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e6elm-0002cp-G4
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e6ell-0004iE-Gq
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:36:02 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 23 Oct 2017 17:35:33 +0200
Message-Id: <1508772937-21054-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 0/4] vITS Reset
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
tables which are not valid anymore. This leads to state
inconsistencies that are detected by the kernel save/restore
code. And eventually this may cause qemu abort.

The two first patches would need to be cc'ed stable. Assuming
patches 1-5 of "[PATCH v5 00/10] vITS Migration fixes and reset" 
 also are cc'ed stable, they fix the above issue, without 
implementing a dedicated ITS KVM device reset IOCTL.
Patches 3-4 use the new reset IOCTL which clarifies the reset
process.

The series is in RFC state as it depends on:
[1] [PATCH v5 00/10] vITS Migration fixes and reset

Best Regards

Eric

The series is available at:
https://github.com/eauger/qemu/tree/v2.10-its-reset-v2

History:
v1 -> v2:
- Clarify why abort should be removed for save. Leave abort
  for restore.
- Adopt the same reset infra as vgic
- introduce "hw/intc/arm_gicv3_its: Implement a minimalist reset"
  which perform individual register writes. This is sufficient to
  fix the issues without ioctl

Eric Auger (4):
  hw/intc/arm_gicv3_its: Don't abort on table save failure
  hw/intc/arm_gicv3_its: Implement a minimalist reset
  linux-headers: Partial header update for ITS reset
  hw/intc/arm_gicv3_its: Implement full reset

 hw/intc/arm_gicv3_its_kvm.c   | 53 +++++++++++++++++++++++++++++++++++++------
 linux-headers/asm-arm/kvm.h   |  1 +
 linux-headers/asm-arm64/kvm.h |  1 +
 3 files changed, 48 insertions(+), 7 deletions(-)

-- 
2.5.5
