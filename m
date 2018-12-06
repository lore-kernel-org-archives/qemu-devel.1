Received: from eggs.gnu.org ([2001:4830:134:3::10]:49887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gUrSH-0002wX-C0
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gUrSF-0000Ea-QL
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:04:29 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Thu, 6 Dec 2018 19:25:55 +0800
Message-Id: <1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH V12 0/5] add pvpanic mmio support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

The first patches are simple cleanups:
     - patch 1 move the pvpanic device with the 'ocmmon objects' so we comp=
ile
               it once for the x86/arm/aarch64 archs,
     - patch 2 simply renames ISA fields/definitions to generic ones.

     Then instead of add/use the MMIO pvpanic device in the virt machine in=
 an
     unique patch, I split it in two distinct patches:
     - patch 3 uses Peng Hao's work, but add the MMIO interface to the exis=
ting
        device (no logical change).
     - patch 4 is Peng Hao's work in the virt machine (no logical change).
     - patch 5 add pvpanic device in acpi table in virt machine
     v2 from Peng Hao is:
     https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03433.html

v3 --> v4
     patch 1,2 no modification.
     patch 3, add TYPE=5FPANIC=5FMMIO for distinguishing different bus devi=
ce,
              virt + isa=5Fpvpanic will abnormally terminate virtual machin=
e.
     patch 4, "pvpanic,mmio" --> "qemu,pvpanic-mmio".
     patch 5, newly added.

v4 --> v5
     patch 1,2 no modification.
     patch 3 delete PvpanicCommonState structure.
     patch 4 VIRT=5FPVPANIC=5FMMIO --> VIRT=5FPVPANIC
             correct VIRT=5FPVPANIC's overlap start address
     patch 5 no modification.

v5 --> v6
     add document.

v6 --> v7
     patch 5 modify device name from "PANC" to "PEVT".
     patch 6 modify document description.

v7 --> v8
     add configure interface for pvpanic-mmio

v8 --> v9
     revert "moving structure definition to header file"
     because of compile error in x86.

v9 --> v10
     Modify document.
     Repair missing header files.

v10 --> v11
     change configure interface in virt machine configure parameters.

v11 --> v12
     realize pvpanic as a pci device and use the mmio of pci device.

Philippe Mathieu-Daud=C3=A9 (2):
  hw/misc/pvpanic: Build the pvpanic device in $(common-obj)
  hw/misc/pvpanic: Cosmetic renaming

Peng Hao (3):
  pvpanic : update pvpanic document
  hw/arm/virt: Use the pvpanic device
  pvpanic: add mmio interface as a pci device

default-configs/arm-softmmu.mak |  1 +
docs/specs/pvpanic.txt          | 13 +++++-
hw/misc/Makefile.objs           |  2 +-
hw/misc/pvpanic.c               | 91 +++++++++++++++++++++++++++++++++-----=
---
include/hw/misc/pvpanic.h       |  1 +
include/hw/pci/pci.h            |  1 +
6 files changed, 91 insertions(+), 18 deletions(-)

--=20
1.8.3.1
