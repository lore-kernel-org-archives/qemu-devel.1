Received: from eggs.gnu.org ([2001:4830:134:3::10]:54685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fzm6z-0008Pa-83
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fzlrd-0002g1-MA
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 12:50:14 -0400
Received: from mail-eopbgr730079.outbound.protection.outlook.com
	([40.107.73.79]:55072
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1fzlrb-0002dH-KW
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 12:50:09 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Tue, 11 Sep 2018 11:49:43 -0500
Message-Id: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/6] x86_iommu/amd: add interrupt remap support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This series adds the interrupt remapping support for amd-iommu device.

IOMMU spec is available at: https://support.amd.com/TechDocs/48882_IOMMU.pdf

To enable the interrupt remap use below qemu cli
# $QEMU \
  -device amd-iommu,intremap=on

I have tested FC-28 and Ubuntu 18.04 guest. 

Linux guest bootup log shows the interrupt remap supports:

[root@localhost ~]# dmesg | grep -i AMD-Vi
[    0.001761] AMD-Vi: Using IVHD type 0x10
[    0.003051] AMD-Vi: device: 00:03.0 cap: 0040 seg: 0 flags: d1 info 0000
[    0.004007] AMD-Vi:        mmio-addr: 00000000fed80000
[    0.004874] AMD-Vi:   DEV_ALL                        flags: 00
[    0.006236] AMD-Vi:   DEV_SPECIAL(IOAPIC[0])         devid: 00:14.0
[    0.667943] AMD-Vi: Found IOMMU at 0000:00:03.0 cap 0x40
[    0.668727] AMD-Vi: Extended features (0x29d3):
[    0.669874] AMD-Vi: Interrupt remapping enabled
[    0.671074] AMD-Vi: Lazy IO/TLB flushing enabled

cat /proc/interrupts confirms that its using IR

[root@localhost ~]# cat /proc/interrupts 
CPU0       
 0:         40  IR-IO-APIC    2-edge      timer
 1:          9  IR-IO-APIC    1-edge      i8042
 4:       1770  IR-IO-APIC    4-edge      ttyS0
 7:          0  IR-IO-APIC    7-edge      parport0
 8:          1  IR-IO-APIC    8-edge      rtc0
 9:          0  IR-IO-APIC    9-fasteoi   acpi
12:         15  IR-IO-APIC   12-edge      i8042
16:          0  IR-IO-APIC   16-fasteoi   i801_smbus
24:          0   PCI-MSI 49152-edge      AMD-Vi
25:      13070  IR-PCI-MSI 512000-edge      ahci[0000:00:1f.2]
26:         86  IR-PCI-MSI 32768-edge      enp0s2-rx-0
27:        139  IR-PCI-MSI 32769-edge      enp0s2-tx-0
28:          1  IR-PCI-MSI 32770-edge      enp0s2
NMI:          0   Non-maskable interrupts
LOC:      26686   Local timer interrupts
SPU:          0   Spurious interrupts
...
...

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Brijesh Singh (6):
  x86_iommu: move the kernel-irqchip check in common code
  x86_iommu/amd: Prepare for interrupt remap support
  x86_iommu/amd: Add interrupt remap support when VAPIC is not enabled
  i386: acpi: add IVHD device entry for IOAPIC
  x86_iommu/amd: Add interrupt remap support when VAPIC is enabled
  x86_iommu/amd: Enable Guest virtual APIC support

 hw/i386/acpi-build.c  |  23 +++-
 hw/i386/amd_iommu.c   | 360 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h   | 115 +++++++++++++++-
 hw/i386/intel_iommu.c |   7 -
 hw/i386/trace-events  |  14 ++
 hw/i386/x86-iommu.c   |   9 ++
 6 files changed, 516 insertions(+), 12 deletions(-)

-- 
2.7.4
