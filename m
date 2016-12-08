Received: from eggs.gnu.org ([2001:4830:134:3::10]:59672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qC-0002pa-1O
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qA-00046u-HE
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:50:44 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Thu,  8 Dec 2016 18:50:20 +0100
Message-Id: <20161208175030.12269-1-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH kvm-unit-tests v8 00/10] arm/arm64: add gic
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, marc.zyngier@arm.com, andre.przywara@arm.com, eric.auger@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, christoffer.dall@linaro.org


v8:
 - Main change is rebasing to Wei's sysreg framework, which is part
   of his PMU series, which I've applied to arm/next. That rebase
   leads to dropping the first two patches of the v7 series, expecting
   get_mpidr() to return u64 (with future patches), a rework of the
   delay routines (now based on sysreg framework), and changes to all
   sysreg asms
 - The delay routines also got their own files: delay.[ch]
 - Another bigger change was to now keep gic_common_ops local to
   lib/arm/gic.c, export the functions from the gic-v[23] instead
 - Yet another bigger change was dropping the sender and irq cmdline
   inputs, hard coding to '1' is sufficient and much less code
 - Other minor changes listed in individual patches  =20


v7:
 - biggest change is splitting lib/arm/gic.c into lib/arm/gic.c,
   lib/arm/gic-v2.c, lib/arm/gic-v3.c
 - second biggest change, which probably affects Alex, is that
   gic_ipi_send(cpu, irq) changed to gic_ipi_send_single(irq, cpu),
   note the swapping of cpu and irq!
 - other changes thanks to Eric are noted in individual patches
 - also rebased to latest master

v6:
 - rebased to latest master
 - several other changes thanks to Andre and Alex, changes in
   individual patch change logs
 - some code cleanups

v5:
 - fix arm32/gicv3 compile [drew]
 - use modern register names [Andre]
 - one Andre r-b

v4:
 - Eric's r-b's
 - Andre's suggestion to only take defines we need
 - several other changes listed in individual patches

v3:
 - Rebased on latest master
 - Added Alex's r-b's

v2:
 Rebased on latest master + my "populate argv[0]" series (will
 send a REPOST for that shortly. Additionally a few patches got
 fixes/features;
 07/10 got same fix as kernel 7c9b973061 "irqchip/gic-v3: Configure
       all interrupts as non-secure Group-1" in order to continue
       working over TCG, as the gicv3 code for TCG removed a hack
       it had there to make Linux happy.
 08/10 added more output for when things fail (if they fail)
 09/10 switched gicv3 broadcast implementation to using IRM. This
       found a bug in a recent (but not tip) kernel, which I was
       about to fix, but then I saw MarcZ beat me to it.
 10/10 actually check that the input irq is the received irq


Import defines, and steal enough helper functions, from Linux to
enable programming of the gic (v2 and v3). Then use the framework
to add an initial test (an ipi test; self, target-list, broadcast).

It's my hope that this framework will be a suitable base on which
more tests may be easily added, particularly because we have
vgic-new and tcg gicv3 emulation getting close to merge. (v3 UPDATE:
vgic-new and tcg gicv3 are merged now)

To run it, along with other tests, just do

 ./configure [ --arch=3D[arm|arm64] --cross-prefix=3D$PREFIX ]
 make
 export QEMU=3D$PATH_TO_QEMU
 ./run_tests.sh

To run it separately do, e.g.

$QEMU -machine virt,accel=3Dtcg -cpu cortex-a57 \
 -device virtio-serial-device \
 -device virtconsole,chardev=3Dctd -chardev testdev,id=3Dctd \
 -display none -serial stdio \
 -kernel arm/gic.flat \
 -smp 123 -machine gic-version=3D3 -append ipi
      ^^ note, we can go nuts with nr-cpus on TCG :-)

Or, a KVM example using a different "sender" cpu and irq (other than zero=
)

