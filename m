Received: from eggs.gnu.org ([2001:4830:134:3::10]:34976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE16L-0006OE-AY
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE16K-00027F-G7
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:47:09 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Dec 2016 22:46:31 +0100
Message-Id: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests RFC 00/15] arm/arm64: add ITS framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org, drjones@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org
Cc: andre.przywara@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com

This series proposes a framework to test the virtual ITS.
This is based on Drew's v7 series [1]. The last patch tests
several ITS commands (collection/device mapping, interrupt
translation service entry creation and LPI trigger through INT
command). At this point we don't use any external PCIe device
to write into the GITS_TRANSLATER register.

The bulk of the code derives from the ITS driver code so all
the credit is due to Marc.

Many other ITS commands could be tested. Also existing MMIO
accesses could be enhanced into standalone tests. Current focus
was to make it functional.

The code deserves more cleanup with respect to cacheability
attributes in general.

Tested on Cavium ThunderX [2].

Best Regards

Eric

[1] [kvm-unit-tests PATCH v7 00/11] arm/arm64: add gic framework

[2] sample command line:

$QEMU -machine virt,accel=kvm -cpu host \
 -device virtio-serial-device \
 -device virtconsole,chardev=ctd -chardev testdev,id=ctd \
 -display none -serial stdio \
 -kernel arm/gic.flat \
 -smp 8 -machine gic-version=3 -append 'its'

Eric Auger (15):
  libcflat: Add other size defines
  arm/arm64: gicv3: Add some re-distributor defines
  arm/arm64: ITS skeleton
  arm/arm64: ITS: BASER parsing and setup
  arm/arm64: GICv3: add cpu count
  arm/arm64: ITS: Set the LPI config and pending tables
  arm/arm64: ITS: Init the command queue
  arm/arm64: ITS: enable LPIs at re-distributor level
  arm/arm64: ITS: Parse the typer register
  arm/arm64: ITS: its_enable_defaults
  arm/arm64: ITS: create device
  arm/arm64: ITS: create collection
  arm/arm64: ITS: commands
  arm/arm64: gic: Generalize ipi_enable()
  arm/arm64: ITS test

 arm/Makefile.common        |   1 +
 arm/gic.c                  | 101 +++++++++++-
 lib/arm/asm/gic-v3-its.h   | 238 +++++++++++++++++++++++++++
 lib/arm/asm/gic-v3.h       |  84 ++++++++++
 lib/arm/asm/gic.h          |   1 +
 lib/arm/gic-v3-its-cmd.c   | 399 +++++++++++++++++++++++++++++++++++++++++++++
 lib/arm/gic-v3-its.c       | 305 ++++++++++++++++++++++++++++++++++
 lib/arm/gic-v3.c           |   2 +
 lib/arm/gic.c              |  30 +++-
 lib/arm64/asm/gic-v3-its.h |   1 +
 lib/libcflat.h             |   3 +
 11 files changed, 1154 insertions(+), 11 deletions(-)
 create mode 100644 lib/arm/asm/gic-v3-its.h
 create mode 100644 lib/arm/gic-v3-its-cmd.c
 create mode 100644 lib/arm/gic-v3-its.c
 create mode 100644 lib/arm64/asm/gic-v3-its.h

-- 
2.5.5
