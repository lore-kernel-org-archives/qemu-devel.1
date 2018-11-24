Received: from eggs.gnu.org ([2001:4830:134:3::10]:52588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gQTUI-0002j7-Jp
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 03:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gQTSb-0000I6-8V
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 03:38:42 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sun, 25 Nov 2018 01:00:11 +0800
Message-Id: <1543078821-16636-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH V8 00/10] add pvpanic mmio support
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
    =20
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
   =20
v5 --> v6
     add document.
 =20
v6 --> v7
     patch 5 modify device name from "PANC" to "PEVT".
     patch 6 modify document description.

v7 --> v8
     add configure interface for pvpanic-mmio

the kernel part of the series:
     https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/l=
og/?h=3Dchar-misc-testing
     misc/pvpanic: remove a redundant comma
     misc/pvpanic: convert to SPDX license tags
     misc/pvpanic: change header file sort style
     misc/pvpanic: remove unnecessary header file
     misc/pvpanic : break dependency on ACPI
     misc/pvpanic : grouping ACPI related stuff
     misc/pvpanic: add support to get pvpanic device info FDT
     dt-bindings: misc/pvpanic: add document for pvpanic-mmio
     misc/pvpanic: add MMIO support
     misc/pvpanic: simplify the code using acpi=5Fdev=5Fresource=5Fio
     pvpanic: move pvpanic to misc as common driver

Philippe Mathieu-Daud=C3=A9 (2):
  hw/misc/pvpanic: Build the pvpanic device in $(common-obj)
  hw/misc/pvpanic: Cosmetic renaming

Peng Hao (8):
  hw/misc/pvpanic: Add the MMIO interface
  hw/misc/pvpanic: moving structure definition to header file
  hw/arm/virt: Use the pvpanic device
  hw/arm/virt: add pvpanic device in virt acpi table
  hw/misc/pvpanic: add configure query interface
  hw/misc/pvpanic: preparing for adding configure interface
  hw/misc/pvpanic: realize the configure interface
  pvpanic : update pvpanic document
 =20
 default-configs/arm-softmmu.mak |  1 +
 docs/specs/pvpanic.txt          | 18 +++++++++--
 hw/arm/sysbus-fdt.c             |  2 ++
 hw/arm/virt-acpi-build.c        | 18 +++++++++++
 hw/arm/virt.c                   | 22 +++++++++++++
 hw/misc/Makefile.objs           |  2 +-
 hw/misc/pvpanic.c               | 68 ++++++++++++++++++++++++++++---------=
----
 include/hw/arm/virt.h           |  1 +
 include/hw/misc/pvpanic.h       | 34 +++++++++++++++++++++
 9 files changed, 140 insertions(+), 26 deletions(-)

--=20
1.8.3.1
