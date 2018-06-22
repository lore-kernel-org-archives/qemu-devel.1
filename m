Received: from eggs.gnu.org ([2001:4830:134:3::10]:41439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWJA3-0000Jg-Fx
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWJA2-0005a6-7f
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:19:23 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 22 Jun 2018 12:19:04 +0200
Message-Id: <1529662749-32069-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 0/5] ARM virt: Support PC-DIMM at 2TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com

This series aims at supporting PC-DIMM in machvirt. The device_memory
is set at 2TB. While its max capacity is currently limited to 2TB,
the actual size depends on the initial guest RAM size and maxmem
parameter. Using memory beyond 2TB is possible if KVM, the FW and the
guest supports up to 42 bit IPA/GPA.

Actual hot-plug and hot-unplug of PC-DIMM is not suported due to lack
of support of those features in baremetal.

This series reuses/rebases patches initially submitted by Shameer in [1]
and Kwangwoo in [2].

[1] [RFC v2 0/6] hw/arm: Add support for non-contiguous iova regions
http://patchwork.ozlabs.org/cover/914694/

[2] [RFC PATCH 0/3] add nvdimm support on AArch64 virt platform
https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04599.html

It has the following dependencies:

[3] [RFC 0/6] KVM/ARM: Dynamic and larger GPA size
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05759.htm
which itself depends on the kernel series [4]

[4] [PATCH v2 00/17] kvm: arm64: Dynamic & 52bit IPA support
https://lkml.org/lkml/2018/3/27/437
For testing, use my kernel branch:
https://github.com/eauger/linux/tree/4.16.0-rc3-Suzuki-52b-IPA-v2

Best Regards

Eric

This QEMU series can be found at:
https://github.com/eauger/qemu/tree/v2.12.0-pcdimm-2tb-rfc

Tests:
- On Cavium Gigabyte, a 48b VM was created and PC-DIMM slots were successfully
  added and recognized by the guest. EDK2 has a fixed limit at 40b PA so this
  was tested without FW. NUMA config has not been tested yet.

Eric Auger (1):
  hw/arm/virt: Allocate device_memory

Shameer Kolothum (4):
  hw/arm/virt: Add pc-dimm mem hotplug framework
  hw/arm/boot: introduce fdt_add_memory_node helper
  hw/arm/boot: Expose the PC-DIMM nodes in the DT
  hw/arm/virt-acpi-build: Add PC-DIMM in SRAT

 default-configs/arm-softmmu.mak |   2 +
 hw/arm/boot.c                   | 110 ++++++++++++++++++++--------
 hw/arm/virt-acpi-build.c        |  34 +++++++++
 hw/arm/virt.c                   | 158 ++++++++++++++++++++++++++++++++--------
 include/hw/arm/arm.h            |   2 +
 include/hw/arm/virt.h           |   1 +
 6 files changed, 247 insertions(+), 60 deletions(-)

-- 
2.5.5