$QEMU -machine virt,accel=3Dkvm -cpu host \
 -device virtio-serial-device \
 -device virtconsole,chardev=3Dctd -chardev testdev,id=3Dctd \
 -display none -serial stdio \
 -kernel arm/gic.flat \
 -smp 48 -machine gic-version=3D3 -append 'ipi sender=3D42 irq=3D1'


Patches:
01-04: fixes and functionality needed by the later gic patches
05-06: enable gicv2 and gicv2 IPI test
07-09: enable gicv3 and gicv3 IPI test
   10: extend the IPI tests to use cpu1 and irq1 instead of zero

Available here: https://github.com/rhdrjones/kvm-unit-tests/commits/arm/g=
ic-v8
and based on https://github.com/rhdrjones/kvm-unit-tests/commits/arm/next


Andrew Jones (9):
  arm/arm64: yield on cpu_relax
  arm/arm64: smp: support more than 8 cpus
  arm/arm64: add some delay routines
  arm/arm64: irq enable/disable
  arm/arm64: add initial gicv2 support
  arm/arm64: gicv2: add an IPI test
  arm/arm64: add initial gicv3 support
  arm/arm64: gicv3: add an IPI test
  arm/arm64: gic: don't just use zero

Peter Xu (1):
  libcflat: add IS_ALIGNED() macro, and page sizes

 arm/Makefile.common        |  12 +-
 arm/run                    |  19 +--
 arm/unittests.cfg          |  14 +++
 lib/arm/asm/arch_gicv3.h   |  65 ++++++++++
 lib/arm/asm/barrier.h      |   5 +-
 lib/arm/asm/delay.h        |  14 +++
 lib/arm/asm/gic-v2.h       |  42 +++++++
 lib/arm/asm/gic-v3.h       | 117 ++++++++++++++++++
 lib/arm/asm/gic.h          |  65 ++++++++++
 lib/arm/asm/processor.h    |  34 +++++-
 lib/arm/asm/setup.h        |   4 +-
 lib/arm64/asm/arch_gicv3.h |  64 ++++++++++
 lib/arm64/asm/barrier.h    |   3 +-
 lib/arm64/asm/delay.h      |   1 +
 lib/arm64/asm/gic-v2.h     |   1 +
 lib/arm64/asm/gic-v3.h     |   1 +
 lib/arm64/asm/gic.h        |   1 +
 lib/arm64/asm/processor.h  |  31 ++++-
 lib/arm64/asm/sysreg.h     |  34 +++++-
 lib/libcflat.h             |   6 +
 arm/gic.c                  | 298 +++++++++++++++++++++++++++++++++++++++=
++++++
 arm/selftest.c             |   7 +-
 lib/arm/delay.c            |  29 +++++
 lib/arm/gic-v2.c           |  57 +++++++++
 lib/arm/gic-v3.c           | 145 ++++++++++++++++++++++
 lib/arm/gic.c              | 147 ++++++++++++++++++++++
 lib/arm/setup.c            |  10 ++
 27 files changed, 1202 insertions(+), 24 deletions(-)
 create mode 100644 lib/arm/asm/arch_gicv3.h
 create mode 100644 lib/arm/asm/delay.h
 create mode 100644 lib/arm/asm/gic-v2.h
 create mode 100644 lib/arm/asm/gic-v3.h
 create mode 100644 lib/arm/asm/gic.h
 create mode 100644 lib/arm64/asm/arch_gicv3.h
 create mode 100644 lib/arm64/asm/delay.h
 create mode 100644 lib/arm64/asm/gic-v2.h
 create mode 100644 lib/arm64/asm/gic-v3.h
 create mode 100644 lib/arm64/asm/gic.h
 create mode 100644 arm/gic.c
 create mode 100644 lib/arm/delay.c
 create mode 100644 lib/arm/gic-v2.c
 create mode 100644 lib/arm/gic-v3.c
 create mode 100644 lib/arm/gic.c

--=20
2.9.3
