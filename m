Received: from eggs.gnu.org ([2001:4830:134:3::10]:50982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gGLL5-00068B-ML
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 05:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gGLL4-0003Vh-KV
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 05:57:03 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sun, 28 Oct 2018 02:07:25 +0800
Message-Id: <1540663650-106694-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH V5 0/5]  add pvpanic mmio support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

The first patches are simple cleanups:
- patch 1 move the pvpanic device with the 'ocmmon objects' so we compile
  it once for the x86/arm/aarch64 archs,
- patch 2 simply renames ISA fields/definitions to generic ones.

Then instead of add/use the MMIO pvpanic device in the virt machine in an
unique patch, I split it in two distinct patches:
- patch 3 uses Peng Hao's work, but add the MMIO interface to the existing
  device (no logical change).
- patch 4 is Peng Hao's work in the virt machine (no logical change).
- patch 5 add pvpanic device in acpi table in virt machine
v2 from Peng Hao is:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03433.html

v3 --> v4
  patch 1,2 no modification.
  patch 3, add TYPE=5FPANIC=5FMMIO for distinguishing different bus device,
           virt + isa=5Fpvpanic will abnormally terminate virtual machine. =

  patch 4, "pvpanic,mmio" --> "qemu,pvpanic-mmio".
  patch 5, newly added.

v4 --> v5
  patch 1,2 no modification.
  patch 3 delete PvpanicCommonState structure.
  patch 4 VIRT=5FPVPANIC=5FMMIO --> VIRT=5FPVPANIC
          correct VIRT=5FPVPANIC's overlap start address
  patch 5 no modification.

Philippe Mathieu-Daud=C3=A9 (2):
  hw/misc/pvpanic: Build the pvpanic device in $(common-obj)
  hw/misc/pvpanic: Cosmetic renaming

Peng Hao (3):
  hw/misc/pvpanic: Add the MMIO interface
  hw/arm/virt: Use the pvpanic device
  hw/arm/virt: add pvpanic device in virt acpi table

 default-configs/aarch64-softmmu.mak |  1 +
 hw/arm/virt-acpi-build.c            | 16 ++++++++
 hw/arm/virt.c                       | 21 ++++++++++
 hw/misc/Makefile.objs               |  2 +-
 hw/misc/pvpanic.c                   | 78 ++++++++++++++++++++++++++++++---=
----
 include/hw/arm/virt.h               |  1 +
 include/hw/misc/pvpanic.h           |  2 +
 7 files changed, 105 insertions(+), 16 deletions(-)

--=20
1.8.3.1
