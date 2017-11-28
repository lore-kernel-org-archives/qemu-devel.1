Received: from eggs.gnu.org ([2001:4830:134:3::10]:32992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eJi1I-000109-Nv
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eJi1E-0004uJ-MX
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:42:00 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 28 Nov 2017 16:41:28 +0100
Message-Id: <1511883692-11511-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/4] vITS Reset
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

This series adds vITS reset modality:
- the 2 first patches bring a minimalist reset through individual
  register writes. However, with kernel versions < 4.15, this reset
  is not complete (vITS caches are not voided).
- With kernel versions >= 4.15 we can rely on a new ITS KVM device
  reset IOTCL. The last 2 patches introduce the full reset.

Tested with 4.11, 4.14 and 4.15 host kernels.

Best Regards

Eric

The series is available at:
https://github.com/eauger/qemu/tree/2.11.0-rc2-its-reset-v6

History:
v5 -> v6:
- update linux header update commit title and message
- add class_size in 2/4

v4 -> v5:
- correct error message in 2/4

v3 -> v4:
- replace partial linux header update by an exhaustive one

v2 -> v3:
- don't call post_load on reset (no iidr check anymore)

v1 -> v2:
- Clarify why abort should be removed for save. Leave abort
  for restore.
- Adopt the same reset infra as vgic
- introduce "hw/intc/arm_gicv3_its: Implement a minimalist reset"
  which perform individual register writes. This is sufficient to
  fix the issues without ioctl


Eric Auger (4):
  hw/intc/arm_gicv3_its: Don't call post_load on reset
  hw/intc/arm_gicv3_its: Implement a minimalist reset
  linux-headers: update to 4.15-rc1
  hw/intc/arm_gicv3_its: Implement full reset

 hw/intc/arm_gicv3_its_common.c                     |   2 -
 hw/intc/arm_gicv3_its_kvm.c                        |  53 ++-
 include/standard-headers/asm-s390/virtio-ccw.h     |   1 +
 include/standard-headers/asm-x86/hyperv.h          | 394 +--------------------
 include/standard-headers/linux/input-event-codes.h |   2 +
 include/standard-headers/linux/input.h             |   1 +
 include/standard-headers/linux/pci_regs.h          |  45 ++-
 linux-headers/asm-arm/kvm.h                        |   8 +
 linux-headers/asm-arm/kvm_para.h                   |   1 +
 linux-headers/asm-arm/unistd.h                     |   2 +
 linux-headers/asm-arm64/kvm.h                      |   8 +
 linux-headers/asm-arm64/unistd.h                   |   1 +
 linux-headers/asm-powerpc/epapr_hcalls.h           |   1 +
 linux-headers/asm-powerpc/kvm.h                    |   1 +
 linux-headers/asm-powerpc/kvm_para.h               |   1 +
 linux-headers/asm-powerpc/unistd.h                 |   1 +
 linux-headers/asm-s390/kvm.h                       |   1 +
 linux-headers/asm-s390/kvm_para.h                  |   1 +
 linux-headers/asm-s390/unistd.h                    |   4 +-
 linux-headers/asm-x86/kvm.h                        |   1 +
 linux-headers/asm-x86/kvm_para.h                   |   2 +-
 linux-headers/asm-x86/unistd.h                     |   1 +
 linux-headers/linux/kvm.h                          |   2 +
 linux-headers/linux/kvm_para.h                     |   1 +
 linux-headers/linux/psci.h                         |   1 +
 linux-headers/linux/userfaultfd.h                  |   1 +
 linux-headers/linux/vfio.h                         |   1 +
 linux-headers/linux/vfio_ccw.h                     |   1 +
 linux-headers/linux/vhost.h                        |   1 +
 29 files changed, 123 insertions(+), 417 deletions(-)

-- 
2.5.5
