Received: from eggs.gnu.org ([2001:4830:134:3::10]:54052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fIyFk-0007mq-2J
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fIyFi-0005kd-RG
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:22:08 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Wed, 16 May 2018 16:20:20 +0100
Message-ID: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v2 0/6] hw/arm: Add support for non-contiguous
 iova regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: drjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, eric.auger@redhat.com, zhaoshenglong@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

When the kernel reports valid iova ranges as non-contiguous,
memory should be allocated to Guest in such a way that
reserved regions(holes) are not visible by Guest.

This series retrieves the valid iova ranges based on the new
proposed VFIO interface for kernel [1]. It then populates the
first 1GB ram as a non-pluggable dimm and rest as a pc-dimm if
the valid iova ranges are non-contiguous.

Patch #3 of this series is loosely based on an earlier attempt
by Kwangwoo Lee to add hotplug/pc-dimm support to arm64[2]

RFC v1[3] --> RFCv2
 -Based on new VFIO kernel interface
 -Part of Mem modelled as pc-dimm 
 -Rebased to qemu 2.12.0

[1] https://lkml.org/lkml/2018/4/18/293
[2] https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04600.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg02412.html

Shameer Kolothum (6):
  hw/vfio: Retrieve valid iova ranges from kernel
  hw/arm/virt: Enable dynamic generation of guest RAM memory regions
  hw/arm/virt: Add pc-dimm mem hotplug framework
  hw/arm: Changes required to accommodate non-contiguous DT mem nodes
  hw/arm: ACPI SRAT changes to accommodate non-contiguous mem
  hw/arm: Populate non-contiguous memory regions

 default-configs/aarch64-softmmu.mak |   1 +
 hw/arm/boot.c                       |  91 ++++++---
 hw/arm/virt-acpi-build.c            |  24 ++-
 hw/arm/virt.c                       | 367 +++++++++++++++++++++++++++++++++++-
 hw/vfio/common.c                    | 108 ++++++++++-
 include/hw/arm/arm.h                |  12 ++
 include/hw/arm/virt.h               |   3 +
 include/hw/vfio/vfio-common.h       |   7 +
 linux-headers/linux/vfio.h          |  23 +++
 9 files changed, 589 insertions(+), 47 deletions(-)

-- 
2.7.4
