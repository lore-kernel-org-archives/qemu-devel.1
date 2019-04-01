Received: from eggs.gnu.org ([209.51.188.92]:40331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hAv8c-0000rh-N6
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hAv8P-0005k4-Us
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:30:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hAv8P-0005gd-6g
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:29:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C593356E9
	for <qemu-devel@nongnu.org>; Mon,  1 Apr 2019 11:29:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  1 Apr 2019 13:29:45 +0200
Message-Id: <20190401112945.25592-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: convert to JSON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Matteo Croce <mcroce@redhat.com>

JSON is already in wide use within QEMU for QMP and QAPI, enable
wider usage of MAINTAINERS by applying a well-defined machine-readable
format.

Converting scripts/getmaintainers.pl is left for next year.

Suggested-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS      | 2614 +---------------------------
 MAINTAINERS.json | 4257 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 4301 insertions(+), 2570 deletions(-)
 create mode 100644 MAINTAINERS.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 56139ac8ab..1464abd326 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9,21 +9,38 @@ to be CC'd when submitting a patch to obtain appropriat=
e review.
 In general, if you have a question about inclusion of a patch, you shoul=
d
 consult qemu-devel and not any specific individual privately.
=20
-Descriptions of section entries:
+The maintainers list can be found in machine-readable JSON format as an =
array
+of dictionaries.  The keys in the dictionary are defined as follows:
=20
-	M: Mail patches to: FullName <address@domain>
-	   Maintainers are looking after a certain area and must be CCed on
-	   patches. They are considered the main contact point.
-	R: Designated reviewer: FullName <address@domain>
-	   These reviewers should be CCed on patches.
-	   Reviewers are familiar with the subject matter and provide feedback
-	   even though they are not maintainers.
-	L: Mailing list that is relevant to this area
-	   These lists should be CCed on patches.
-	W: Web-page with status/info
-	Q: Patchwork web based patch tracking system site
-	T: SCM tree type and location.  Type is one of: git, hg, quilt, stgit.
-	S: Status, one of the following:
+Name
+        Descriptive name of the section
+
+Mail
+	Mail patches to: FullName <address@domain>
+	Maintainers are looking after a certain area and must be CCed on
+	patches. They are considered the main contact point.
+
+Reviewer
+	Designated reviewer: FullName <address@domain>
+	hese reviewers should be CCed on patches.
+	eviewers are familiar with the subject matter and provide feedback
+	ven though they are not maintainers.
+
+List
+	Mailing list that is relevant to this area
+	These lists should be CCed on patches.
+
+Webpage
+	Web-page with status/info
+
+Patchwork
+	Patchwork web based patch tracking system site
+
+Tree
+	SCM tree type and location.  Type is one of: git, hg, quilt, stgit.
+
+Status
+	Status, one of the following:
 	   Supported:	Someone is actually paid to look after this.
 	   Maintained:	Someone actually looks after it.
 	   Odd Fixes:	It has a maintainer but they don't have time to do
@@ -33,2562 +50,19 @@ Descriptions of section entries:
 	   Obsolete:	Old code. Something tagged obsolete generally means
 			it has been replaced by a better system and you
 			should be using that.
-	F: Files and directories with wildcard patterns.
-	   A trailing slash includes all files and subdirectory files.
-	   F:	drivers/net/	all files in and below drivers/net
-	   F:	drivers/net/*	all files in drivers/net, but not below
-	   F:	*/net/*		all files in "any top level directory"/net
-	   One pattern per line.  Multiple F: lines acceptable.
-	X: Files and directories that are NOT maintained, same rules as F:
-	   Files exclusions are tested before file matches.
-	   Can be useful for excluding a specific subdirectory, for instance:
-	   F:	net/
-	   X:	net/ipv6/
-	   matches all files in and below net excluding net/ipv6/
-	K: Keyword perl extended regex pattern to match content in a
-	   patch or file.  For instance:
-	   K: of_get_profile
-	      matches patches or files that contain "of_get_profile"
-	   K: \b(printk|pr_(info|err))\b
-	      matches patches or files that contain one or more of the words
-	      printk, pr_info or pr_err
-	   One regex pattern per line.  Multiple K: lines acceptable.
-
-
-General Project Administration
-------------------------------
-M: Peter Maydell <peter.maydell@linaro.org>
-
-All patches CC here
-L: qemu-devel@nongnu.org
-F: *
-F: */
-
-Responsible Disclosure, Reporting Security Issues
-------------------------------
-W: https://wiki.qemu.org/SecurityProcess
-M: Michael S. Tsirkin <mst@redhat.com>
-L: secalert@redhat.com
-
-Trivial patches
----------------
-Trivial patches
-M: Michael Tokarev <mjt@tls.msk.ru>
-M: Laurent Vivier <laurent@vivier.eu>
-S: Maintained
-L: qemu-trivial@nongnu.org
-K: ^Subject:.*(?i)trivial
-T: git git://git.corpit.ru/qemu.git trivial-patches
-T: git https://github.com/vivier/qemu.git trivial-patches
-
-Architecture support
---------------------
-S390
-M: Cornelia Huck <cohuck@redhat.com>
-S: Supported
-F: default-configs/s390x-softmmu.mak
-F: gdb-xml/s390*.xml
-F: hw/char/sclp*.[hc]
-F: hw/char/terminal3270.c
-F: hw/intc/s390_flic.c
-F: hw/intc/s390_flic_kvm.c
-F: hw/s390x/
-F: hw/vfio/ap.c
-F: hw/vfio/ccw.c
-F: hw/watchdog/wdt_diag288.c
-F: include/hw/s390x/
-F: include/hw/watchdog/wdt_diag288.h
-F: pc-bios/s390-ccw/
-F: pc-bios/s390-ccw.img
-F: target/s390x/
-F: docs/vfio-ap.txt
-K: ^Subject:.*(?i)s390x?
-T: git https://github.com/cohuck/qemu.git s390-next
-L: qemu-s390x@nongnu.org
-
-Guest CPU cores (TCG):
-----------------------
-Overall
-L: qemu-devel@nongnu.org
-M: Richard Henderson <rth@twiddle.net>
-R: Paolo Bonzini <pbonzini@redhat.com>
-S: Maintained
-F: cpus.c
-F: exec.c
-F: accel/tcg/
-F: accel/stubs/tcg-stub.c
-F: scripts/decodetree.py
-F: docs/devel/decodetree.rst
-F: include/exec/cpu*.h
-F: include/exec/exec-all.h
-F: include/exec/helper*.h
-F: include/exec/tb-hash.h
-F: include/sysemu/cpus.h
-
-FPU emulation
-M: Aurelien Jarno <aurelien@aurel32.net>
-M: Peter Maydell <peter.maydell@linaro.org>
-M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
-S: Maintained
-F: fpu/
-F: include/fpu/
-F: tests/fp/
-
-Alpha
-M: Richard Henderson <rth@twiddle.net>
-S: Maintained
-F: target/alpha/
-F: tests/tcg/alpha/
-F: disas/alpha.c
-
-ARM
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: target/arm/
-F: tests/tcg/arm/
-F: tests/tcg/aarch64/
-F: hw/arm/
-F: hw/cpu/a*mpcore.c
-F: include/hw/cpu/a*mpcore.h
-F: disas/arm.c
-F: disas/arm-a64.cc
-F: disas/libvixl/
-
-ARM SMMU
-M: Eric Auger <eric.auger@redhat.com>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/smmu*
-F: include/hw/arm/smmu*
-
-CRIS
-M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-S: Maintained
-F: target/cris/
-F: hw/cris/
-F: include/hw/cris/
-F: tests/tcg/cris/
-F: disas/cris.c
-
-HPPA (PA-RISC)
-M: Richard Henderson <rth@twiddle.net>
-S: Maintained
-F: target/hppa/
-F: hw/hppa/
-F: disas/hppa.c
-
-LM32
-M: Michael Walle <michael@walle.cc>
-S: Maintained
-F: target/lm32/
-F: disas/lm32.c
-F: hw/lm32/
-F: hw/*/lm32_*
-F: hw/*/milkymist-*
-F: include/hw/display/milkymist_tmu2.h
-F: include/hw/char/lm32_juart.h
-F: include/hw/lm32/
-F: tests/tcg/lm32/
-
-M68K
-M: Laurent Vivier <laurent@vivier.eu>
-S: Maintained
-F: target/m68k/
-F: disas/m68k.c
-
-MicroBlaze
-M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-S: Maintained
-F: target/microblaze/
-F: hw/microblaze/
-F: disas/microblaze.c
-
-MIPS
-M: Aurelien Jarno <aurelien@aurel32.net>
-M: Aleksandar Markovic <amarkovic@wavecomp.com>
-R: Aleksandar Rikalo <arikalo@wavecomp.com>
-S: Maintained
-F: target/mips/
-F: default-configs/*mips*
-F: disas/mips.c
-F: disas/nanomips.cpp
-F: disas/nanomips.h
-F: hw/intc/mips_gic.c
-F: hw/mips/
-F: hw/misc/mips_*
-F: hw/timer/mips_gictimer.c
-F: include/hw/intc/mips_gic.h
-F: include/hw/mips/
-F: include/hw/misc/mips_*
-F: include/hw/timer/mips_gictimer.h
-F: tests/tcg/mips/
-K: ^Subject:.*(?i)mips
-
-Moxie
-M: Anthony Green <green@moxielogic.com>
-S: Maintained
-F: target/moxie/
-F: disas/moxie.c
-F: hw/moxie/
-F: default-configs/moxie-softmmu.mak
-
-NiosII
-M: Chris Wulff <crwulff@gmail.com>
-M: Marek Vasut <marex@denx.de>
-S: Maintained
-F: target/nios2/
-F: hw/nios2/
-F: hw/intc/nios2_iic.c
-F: disas/nios2.c
-F: default-configs/nios2-softmmu.mak
-
-OpenRISC
-M: Stafford Horne <shorne@gmail.com>
-S: Odd Fixes
-F: target/openrisc/
-F: hw/openrisc/
-F: tests/tcg/openrisc/
-
-PowerPC
-M: David Gibson <david@gibson.dropbear.id.au>
-L: qemu-ppc@nongnu.org
-S: Maintained
-F: target/ppc/
-F: hw/ppc/
-F: include/hw/ppc/
-F: disas/ppc.c
-
-RISC-V
-M: Palmer Dabbelt <palmer@sifive.com>
-M: Alistair Francis <Alistair.Francis@wdc.com>
-M: Sagar Karandikar <sagark@eecs.berkeley.edu>
-M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
-L: qemu-riscv@nongnu.org
-S: Supported
-F: target/riscv/
-F: hw/riscv/
-F: include/hw/riscv/
-F: linux-user/host/riscv32/
-F: linux-user/host/riscv64/
-
-S390
-M: Richard Henderson <rth@twiddle.net>
-M: David Hildenbrand <david@redhat.com>
-S: Maintained
-F: target/s390x/
-F: hw/s390x/
-F: disas/s390.c
-F: tests/tcg/s390x/
-L: qemu-s390x@nongnu.org
-
-SH4
-M: Aurelien Jarno <aurelien@aurel32.net>
-S: Odd Fixes
-F: target/sh4/
-F: hw/sh4/
-F: disas/sh4.c
-F: include/hw/sh4/
-
-SPARC
-M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
-M: Artyom Tarasenko <atar4qemu@gmail.com>
-S: Maintained
-F: target/sparc/
-F: hw/sparc/
-F: hw/sparc64/
-F: include/hw/sparc/sparc64.h
-F: disas/sparc.c
-
-UniCore32
-M: Guan Xuetao <gxt@mprc.pku.edu.cn>
-S: Maintained
-F: target/unicore32/
-F: hw/unicore32/
-F: include/hw/unicore32/
-
-X86
-M: Paolo Bonzini <pbonzini@redhat.com>
-M: Richard Henderson <rth@twiddle.net>
-M: Eduardo Habkost <ehabkost@redhat.com>
-S: Maintained
-F: target/i386/
-F: tests/tcg/i386/
-F: tests/tcg/x86_64/
-F: hw/i386/
-F: disas/i386.c
-F: docs/qemu-cpu-models.texi
-T: git https://github.com/ehabkost/qemu.git x86-next
-
-Xtensa
-M: Max Filippov <jcmvbkbc@gmail.com>
-W: http://wiki.osll.ru/doku.php?id=3Detc:users:jcmvbkbc:qemu-target-xten=
sa
-S: Maintained
-F: target/xtensa/
-F: hw/xtensa/
-F: tests/tcg/xtensa/
-F: disas/xtensa.c
-F: include/hw/xtensa/xtensa-isa.h
-F: default-configs/xtensa*.mak
-
-TriCore
-M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
-S: Maintained
-F: target/tricore/
-F: hw/tricore/
-F: include/hw/tricore/
-
-Multiarch Linux User Tests
-M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
-S: Maintained
-F: tests/tcg/multiarch/
-
-Guest CPU Cores (KVM):
-----------------------
-
-Overall
-M: Paolo Bonzini <pbonzini@redhat.com>
-L: kvm@vger.kernel.org
-S: Supported
-F: */kvm.*
-F: accel/kvm/
-F: accel/stubs/kvm-stub.c
-F: include/hw/kvm/
-F: include/sysemu/kvm*.h
-F: scripts/kvm/kvm_flightrecorder
-
-ARM
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: target/arm/kvm.c
-
-MIPS
-M: James Hogan <jhogan@kernel.org>
-R: Aleksandar Rikalo <arikalo@wavecomp.com>
-S: Maintained
-F: target/mips/kvm.c
-
-PPC
-M: David Gibson <david@gibson.dropbear.id.au>
-S: Maintained
-F: target/ppc/kvm.c
-
-S390
-M: Halil Pasic <pasic@linux.ibm.com>
-M: Cornelia Huck <cohuck@redhat.com>
-M: Christian Borntraeger <borntraeger@de.ibm.com>
-S: Supported
-F: target/s390x/kvm.c
-F: target/s390x/kvm_s390x.h
-F: target/s390x/kvm-stub.c
-F: target/s390x/ioinst.[ch]
-F: target/s390x/machine.c
-F: target/s390x/sigp.c
-F: hw/intc/s390_flic.c
-F: hw/intc/s390_flic_kvm.c
-F: include/hw/s390x/s390_flic.h
-F: gdb-xml/s390*.xml
-T: git https://github.com/cohuck/qemu.git s390-next
-T: git https://github.com/borntraeger/qemu.git s390-next
-L: qemu-s390x@nongnu.org
-
-X86
-M: Paolo Bonzini <pbonzini@redhat.com>
-M: Marcelo Tosatti <mtosatti@redhat.com>
-L: kvm@vger.kernel.org
-S: Supported
-F: target/i386/kvm.c
-F: scripts/kvm/vmxcap
-
-Guest CPU Cores (Xen):
-----------------------
-
-X86
-M: Stefano Stabellini <sstabellini@kernel.org>
-M: Anthony Perard <anthony.perard@citrix.com>
-M: Paul Durrant <paul.durrant@citrix.com>
-L: xen-devel@lists.xenproject.org
-S: Supported
-F: */xen*
-F: hw/9pfs/xen-9p-backend.c
-F: hw/char/xen_console.c
-F: hw/display/xenfb.c
-F: hw/net/xen_nic.c
-F: hw/block/xen*
-F: hw/block/dataplane/xen*
-F: hw/xen/
-F: hw/xenpv/
-F: hw/i386/xen/
-F: include/hw/block/dataplane/xen*
-F: include/hw/xen/
-F: include/sysemu/xen-mapcache.h
-
-Hosts:
-------
-
-LINUX
-M: Michael S. Tsirkin <mst@redhat.com>
-M: Cornelia Huck <cohuck@redhat.com>
-M: Paolo Bonzini <pbonzini@redhat.com>
-S: Maintained
-F: linux-headers/
-F: scripts/update-linux-headers.sh
-
-POSIX
-M: Paolo Bonzini <pbonzini@redhat.com>
-S: Maintained
-F: os-posix.c
-F: include/sysemu/os-posix.h
-F: util/*posix*.c
-F: include/qemu/*posix*.h
-
-NETBSD
-L: qemu-devel@nongnu.org
-M: Kamil Rytarowski <kamil@netbsd.org>
-S: Maintained
-K: ^Subject:.*(?i)NetBSD
-
-OPENBSD
-L: qemu-devel@nongnu.org
-M: Brad Smith <brad@comstyle.com>
-S: Maintained
-K: ^Subject:.*(?i)OpenBSD
-
-W32, W64
-L: qemu-devel@nongnu.org
-M: Stefan Weil <sw@weilnetz.de>
-S: Maintained
-F: *win32*
-F: */*win32*
-F: include/*/*win32*
-X: qga/*win32*
-F: qemu.nsi
-
-Alpha Machines
-M: Richard Henderson <rth@twiddle.net>
-S: Maintained
-F: hw/alpha/
-F: hw/isa/smc37c669-superio.c
-
-ARM Machines
-------------
-Allwinner-a10
-M: Beniamino Galvani <b.galvani@gmail.com>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/*/allwinner*
-F: include/hw/*/allwinner*
-F: hw/arm/cubieboard.c
-
-ARM PrimeCell and CMSDK devices
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/char/pl011.c
-F: include/hw/char/pl011.h
-F: hw/display/pl110*
-F: hw/dma/pl080.c
-F: include/hw/dma/pl080.h
-F: hw/dma/pl330.c
-F: hw/gpio/pl061.c
-F: hw/input/pl050.c
-F: hw/intc/pl190.c
-F: hw/sd/pl181.c
-F: hw/ssi/pl022.c
-F: include/hw/ssi/pl022.h
-F: hw/timer/pl031.c
-F: include/hw/timer/pl031.h
-F: include/hw/arm/primecell.h
-F: hw/timer/cmsdk-apb-timer.c
-F: include/hw/timer/cmsdk-apb-timer.h
-F: hw/timer/cmsdk-apb-dualtimer.c
-F: include/hw/timer/cmsdk-apb-dualtimer.h
-F: hw/char/cmsdk-apb-uart.c
-F: include/hw/char/cmsdk-apb-uart.h
-F: hw/watchdog/cmsdk-apb-watchdog.c
-F: include/hw/watchdog/cmsdk-apb-watchdog.h
-F: hw/misc/tz-ppc.c
-F: include/hw/misc/tz-ppc.h
-F: hw/misc/tz-mpc.c
-F: include/hw/misc/tz-mpc.h
-F: hw/misc/tz-msc.c
-F: include/hw/misc/tz-msc.h
-
-ARM cores
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/intc/arm*
-F: hw/intc/gic_internal.h
-F: hw/misc/a9scu.c
-F: hw/misc/arm11scu.c
-F: hw/misc/arm_l2x0.c
-F: hw/timer/a9gtimer*
-F: hw/timer/arm*
-F: include/hw/arm/arm*.h
-F: include/hw/intc/arm*
-F: include/hw/misc/a9scu.h
-F: include/hw/misc/arm11scu.h
-F: include/hw/timer/a9gtimer.h
-F: include/hw/timer/arm_mptimer.h
-F: include/hw/timer/armv7m_systick.h
-F: tests/test-arm-mptimer.c
-
-Exynos
-M: Igor Mitsyanko <i.mitsyanko@gmail.com>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/*/exynos*
-F: include/hw/arm/exynos4210.h
-
-Calxeda Highbank
-M: Rob Herring <robh@kernel.org>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/highbank.c
-F: hw/net/xgmac.c
-
-Canon DIGIC
-M: Antony Pavlov <antonynpavlov@gmail.com>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: include/hw/arm/digic.h
-F: hw/*/digic*
-F: include/hw/*/digic*
-
-Gumstix
-M: Peter Maydell <peter.maydell@linaro.org>
-R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
-L: qemu-devel@nongnu.org
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/gumstix.c
-
-i.MX25 PDK
-M: Peter Maydell <peter.maydell@linaro.org>
-R: Jean-Christophe Dubois <jcd@tribudubois.net>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/fsl-imx25.c
-F: hw/arm/imx25_pdk.c
-F: hw/misc/imx25_ccm.c
-F: include/hw/arm/fsl-imx25.h
-F: include/hw/misc/imx25_ccm.h
-
-i.MX31 (kzm)
-M: Peter Chubb <peter.chubb@nicta.com.au>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/kzm.c
-F: hw/*/imx_*
-F: hw/*/*imx31*
-F: include/hw/*/imx_*
-F: include/hw/*/*imx31*
-
-Integrator CP
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/integratorcp.c
-F: hw/misc/arm_integrator_debug.c
-F: include/hw/misc/arm_integrator_debug.h
-
-MCIMX6UL EVK / i.MX6ul
-M: Peter Maydell <peter.maydell@linaro.org>
-R: Jean-Christophe Dubois <jcd@tribudubois.net>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/mcimx6ul-evk.c
-F: hw/arm/fsl-imx6ul.c
-F: hw/misc/imx6ul_ccm.c
-F: include/hw/arm/fsl-imx6ul.h
-F: include/hw/misc/imx6ul_ccm.h
-
-MCIMX7D SABRE / i.MX7
-M: Peter Maydell <peter.maydell@linaro.org>
-R: Andrey Smirnov <andrew.smirnov@gmail.com>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/mcimx7d-sabre.c
-F: hw/arm/fsl-imx7.c
-F: hw/misc/imx7_*.c
-F: include/hw/arm/fsl-imx7.h
-F: include/hw/misc/imx7_*.h
-F: hw/pci-host/designware.c
-F: include/hw/pci-host/designware.h
-
-MPS2
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/mps2.c
-F: hw/arm/mps2-tz.c
-F: hw/misc/mps2-*.c
-F: include/hw/misc/mps2-*.h
-F: hw/arm/armsse.c
-F: include/hw/arm/armsse.h
-F: hw/misc/iotkit-secctl.c
-F: include/hw/misc/iotkit-secctl.h
-F: hw/misc/iotkit-sysctl.c
-F: include/hw/misc/iotkit-sysctl.h
-F: hw/misc/iotkit-sysinfo.c
-F: include/hw/misc/iotkit-sysinfo.h
-F: hw/misc/armsse-cpuid.c
-F: include/hw/misc/armsse-cpuid.h
-F: hw/misc/armsse-mhu.c
-F: include/hw/misc/armsse-mhu.h
-
-Musca
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/musca.c
-
-Musicpal
-M: Jan Kiszka <jan.kiszka@web.de>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/musicpal.c
-
-nSeries
-M: Andrzej Zaborowski <balrogg@gmail.com>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/nseries.c
-F: hw/input/lm832x.c
-F: hw/input/tsc2005.c
-F: hw/misc/cbus.c
-F: hw/timer/twl92230.c
-
-Palm
-M: Andrzej Zaborowski <balrogg@gmail.com>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/palm.c
-F: hw/input/tsc210x.c
-
-Raspberry Pi
-M: Peter Maydell <peter.maydell@linaro.org>
-R: Andrew Baumann <Andrew.Baumann@microsoft.com>
-R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/raspi.c
-F: hw/arm/raspi_platform.h
-F: hw/*/bcm283*
-F: include/hw/arm/raspi*
-F: include/hw/*/bcm283*
-
-Real View
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/realview*
-F: hw/cpu/realview_mpcore.c
-F: hw/intc/realview_gic.c
-F: include/hw/intc/realview_gic.h
-
-PXA2XX
-M: Andrzej Zaborowski <balrogg@gmail.com>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/mainstone.c
-F: hw/arm/spitz.c
-F: hw/arm/tosa.c
-F: hw/arm/z2.c
-F: hw/*/pxa2xx*
-F: hw/display/tc6393xb.c
-F: hw/gpio/max7310.c
-F: hw/gpio/zaurus.c
-F: hw/misc/mst_fpga.c
-F: hw/misc/max111x.c
-F: include/hw/arm/pxa.h
-F: include/hw/arm/sharpsl.h
-
-SABRELITE / i.MX6
-M: Peter Maydell <peter.maydell@linaro.org>
-R: Jean-Christophe Dubois <jcd@tribudubois.net>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/sabrelite.c
-F: hw/arm/fsl-imx6.c
-F: hw/misc/imx6_*.c
-F: hw/ssi/imx_spi.c
-F: include/hw/arm/fsl-imx6.h
-F: include/hw/misc/imx6_*.h
-F: include/hw/ssi/imx_spi.h
-
-Sharp SL-5500 (Collie) PDA
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/collie.c
-F: hw/arm/strongarm*
-
-Stellaris
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/*/stellaris*
-
-Versatile Express
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/vexpress.c
-
-Versatile PB
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/*/versatile*
-F: hw/misc/arm_sysctl.c
-
-Virt
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/virt*
-F: include/hw/arm/virt.h
-
-Xilinx Zynq
-M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-M: Alistair Francis <alistair@alistair23.me>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/*/xilinx_*
-F: hw/*/cadence_*
-F: hw/misc/zynq*
-F: include/hw/misc/zynq*
-X: hw/ssi/xilinx_*
-
-Xilinx ZynqMP
-M: Alistair Francis <alistair@alistair23.me>
-M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/*/xlnx*.c
-F: include/hw/*/xlnx*.h
-F: include/hw/ssi/xilinx_spips.h
-F: hw/display/dpcd.c
-F: include/hw/display/dpcd.h
-
-ARM ACPI Subsystem
-M: Shannon Zhao <shannon.zhaosl@gmail.com>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/virt-acpi-build.c
-
-STM32F205
-M: Alistair Francis <alistair@alistair23.me>
-M: Peter Maydell <peter.maydell@linaro.org>
-S: Maintained
-F: hw/arm/stm32f205_soc.c
-F: hw/misc/stm32f2xx_syscfg.c
-F: hw/char/stm32f2xx_usart.c
-F: hw/timer/stm32f2xx_timer.c
-F: hw/adc/*
-F: hw/ssi/stm32f2xx_spi.c
-F: include/hw/*/stm32*.h
-
-Netduino 2
-M: Alistair Francis <alistair@alistair23.me>
-M: Peter Maydell <peter.maydell@linaro.org>
-S: Maintained
-F: hw/arm/netduino2.c
-
-SmartFusion2
-M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
-M: Peter Maydell <peter.maydell@linaro.org>
-S: Maintained
-F: hw/arm/msf2-soc.c
-F: hw/misc/msf2-sysreg.c
-F: hw/timer/mss-timer.c
-F: hw/ssi/mss-spi.c
-F: include/hw/arm/msf2-soc.h
-F: include/hw/misc/msf2-sysreg.h
-F: include/hw/timer/mss-timer.h
-F: include/hw/ssi/mss-spi.h
-
-Emcraft M2S-FG484
-M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
-M: Peter Maydell <peter.maydell@linaro.org>
-S: Maintained
-F: hw/arm/msf2-som.c
-
-ASPEED BMCs
-M: C=C3=A9dric Le Goater <clg@kaod.org>
-M: Peter Maydell <peter.maydell@linaro.org>
-R: Andrew Jeffery <andrew@aj.id.au>
-R: Joel Stanley <joel@jms.id.au>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/*/*aspeed*
-F: hw/misc/pca9552.c
-F: include/hw/*/*aspeed*
-F: include/hw/misc/pca9552*.h
-F: hw/net/ftgmac100.c
-F: include/hw/net/ftgmac100.h
-
-NRF51
-M: Joel Stanley <joel@jms.id.au>
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/*/nrf51*.c
-F: hw/*/microbit*.c
-F: include/hw/*/nrf51*.h
-F: include/hw/*/microbit*.h
-F: tests/microbit-test.c
-
-CRIS Machines
--------------
-Axis Dev88
-M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-S: Maintained
-F: hw/cris/axis_dev88.c
-F: hw/*/etraxfs_*.c
-
-HP-PARISC Machines
-------------------
-Dino
-M: Richard Henderson <rth@twiddle.net>
-R: Helge Deller <deller@gmx.de>
-S: Odd Fixes
-F: hw/hppa/
-F: pc-bios/hppa-firmware.img
-
-LM32 Machines
--------------
-EVR32 and uclinux BSP
-M: Michael Walle <michael@walle.cc>
-S: Maintained
-F: hw/lm32/lm32_boards.c
-
-milkymist
-M: Michael Walle <michael@walle.cc>
-S: Maintained
-F: hw/lm32/milkymist.c
-
-M68K Machines
--------------
-an5206
-M: Thomas Huth <huth@tuxfamily.org>
-S: Odd Fixes
-F: hw/m68k/an5206.c
-F: hw/m68k/mcf5206.c
-
-mcf5208
-M: Thomas Huth <huth@tuxfamily.org>
-S: Odd Fixes
-F: hw/m68k/mcf5208.c
-F: hw/m68k/mcf_intc.c
-F: hw/char/mcf_uart.c
-F: hw/net/mcf_fec.c
-F: include/hw/m68k/mcf*.h
-
-MicroBlaze Machines
--------------------
-petalogix_s3adsp1800
-M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-S: Maintained
-F: hw/microblaze/petalogix_s3adsp1800_mmu.c
-F: include/hw/char/xilinx_uartlite.h
-
-petalogix_ml605
-M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-S: Maintained
-F: hw/microblaze/petalogix_ml605_mmu.c
-
-MIPS Machines
--------------
-Jazz
-M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
-R: Aleksandar Rikalo <arikalo@wavecomp.com>
-S: Maintained
-F: hw/mips/mips_jazz.c
-F: hw/display/jazz_led.c
-F: hw/dma/rc4030.c
-
-Malta
-M: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <arikalo@wavecomp.com>
-S: Maintained
-F: hw/mips/mips_malta.c
-
-Mipssim
-M: Aleksandar Markovic <amarkovic@wavecomp.com>
-R: Aleksandar Rikalo <arikalo@wavecomp.com>
-S: Odd Fixes
-F: hw/mips/mips_mipssim.c
-F: hw/net/mipsnet.c
-
-R4000
-M: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <arikalo@wavecomp.com>
-S: Maintained
-F: hw/mips/mips_r4k.c
-
-Fulong 2E
-M: Aleksandar Markovic <amarkovic@wavecomp.com>
-R: Aleksandar Rikalo <arikalo@wavecomp.com>
-S: Odd Fixes
-F: hw/mips/mips_fulong2e.c
-F: hw/isa/vt82c686.c
-F: hw/pci-host/bonito.c
-F: include/hw/isa/vt82c686.h
-
-Boston
-M: Paul Burton <pburton@wavecomp.com>
-R: Aleksandar Rikalo <arikalo@wavecomp.com>
-S: Maintained
-F: hw/core/loader-fit.c
-F: hw/mips/boston.c
-F: hw/pci-host/xilinx-pcie.c
-F: include/hw/pci-host/xilinx-pcie.h
-
-OpenRISC Machines
------------------
-or1k-sim
-M: Jia Liu <proljc@gmail.com>
-S: Maintained
-F: hw/openrisc/openrisc_sim.c
-
-PowerPC Machines
-----------------
-405
-M: David Gibson <david@gibson.dropbear.id.au>
-L: qemu-ppc@nongnu.org
-S: Odd Fixes
-F: hw/ppc/ppc405_boards.c
-
-Bamboo
-M: David Gibson <david@gibson.dropbear.id.au>
-L: qemu-ppc@nongnu.org
-S: Odd Fixes
-F: hw/ppc/ppc440_bamboo.c
-
-e500
-M: David Gibson <david@gibson.dropbear.id.au>
-L: qemu-ppc@nongnu.org
-S: Odd Fixes
-F: hw/ppc/e500*
-F: hw/gpio/mpc8xxx.c
-F: hw/i2c/mpc_i2c.c
-F: hw/net/fsl_etsec/
-F: hw/pci-host/ppce500.c
-F: include/hw/ppc/ppc_e500.h
-F: include/hw/pci-host/ppce500.h
-F: pc-bios/u-boot.e500
-
-mpc8544ds
-M: David Gibson <david@gibson.dropbear.id.au>
-L: qemu-ppc@nongnu.org
-S: Odd Fixes
-F: hw/ppc/mpc8544ds.c
-F: hw/ppc/mpc8544_guts.c
-
-New World (mac99)
-M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
-R: David Gibson <david@gibson.dropbear.id.au>
-L: qemu-ppc@nongnu.org
-S: Odd Fixes
-F: hw/ppc/mac_newworld.c
-F: hw/pci-host/uninorth.c
-F: hw/pci-bridge/dec.[hc]
-F: hw/misc/macio/
-F: hw/misc/mos6522.c
-F: hw/nvram/mac_nvram.c
-F: hw/input/adb*
-F: include/hw/misc/macio/
-F: include/hw/misc/mos6522.h
-F: include/hw/ppc/mac_dbdma.h
-F: include/hw/pci-host/uninorth.h
-F: include/hw/input/adb*
-F: pc-bios/qemu_vga.ndrv
-
-Old World (g3beige)
-M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
-R: David Gibson <david@gibson.dropbear.id.au>
-L: qemu-ppc@nongnu.org
-S: Odd Fixes
-F: hw/ppc/mac_oldworld.c
-F: hw/pci-host/grackle.c
-F: hw/misc/macio/
-F: hw/intc/heathrow_pic.c
-F: hw/input/adb*
-F: include/hw/intc/heathrow_pic.h
-F: include/hw/input/adb*
-F: pc-bios/qemu_vga.ndrv
-
-PReP
-M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
-L: qemu-devel@nongnu.org
-L: qemu-ppc@nongnu.org
-S: Maintained
-F: hw/ppc/prep.c
-F: hw/ppc/prep_systemio.c
-F: hw/ppc/rs6000_mc.c
-F: hw/pci-host/prep.[hc]
-F: hw/isa/i82378.c
-F: hw/isa/pc87312.c
-F: hw/dma/i82374.c
-F: hw/timer/m48t59-isa.c
-F: include/hw/isa/pc87312.h
-F: include/hw/timer/m48t59.h
-F: pc-bios/ppc_rom.bin
-
-sPAPR
-M: David Gibson <david@gibson.dropbear.id.au>
-L: qemu-ppc@nongnu.org
-S: Supported
-F: hw/*/spapr*
-F: include/hw/*/spapr*
-F: hw/*/xics*
-F: include/hw/*/xics*
-F: pc-bios/spapr-rtas/*
-F: pc-bios/spapr-rtas.bin
-F: pc-bios/slof.bin
-F: docs/specs/ppc-spapr-hcalls.txt
-F: docs/specs/ppc-spapr-hotplug.txt
-F: tests/spapr*
-F: tests/libqos/*spapr*
-F: tests/rtas*
-F: tests/libqos/rtas*
-
-PowerNV (Non-Virtualized)
-M: C=C3=A9dric Le Goater <clg@kaod.org>
-M: David Gibson <david@gibson.dropbear.id.au>
-L: qemu-ppc@nongnu.org
-S: Maintained
-F: hw/ppc/pnv*
-F: hw/intc/pnv*
-F: hw/intc/xics_pnv.c
-F: include/hw/ppc/pnv*
-F: pc-bios/skiboot.lid
-F: tests/pnv*
-
-virtex_ml507
-M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-L: qemu-ppc@nongnu.org
-S: Odd Fixes
-F: hw/ppc/virtex_ml507.c
-
-sam460ex
-M: BALATON Zoltan <balaton@eik.bme.hu>
-L: qemu-ppc@nongnu.org
-S: Maintained
-F: hw/ppc/sam460ex.c
-F: hw/ppc/ppc440_pcix.c
-F: hw/display/sm501*
-F: hw/ide/sii3112.c
-F: hw/timer/m41t80.c
-F: pc-bios/canyonlands.dt[sb]
-F: pc-bios/u-boot-sam460ex-20100605.bin
-F: roms/u-boot-sam460ex
-
-SH4 Machines
-------------
-R2D
-M: Magnus Damm <magnus.damm@gmail.com>
-S: Maintained
-F: hw/sh4/r2d.c
-F: hw/intc/sh_intc.c
-F: hw/timer/sh_timer.c
-
-Shix
-M: Magnus Damm <magnus.damm@gmail.com>
-S: Odd Fixes
-F: hw/sh4/shix.c
-
-SPARC Machines
---------------
-Sun4m
-M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
-S: Maintained
-F: hw/sparc/sun4m.c
-F: hw/sparc/sun4m_iommu.c
-F: hw/display/cg3.c
-F: hw/display/tcx.c
-F: hw/dma/sparc32_dma.c
-F: hw/misc/eccmemctl.c
-F: hw/*/slavio_*.c
-F: include/hw/nvram/sun_nvram.h
-F: include/hw/sparc/sparc32_dma.h
-F: include/hw/sparc/sun4m_iommu.h
-F: pc-bios/openbios-sparc32
-
-Sun4u
-M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
-S: Maintained
-F: hw/sparc64/sun4u.c
-F: hw/sparc64/sun4u_iommu.c
-F: include/hw/sparc/sun4u_iommu.h
-F: hw/pci-host/sabre.c
-F: include/hw/pci-host/sabre.h
-F: hw/pci-bridge/simba.c
-F: include/hw/pci-bridge/simba.h
-F: pc-bios/openbios-sparc64
-
-Sun4v
-M: Artyom Tarasenko <atar4qemu@gmail.com>
-S: Maintained
-F: hw/sparc64/niagara.c
-F: hw/timer/sun4v-rtc.c
-F: include/hw/timer/sun4v-rtc.h
-
-Leon3
-M: Fabien Chouteau <chouteau@adacore.com>
-S: Maintained
-F: hw/sparc/leon3.c
-F: hw/*/grlib*
-F: include/hw/sparc/grlib.h
-
-S390 Machines
--------------
-S390 Virtio-ccw
-M: Cornelia Huck <cohuck@redhat.com>
-M: Halil Pasic <pasic@linux.ibm.com>
-M: Christian Borntraeger <borntraeger@de.ibm.com>
-S: Supported
-F: hw/char/sclp*.[hc]
-F: hw/char/terminal3270.c
-F: hw/s390x/
-F: include/hw/s390x/
-F: hw/watchdog/wdt_diag288.c
-F: include/hw/watchdog/wdt_diag288.h
-F: default-configs/s390x-softmmu.mak
-T: git https://github.com/cohuck/qemu.git s390-next
-T: git https://github.com/borntraeger/qemu.git s390-next
-L: qemu-s390x@nongnu.org
-
-S390-ccw boot
-M: Christian Borntraeger <borntraeger@de.ibm.com>
-M: Thomas Huth <thuth@redhat.com>
-S: Supported
-F: hw/s390x/ipl.*
-F: pc-bios/s390-ccw/
-F: pc-bios/s390-ccw.img
-T: git https://github.com/borntraeger/qemu.git s390-next
-L: qemu-s390x@nongnu.org
-
-S390 PCI
-M: Collin Walling <walling@linux.ibm.com>
-S: Supported
-F: hw/s390x/s390-pci*
-L: qemu-s390x@nongnu.org
-
-UniCore32 Machines
--------------
-PKUnity-3 SoC initramfs-with-busybox
-M: Guan Xuetao <gxt@mprc.pku.edu.cn>
-S: Maintained
-F: hw/*/puv3*
-F: hw/unicore32/
-
-X86 Machines
-------------
-PC
-M: Michael S. Tsirkin <mst@redhat.com>
-M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
-S: Supported
-F: include/hw/i386/
-F: hw/i386/
-F: hw/pci-host/piix.c
-F: hw/pci-host/q35.c
-F: hw/pci-host/pam.c
-F: include/hw/pci-host/q35.h
-F: include/hw/pci-host/pam.h
-F: hw/isa/piix4.c
-F: hw/isa/lpc_ich9.c
-F: hw/i2c/smbus_ich9.c
-F: hw/acpi/piix4.c
-F: hw/acpi/ich9.c
-F: include/hw/acpi/ich9.h
-F: include/hw/acpi/piix4.h
-F: hw/misc/sga.c
-F: hw/isa/apm.c
-F: include/hw/isa/apm.h
-F: tests/test-x86-cpuid.c
-F: tests/test-x86-cpuid-compat.c
-
-PC Chipset
-M: Michael S. Tsirkin <mst@redhat.com>
-M: Paolo Bonzini <pbonzini@redhat.com>
-S: Supported
-F: hw/char/debugcon.c
-F: hw/char/parallel*
-F: hw/char/serial*
-F: hw/dma/i8257*
-F: hw/i2c/pm_smbus.c
-F: hw/input/pckbd.c
-F: hw/intc/apic*
-F: hw/intc/ioapic*
-F: hw/intc/i8259*
-F: hw/isa/isa-superio.c
-F: hw/misc/debugexit.c
-F: hw/misc/pc-testdev.c
-F: hw/timer/hpet*
-F: hw/timer/i8254*
-F: hw/timer/mc146818rtc*
-F: hw/watchdog/wdt_ib700.c
-F: hw/watchdog/wdt_i6300esb.c
-F: include/hw/display/vga.h
-F: include/hw/char/parallel.h
-F: include/hw/dma/i8257.h
-F: include/hw/i2c/pm_smbus.h
-F: include/hw/input/i8042.h
-F: include/hw/isa/i8259_internal.h
-F: include/hw/isa/superio.h
-F: include/hw/timer/hpet.h
-F: include/hw/timer/i8254*
-F: include/hw/timer/mc146818rtc*
-
-Machine core
-M: Eduardo Habkost <ehabkost@redhat.com>
-M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
-S: Supported
-F: hw/core/machine.c
-F: hw/core/null-machine.c
-F: hw/cpu/cluster.c
-F: include/hw/boards.h
-F: include/hw/cpu/cluster.h
-T: git https://github.com/ehabkost/qemu.git machine-next
-
-Xtensa Machines
----------------
-sim
-M: Max Filippov <jcmvbkbc@gmail.com>
-S: Maintained
-F: hw/xtensa/sim.c
-
-XTFPGA (LX60, LX200, ML605, KC705)
-M: Max Filippov <jcmvbkbc@gmail.com>
-S: Maintained
-F: hw/xtensa/xtfpga.c
-F: hw/net/opencores_eth.c
-
-Devices
--------
-EDU
-M: Jiri Slaby <jslaby@suse.cz>
-S: Maintained
-F: hw/misc/edu.c
-
-IDE
-M: John Snow <jsnow@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: include/hw/ide.h
-F: include/hw/ide/
-F: hw/ide/
-F: hw/block/block.c
-F: hw/block/cdrom.c
-F: hw/block/hd-geometry.c
-F: tests/ide-test.c
-F: tests/ahci-test.c
-F: tests/cdrom-test.c
-F: tests/libqos/ahci*
-T: git https://github.com/jnsnow/qemu.git ide
-
-IPMI
-M: Corey Minyard <minyard@acm.org>
-S: Maintained
-F: include/hw/ipmi/*
-F: hw/ipmi/*
-F: hw/smbios/smbios_type_38.c
-F: tests/ipmi*
-T: git https://github.com/cminyard/qemu.git master-ipmi-rebase
-
-Floppy
-M: John Snow <jsnow@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: hw/block/fdc.c
-F: include/hw/block/fdc.h
-F: tests/fdc-test.c
-T: git https://github.com/jnsnow/qemu.git ide
-
-OMAP
-M: Peter Maydell <peter.maydell@linaro.org>
-S: Maintained
-F: hw/*/omap*
-F: include/hw/arm/omap.h
-
-IPack
-M: Alberto Garcia <berto@igalia.com>
-S: Odd Fixes
-F: hw/char/ipoctal232.c
-F: hw/ipack/
-
-PCI
-M: Michael S. Tsirkin <mst@redhat.com>
-M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
-S: Supported
-F: include/hw/pci/*
-F: hw/misc/pci-testdev.c
-F: hw/pci/*
-F: hw/pci-bridge/*
-F: docs/pci*
-F: docs/specs/*pci*
-F: default-configs/pci.mak
-
-ACPI/SMBIOS
-M: Michael S. Tsirkin <mst@redhat.com>
-M: Igor Mammedov <imammedo@redhat.com>
-S: Supported
-F: include/hw/acpi/*
-F: include/hw/firmware/smbios.h
-F: hw/mem/*
-F: hw/acpi/*
-F: hw/smbios/*
-F: hw/i386/acpi-build.[hc]
-F: hw/arm/virt-acpi-build.c
-F: tests/bios-tables-test.c
-F: tests/acpi-utils.[hc]
-F: tests/data/acpi/
-
-ppc4xx
-M: David Gibson <david@gibson.dropbear.id.au>
-L: qemu-ppc@nongnu.org
-S: Odd Fixes
-F: hw/ppc/ppc4*.c
-F: hw/i2c/ppc4xx_i2c.c
-F: include/hw/ppc/ppc4xx.h
-F: include/hw/i2c/ppc4xx_i2c.h
-
-Character devices
-M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
-R: Paolo Bonzini <pbonzini@redhat.com>
-S: Odd Fixes
-F: hw/char/
-
-Network devices
-M: Jason Wang <jasowang@redhat.com>
-S: Odd Fixes
-F: hw/net/
-F: include/hw/net/
-F: tests/virtio-net-test.c
-T: git https://github.com/jasowang/qemu.git net
-
-SCSI
-M: Paolo Bonzini <pbonzini@redhat.com>
-R: Fam Zheng <fam@euphon.net>
-S: Supported
-F: include/hw/scsi/*
-F: hw/scsi/*
-F: tests/virtio-scsi-test.c
-T: git https://github.com/bonzini/qemu.git scsi-next
-
-SSI
-M: Alistair Francis <alistair@alistair23.me>
-S: Maintained
-F: hw/ssi/*
-F: hw/block/m25p80.c
-F: include/hw/ssi/ssi.h
-X: hw/ssi/xilinx_*
-F: tests/m25p80-test.c
-
-Xilinx SPI
-M: Alistair Francis <alistair@alistair23.me>
-S: Maintained
-F: hw/ssi/xilinx_*
-
-SD (Secure Card)
-M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
-S: Odd Fixes
-F: include/hw/sd/sd*
-F: hw/sd/core.c
-F: hw/sd/sd*
-F: tests/sd*
=20
-USB
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Maintained
-F: hw/usb/*
-F: tests/usb-*-test.c
-F: docs/usb2.txt
-F: docs/usb-storage.txt
-F: include/hw/usb.h
-F: include/hw/usb/
-F: default-configs/usb.mak
-
-USB (serial adapter)
-M: Gerd Hoffmann <kraxel@redhat.com>
-M: Samuel Thibault <samuel.thibault@ens-lyon.org>
-S: Maintained
-F: hw/usb/dev-serial.c
-
-VFIO
-M: Alex Williamson <alex.williamson@redhat.com>
-S: Supported
-F: hw/vfio/*
-F: include/hw/vfio/
-
-vfio-ccw
-M: Cornelia Huck <cohuck@redhat.com>
-M: Eric Farman <farman@linux.ibm.com>
-M: Farhan Ali <alifm@linux.ibm.com>
-S: Supported
-F: hw/vfio/ccw.c
-F: hw/s390x/s390-ccw.c
-F: include/hw/s390x/s390-ccw.h
-T: git https://github.com/cohuck/qemu.git s390-next
-L: qemu-s390x@nongnu.org
-
-vfio-ap
-M: Christian Borntraeger <borntraeger@de.ibm.com>
-M: Tony Krowiak <akrowiak@linux.ibm.com>
-M: Halil Pasic <pasic@linux.ibm.com>
-M: Pierre Morel <pmorel@linux.ibm.com>
-S: Supported
-F: hw/s390x/ap-device.c
-F: hw/s390x/ap-bridge.c
-F: include/hw/s390x/ap-device.h
-F: include/hw/s390x/ap-bridge.h
-F: hw/vfio/ap.c
-F: docs/vfio-ap.txt
-L: qemu-s390x@nongnu.org
-
-vhost
-M: Michael S. Tsirkin <mst@redhat.com>
-S: Supported
-F: hw/*/*vhost*
-F: docs/interop/vhost-user.json
-F: docs/interop/vhost-user.txt
-F: contrib/vhost-user-*/
-
-virtio
-M: Michael S. Tsirkin <mst@redhat.com>
-S: Supported
-F: hw/*/virtio*
-F: hw/virtio/Makefile.objs
-F: hw/virtio/trace-events
-F: net/vhost-user.c
-F: include/hw/virtio/
-F: tests/virtio-balloon-test.c
-
-virtio-9p
-M: Greg Kurz <groug@kaod.org>
-S: Supported
-F: hw/9pfs/
-F: fsdev/
-F: tests/virtio-9p-test.c
-T: git https://github.com/gkurz/qemu.git 9p-next
-
-virtio-blk
-M: Stefan Hajnoczi <stefanha@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: hw/block/virtio-blk.c
-F: hw/block/dataplane/*
-F: tests/virtio-blk-test.c
-T: git https://github.com/stefanha/qemu.git block
-
-virtio-ccw
-M: Cornelia Huck <cohuck@redhat.com>
-M: Halil Pasic <pasic@linux.ibm.com>
-S: Supported
-F: hw/s390x/virtio-ccw*.[hc]
-F: hw/s390x/vhost-vsock-ccw.c
-T: git https://github.com/cohuck/qemu.git s390-next
-T: git https://github.com/borntraeger/qemu.git s390-next
-L: qemu-s390x@nongnu.org
-
-virtio-input
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Maintained
-F: hw/input/virtio-input*.c
-F: include/hw/virtio/virtio-input.h
-
-virtio-serial
-M: Amit Shah <amit@kernel.org>
-S: Supported
-F: hw/char/virtio-serial-bus.c
-F: hw/char/virtio-console.c
-F: include/hw/virtio/virtio-serial.h
-F: tests/virtio-console-test.c
-F: tests/virtio-serial-test.c
-
-virtio-rng
-M: Amit Shah <amit@kernel.org>
-S: Supported
-F: hw/virtio/virtio-rng.c
-F: include/hw/virtio/virtio-rng.h
-F: include/sysemu/rng*.h
-F: backends/rng*.c
-F: tests/virtio-rng-test.c
-
-virtio-crypto
-M: Gonglei <arei.gonglei@huawei.com>
-S: Supported
-F: hw/virtio/virtio-crypto.c
-F: hw/virtio/virtio-crypto-pci.c
-F: include/hw/virtio/virtio-crypto.h
-
-nvme
-M: Keith Busch <keith.busch@intel.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: hw/block/nvme*
-F: tests/nvme-test.c
-
-megasas
-M: Hannes Reinecke <hare@suse.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: hw/scsi/megasas.c
-F: hw/scsi/mfi.h
-F: tests/megasas-test.c
-
-Network packet abstractions
-M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
-S: Maintained
-F: include/net/eth.h
-F: net/eth.c
-F: hw/net/net_rx_pkt*
-F: hw/net/net_tx_pkt*
-
-Vmware
-M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
-S: Maintained
-F: hw/net/vmxnet*
-F: hw/scsi/vmw_pvscsi*
-F: tests/vmxnet3-test.c
-
-Rocker
-M: Jiri Pirko <jiri@resnulli.us>
-S: Maintained
-F: hw/net/rocker/
-F: tests/rocker/
-F: docs/specs/rocker.txt
-
-NVDIMM
-M: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
-S: Maintained
-F: hw/acpi/nvdimm.c
-F: hw/mem/nvdimm.c
-F: include/hw/mem/nvdimm.h
-F: docs/nvdimm.txt
-
-e1000x
-M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
-S: Maintained
-F: hw/net/e1000x*
-
-e1000e
-M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
-S: Maintained
-F: hw/net/e1000e*
-
-eepro100
-M: Stefan Weil <sw@weilnetz.de>
-S: Maintained
-F: hw/net/eepro100.c
-
-Generic Loader
-M: Alistair Francis <alistair@alistair23.me>
-S: Maintained
-F: hw/core/generic-loader.c
-F: include/hw/core/generic-loader.h
-F: docs/generic-loader.txt
-
-Intel Hexadecimal Object File Loader
-M: Su Hang <suhang16@mails.ucas.ac.cn>
-S: Maintained
-F: tests/hexloader-test.c
-F: tests/data/hex-loader/test.hex
-
-CHRP NVRAM
-M: Thomas Huth <thuth@redhat.com>
-S: Maintained
-F: hw/nvram/chrp_nvram.c
-F: include/hw/nvram/chrp_nvram.h
-F: tests/prom-env-test.c
-
-VM Generation ID
-M: Ben Warren <ben@skyportsystems.com>
-S: Maintained
-F: hw/acpi/vmgenid.c
-F: include/hw/acpi/vmgenid.h
-F: docs/specs/vmgenid.txt
-F: tests/vmgenid-test.c
-F: stubs/vmgenid.c
-
-Unimplemented device
-M: Peter Maydell <peter.maydell@linaro.org>
-R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
-S: Maintained
-F: include/hw/misc/unimp.h
-F: hw/misc/unimp.c
-
-Standard VGA
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Maintained
-F: hw/display/vga*
-F: hw/display/bochs-display.c
-F: include/hw/display/vga.h
-F: include/hw/display/bochs-vbe.h
-
-ramfb
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Maintained
-F: hw/display/ramfb*.c
-F: include/hw/display/ramfb.h
-
-virtio-gpu
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Maintained
-F: hw/display/virtio-gpu*
-F: hw/display/virtio-vga.c
-F: include/hw/virtio/virtio-gpu.h
-
-Cirrus VGA
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
-W: https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harm=
ful/
-F: hw/display/cirrus*
-
-EDID Generator
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Maintained
-F: hw/display/edid*
-F: include/hw/display/edid.h
-F: qemu-edid.c
-
-Firmware configuration (fw_cfg)
-M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
-R: Laszlo Ersek <lersek@redhat.com>
-R: Gerd Hoffmann <kraxel@redhat.com>
-S: Supported
-F: docs/specs/fw_cfg.txt
-F: hw/nvram/fw_cfg.c
-F: include/hw/nvram/fw_cfg.h
-F: include/standard-headers/linux/qemu_fw_cfg.h
-F: tests/libqos/fw_cfg.c
-F: tests/fw_cfg-test.c
-T: git https://github.com/philmd/qemu.git fw_cfg-next
-
-XIVE
-M: David Gibson <david@gibson.dropbear.id.au>
-M: C=C3=A9dric Le Goater <clg@kaod.org>
-L: qemu-ppc@nongnu.org
-S: Supported
-F: hw/*/*xive*
-F: include/hw/*/*xive*
-
-Subsystems
-----------
-Audio
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Maintained
-F: audio/
-F: hw/audio/
-F: include/hw/audio/
-F: tests/ac97-test.c
-F: tests/es1370-test.c
-F: tests/intel-hda-test.c
-
-Block layer core
-M: Kevin Wolf <kwolf@redhat.com>
-M: Max Reitz <mreitz@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block*
-F: block/
-F: hw/block/
-F: include/block/
-F: qemu-img*
-F: qemu-io*
-F: tests/qemu-iotests/
-F: util/qemu-progress.c
-F: qobject/block-qdict.c
-F: tests/check-block-qdict.c
-T: git https://repo.or.cz/qemu/kevin.git block
-
-Block I/O path
-M: Stefan Hajnoczi <stefanha@redhat.com>
-M: Fam Zheng <fam@euphon.net>
-L: qemu-block@nongnu.org
-S: Supported
-F: util/async.c
-F: util/aio-*.c
-F: block/io.c
-F: migration/block*
-F: include/block/aio.h
-F: include/block/aio-wait.h
-F: scripts/qemugdb/aio.py
-T: git https://github.com/stefanha/qemu.git block
-
-Block SCSI subsystem
-M: Paolo Bonzini <pbonzini@redhat.com>
-R: Fam Zheng <fam@euphon.net>
-L: qemu-block@nongnu.org
-S: Supported
-F: include/scsi/*
-F: scsi/*
-
-Block Jobs
-M: John Snow <jsnow@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: blockjob.c
-F: include/block/blockjob.h
-F: job.c
-F: job-qmp.c
-F: include/qemu/job.h
-F: block/backup.c
-F: block/commit.c
-F: block/stream.c
-F: block/mirror.c
-F: qapi/job.json
-T: git https://github.com/jnsnow/qemu.git jobs
-
-Block QAPI, monitor, command line
-M: Markus Armbruster <armbru@redhat.com>
-S: Supported
-F: blockdev.c
-F: block/qapi.c
-F: qapi/block*.json
-F: qapi/transaction.json
-T: git https://repo.or.cz/qemu/armbru.git block-next
-
-Dirty Bitmaps
-M: Fam Zheng <fam@euphon.net>
-M: John Snow <jsnow@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: util/hbitmap.c
-F: block/dirty-bitmap.c
-F: include/qemu/hbitmap.h
-F: include/block/dirty-bitmap.h
-F: tests/test-hbitmap.c
-F: docs/interop/bitmaps.rst
-T: git https://github.com/famz/qemu.git bitmaps
-T: git https://github.com/jnsnow/qemu.git bitmaps
-
-Character device backends
-M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
-R: Paolo Bonzini <pbonzini@redhat.com>
-S: Maintained
-F: chardev/
-F: include/chardev/
-F: qapi/char.json
-
-Character Devices (Braille)
-M: Samuel Thibault <samuel.thibault@ens-lyon.org>
-S: Maintained
-F: chardev/baum.c
-
-Command line option argument parsing
-M: Markus Armbruster <armbru@redhat.com>
-S: Supported
-F: include/qemu/option.h
-F: tests/test-keyval.c
-F: tests/test-qemu-opts.c
-F: util/keyval.c
-F: util/qemu-option.c
-
-Coverity model
-M: Markus Armbruster <armbru@redhat.com>
-S: Supported
-F: scripts/coverity-model.c
-
-CPU
-L: qemu-devel@nongnu.org
-S: Supported
-F: qom/cpu.c
-F: include/qom/cpu.h
-
-Device Tree
-M: Alistair Francis <alistair.francis@wdc.com>
-R: David Gibson <david@gibson.dropbear.id.au>
-S: Maintained
-F: device_tree.c
-F: include/sysemu/device_tree.h
-
-Dump
-S: Supported
-M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
-F: dump.c
-F: hw/misc/vmcoreinfo.c
-F: include/hw/misc/vmcoreinfo.h
-F: include/sysemu/dump-arch.h
-F: include/sysemu/dump.h
-F: scripts/dump-guest-memory.py
-F: stubs/dump.c
-
-Error reporting
-M: Markus Armbruster <armbru@redhat.com>
-S: Supported
-F: include/qapi/error.h
-F: include/qemu/error-report.h
-F: util/error.c
-F: util/qemu-error.c
-
-GDB stub
-S: Orphan
-F: gdbstub*
-F: gdb-xml/
-
-Memory API
-M: Paolo Bonzini <pbonzini@redhat.com>
-S: Supported
-F: include/exec/ioport.h
-F: ioport.c
-F: include/exec/memory.h
-F: include/exec/ram_addr.h
-F: memory.c
-F: include/exec/memory-internal.h
-F: exec.c
-
-SPICE
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Supported
-F: include/ui/qemu-spice.h
-F: include/ui/spice-display.h
-F: ui/spice-*.c
-F: audio/spiceaudio.c
-F: hw/display/qxl*
-F: qapi/ui.json
-F: docs/spice-port-fqdn.txt
-
-Graphics
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
-F: ui/
-F: include/ui/
-F: qapi/ui.json
-F: util/drm.c
-
-Cocoa graphics
-M: Peter Maydell <peter.maydell@linaro.org>
-S: Odd Fixes
-F: ui/cocoa.m
-
-Main loop
-M: Paolo Bonzini <pbonzini@redhat.com>
-S: Maintained
-F: cpus.c
-F: util/main-loop.c
-F: util/qemu-timer.c
-F: vl.c
-F: qapi/run-state.json
-
-Human Monitor (HMP)
-M: Dr. David Alan Gilbert <dgilbert@redhat.com>
-S: Maintained
-F: monitor.c
-F: hmp.[ch]
-F: hmp-commands*.hx
-F: include/monitor/hmp-target.h
-F: tests/test-hmp.c
-
-Network device backends
-M: Jason Wang <jasowang@redhat.com>
-S: Maintained
-F: net/
-F: include/net/
-T: git https://github.com/jasowang/qemu.git net
-F: qapi/net.json
-
-Netmap network backend
-M: Luigi Rizzo <rizzo@iet.unipi.it>
-M: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
-M: Vincenzo Maffione <v.maffione@gmail.com>
-W: http://info.iet.unipi.it/~luigi/netmap/
-S: Maintained
-F: net/netmap.c
-
-NUMA
-M: Eduardo Habkost <ehabkost@redhat.com>
-S: Maintained
-F: numa.c
-F: include/sysemu/numa.h
-T: git https://github.com/ehabkost/qemu.git machine-next
-
-Host Memory Backends
-M: Eduardo Habkost <ehabkost@redhat.com>
-M: Igor Mammedov <imammedo@redhat.com>
-S: Maintained
-F: backends/hostmem*.c
-F: include/sysemu/hostmem.h
-T: git https://github.com/ehabkost/qemu.git machine-next
-
-Cryptodev Backends
-M: Gonglei <arei.gonglei@huawei.com>
-S: Maintained
-F: include/sysemu/cryptodev*.h
-F: backends/cryptodev*.c
-
-Python scripts
-M: Eduardo Habkost <ehabkost@redhat.com>
-M: Cleber Rosa <crosa@redhat.com>
-S: Odd fixes
-F: scripts/qmp/*
-F: scripts/*.py
-F: tests/*.py
-
-QAPI
-M: Markus Armbruster <armbru@redhat.com>
-M: Michael Roth <mdroth@linux.vnet.ibm.com>
-S: Supported
-F: qapi/
-X: qapi/*.json
-F: include/qapi/
-X: include/qapi/qmp/
-F: include/qapi/qmp/dispatch.h
-F: tests/qapi-schema/
-F: tests/test-*-visitor.c
-F: tests/test-qapi-*.c
-F: tests/test-qmp-*.c
-F: tests/test-visitor-serialization.c
-F: scripts/qapi-gen.py
-F: scripts/qapi/*
-F: docs/devel/qapi*
-T: git https://repo.or.cz/qemu/armbru.git qapi-next
-
-QAPI Schema
-M: Eric Blake <eblake@redhat.com>
-M: Markus Armbruster <armbru@redhat.com>
-S: Supported
-F: qapi/*.json
-T: git https://repo.or.cz/qemu/armbru.git qapi-next
-
-QObject
-M: Markus Armbruster <armbru@redhat.com>
-S: Supported
-F: qobject/
-F: include/qapi/qmp/
-X: include/qapi/qmp/dispatch.h
-F: scripts/coccinelle/qobject.cocci
-F: tests/check-qdict.c
-F: tests/check-qjson.c
-F: tests/check-qlist.c
-F: tests/check-qlit.c
-F: tests/check-qnull.c
-F: tests/check-qnum.c
-F: tests/check-qobject.c
-F: tests/check-qstring.c
-F: tests/data/qobject/qdict.txt
-T: git https://repo.or.cz/qemu/armbru.git qapi-next
-
-QEMU Guest Agent
-M: Michael Roth <mdroth@linux.vnet.ibm.com>
-S: Maintained
-F: qga/
-F: qemu-ga.texi
-F: scripts/qemu-guest-agent/
-F: tests/test-qga.c
-F: docs/interop/qemu-ga-ref.texi
-T: git https://github.com/mdroth/qemu.git qga
-
-QOM
-M: Andreas F=C3=A4rber <afaerber@suse.de>
-S: Supported
-T: git https://github.com/afaerber/qemu-cpu.git qom-next
-F: include/qom/
-X: include/qom/cpu.h
-F: qom/
-X: qom/cpu.c
-F: tests/check-qom-interface.c
-F: tests/check-qom-proplist.c
-
-QMP
-M: Markus Armbruster <armbru@redhat.com>
-S: Supported
-F: qmp.c
-F: monitor.c
-F: docs/devel/*qmp-*
-F: docs/interop/*qmp-*
-F: scripts/qmp/
-F: tests/qmp-test.c
-F: tests/qmp-cmd-test.c
-T: git https://repo.or.cz/qemu/armbru.git qapi-next
-
-qtest
-M: Thomas Huth <thuth@redhat.com>
-M: Laurent Vivier <lvivier@redhat.com>
-R: Paolo Bonzini <pbonzini@redhat.com>
-S: Maintained
-F: qtest.c
-F: tests/libqtest.*
-F: tests/libqos/
-F: tests/*-test.c
-
-Register API
-M: Alistair Francis <alistair@alistair23.me>
-S: Maintained
-F: hw/core/register.c
-F: include/hw/register.h
-F: include/hw/registerfields.h
-
-SLIRP
-M: Samuel Thibault <samuel.thibault@ens-lyon.org>
-M: Jan Kiszka <jan.kiszka@siemens.com>
-S: Maintained
-F: slirp/
-F: net/slirp.c
-F: include/net/slirp.h
-T: git https://people.debian.org/~sthibault/qemu.git slirp
-T: git git://git.kiszka.org/qemu.git queues/slirp
-
-Stubs
-M: Paolo Bonzini <pbonzini@redhat.com>
-S: Maintained
-F: stubs/
-
-Tracing
-M: Stefan Hajnoczi <stefanha@redhat.com>
-S: Maintained
-F: trace/
-F: trace-events
-F: qemu-option-trace.texi
-F: scripts/tracetool.py
-F: scripts/tracetool/
-F: scripts/qemu-trace-stap*
-F: docs/devel/tracing.txt
-T: git https://github.com/stefanha/qemu.git tracing
-
-TPM
-M: Stefan Berger <stefanb@linux.ibm.com>
-S: Maintained
-F: tpm.c
-F: stubs/tpm.c
-F: hw/tpm/*
-F: include/hw/acpi/tpm.h
-F: include/sysemu/tpm*
-F: qapi/tpm.json
-F: backends/tpm.c
-F: tests/*tpm*
-T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
-
-Checkpatch
-S: Odd Fixes
-F: scripts/checkpatch.pl
-
-Migration
-M: Juan Quintela <quintela@redhat.com>
-M: Dr. David Alan Gilbert <dgilbert@redhat.com>
-S: Maintained
-F: include/migration/
-F: migration/
-F: scripts/vmstate-static-checker.py
-F: tests/vmstate-static-checker-data/
-F: tests/migration-test.c
-F: docs/devel/migration.rst
-F: qapi/migration.json
-
-Seccomp
-M: Eduardo Otubo <otubo@redhat.com>
-S: Supported
-F: qemu-seccomp.c
-F: include/sysemu/seccomp.h
-
-Cryptography
-M: Daniel P. Berrange <berrange@redhat.com>
-S: Maintained
-F: crypto/
-F: include/crypto/
-F: tests/test-crypto-*
-F: tests/benchmark-crypto-*
-F: tests/crypto-tls-*
-F: tests/pkix_asn1_tab.c
-F: qemu.sasl
-
-Coroutines
-M: Stefan Hajnoczi <stefanha@redhat.com>
-M: Kevin Wolf <kwolf@redhat.com>
-S: Maintained
-F: util/*coroutine*
-F: include/qemu/coroutine*
-F: tests/test-coroutine.c
-
-Buffers
-M: Daniel P. Berrange <berrange@redhat.com>
-S: Odd fixes
-F: util/buffer.c
-F: include/qemu/buffer.h
-
-I/O Channels
-M: Daniel P. Berrange <berrange@redhat.com>
-S: Maintained
-F: io/
-F: include/io/
-F: tests/test-io-*
-
-User authorization
-M: Daniel P. Berrange <berrange@redhat.com>
-S: Maintained
-F: authz/
-F: qapi/authz.json
-F: include/authz/
-F: tests/test-authz-*
-
-Sockets
-M: Daniel P. Berrange <berrange@redhat.com>
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Maintained
-F: include/qemu/sockets.h
-F: util/qemu-sockets.c
-F: qapi/sockets.json
-
-File monitor
-M: Daniel P. Berrange <berrange@redhat.com>
-S: Odd fixes
-F: util/filemonitor*.c
-F: include/qemu/filemonitor.h
-F: tests/test-util-filemonitor.c
-
-Throttling infrastructure
-M: Alberto Garcia <berto@igalia.com>
-S: Supported
-F: block/throttle-groups.c
-F: include/block/throttle-groups.h
-F: include/qemu/throttle*.h
-F: util/throttle.c
-F: docs/throttle.txt
-F: tests/test-throttle.c
-L: qemu-block@nongnu.org
-
-UUID
-M: Fam Zheng <fam@euphon.net>
-S: Supported
-F: util/uuid.c
-F: include/qemu/uuid.h
-F: tests/test-uuid.c
-
-COLO Framework
-M: zhanghailiang <zhang.zhanghailiang@huawei.com>
-S: Maintained
-F: migration/colo*
-F: include/migration/colo.h
-F: include/migration/failover.h
-F: docs/COLO-FT.txt
-
-COLO Proxy
-M: Zhang Chen <chen.zhang@intel.com>
-M: Li Zhijian <lizhijian@cn.fujitsu.com>
-S: Supported
-F: docs/colo-proxy.txt
-F: net/colo*
-F: net/filter-rewriter.c
-F: net/filter-mirror.c
-
-Record/replay
-M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
-R: Paolo Bonzini <pbonzini@redhat.com>
-W: https://wiki.qemu.org/Features/record-replay
-S: Supported
-F: replay/*
-F: block/blkreplay.c
-F: net/filter-replay.c
-F: include/sysemu/replay.h
-F: docs/replay.txt
-F: stubs/replay.c
-
-IOVA Tree
-M: Peter Xu <peterx@redhat.com>
-S: Maintained
-F: include/qemu/iova-tree.h
-F: util/iova-tree.c
-
-elf2dmp
-M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
-S: Maintained
-F: contrib/elf2dmp/
-
-I2C and SMBus
-M: Corey Minyard <cminyard@mvista.com>
-S: Maintained
-F: hw/i2c/core.c
-F: hw/i2c/smbus_slave.c
-F: hw/i2c/smbus_master.c
-F: hw/i2c/smbus_eeprom.c
-F: include/hw/i2c/i2c.h
-F: include/hw/i2c/smbus_master.h
-F: include/hw/i2c/smbus_slave.h
-F: include/hw/i2c/smbus_eeprom.h
-
-Usermode Emulation
-------------------
-Overall
-M: Riku Voipio <riku.voipio@iki.fi>
-S: Maintained
-F: thunk.c
-F: accel/tcg/user-exec*.c
-
-BSD user
-S: Orphan
-F: bsd-user/
-F: default-configs/*-bsd-user.mak
-
-Linux user
-M: Riku Voipio <riku.voipio@iki.fi>
-R: Laurent Vivier <laurent@vivier.eu>
-S: Maintained
-F: linux-user/
-F: default-configs/*-linux-user.mak
-F: scripts/qemu-binfmt-conf.sh
-
-Tiny Code Generator (TCG)
--------------------------
-Common code
-M: Richard Henderson <rth@twiddle.net>
-S: Maintained
-F: tcg/
-
-AArch64 target
-M: Claudio Fontana <claudio.fontana@huawei.com>
-M: Claudio Fontana <claudio.fontana@gmail.com>
-S: Maintained
-L: qemu-arm@nongnu.org
-F: tcg/aarch64/
-F: disas/arm-a64.cc
-F: disas/libvixl/
-
-ARM target
-M: Andrzej Zaborowski <balrogg@gmail.com>
-S: Maintained
-L: qemu-arm@nongnu.org
-F: tcg/arm/
-F: disas/arm.c
-
-i386 target
-M: Richard Henderson <rth@twiddle.net>
-S: Maintained
-F: tcg/i386/
-F: disas/i386.c
-
-MIPS target
-M: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <arikalo@wavecomp.com>
-S: Maintained
-F: tcg/mips/
-F: disas/mips.c
-
-PPC
-M: Richard Henderson <rth@twiddle.net>
-S: Odd Fixes
-F: tcg/ppc/
-F: disas/ppc.c
-
-RISC-V
-M: Palmer Dabbelt <palmer@sifive.com>
-M: Alistair Francis <Alistair.Francis@wdc.com>
-L: qemu-riscv@nongnu.org
-S: Maintained
-F: tcg/riscv/
-F: disas/riscv.c
-
-S390 target
-M: Richard Henderson <rth@twiddle.net>
-S: Maintained
-F: tcg/s390/
-F: disas/s390.c
-L: qemu-s390x@nongnu.org
-
-SPARC target
-S: Odd Fixes
-F: tcg/sparc/
-F: disas/sparc.c
-
-TCI target
-M: Stefan Weil <sw@weilnetz.de>
-S: Maintained
-F: tcg/tci/
-F: tcg/tci.c
-F: disas/tci.c
-
-Block drivers
--------------
-VMDK
-M: Fam Zheng <fam@euphon.net>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/vmdk.c
-
-RBD
-M: Josh Durgin <jdurgin@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/rbd.c
-
-Sheepdog
-M: Liu Yuan <namei.unix@gmail.com>
-L: qemu-block@nongnu.org
-L: sheepdog@lists.wpkg.org
-S: Odd Fixes
-F: block/sheepdog.c
-
-VHDX
-M: Jeff Cody <codyprime@gmail.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/vhdx*
-
-VDI
-M: Stefan Weil <sw@weilnetz.de>
-L: qemu-block@nongnu.org
-S: Maintained
-F: block/vdi.c
-
-iSCSI
-M: Ronnie Sahlberg <ronniesahlberg@gmail.com>
-M: Paolo Bonzini <pbonzini@redhat.com>
-M: Peter Lieven <pl@kamp.de>
-L: qemu-block@nongnu.org
-S: Odd Fixes
-F: block/iscsi.c
-F: block/iscsi-opts.c
-
-Network Block Device (NBD)
-M: Eric Blake <eblake@redhat.com>
-L: qemu-block@nongnu.org
-S: Maintained
-F: block/nbd*
-F: nbd/
-F: include/block/nbd*
-F: qemu-nbd.*
-F: blockdev-nbd.c
-F: docs/interop/nbd.txt
-T: git https://repo.or.cz/qemu/ericb.git nbd
-
-NFS
-M: Peter Lieven <pl@kamp.de>
-L: qemu-block@nongnu.org
-S: Maintained
-F: block/nfs.c
-
-SSH
-M: Richard W.M. Jones <rjones@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/ssh.c
-
-CURL
-L: qemu-block@nongnu.org
-S: Supported
-F: block/curl.c
-
-GLUSTER
-L: qemu-block@nongnu.org
-S: Supported
-F: block/gluster.c
-
-Null Block Driver
-M: Fam Zheng <fam@euphon.net>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/null.c
-
-NVMe Block Driver
-M: Fam Zheng <fam@euphon.net>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/nvme*
-
-Bootdevice
-M: Gonglei <arei.gonglei@huawei.com>
-S: Maintained
-F: bootdevice.c
-
-Quorum
-M: Alberto Garcia <berto@igalia.com>
-S: Supported
-F: block/quorum.c
-L: qemu-block@nongnu.org
-
-blklogwrites
-M: Ari Sundholm <ari@tuxera.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/blklogwrites.c
-
-blkverify
-M: Stefan Hajnoczi <stefanha@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/blkverify.c
-
-bochs
-M: Stefan Hajnoczi <stefanha@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/bochs.c
-
-cloop
-M: Stefan Hajnoczi <stefanha@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/cloop.c
-
-dmg
-M: Stefan Hajnoczi <stefanha@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/dmg.c
-
-parallels
-M: Stefan Hajnoczi <stefanha@redhat.com>
-M: Denis V. Lunev <den@openvz.org>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/parallels.c
-F: docs/interop/parallels.txt
-
-qed
-M: Stefan Hajnoczi <stefanha@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/qed.c
-
-raw
-M: Kevin Wolf <kwolf@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/linux-aio.c
-F: include/block/raw-aio.h
-F: block/raw-format.c
-F: block/file-posix.c
-F: block/file-win32.c
-F: block/win32-aio.c
-
-qcow2
-M: Kevin Wolf <kwolf@redhat.com>
-M: Max Reitz <mreitz@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/qcow2*
-F: docs/interop/qcow2.txt
-
-qcow
-M: Kevin Wolf <kwolf@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/qcow.c
-
-blkdebug
-M: Kevin Wolf <kwolf@redhat.com>
-M: Max Reitz <mreitz@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/blkdebug.c
-
-vpc
-M: Kevin Wolf <kwolf@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/vpc.c
-
-vvfat
-M: Kevin Wolf <kwolf@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: block/vvfat.c
-
-Image format fuzzer
-M: Stefan Hajnoczi <stefanha@redhat.com>
-L: qemu-block@nongnu.org
-S: Supported
-F: tests/image-fuzzer/
-
-Replication
-M: Wen Congyang <wencongyang2@huawei.com>
-M: Xie Changlong <xiechanglong.d@gmail.com>
-S: Supported
-F: replication*
-F: block/replication.c
-F: tests/test-replication.c
-F: docs/block-replication.txt
-
-PVRDMA
-M: Yuval Shaia <yuval.shaia@oracle.com>
-M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
-S: Maintained
-F: hw/rdma/*
-F: hw/rdma/vmw/*
-F: docs/pvrdma.txt
-F: contrib/rdmacm-mux/*
-F: qapi/rdma.json
-
-Build and test automation
--------------------------
-Build and test automation
-M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
-M: Fam Zheng <fam@euphon.net>
-R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
-L: qemu-devel@nongnu.org
-S: Maintained
-F: .travis.yml
-F: scripts/travis/
-F: .shippable.yml
-F: tests/docker/
-F: tests/vm/
-F: scripts/archive-source.sh
-W: https://travis-ci.org/qemu/qemu
-W: https://app.shippable.com/github/qemu/qemu
-W: http://patchew.org/QEMU/
-
-FreeBSD Hosted Continuous Integration
-M: Ed Maste <emaste@freebsd.org>
-M: Li-Wen Hsu <lwhsu@freebsd.org>
-L: qemu-devel@nongnu.org
-S: Maintained
-F: .cirrus.yml
-W: https://cirrus-ci.com/github/qemu/qemu
-
-GitLab Continuous Integration
-M: Thomas Huth <thuth@redhat.com>
-S: Maintained
-F: .gitlab-ci.yml
-
-Guest Test Compilation Support
-M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
-R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
-S: Maintained
-F: tests/tcg/Makefile
-F: tests/tcg/Makefile.include
-L: qemu-devel@nongnu.org
-
-Documentation
--------------
-Build system architecture
-M: Daniel P. Berrange <berrange@redhat.com>
-S: Odd Fixes
-F: docs/devel/build-system.txt
-
-GIT Data Mining Config
-M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
-S: Odd Fixes
-F: gitdm.config
-F: contrib/gitdm/*
-
-Incompatible changes
-R: libvir-list@redhat.com
-F: qemu-deprecated.texi
+Files
+	Files and directories with wildcard patterns.
+	   A trailing slash includes all files and subdirectory files.
+	   	drivers/net/	all files in and below drivers/net
+	   	drivers/net/*	all files in drivers/net, but not below
+	   	*/net/*		all files in "any top level directory"/net
=20
-Build System
-------------
-GIT submodules
-M: Daniel P. Berrange <berrange@redhat.com>
-S: Odd Fixes
-F: scripts/git-submodule.sh
+Excluded
+	Files and directories that are NOT maintained, same rules as F:
+	   Files exclusions are tested before file matches.
+	   Can be useful for excluding a specific subdirectory:
=20
-Sphinx documentation configuration and build machinery
-M: Peter Maydell <peter.maydell@linaro.org>
-S: Maintained
-F: docs/conf.py
-F: docs/*/conf.py
+Regexp
+        Keyword perl extended regex pattern to match content in a
+	patch or file.
diff --git a/MAINTAINERS.json b/MAINTAINERS.json
new file mode 100644
index 0000000000..613df2ddbb
--- /dev/null
+++ b/MAINTAINERS.json
@@ -0,0 +1,4257 @@
+[
+  {
+    "Name": "General Project Administration",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ]
+  },
+  {
+    "Name": "All patches CC here",
+    "List": [
+      "qemu-devel@nongnu.org"
+    ],
+    "Files": [
+      "*",
+      "*/"
+    ]
+  },
+  {
+    "Name": "Responsible Disclosure, Reporting Security Issues",
+    "Mail": [
+      "Michael S. Tsirkin <mst@redhat.com>"
+    ],
+    "List": [
+      "secalert@redhat.com"
+    ],
+    "Webpage": [
+      "https://wiki.qemu.org/SecurityProcess"
+    ]
+  },
+  {
+    "Name": "Trivial patches"
+  },
+  {
+    "Name": "Trivial patches",
+    "Mail": [
+      "Michael Tokarev <mjt@tls.msk.ru>",
+      "Laurent Vivier <laurent@vivier.eu>"
+    ],
+    "List": [
+      "qemu-trivial@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Tree": "git https://github.com/vivier/qemu.git trivial-patches",
+    "Regexp": [
+      "^Subject:.*(?i)trivial"
+    ]
+  },
+  {
+    "Name": "Architecture support"
+  },
+  {
+    "Name": "S390",
+    "Mail": [
+      "Cornelia Huck <cohuck@redhat.com>"
+    ],
+    "List": [
+      "qemu-s390x@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "default-configs/s390x-softmmu.mak",
+      "gdb-xml/s390*.xml",
+      "hw/char/sclp*.[hc]",
+      "hw/char/terminal3270.c",
+      "hw/intc/s390_flic.c",
+      "hw/intc/s390_flic_kvm.c",
+      "hw/s390x/",
+      "hw/vfio/ap.c",
+      "hw/vfio/ccw.c",
+      "hw/watchdog/wdt_diag288.c",
+      "include/hw/s390x/",
+      "include/hw/watchdog/wdt_diag288.h",
+      "pc-bios/s390-ccw/",
+      "pc-bios/s390-ccw.img",
+      "target/s390x/",
+      "docs/vfio-ap.txt"
+    ],
+    "Tree": "git https://github.com/cohuck/qemu.git s390-next",
+    "Regexp": [
+      "^Subject:.*(?i)s390x?"
+    ]
+  },
+  {
+    "Name": "Guest CPU cores (TCG):"
+  },
+  {
+    "Name": "Overall",
+    "Mail": [
+      "Richard Henderson <rth@twiddle.net>"
+    ],
+    "List": [
+      "qemu-devel@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "cpus.c",
+      "exec.c",
+      "accel/tcg/",
+      "accel/stubs/tcg-stub.c",
+      "scripts/decodetree.py",
+      "docs/devel/decodetree.rst",
+      "include/exec/cpu*.h",
+      "include/exec/exec-all.h",
+      "include/exec/helper*.h",
+      "include/exec/tb-hash.h",
+      "include/sysemu/cpus.h"
+    ],
+    "Reviewer": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ]
+  },
+  {
+    "Name": "FPU emulation",
+    "Mail": [
+      "Aurelien Jarno <aurelien@aurel32.net>",
+      "Peter Maydell <peter.maydell@linaro.org>",
+      "Alex Benn=C3=A9e <alex.bennee@linaro.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "fpu/",
+      "include/fpu/",
+      "tests/fp/"
+    ]
+  },
+  {
+    "Name": "Alpha",
+    "Mail": [
+      "Richard Henderson <rth@twiddle.net>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/alpha/",
+      "tests/tcg/alpha/",
+      "disas/alpha.c"
+    ]
+  },
+  {
+    "Name": "ARM",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/arm/",
+      "tests/tcg/arm/",
+      "tests/tcg/aarch64/",
+      "hw/arm/",
+      "hw/cpu/a*mpcore.c",
+      "include/hw/cpu/a*mpcore.h",
+      "disas/arm.c",
+      "disas/arm-a64.cc",
+      "disas/libvixl/"
+    ]
+  },
+  {
+    "Name": "ARM SMMU",
+    "Mail": [
+      "Eric Auger <eric.auger@redhat.com>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/smmu*",
+      "include/hw/arm/smmu*"
+    ]
+  },
+  {
+    "Name": "CRIS",
+    "Mail": [
+      "Edgar E. Iglesias <edgar.iglesias@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/cris/",
+      "hw/cris/",
+      "include/hw/cris/",
+      "tests/tcg/cris/",
+      "disas/cris.c"
+    ]
+  },
+  {
+    "Name": "HPPA (PA-RISC)",
+    "Mail": [
+      "Richard Henderson <rth@twiddle.net>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/hppa/",
+      "hw/hppa/",
+      "disas/hppa.c"
+    ]
+  },
+  {
+    "Name": "LM32",
+    "Mail": [
+      "Michael Walle <michael@walle.cc>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/lm32/",
+      "disas/lm32.c",
+      "hw/lm32/",
+      "hw/*/lm32_*",
+      "hw/*/milkymist-*",
+      "include/hw/display/milkymist_tmu2.h",
+      "include/hw/char/lm32_juart.h",
+      "include/hw/lm32/",
+      "tests/tcg/lm32/"
+    ]
+  },
+  {
+    "Name": "M68K",
+    "Mail": [
+      "Laurent Vivier <laurent@vivier.eu>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/m68k/",
+      "disas/m68k.c"
+    ]
+  },
+  {
+    "Name": "MicroBlaze",
+    "Mail": [
+      "Edgar E. Iglesias <edgar.iglesias@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/microblaze/",
+      "hw/microblaze/",
+      "disas/microblaze.c"
+    ]
+  },
+  {
+    "Name": "MIPS",
+    "Mail": [
+      "Aurelien Jarno <aurelien@aurel32.net>",
+      "Aleksandar Markovic <amarkovic@wavecomp.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/mips/",
+      "default-configs/*mips*",
+      "disas/mips.c",
+      "disas/nanomips.cpp",
+      "disas/nanomips.h",
+      "hw/intc/mips_gic.c",
+      "hw/mips/",
+      "hw/misc/mips_*",
+      "hw/timer/mips_gictimer.c",
+      "include/hw/intc/mips_gic.h",
+      "include/hw/mips/",
+      "include/hw/misc/mips_*",
+      "include/hw/timer/mips_gictimer.h",
+      "tests/tcg/mips/"
+    ],
+    "Reviewer": [
+      "Aleksandar Rikalo <arikalo@wavecomp.com>"
+    ],
+    "Regexp": [
+      "^Subject:.*(?i)mips"
+    ]
+  },
+  {
+    "Name": "Moxie",
+    "Mail": [
+      "Anthony Green <green@moxielogic.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/moxie/",
+      "disas/moxie.c",
+      "hw/moxie/",
+      "default-configs/moxie-softmmu.mak"
+    ]
+  },
+  {
+    "Name": "NiosII",
+    "Mail": [
+      "Chris Wulff <crwulff@gmail.com>",
+      "Marek Vasut <marex@denx.de>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/nios2/",
+      "hw/nios2/",
+      "hw/intc/nios2_iic.c",
+      "disas/nios2.c",
+      "default-configs/nios2-softmmu.mak"
+    ]
+  },
+  {
+    "Name": "OpenRISC",
+    "Mail": [
+      "Stafford Horne <shorne@gmail.com>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "target/openrisc/",
+      "hw/openrisc/",
+      "tests/tcg/openrisc/"
+    ]
+  },
+  {
+    "Name": "PowerPC",
+    "Mail": [
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/ppc/",
+      "hw/ppc/",
+      "include/hw/ppc/",
+      "disas/ppc.c"
+    ]
+  },
+  {
+    "Name": "RISC-V",
+    "Mail": [
+      "Palmer Dabbelt <palmer@sifive.com>",
+      "Alistair Francis <Alistair.Francis@wdc.com>",
+      "Sagar Karandikar <sagark@eecs.berkeley.edu>",
+      "Bastian Koppelmann <kbastian@mail.uni-paderborn.de>"
+    ],
+    "List": [
+      "qemu-riscv@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "target/riscv/",
+      "hw/riscv/",
+      "include/hw/riscv/",
+      "linux-user/host/riscv32/",
+      "linux-user/host/riscv64/"
+    ]
+  },
+  {
+    "Name": "S390",
+    "Mail": [
+      "Richard Henderson <rth@twiddle.net>",
+      "David Hildenbrand <david@redhat.com>"
+    ],
+    "List": [
+      "qemu-s390x@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/s390x/",
+      "hw/s390x/",
+      "disas/s390.c",
+      "tests/tcg/s390x/"
+    ]
+  },
+  {
+    "Name": "SH4",
+    "Mail": [
+      "Aurelien Jarno <aurelien@aurel32.net>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "target/sh4/",
+      "hw/sh4/",
+      "disas/sh4.c",
+      "include/hw/sh4/"
+    ]
+  },
+  {
+    "Name": "SPARC",
+    "Mail": [
+      "Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>",
+      "Artyom Tarasenko <atar4qemu@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/sparc/",
+      "hw/sparc/",
+      "hw/sparc64/",
+      "include/hw/sparc/sparc64.h",
+      "disas/sparc.c"
+    ]
+  },
+  {
+    "Name": "UniCore32",
+    "Mail": [
+      "Guan Xuetao <gxt@mprc.pku.edu.cn>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/unicore32/",
+      "hw/unicore32/",
+      "include/hw/unicore32/"
+    ]
+  },
+  {
+    "Name": "X86",
+    "Mail": [
+      "Paolo Bonzini <pbonzini@redhat.com>",
+      "Richard Henderson <rth@twiddle.net>",
+      "Eduardo Habkost <ehabkost@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/i386/",
+      "tests/tcg/i386/",
+      "tests/tcg/x86_64/",
+      "hw/i386/",
+      "disas/i386.c",
+      "docs/qemu-cpu-models.texi"
+    ],
+    "Tree": "git https://github.com/ehabkost/qemu.git x86-next"
+  },
+  {
+    "Name": "Xtensa",
+    "Mail": [
+      "Max Filippov <jcmvbkbc@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/xtensa/",
+      "hw/xtensa/",
+      "tests/tcg/xtensa/",
+      "disas/xtensa.c",
+      "include/hw/xtensa/xtensa-isa.h",
+      "default-configs/xtensa*.mak"
+    ],
+    "Webpage": [
+      "http://wiki.osll.ru/doku.php?id=3Detc:users:jcmvbkbc:qemu-target-=
xtensa"
+    ]
+  },
+  {
+    "Name": "TriCore",
+    "Mail": [
+      "Bastian Koppelmann <kbastian@mail.uni-paderborn.de>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/tricore/",
+      "hw/tricore/",
+      "include/hw/tricore/"
+    ]
+  },
+  {
+    "Name": "Multiarch Linux User Tests",
+    "Mail": [
+      "Alex Benn=C3=A9e <alex.bennee@linaro.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tests/tcg/multiarch/"
+    ]
+  },
+  {
+    "Name": "Guest CPU Cores (KVM):"
+  },
+  {
+    "Name": "Overall",
+    "Mail": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ],
+    "List": [
+      "kvm@vger.kernel.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "*/kvm.*",
+      "accel/kvm/",
+      "accel/stubs/kvm-stub.c",
+      "include/hw/kvm/",
+      "include/sysemu/kvm*.h",
+      "scripts/kvm/kvm_flightrecorder"
+    ]
+  },
+  {
+    "Name": "ARM",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/arm/kvm.c"
+    ]
+  },
+  {
+    "Name": "MIPS",
+    "Mail": [
+      "James Hogan <jhogan@kernel.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/mips/kvm.c"
+    ],
+    "Reviewer": [
+      "Aleksandar Rikalo <arikalo@wavecomp.com>"
+    ]
+  },
+  {
+    "Name": "PPC",
+    "Mail": [
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "target/ppc/kvm.c"
+    ]
+  },
+  {
+    "Name": "S390",
+    "Mail": [
+      "Halil Pasic <pasic@linux.ibm.com>",
+      "Cornelia Huck <cohuck@redhat.com>",
+      "Christian Borntraeger <borntraeger@de.ibm.com>"
+    ],
+    "List": [
+      "qemu-s390x@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "target/s390x/kvm.c",
+      "target/s390x/kvm_s390x.h",
+      "target/s390x/kvm-stub.c",
+      "target/s390x/ioinst.[ch]",
+      "target/s390x/machine.c",
+      "target/s390x/sigp.c",
+      "hw/intc/s390_flic.c",
+      "hw/intc/s390_flic_kvm.c",
+      "include/hw/s390x/s390_flic.h",
+      "gdb-xml/s390*.xml"
+    ],
+    "Tree": "git https://github.com/borntraeger/qemu.git s390-next"
+  },
+  {
+    "Name": "X86",
+    "Mail": [
+      "Paolo Bonzini <pbonzini@redhat.com>",
+      "Marcelo Tosatti <mtosatti@redhat.com>"
+    ],
+    "List": [
+      "kvm@vger.kernel.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "target/i386/kvm.c",
+      "scripts/kvm/vmxcap"
+    ]
+  },
+  {
+    "Name": "Guest CPU Cores (Xen):"
+  },
+  {
+    "Name": "X86",
+    "Mail": [
+      "Stefano Stabellini <sstabellini@kernel.org>",
+      "Anthony Perard <anthony.perard@citrix.com>",
+      "Paul Durrant <paul.durrant@citrix.com>"
+    ],
+    "List": [
+      "xen-devel@lists.xenproject.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "*/xen*",
+      "hw/9pfs/xen-9p-backend.c",
+      "hw/char/xen_console.c",
+      "hw/display/xenfb.c",
+      "hw/net/xen_nic.c",
+      "hw/block/xen*",
+      "hw/block/dataplane/xen*",
+      "hw/xen/",
+      "hw/xenpv/",
+      "hw/i386/xen/",
+      "include/hw/block/dataplane/xen*",
+      "include/hw/xen/",
+      "include/sysemu/xen-mapcache.h"
+    ]
+  },
+  {
+    "Name": "Hosts:"
+  },
+  {
+    "Name": "LINUX",
+    "Mail": [
+      "Michael S. Tsirkin <mst@redhat.com>",
+      "Cornelia Huck <cohuck@redhat.com>",
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "linux-headers/",
+      "scripts/update-linux-headers.sh"
+    ]
+  },
+  {
+    "Name": "POSIX",
+    "Mail": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "os-posix.c",
+      "include/sysemu/os-posix.h",
+      "util/*posix*.c",
+      "include/qemu/*posix*.h"
+    ]
+  },
+  {
+    "Name": "NETBSD",
+    "Mail": [
+      "Kamil Rytarowski <kamil@netbsd.org>"
+    ],
+    "List": [
+      "qemu-devel@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Regexp": [
+      "^Subject:.*(?i)NetBSD"
+    ]
+  },
+  {
+    "Name": "OPENBSD",
+    "Mail": [
+      "Brad Smith <brad@comstyle.com>"
+    ],
+    "List": [
+      "qemu-devel@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Regexp": [
+      "^Subject:.*(?i)OpenBSD"
+    ]
+  },
+  {
+    "Name": "W32, W64",
+    "Mail": [
+      "Stefan Weil <sw@weilnetz.de>"
+    ],
+    "List": [
+      "qemu-devel@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "*win32*",
+      "*/*win32*",
+      "include/*/*win32*",
+      "qemu.nsi"
+    ],
+    "Excluded": [
+      "qga/*win32*"
+    ]
+  },
+  {
+    "Name": "Alpha Machines",
+    "Mail": [
+      "Richard Henderson <rth@twiddle.net>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/alpha/",
+      "hw/isa/smc37c669-superio.c"
+    ]
+  },
+  {
+    "Name": "ARM Machines"
+  },
+  {
+    "Name": "Allwinner-a10",
+    "Mail": [
+      "Beniamino Galvani <b.galvani@gmail.com>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/*/allwinner*",
+      "include/hw/*/allwinner*",
+      "hw/arm/cubieboard.c"
+    ]
+  },
+  {
+    "Name": "ARM PrimeCell and CMSDK devices",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/char/pl011.c",
+      "include/hw/char/pl011.h",
+      "hw/display/pl110*",
+      "hw/dma/pl080.c",
+      "include/hw/dma/pl080.h",
+      "hw/dma/pl330.c",
+      "hw/gpio/pl061.c",
+      "hw/input/pl050.c",
+      "hw/intc/pl190.c",
+      "hw/sd/pl181.c",
+      "hw/ssi/pl022.c",
+      "include/hw/ssi/pl022.h",
+      "hw/timer/pl031.c",
+      "include/hw/timer/pl031.h",
+      "include/hw/arm/primecell.h",
+      "hw/timer/cmsdk-apb-timer.c",
+      "include/hw/timer/cmsdk-apb-timer.h",
+      "hw/timer/cmsdk-apb-dualtimer.c",
+      "include/hw/timer/cmsdk-apb-dualtimer.h",
+      "hw/char/cmsdk-apb-uart.c",
+      "include/hw/char/cmsdk-apb-uart.h",
+      "hw/watchdog/cmsdk-apb-watchdog.c",
+      "include/hw/watchdog/cmsdk-apb-watchdog.h",
+      "hw/misc/tz-ppc.c",
+      "include/hw/misc/tz-ppc.h",
+      "hw/misc/tz-mpc.c",
+      "include/hw/misc/tz-mpc.h",
+      "hw/misc/tz-msc.c",
+      "include/hw/misc/tz-msc.h"
+    ]
+  },
+  {
+    "Name": "ARM cores",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/intc/arm*",
+      "hw/intc/gic_internal.h",
+      "hw/misc/a9scu.c",
+      "hw/misc/arm11scu.c",
+      "hw/misc/arm_l2x0.c",
+      "hw/timer/a9gtimer*",
+      "hw/timer/arm*",
+      "include/hw/arm/arm*.h",
+      "include/hw/intc/arm*",
+      "include/hw/misc/a9scu.h",
+      "include/hw/misc/arm11scu.h",
+      "include/hw/timer/a9gtimer.h",
+      "include/hw/timer/arm_mptimer.h",
+      "include/hw/timer/armv7m_systick.h",
+      "tests/test-arm-mptimer.c"
+    ]
+  },
+  {
+    "Name": "Exynos",
+    "Mail": [
+      "Igor Mitsyanko <i.mitsyanko@gmail.com>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/*/exynos*",
+      "include/hw/arm/exynos4210.h"
+    ]
+  },
+  {
+    "Name": "Calxeda Highbank",
+    "Mail": [
+      "Rob Herring <robh@kernel.org>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/highbank.c",
+      "hw/net/xgmac.c"
+    ]
+  },
+  {
+    "Name": "Canon DIGIC",
+    "Mail": [
+      "Antony Pavlov <antonynpavlov@gmail.com>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "include/hw/arm/digic.h",
+      "hw/*/digic*",
+      "include/hw/*/digic*"
+    ]
+  },
+  {
+    "Name": "Gumstix",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-devel@nongnu.org",
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/gumstix.c"
+    ],
+    "Reviewer": [
+      "Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>"
+    ]
+  },
+  {
+    "Name": "i.MX25 PDK",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/fsl-imx25.c",
+      "hw/arm/imx25_pdk.c",
+      "hw/misc/imx25_ccm.c",
+      "include/hw/arm/fsl-imx25.h",
+      "include/hw/misc/imx25_ccm.h"
+    ],
+    "Reviewer": [
+      "Jean-Christophe Dubois <jcd@tribudubois.net>"
+    ]
+  },
+  {
+    "Name": "i.MX31 (kzm)",
+    "Mail": [
+      "Peter Chubb <peter.chubb@nicta.com.au>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/kzm.c",
+      "hw/*/imx_*",
+      "hw/*/*imx31*",
+      "include/hw/*/imx_*",
+      "include/hw/*/*imx31*"
+    ]
+  },
+  {
+    "Name": "Integrator CP",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/integratorcp.c",
+      "hw/misc/arm_integrator_debug.c",
+      "include/hw/misc/arm_integrator_debug.h"
+    ]
+  },
+  {
+    "Name": "MCIMX6UL EVK / i.MX6ul",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/mcimx6ul-evk.c",
+      "hw/arm/fsl-imx6ul.c",
+      "hw/misc/imx6ul_ccm.c",
+      "include/hw/arm/fsl-imx6ul.h",
+      "include/hw/misc/imx6ul_ccm.h"
+    ],
+    "Reviewer": [
+      "Jean-Christophe Dubois <jcd@tribudubois.net>"
+    ]
+  },
+  {
+    "Name": "MCIMX7D SABRE / i.MX7",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/mcimx7d-sabre.c",
+      "hw/arm/fsl-imx7.c",
+      "hw/misc/imx7_*.c",
+      "include/hw/arm/fsl-imx7.h",
+      "include/hw/misc/imx7_*.h",
+      "hw/pci-host/designware.c",
+      "include/hw/pci-host/designware.h"
+    ],
+    "Reviewer": [
+      "Andrey Smirnov <andrew.smirnov@gmail.com>"
+    ]
+  },
+  {
+    "Name": "MPS2",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/mps2.c",
+      "hw/arm/mps2-tz.c",
+      "hw/misc/mps2-*.c",
+      "include/hw/misc/mps2-*.h",
+      "hw/arm/armsse.c",
+      "include/hw/arm/armsse.h",
+      "hw/misc/iotkit-secctl.c",
+      "include/hw/misc/iotkit-secctl.h",
+      "hw/misc/iotkit-sysctl.c",
+      "include/hw/misc/iotkit-sysctl.h",
+      "hw/misc/iotkit-sysinfo.c",
+      "include/hw/misc/iotkit-sysinfo.h",
+      "hw/misc/armsse-cpuid.c",
+      "include/hw/misc/armsse-cpuid.h",
+      "hw/misc/armsse-mhu.c",
+      "include/hw/misc/armsse-mhu.h"
+    ]
+  },
+  {
+    "Name": "Musca",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/musca.c"
+    ]
+  },
+  {
+    "Name": "Musicpal",
+    "Mail": [
+      "Jan Kiszka <jan.kiszka@web.de>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/musicpal.c"
+    ]
+  },
+  {
+    "Name": "nSeries",
+    "Mail": [
+      "Andrzej Zaborowski <balrogg@gmail.com>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/nseries.c",
+      "hw/input/lm832x.c",
+      "hw/input/tsc2005.c",
+      "hw/misc/cbus.c",
+      "hw/timer/twl92230.c"
+    ]
+  },
+  {
+    "Name": "Palm",
+    "Mail": [
+      "Andrzej Zaborowski <balrogg@gmail.com>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/palm.c",
+      "hw/input/tsc210x.c"
+    ]
+  },
+  {
+    "Name": "Raspberry Pi",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/raspi.c",
+      "hw/arm/raspi_platform.h",
+      "hw/*/bcm283*",
+      "include/hw/arm/raspi*",
+      "include/hw/*/bcm283*"
+    ],
+    "Reviewer": [
+      "Andrew Baumann <Andrew.Baumann@microsoft.com>",
+      "Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>"
+    ]
+  },
+  {
+    "Name": "Real View",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/realview*",
+      "hw/cpu/realview_mpcore.c",
+      "hw/intc/realview_gic.c",
+      "include/hw/intc/realview_gic.h"
+    ]
+  },
+  {
+    "Name": "PXA2XX",
+    "Mail": [
+      "Andrzej Zaborowski <balrogg@gmail.com>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/mainstone.c",
+      "hw/arm/spitz.c",
+      "hw/arm/tosa.c",
+      "hw/arm/z2.c",
+      "hw/*/pxa2xx*",
+      "hw/display/tc6393xb.c",
+      "hw/gpio/max7310.c",
+      "hw/gpio/zaurus.c",
+      "hw/misc/mst_fpga.c",
+      "hw/misc/max111x.c",
+      "include/hw/arm/pxa.h",
+      "include/hw/arm/sharpsl.h"
+    ]
+  },
+  {
+    "Name": "SABRELITE / i.MX6",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/sabrelite.c",
+      "hw/arm/fsl-imx6.c",
+      "hw/misc/imx6_*.c",
+      "hw/ssi/imx_spi.c",
+      "include/hw/arm/fsl-imx6.h",
+      "include/hw/misc/imx6_*.h",
+      "include/hw/ssi/imx_spi.h"
+    ],
+    "Reviewer": [
+      "Jean-Christophe Dubois <jcd@tribudubois.net>"
+    ]
+  },
+  {
+    "Name": "Sharp SL-5500 (Collie) PDA",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/arm/collie.c",
+      "hw/arm/strongarm*"
+    ]
+  },
+  {
+    "Name": "Stellaris",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/*/stellaris*"
+    ]
+  },
+  {
+    "Name": "Versatile Express",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/vexpress.c"
+    ]
+  },
+  {
+    "Name": "Versatile PB",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/*/versatile*",
+      "hw/misc/arm_sysctl.c"
+    ]
+  },
+  {
+    "Name": "Virt",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/virt*",
+      "include/hw/arm/virt.h"
+    ]
+  },
+  {
+    "Name": "Xilinx Zynq",
+    "Mail": [
+      "Edgar E. Iglesias <edgar.iglesias@gmail.com>",
+      "Alistair Francis <alistair@alistair23.me>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/*/xilinx_*",
+      "hw/*/cadence_*",
+      "hw/misc/zynq*",
+      "include/hw/misc/zynq*"
+    ],
+    "Excluded": [
+      "hw/ssi/xilinx_*"
+    ]
+  },
+  {
+    "Name": "Xilinx ZynqMP",
+    "Mail": [
+      "Alistair Francis <alistair@alistair23.me>",
+      "Edgar E. Iglesias <edgar.iglesias@gmail.com>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/*/xlnx*.c",
+      "include/hw/*/xlnx*.h",
+      "include/hw/ssi/xilinx_spips.h",
+      "hw/display/dpcd.c",
+      "include/hw/display/dpcd.h"
+    ]
+  },
+  {
+    "Name": "ARM ACPI Subsystem",
+    "Mail": [
+      "Shannon Zhao <shannon.zhaosl@gmail.com>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/virt-acpi-build.c"
+    ]
+  },
+  {
+    "Name": "STM32F205",
+    "Mail": [
+      "Alistair Francis <alistair@alistair23.me>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/stm32f205_soc.c",
+      "hw/misc/stm32f2xx_syscfg.c",
+      "hw/char/stm32f2xx_usart.c",
+      "hw/timer/stm32f2xx_timer.c",
+      "hw/adc/*",
+      "hw/ssi/stm32f2xx_spi.c",
+      "include/hw/*/stm32*.h"
+    ]
+  },
+  {
+    "Name": "Netduino 2",
+    "Mail": [
+      "Alistair Francis <alistair@alistair23.me>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/netduino2.c"
+    ]
+  },
+  {
+    "Name": "SmartFusion2",
+    "Mail": [
+      "Subbaraya Sundeep <sundeep.lkml@gmail.com>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/msf2-soc.c",
+      "hw/misc/msf2-sysreg.c",
+      "hw/timer/mss-timer.c",
+      "hw/ssi/mss-spi.c",
+      "include/hw/arm/msf2-soc.h",
+      "include/hw/misc/msf2-sysreg.h",
+      "include/hw/timer/mss-timer.h",
+      "include/hw/ssi/mss-spi.h"
+    ]
+  },
+  {
+    "Name": "Emcraft M2S-FG484",
+    "Mail": [
+      "Subbaraya Sundeep <sundeep.lkml@gmail.com>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/arm/msf2-som.c"
+    ]
+  },
+  {
+    "Name": "ASPEED BMCs",
+    "Mail": [
+      "C=C3=A9dric Le Goater <clg@kaod.org>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/*/*aspeed*",
+      "hw/misc/pca9552.c",
+      "include/hw/*/*aspeed*",
+      "include/hw/misc/pca9552*.h",
+      "hw/net/ftgmac100.c",
+      "include/hw/net/ftgmac100.h"
+    ],
+    "Reviewer": [
+      "Andrew Jeffery <andrew@aj.id.au>",
+      "Joel Stanley <joel@jms.id.au>"
+    ]
+  },
+  {
+    "Name": "NRF51",
+    "Mail": [
+      "Joel Stanley <joel@jms.id.au>",
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/*/nrf51*.c",
+      "hw/*/microbit*.c",
+      "include/hw/*/nrf51*.h",
+      "include/hw/*/microbit*.h",
+      "tests/microbit-test.c"
+    ]
+  },
+  {
+    "Name": "CRIS Machines"
+  },
+  {
+    "Name": "Axis Dev88",
+    "Mail": [
+      "Edgar E. Iglesias <edgar.iglesias@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/cris/axis_dev88.c",
+      "hw/*/etraxfs_*.c"
+    ]
+  },
+  {
+    "Name": "HP-PARISC Machines"
+  },
+  {
+    "Name": "Dino",
+    "Mail": [
+      "Richard Henderson <rth@twiddle.net>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/hppa/",
+      "pc-bios/hppa-firmware.img"
+    ],
+    "Reviewer": [
+      "Helge Deller <deller@gmx.de>"
+    ]
+  },
+  {
+    "Name": "LM32 Machines"
+  },
+  {
+    "Name": "EVR32 and uclinux BSP",
+    "Mail": [
+      "Michael Walle <michael@walle.cc>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/lm32/lm32_boards.c"
+    ]
+  },
+  {
+    "Name": "milkymist",
+    "Mail": [
+      "Michael Walle <michael@walle.cc>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/lm32/milkymist.c"
+    ]
+  },
+  {
+    "Name": "M68K Machines"
+  },
+  {
+    "Name": "an5206",
+    "Mail": [
+      "Thomas Huth <huth@tuxfamily.org>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/m68k/an5206.c",
+      "hw/m68k/mcf5206.c"
+    ]
+  },
+  {
+    "Name": "mcf5208",
+    "Mail": [
+      "Thomas Huth <huth@tuxfamily.org>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/m68k/mcf5208.c",
+      "hw/m68k/mcf_intc.c",
+      "hw/char/mcf_uart.c",
+      "hw/net/mcf_fec.c",
+      "include/hw/m68k/mcf*.h"
+    ]
+  },
+  {
+    "Name": "MicroBlaze Machines"
+  },
+  {
+    "Name": "petalogix_s3adsp1800",
+    "Mail": [
+      "Edgar E. Iglesias <edgar.iglesias@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/microblaze/petalogix_s3adsp1800_mmu.c",
+      "include/hw/char/xilinx_uartlite.h"
+    ]
+  },
+  {
+    "Name": "petalogix_ml605",
+    "Mail": [
+      "Edgar E. Iglesias <edgar.iglesias@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/microblaze/petalogix_ml605_mmu.c"
+    ]
+  },
+  {
+    "Name": "MIPS Machines"
+  },
+  {
+    "Name": "Jazz",
+    "Mail": [
+      "Herv=C3=A9 Poussineau <hpoussin@reactos.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/mips/mips_jazz.c",
+      "hw/display/jazz_led.c",
+      "hw/dma/rc4030.c"
+    ],
+    "Reviewer": [
+      "Aleksandar Rikalo <arikalo@wavecomp.com>"
+    ]
+  },
+  {
+    "Name": "Malta",
+    "Mail": [
+      "Aurelien Jarno <aurelien@aurel32.net>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/mips/mips_malta.c"
+    ],
+    "Reviewer": [
+      "Aleksandar Rikalo <arikalo@wavecomp.com>"
+    ]
+  },
+  {
+    "Name": "Mipssim",
+    "Mail": [
+      "Aleksandar Markovic <amarkovic@wavecomp.com>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/mips/mips_mipssim.c",
+      "hw/net/mipsnet.c"
+    ],
+    "Reviewer": [
+      "Aleksandar Rikalo <arikalo@wavecomp.com>"
+    ]
+  },
+  {
+    "Name": "R4000",
+    "Mail": [
+      "Aurelien Jarno <aurelien@aurel32.net>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/mips/mips_r4k.c"
+    ],
+    "Reviewer": [
+      "Aleksandar Rikalo <arikalo@wavecomp.com>"
+    ]
+  },
+  {
+    "Name": "Fulong 2E",
+    "Mail": [
+      "Aleksandar Markovic <amarkovic@wavecomp.com>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/mips/mips_fulong2e.c",
+      "hw/isa/vt82c686.c",
+      "hw/pci-host/bonito.c",
+      "include/hw/isa/vt82c686.h"
+    ],
+    "Reviewer": [
+      "Aleksandar Rikalo <arikalo@wavecomp.com>"
+    ]
+  },
+  {
+    "Name": "Boston",
+    "Mail": [
+      "Paul Burton <pburton@wavecomp.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/core/loader-fit.c",
+      "hw/mips/boston.c",
+      "hw/pci-host/xilinx-pcie.c",
+      "include/hw/pci-host/xilinx-pcie.h"
+    ],
+    "Reviewer": [
+      "Aleksandar Rikalo <arikalo@wavecomp.com>"
+    ]
+  },
+  {
+    "Name": "OpenRISC Machines"
+  },
+  {
+    "Name": "or1k-sim",
+    "Mail": [
+      "Jia Liu <proljc@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/openrisc/openrisc_sim.c"
+    ]
+  },
+  {
+    "Name": "PowerPC Machines"
+  },
+  {
+    "Name": "405",
+    "Mail": [
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/ppc/ppc405_boards.c"
+    ]
+  },
+  {
+    "Name": "Bamboo",
+    "Mail": [
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/ppc/ppc440_bamboo.c"
+    ]
+  },
+  {
+    "Name": "e500",
+    "Mail": [
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/ppc/e500*",
+      "hw/gpio/mpc8xxx.c",
+      "hw/i2c/mpc_i2c.c",
+      "hw/net/fsl_etsec/",
+      "hw/pci-host/ppce500.c",
+      "include/hw/ppc/ppc_e500.h",
+      "include/hw/pci-host/ppce500.h",
+      "pc-bios/u-boot.e500"
+    ]
+  },
+  {
+    "Name": "mpc8544ds",
+    "Mail": [
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/ppc/mpc8544ds.c",
+      "hw/ppc/mpc8544_guts.c"
+    ]
+  },
+  {
+    "Name": "New World (mac99)",
+    "Mail": [
+      "Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/ppc/mac_newworld.c",
+      "hw/pci-host/uninorth.c",
+      "hw/pci-bridge/dec.[hc]",
+      "hw/misc/macio/",
+      "hw/misc/mos6522.c",
+      "hw/nvram/mac_nvram.c",
+      "hw/input/adb*",
+      "include/hw/misc/macio/",
+      "include/hw/misc/mos6522.h",
+      "include/hw/ppc/mac_dbdma.h",
+      "include/hw/pci-host/uninorth.h",
+      "include/hw/input/adb*",
+      "pc-bios/qemu_vga.ndrv"
+    ],
+    "Reviewer": [
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ]
+  },
+  {
+    "Name": "Old World (g3beige)",
+    "Mail": [
+      "Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/ppc/mac_oldworld.c",
+      "hw/pci-host/grackle.c",
+      "hw/misc/macio/",
+      "hw/intc/heathrow_pic.c",
+      "hw/input/adb*",
+      "include/hw/intc/heathrow_pic.h",
+      "include/hw/input/adb*",
+      "pc-bios/qemu_vga.ndrv"
+    ],
+    "Reviewer": [
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ]
+  },
+  {
+    "Name": "PReP",
+    "Mail": [
+      "Herv=C3=A9 Poussineau <hpoussin@reactos.org>"
+    ],
+    "List": [
+      "qemu-devel@nongnu.org",
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/ppc/prep.c",
+      "hw/ppc/prep_systemio.c",
+      "hw/ppc/rs6000_mc.c",
+      "hw/pci-host/prep.[hc]",
+      "hw/isa/i82378.c",
+      "hw/isa/pc87312.c",
+      "hw/dma/i82374.c",
+      "hw/timer/m48t59-isa.c",
+      "include/hw/isa/pc87312.h",
+      "include/hw/timer/m48t59.h",
+      "pc-bios/ppc_rom.bin"
+    ]
+  },
+  {
+    "Name": "sPAPR",
+    "Mail": [
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/*/spapr*",
+      "include/hw/*/spapr*",
+      "hw/*/xics*",
+      "include/hw/*/xics*",
+      "pc-bios/spapr-rtas/*",
+      "pc-bios/spapr-rtas.bin",
+      "pc-bios/slof.bin",
+      "docs/specs/ppc-spapr-hcalls.txt",
+      "docs/specs/ppc-spapr-hotplug.txt",
+      "tests/spapr*",
+      "tests/libqos/*spapr*",
+      "tests/rtas*",
+      "tests/libqos/rtas*"
+    ]
+  },
+  {
+    "Name": "PowerNV (Non-Virtualized)",
+    "Mail": [
+      "C=C3=A9dric Le Goater <clg@kaod.org>",
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/ppc/pnv*",
+      "hw/intc/pnv*",
+      "hw/intc/xics_pnv.c",
+      "include/hw/ppc/pnv*",
+      "pc-bios/skiboot.lid",
+      "tests/pnv*"
+    ]
+  },
+  {
+    "Name": "virtex_ml507",
+    "Mail": [
+      "Edgar E. Iglesias <edgar.iglesias@gmail.com>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/ppc/virtex_ml507.c"
+    ]
+  },
+  {
+    "Name": "sam460ex",
+    "Mail": [
+      "BALATON Zoltan <balaton@eik.bme.hu>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/ppc/sam460ex.c",
+      "hw/ppc/ppc440_pcix.c",
+      "hw/display/sm501*",
+      "hw/ide/sii3112.c",
+      "hw/timer/m41t80.c",
+      "pc-bios/canyonlands.dt[sb]",
+      "pc-bios/u-boot-sam460ex-20100605.bin",
+      "roms/u-boot-sam460ex"
+    ]
+  },
+  {
+    "Name": "SH4 Machines"
+  },
+  {
+    "Name": "R2D",
+    "Mail": [
+      "Magnus Damm <magnus.damm@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/sh4/r2d.c",
+      "hw/intc/sh_intc.c",
+      "hw/timer/sh_timer.c"
+    ]
+  },
+  {
+    "Name": "Shix",
+    "Mail": [
+      "Magnus Damm <magnus.damm@gmail.com>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/sh4/shix.c"
+    ]
+  },
+  {
+    "Name": "SPARC Machines"
+  },
+  {
+    "Name": "Sun4m",
+    "Mail": [
+      "Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/sparc/sun4m.c",
+      "hw/sparc/sun4m_iommu.c",
+      "hw/display/cg3.c",
+      "hw/display/tcx.c",
+      "hw/dma/sparc32_dma.c",
+      "hw/misc/eccmemctl.c",
+      "hw/*/slavio_*.c",
+      "include/hw/nvram/sun_nvram.h",
+      "include/hw/sparc/sparc32_dma.h",
+      "include/hw/sparc/sun4m_iommu.h",
+      "pc-bios/openbios-sparc32"
+    ]
+  },
+  {
+    "Name": "Sun4u",
+    "Mail": [
+      "Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/sparc64/sun4u.c",
+      "hw/sparc64/sun4u_iommu.c",
+      "include/hw/sparc/sun4u_iommu.h",
+      "hw/pci-host/sabre.c",
+      "include/hw/pci-host/sabre.h",
+      "hw/pci-bridge/simba.c",
+      "include/hw/pci-bridge/simba.h",
+      "pc-bios/openbios-sparc64"
+    ]
+  },
+  {
+    "Name": "Sun4v",
+    "Mail": [
+      "Artyom Tarasenko <atar4qemu@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/sparc64/niagara.c",
+      "hw/timer/sun4v-rtc.c",
+      "include/hw/timer/sun4v-rtc.h"
+    ]
+  },
+  {
+    "Name": "Leon3",
+    "Mail": [
+      "Fabien Chouteau <chouteau@adacore.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/sparc/leon3.c",
+      "hw/*/grlib*",
+      "include/hw/sparc/grlib.h"
+    ]
+  },
+  {
+    "Name": "S390 Machines"
+  },
+  {
+    "Name": "S390 Virtio-ccw",
+    "Mail": [
+      "Cornelia Huck <cohuck@redhat.com>",
+      "Halil Pasic <pasic@linux.ibm.com>",
+      "Christian Borntraeger <borntraeger@de.ibm.com>"
+    ],
+    "List": [
+      "qemu-s390x@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/char/sclp*.[hc]",
+      "hw/char/terminal3270.c",
+      "hw/s390x/",
+      "include/hw/s390x/",
+      "hw/watchdog/wdt_diag288.c",
+      "include/hw/watchdog/wdt_diag288.h",
+      "default-configs/s390x-softmmu.mak"
+    ],
+    "Tree": "git https://github.com/borntraeger/qemu.git s390-next"
+  },
+  {
+    "Name": "S390-ccw boot",
+    "Mail": [
+      "Christian Borntraeger <borntraeger@de.ibm.com>",
+      "Thomas Huth <thuth@redhat.com>"
+    ],
+    "List": [
+      "qemu-s390x@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/s390x/ipl.*",
+      "pc-bios/s390-ccw/",
+      "pc-bios/s390-ccw.img"
+    ],
+    "Tree": "git https://github.com/borntraeger/qemu.git s390-next"
+  },
+  {
+    "Name": "S390 PCI",
+    "Mail": [
+      "Collin Walling <walling@linux.ibm.com>"
+    ],
+    "List": [
+      "qemu-s390x@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/s390x/s390-pci*"
+    ]
+  },
+  {
+    "Name": "UniCore32 Machines"
+  },
+  {
+    "Name": "PKUnity-3 SoC initramfs-with-busybox",
+    "Mail": [
+      "Guan Xuetao <gxt@mprc.pku.edu.cn>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/*/puv3*",
+      "hw/unicore32/"
+    ]
+  },
+  {
+    "Name": "X86 Machines"
+  },
+  {
+    "Name": "PC",
+    "Mail": [
+      "Michael S. Tsirkin <mst@redhat.com>",
+      "Marcel Apfelbaum <marcel.apfelbaum@gmail.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "include/hw/i386/",
+      "hw/i386/",
+      "hw/pci-host/piix.c",
+      "hw/pci-host/q35.c",
+      "hw/pci-host/pam.c",
+      "include/hw/pci-host/q35.h",
+      "include/hw/pci-host/pam.h",
+      "hw/isa/piix4.c",
+      "hw/isa/lpc_ich9.c",
+      "hw/i2c/smbus_ich9.c",
+      "hw/acpi/piix4.c",
+      "hw/acpi/ich9.c",
+      "include/hw/acpi/ich9.h",
+      "include/hw/acpi/piix4.h",
+      "hw/misc/sga.c",
+      "hw/isa/apm.c",
+      "include/hw/isa/apm.h",
+      "tests/test-x86-cpuid.c",
+      "tests/test-x86-cpuid-compat.c"
+    ]
+  },
+  {
+    "Name": "PC Chipset",
+    "Mail": [
+      "Michael S. Tsirkin <mst@redhat.com>",
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/char/debugcon.c",
+      "hw/char/parallel*",
+      "hw/char/serial*",
+      "hw/dma/i8257*",
+      "hw/i2c/pm_smbus.c",
+      "hw/input/pckbd.c",
+      "hw/intc/apic*",
+      "hw/intc/ioapic*",
+      "hw/intc/i8259*",
+      "hw/isa/isa-superio.c",
+      "hw/misc/debugexit.c",
+      "hw/misc/pc-testdev.c",
+      "hw/timer/hpet*",
+      "hw/timer/i8254*",
+      "hw/timer/mc146818rtc*",
+      "hw/watchdog/wdt_ib700.c",
+      "hw/watchdog/wdt_i6300esb.c",
+      "include/hw/display/vga.h",
+      "include/hw/char/parallel.h",
+      "include/hw/dma/i8257.h",
+      "include/hw/i2c/pm_smbus.h",
+      "include/hw/input/i8042.h",
+      "include/hw/isa/i8259_internal.h",
+      "include/hw/isa/superio.h",
+      "include/hw/timer/hpet.h",
+      "include/hw/timer/i8254*",
+      "include/hw/timer/mc146818rtc*"
+    ]
+  },
+  {
+    "Name": "Machine core",
+    "Mail": [
+      "Eduardo Habkost <ehabkost@redhat.com>",
+      "Marcel Apfelbaum <marcel.apfelbaum@gmail.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/core/machine.c",
+      "hw/core/null-machine.c",
+      "hw/cpu/cluster.c",
+      "include/hw/boards.h",
+      "include/hw/cpu/cluster.h"
+    ],
+    "Tree": "git https://github.com/ehabkost/qemu.git machine-next"
+  },
+  {
+    "Name": "Xtensa Machines"
+  },
+  {
+    "Name": "sim",
+    "Mail": [
+      "Max Filippov <jcmvbkbc@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/xtensa/sim.c"
+    ]
+  },
+  {
+    "Name": "XTFPGA (LX60, LX200, ML605, KC705)",
+    "Mail": [
+      "Max Filippov <jcmvbkbc@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/xtensa/xtfpga.c",
+      "hw/net/opencores_eth.c"
+    ]
+  },
+  {
+    "Name": "Devices"
+  },
+  {
+    "Name": "EDU",
+    "Mail": [
+      "Jiri Slaby <jslaby@suse.cz>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/misc/edu.c"
+    ]
+  },
+  {
+    "Name": "IDE",
+    "Mail": [
+      "John Snow <jsnow@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "include/hw/ide.h",
+      "include/hw/ide/",
+      "hw/ide/",
+      "hw/block/block.c",
+      "hw/block/cdrom.c",
+      "hw/block/hd-geometry.c",
+      "tests/ide-test.c",
+      "tests/ahci-test.c",
+      "tests/cdrom-test.c",
+      "tests/libqos/ahci*"
+    ],
+    "Tree": "git https://github.com/jnsnow/qemu.git ide"
+  },
+  {
+    "Name": "IPMI",
+    "Mail": [
+      "Corey Minyard <minyard@acm.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "include/hw/ipmi/*",
+      "hw/ipmi/*",
+      "hw/smbios/smbios_type_38.c",
+      "tests/ipmi*"
+    ],
+    "Tree": "git https://github.com/cminyard/qemu.git master-ipmi-rebase=
"
+  },
+  {
+    "Name": "Floppy",
+    "Mail": [
+      "John Snow <jsnow@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/block/fdc.c",
+      "include/hw/block/fdc.h",
+      "tests/fdc-test.c"
+    ],
+    "Tree": "git https://github.com/jnsnow/qemu.git ide"
+  },
+  {
+    "Name": "OMAP",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/*/omap*",
+      "include/hw/arm/omap.h"
+    ]
+  },
+  {
+    "Name": "IPack",
+    "Mail": [
+      "Alberto Garcia <berto@igalia.com>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/char/ipoctal232.c",
+      "hw/ipack/"
+    ]
+  },
+  {
+    "Name": "PCI",
+    "Mail": [
+      "Michael S. Tsirkin <mst@redhat.com>",
+      "Marcel Apfelbaum <marcel.apfelbaum@gmail.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "include/hw/pci/*",
+      "hw/misc/pci-testdev.c",
+      "hw/pci/*",
+      "hw/pci-bridge/*",
+      "docs/pci*",
+      "docs/specs/*pci*",
+      "default-configs/pci.mak"
+    ]
+  },
+  {
+    "Name": "ACPI/SMBIOS",
+    "Mail": [
+      "Michael S. Tsirkin <mst@redhat.com>",
+      "Igor Mammedov <imammedo@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "include/hw/acpi/*",
+      "include/hw/firmware/smbios.h",
+      "hw/mem/*",
+      "hw/acpi/*",
+      "hw/smbios/*",
+      "hw/i386/acpi-build.[hc]",
+      "hw/arm/virt-acpi-build.c",
+      "tests/bios-tables-test.c",
+      "tests/acpi-utils.[hc]",
+      "tests/data/acpi/"
+    ]
+  },
+  {
+    "Name": "ppc4xx",
+    "Mail": [
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/ppc/ppc4*.c",
+      "hw/i2c/ppc4xx_i2c.c",
+      "include/hw/ppc/ppc4xx.h",
+      "include/hw/i2c/ppc4xx_i2c.h"
+    ]
+  },
+  {
+    "Name": "Character devices",
+    "Mail": [
+      "Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/char/"
+    ],
+    "Reviewer": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ]
+  },
+  {
+    "Name": "Network devices",
+    "Mail": [
+      "Jason Wang <jasowang@redhat.com>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/net/",
+      "include/hw/net/",
+      "tests/virtio-net-test.c"
+    ],
+    "Tree": "git https://github.com/jasowang/qemu.git net"
+  },
+  {
+    "Name": "SCSI",
+    "Mail": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "include/hw/scsi/*",
+      "hw/scsi/*",
+      "tests/virtio-scsi-test.c"
+    ],
+    "Tree": "git https://github.com/bonzini/qemu.git scsi-next",
+    "Reviewer": [
+      "Fam Zheng <fam@euphon.net>"
+    ]
+  },
+  {
+    "Name": "SSI",
+    "Mail": [
+      "Alistair Francis <alistair@alistair23.me>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/ssi/*",
+      "hw/block/m25p80.c",
+      "include/hw/ssi/ssi.h",
+      "tests/m25p80-test.c"
+    ],
+    "Excluded": [
+      "hw/ssi/xilinx_*"
+    ]
+  },
+  {
+    "Name": "Xilinx SPI",
+    "Mail": [
+      "Alistair Francis <alistair@alistair23.me>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/ssi/xilinx_*"
+    ]
+  },
+  {
+    "Name": "SD (Secure Card)",
+    "Mail": [
+      "Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "include/hw/sd/sd*",
+      "hw/sd/core.c",
+      "hw/sd/sd*",
+      "tests/sd*"
+    ]
+  },
+  {
+    "Name": "USB",
+    "Mail": [
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/usb/*",
+      "tests/usb-*-test.c",
+      "docs/usb2.txt",
+      "docs/usb-storage.txt",
+      "include/hw/usb.h",
+      "include/hw/usb/",
+      "default-configs/usb.mak"
+    ]
+  },
+  {
+    "Name": "USB (serial adapter)",
+    "Mail": [
+      "Gerd Hoffmann <kraxel@redhat.com>",
+      "Samuel Thibault <samuel.thibault@ens-lyon.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/usb/dev-serial.c"
+    ]
+  },
+  {
+    "Name": "VFIO",
+    "Mail": [
+      "Alex Williamson <alex.williamson@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/vfio/*",
+      "include/hw/vfio/"
+    ]
+  },
+  {
+    "Name": "vfio-ccw",
+    "Mail": [
+      "Cornelia Huck <cohuck@redhat.com>",
+      "Eric Farman <farman@linux.ibm.com>",
+      "Farhan Ali <alifm@linux.ibm.com>"
+    ],
+    "List": [
+      "qemu-s390x@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/vfio/ccw.c",
+      "hw/s390x/s390-ccw.c",
+      "include/hw/s390x/s390-ccw.h"
+    ],
+    "Tree": "git https://github.com/cohuck/qemu.git s390-next"
+  },
+  {
+    "Name": "vfio-ap",
+    "Mail": [
+      "Christian Borntraeger <borntraeger@de.ibm.com>",
+      "Tony Krowiak <akrowiak@linux.ibm.com>",
+      "Halil Pasic <pasic@linux.ibm.com>",
+      "Pierre Morel <pmorel@linux.ibm.com>"
+    ],
+    "List": [
+      "qemu-s390x@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/s390x/ap-device.c",
+      "hw/s390x/ap-bridge.c",
+      "include/hw/s390x/ap-device.h",
+      "include/hw/s390x/ap-bridge.h",
+      "hw/vfio/ap.c",
+      "docs/vfio-ap.txt"
+    ]
+  },
+  {
+    "Name": "vhost",
+    "Mail": [
+      "Michael S. Tsirkin <mst@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/*/*vhost*",
+      "docs/interop/vhost-user.json",
+      "docs/interop/vhost-user.txt",
+      "contrib/vhost-user-*/"
+    ]
+  },
+  {
+    "Name": "virtio",
+    "Mail": [
+      "Michael S. Tsirkin <mst@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/*/virtio*",
+      "hw/virtio/Makefile.objs",
+      "hw/virtio/trace-events",
+      "net/vhost-user.c",
+      "include/hw/virtio/",
+      "tests/virtio-balloon-test.c"
+    ]
+  },
+  {
+    "Name": "virtio-9p",
+    "Mail": [
+      "Greg Kurz <groug@kaod.org>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/9pfs/",
+      "fsdev/",
+      "tests/virtio-9p-test.c"
+    ],
+    "Tree": "git https://github.com/gkurz/qemu.git 9p-next"
+  },
+  {
+    "Name": "virtio-blk",
+    "Mail": [
+      "Stefan Hajnoczi <stefanha@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/block/virtio-blk.c",
+      "hw/block/dataplane/*",
+      "tests/virtio-blk-test.c"
+    ],
+    "Tree": "git https://github.com/stefanha/qemu.git block"
+  },
+  {
+    "Name": "virtio-ccw",
+    "Mail": [
+      "Cornelia Huck <cohuck@redhat.com>",
+      "Halil Pasic <pasic@linux.ibm.com>"
+    ],
+    "List": [
+      "qemu-s390x@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/s390x/virtio-ccw*.[hc]",
+      "hw/s390x/vhost-vsock-ccw.c"
+    ],
+    "Tree": "git https://github.com/borntraeger/qemu.git s390-next"
+  },
+  {
+    "Name": "virtio-input",
+    "Mail": [
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/input/virtio-input*.c",
+      "include/hw/virtio/virtio-input.h"
+    ]
+  },
+  {
+    "Name": "virtio-serial",
+    "Mail": [
+      "Amit Shah <amit@kernel.org>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/char/virtio-serial-bus.c",
+      "hw/char/virtio-console.c",
+      "include/hw/virtio/virtio-serial.h",
+      "tests/virtio-console-test.c",
+      "tests/virtio-serial-test.c"
+    ]
+  },
+  {
+    "Name": "virtio-rng",
+    "Mail": [
+      "Amit Shah <amit@kernel.org>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/virtio/virtio-rng.c",
+      "include/hw/virtio/virtio-rng.h",
+      "include/sysemu/rng*.h",
+      "backends/rng*.c",
+      "tests/virtio-rng-test.c"
+    ]
+  },
+  {
+    "Name": "virtio-crypto",
+    "Mail": [
+      "Gonglei <arei.gonglei@huawei.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/virtio/virtio-crypto.c",
+      "hw/virtio/virtio-crypto-pci.c",
+      "include/hw/virtio/virtio-crypto.h"
+    ]
+  },
+  {
+    "Name": "nvme",
+    "Mail": [
+      "Keith Busch <keith.busch@intel.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/block/nvme*",
+      "tests/nvme-test.c"
+    ]
+  },
+  {
+    "Name": "megasas",
+    "Mail": [
+      "Hannes Reinecke <hare@suse.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/scsi/megasas.c",
+      "hw/scsi/mfi.h",
+      "tests/megasas-test.c"
+    ]
+  },
+  {
+    "Name": "Network packet abstractions",
+    "Mail": [
+      "Dmitry Fleytman <dmitry.fleytman@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "include/net/eth.h",
+      "net/eth.c",
+      "hw/net/net_rx_pkt*",
+      "hw/net/net_tx_pkt*"
+    ]
+  },
+  {
+    "Name": "Vmware",
+    "Mail": [
+      "Dmitry Fleytman <dmitry.fleytman@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/net/vmxnet*",
+      "hw/scsi/vmw_pvscsi*",
+      "tests/vmxnet3-test.c"
+    ]
+  },
+  {
+    "Name": "Rocker",
+    "Mail": [
+      "Jiri Pirko <jiri@resnulli.us>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/net/rocker/",
+      "tests/rocker/",
+      "docs/specs/rocker.txt"
+    ]
+  },
+  {
+    "Name": "NVDIMM",
+    "Mail": [
+      "Xiao Guangrong <xiaoguangrong.eric@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/acpi/nvdimm.c",
+      "hw/mem/nvdimm.c",
+      "include/hw/mem/nvdimm.h",
+      "docs/nvdimm.txt"
+    ]
+  },
+  {
+    "Name": "e1000x",
+    "Mail": [
+      "Dmitry Fleytman <dmitry.fleytman@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/net/e1000x*"
+    ]
+  },
+  {
+    "Name": "e1000e",
+    "Mail": [
+      "Dmitry Fleytman <dmitry.fleytman@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/net/e1000e*"
+    ]
+  },
+  {
+    "Name": "eepro100",
+    "Mail": [
+      "Stefan Weil <sw@weilnetz.de>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/net/eepro100.c"
+    ]
+  },
+  {
+    "Name": "Generic Loader",
+    "Mail": [
+      "Alistair Francis <alistair@alistair23.me>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/core/generic-loader.c",
+      "include/hw/core/generic-loader.h",
+      "docs/generic-loader.txt"
+    ]
+  },
+  {
+    "Name": "Intel Hexadecimal Object File Loader",
+    "Mail": [
+      "Su Hang <suhang16@mails.ucas.ac.cn>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tests/hexloader-test.c",
+      "tests/data/hex-loader/test.hex"
+    ]
+  },
+  {
+    "Name": "CHRP NVRAM",
+    "Mail": [
+      "Thomas Huth <thuth@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/nvram/chrp_nvram.c",
+      "include/hw/nvram/chrp_nvram.h",
+      "tests/prom-env-test.c"
+    ]
+  },
+  {
+    "Name": "VM Generation ID",
+    "Mail": [
+      "Ben Warren <ben@skyportsystems.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/acpi/vmgenid.c",
+      "include/hw/acpi/vmgenid.h",
+      "docs/specs/vmgenid.txt",
+      "tests/vmgenid-test.c",
+      "stubs/vmgenid.c"
+    ]
+  },
+  {
+    "Name": "Unimplemented device",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "include/hw/misc/unimp.h",
+      "hw/misc/unimp.c"
+    ],
+    "Reviewer": [
+      "Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>"
+    ]
+  },
+  {
+    "Name": "Standard VGA",
+    "Mail": [
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/display/vga*",
+      "hw/display/bochs-display.c",
+      "include/hw/display/vga.h",
+      "include/hw/display/bochs-vbe.h"
+    ]
+  },
+  {
+    "Name": "ramfb",
+    "Mail": [
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/display/ramfb*.c",
+      "include/hw/display/ramfb.h"
+    ]
+  },
+  {
+    "Name": "virtio-gpu",
+    "Mail": [
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/display/virtio-gpu*",
+      "hw/display/virtio-vga.c",
+      "include/hw/virtio/virtio-gpu.h"
+    ]
+  },
+  {
+    "Name": "Cirrus VGA",
+    "Mail": [
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "hw/display/cirrus*"
+    ],
+    "Webpage": [
+      "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-=
harmful/"
+    ]
+  },
+  {
+    "Name": "EDID Generator",
+    "Mail": [
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/display/edid*",
+      "include/hw/display/edid.h",
+      "qemu-edid.c"
+    ]
+  },
+  {
+    "Name": "Firmware configuration (fw_cfg)",
+    "Mail": [
+      "Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "docs/specs/fw_cfg.txt",
+      "hw/nvram/fw_cfg.c",
+      "include/hw/nvram/fw_cfg.h",
+      "include/standard-headers/linux/qemu_fw_cfg.h",
+      "tests/libqos/fw_cfg.c",
+      "tests/fw_cfg-test.c"
+    ],
+    "Tree": "git https://github.com/philmd/qemu.git fw_cfg-next",
+    "Reviewer": [
+      "Laszlo Ersek <lersek@redhat.com>",
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ]
+  },
+  {
+    "Name": "XIVE",
+    "Mail": [
+      "David Gibson <david@gibson.dropbear.id.au>",
+      "C=C3=A9dric Le Goater <clg@kaod.org>"
+    ],
+    "List": [
+      "qemu-ppc@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "hw/*/*xive*",
+      "include/hw/*/*xive*"
+    ]
+  },
+  {
+    "Name": "Subsystems"
+  },
+  {
+    "Name": "Audio",
+    "Mail": [
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "audio/",
+      "hw/audio/",
+      "include/hw/audio/",
+      "tests/ac97-test.c",
+      "tests/es1370-test.c",
+      "tests/intel-hda-test.c"
+    ]
+  },
+  {
+    "Name": "Block layer core",
+    "Mail": [
+      "Kevin Wolf <kwolf@redhat.com>",
+      "Max Reitz <mreitz@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block*",
+      "block/",
+      "hw/block/",
+      "include/block/",
+      "qemu-img*",
+      "qemu-io*",
+      "tests/qemu-iotests/",
+      "util/qemu-progress.c",
+      "qobject/block-qdict.c",
+      "tests/check-block-qdict.c"
+    ],
+    "Tree": "git https://repo.or.cz/qemu/kevin.git block"
+  },
+  {
+    "Name": "Block I/O path",
+    "Mail": [
+      "Stefan Hajnoczi <stefanha@redhat.com>",
+      "Fam Zheng <fam@euphon.net>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "util/async.c",
+      "util/aio-*.c",
+      "block/io.c",
+      "migration/block*",
+      "include/block/aio.h",
+      "include/block/aio-wait.h",
+      "scripts/qemugdb/aio.py"
+    ],
+    "Tree": "git https://github.com/stefanha/qemu.git block"
+  },
+  {
+    "Name": "Block SCSI subsystem",
+    "Mail": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "include/scsi/*",
+      "scsi/*"
+    ],
+    "Reviewer": [
+      "Fam Zheng <fam@euphon.net>"
+    ]
+  },
+  {
+    "Name": "Block Jobs",
+    "Mail": [
+      "John Snow <jsnow@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "blockjob.c",
+      "include/block/blockjob.h",
+      "job.c",
+      "job-qmp.c",
+      "include/qemu/job.h",
+      "block/backup.c",
+      "block/commit.c",
+      "block/stream.c",
+      "block/mirror.c",
+      "qapi/job.json"
+    ],
+    "Tree": "git https://github.com/jnsnow/qemu.git jobs"
+  },
+  {
+    "Name": "Block QAPI, monitor, command line",
+    "Mail": [
+      "Markus Armbruster <armbru@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "blockdev.c",
+      "block/qapi.c",
+      "qapi/block*.json",
+      "qapi/transaction.json"
+    ],
+    "Tree": "git https://repo.or.cz/qemu/armbru.git block-next"
+  },
+  {
+    "Name": "Dirty Bitmaps",
+    "Mail": [
+      "Fam Zheng <fam@euphon.net>",
+      "John Snow <jsnow@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "util/hbitmap.c",
+      "block/dirty-bitmap.c",
+      "include/qemu/hbitmap.h",
+      "include/block/dirty-bitmap.h",
+      "tests/test-hbitmap.c",
+      "docs/interop/bitmaps.rst"
+    ],
+    "Tree": "git https://github.com/jnsnow/qemu.git bitmaps"
+  },
+  {
+    "Name": "Character device backends",
+    "Mail": [
+      "Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "chardev/",
+      "include/chardev/",
+      "qapi/char.json"
+    ],
+    "Reviewer": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ]
+  },
+  {
+    "Name": "Character Devices (Braille)",
+    "Mail": [
+      "Samuel Thibault <samuel.thibault@ens-lyon.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "chardev/baum.c"
+    ]
+  },
+  {
+    "Name": "Command line option argument parsing",
+    "Mail": [
+      "Markus Armbruster <armbru@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "include/qemu/option.h",
+      "tests/test-keyval.c",
+      "tests/test-qemu-opts.c",
+      "util/keyval.c",
+      "util/qemu-option.c"
+    ]
+  },
+  {
+    "Name": "Coverity model",
+    "Mail": [
+      "Markus Armbruster <armbru@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "scripts/coverity-model.c"
+    ]
+  },
+  {
+    "Name": "CPU",
+    "List": [
+      "qemu-devel@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "qom/cpu.c",
+      "include/qom/cpu.h"
+    ]
+  },
+  {
+    "Name": "Device Tree",
+    "Mail": [
+      "Alistair Francis <alistair.francis@wdc.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "device_tree.c",
+      "include/sysemu/device_tree.h"
+    ],
+    "Reviewer": [
+      "David Gibson <david@gibson.dropbear.id.au>"
+    ]
+  },
+  {
+    "Name": "Dump",
+    "Mail": [
+      "Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "dump.c",
+      "hw/misc/vmcoreinfo.c",
+      "include/hw/misc/vmcoreinfo.h",
+      "include/sysemu/dump-arch.h",
+      "include/sysemu/dump.h",
+      "scripts/dump-guest-memory.py",
+      "stubs/dump.c"
+    ]
+  },
+  {
+    "Name": "Error reporting",
+    "Mail": [
+      "Markus Armbruster <armbru@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "include/qapi/error.h",
+      "include/qemu/error-report.h",
+      "util/error.c",
+      "util/qemu-error.c"
+    ]
+  },
+  {
+    "Name": "GDB stub",
+    "Status": "Orphan",
+    "Files": [
+      "gdbstub*",
+      "gdb-xml/"
+    ]
+  },
+  {
+    "Name": "Memory API",
+    "Mail": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "include/exec/ioport.h",
+      "ioport.c",
+      "include/exec/memory.h",
+      "include/exec/ram_addr.h",
+      "memory.c",
+      "include/exec/memory-internal.h",
+      "exec.c"
+    ]
+  },
+  {
+    "Name": "SPICE",
+    "Mail": [
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "include/ui/qemu-spice.h",
+      "include/ui/spice-display.h",
+      "ui/spice-*.c",
+      "audio/spiceaudio.c",
+      "hw/display/qxl*",
+      "qapi/ui.json",
+      "docs/spice-port-fqdn.txt"
+    ]
+  },
+  {
+    "Name": "Graphics",
+    "Mail": [
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "ui/",
+      "include/ui/",
+      "qapi/ui.json",
+      "util/drm.c"
+    ]
+  },
+  {
+    "Name": "Cocoa graphics",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "ui/cocoa.m"
+    ]
+  },
+  {
+    "Name": "Main loop",
+    "Mail": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "cpus.c",
+      "util/main-loop.c",
+      "util/qemu-timer.c",
+      "vl.c",
+      "qapi/run-state.json"
+    ]
+  },
+  {
+    "Name": "Human Monitor (HMP)",
+    "Mail": [
+      "Dr. David Alan Gilbert <dgilbert@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "monitor.c",
+      "hmp.[ch]",
+      "hmp-commands*.hx",
+      "include/monitor/hmp-target.h",
+      "tests/test-hmp.c"
+    ]
+  },
+  {
+    "Name": "Network device backends",
+    "Mail": [
+      "Jason Wang <jasowang@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "net/",
+      "include/net/",
+      "qapi/net.json"
+    ],
+    "Tree": "git https://github.com/jasowang/qemu.git net"
+  },
+  {
+    "Name": "Netmap network backend",
+    "Mail": [
+      "Luigi Rizzo <rizzo@iet.unipi.it>",
+      "Giuseppe Lettieri <g.lettieri@iet.unipi.it>",
+      "Vincenzo Maffione <v.maffione@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "net/netmap.c"
+    ],
+    "Webpage": [
+      "http://info.iet.unipi.it/~luigi/netmap/"
+    ]
+  },
+  {
+    "Name": "NUMA",
+    "Mail": [
+      "Eduardo Habkost <ehabkost@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "numa.c",
+      "include/sysemu/numa.h"
+    ],
+    "Tree": "git https://github.com/ehabkost/qemu.git machine-next"
+  },
+  {
+    "Name": "Host Memory Backends",
+    "Mail": [
+      "Eduardo Habkost <ehabkost@redhat.com>",
+      "Igor Mammedov <imammedo@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "backends/hostmem*.c",
+      "include/sysemu/hostmem.h"
+    ],
+    "Tree": "git https://github.com/ehabkost/qemu.git machine-next"
+  },
+  {
+    "Name": "Cryptodev Backends",
+    "Mail": [
+      "Gonglei <arei.gonglei@huawei.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "include/sysemu/cryptodev*.h",
+      "backends/cryptodev*.c"
+    ]
+  },
+  {
+    "Name": "Python scripts",
+    "Mail": [
+      "Eduardo Habkost <ehabkost@redhat.com>",
+      "Cleber Rosa <crosa@redhat.com>"
+    ],
+    "Status": "Odd fixes",
+    "Files": [
+      "scripts/qmp/*",
+      "scripts/*.py",
+      "tests/*.py"
+    ]
+  },
+  {
+    "Name": "QAPI",
+    "Mail": [
+      "Markus Armbruster <armbru@redhat.com>",
+      "Michael Roth <mdroth@linux.vnet.ibm.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "qapi/",
+      "include/qapi/",
+      "include/qapi/qmp/dispatch.h",
+      "tests/qapi-schema/",
+      "tests/test-*-visitor.c",
+      "tests/test-qapi-*.c",
+      "tests/test-qmp-*.c",
+      "tests/test-visitor-serialization.c",
+      "scripts/qapi-gen.py",
+      "scripts/qapi/*",
+      "docs/devel/qapi*"
+    ],
+    "Tree": "git https://repo.or.cz/qemu/armbru.git qapi-next",
+    "Excluded": [
+      "qapi/*.json",
+      "include/qapi/qmp/"
+    ]
+  },
+  {
+    "Name": "QAPI Schema",
+    "Mail": [
+      "Eric Blake <eblake@redhat.com>",
+      "Markus Armbruster <armbru@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "qapi/*.json"
+    ],
+    "Tree": "git https://repo.or.cz/qemu/armbru.git qapi-next"
+  },
+  {
+    "Name": "QObject",
+    "Mail": [
+      "Markus Armbruster <armbru@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "qobject/",
+      "include/qapi/qmp/",
+      "scripts/coccinelle/qobject.cocci",
+      "tests/check-qdict.c",
+      "tests/check-qjson.c",
+      "tests/check-qlist.c",
+      "tests/check-qlit.c",
+      "tests/check-qnull.c",
+      "tests/check-qnum.c",
+      "tests/check-qobject.c",
+      "tests/check-qstring.c",
+      "tests/data/qobject/qdict.txt"
+    ],
+    "Tree": "git https://repo.or.cz/qemu/armbru.git qapi-next",
+    "Excluded": [
+      "include/qapi/qmp/dispatch.h"
+    ]
+  },
+  {
+    "Name": "QEMU Guest Agent",
+    "Mail": [
+      "Michael Roth <mdroth@linux.vnet.ibm.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "qga/",
+      "qemu-ga.texi",
+      "scripts/qemu-guest-agent/",
+      "tests/test-qga.c",
+      "docs/interop/qemu-ga-ref.texi"
+    ],
+    "Tree": "git https://github.com/mdroth/qemu.git qga"
+  },
+  {
+    "Name": "QOM",
+    "Mail": [
+      "Andreas F=C3=A4rber <afaerber@suse.de>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "include/qom/",
+      "qom/",
+      "tests/check-qom-interface.c",
+      "tests/check-qom-proplist.c"
+    ],
+    "Tree": "git https://github.com/afaerber/qemu-cpu.git qom-next",
+    "Excluded": [
+      "include/qom/cpu.h",
+      "qom/cpu.c"
+    ]
+  },
+  {
+    "Name": "QMP",
+    "Mail": [
+      "Markus Armbruster <armbru@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "qmp.c",
+      "monitor.c",
+      "docs/devel/*qmp-*",
+      "docs/interop/*qmp-*",
+      "scripts/qmp/",
+      "tests/qmp-test.c",
+      "tests/qmp-cmd-test.c"
+    ],
+    "Tree": "git https://repo.or.cz/qemu/armbru.git qapi-next"
+  },
+  {
+    "Name": "qtest",
+    "Mail": [
+      "Thomas Huth <thuth@redhat.com>",
+      "Laurent Vivier <lvivier@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "qtest.c",
+      "tests/libqtest.*",
+      "tests/libqos/",
+      "tests/*-test.c"
+    ],
+    "Reviewer": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ]
+  },
+  {
+    "Name": "Register API",
+    "Mail": [
+      "Alistair Francis <alistair@alistair23.me>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/core/register.c",
+      "include/hw/register.h",
+      "include/hw/registerfields.h"
+    ]
+  },
+  {
+    "Name": "SLIRP",
+    "Mail": [
+      "Samuel Thibault <samuel.thibault@ens-lyon.org>",
+      "Jan Kiszka <jan.kiszka@siemens.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "slirp/",
+      "net/slirp.c",
+      "include/net/slirp.h"
+    ],
+    "Tree": "git git://git.kiszka.org/qemu.git queues/slirp"
+  },
+  {
+    "Name": "Stubs",
+    "Mail": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "stubs/"
+    ]
+  },
+  {
+    "Name": "Tracing",
+    "Mail": [
+      "Stefan Hajnoczi <stefanha@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "trace/",
+      "trace-events",
+      "qemu-option-trace.texi",
+      "scripts/tracetool.py",
+      "scripts/tracetool/",
+      "scripts/qemu-trace-stap*",
+      "docs/devel/tracing.txt"
+    ],
+    "Tree": "git https://github.com/stefanha/qemu.git tracing"
+  },
+  {
+    "Name": "TPM",
+    "Mail": [
+      "Stefan Berger <stefanb@linux.ibm.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tpm.c",
+      "stubs/tpm.c",
+      "hw/tpm/*",
+      "include/hw/acpi/tpm.h",
+      "include/sysemu/tpm*",
+      "qapi/tpm.json",
+      "backends/tpm.c",
+      "tests/*tpm*"
+    ],
+    "Tree": "git https://github.com/stefanberger/qemu-tpm.git tpm-next"
+  },
+  {
+    "Name": "Checkpatch",
+    "Status": "Odd Fixes",
+    "Files": [
+      "scripts/checkpatch.pl"
+    ]
+  },
+  {
+    "Name": "Migration",
+    "Mail": [
+      "Juan Quintela <quintela@redhat.com>",
+      "Dr. David Alan Gilbert <dgilbert@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "include/migration/",
+      "migration/",
+      "scripts/vmstate-static-checker.py",
+      "tests/vmstate-static-checker-data/",
+      "tests/migration-test.c",
+      "docs/devel/migration.rst",
+      "qapi/migration.json"
+    ]
+  },
+  {
+    "Name": "Seccomp",
+    "Mail": [
+      "Eduardo Otubo <otubo@redhat.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "qemu-seccomp.c",
+      "include/sysemu/seccomp.h"
+    ]
+  },
+  {
+    "Name": "Cryptography",
+    "Mail": [
+      "Daniel P. Berrange <berrange@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "crypto/",
+      "include/crypto/",
+      "tests/test-crypto-*",
+      "tests/benchmark-crypto-*",
+      "tests/crypto-tls-*",
+      "tests/pkix_asn1_tab.c",
+      "qemu.sasl"
+    ]
+  },
+  {
+    "Name": "Coroutines",
+    "Mail": [
+      "Stefan Hajnoczi <stefanha@redhat.com>",
+      "Kevin Wolf <kwolf@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "util/*coroutine*",
+      "include/qemu/coroutine*",
+      "tests/test-coroutine.c"
+    ]
+  },
+  {
+    "Name": "Buffers",
+    "Mail": [
+      "Daniel P. Berrange <berrange@redhat.com>"
+    ],
+    "Status": "Odd fixes",
+    "Files": [
+      "util/buffer.c",
+      "include/qemu/buffer.h"
+    ]
+  },
+  {
+    "Name": "I/O Channels",
+    "Mail": [
+      "Daniel P. Berrange <berrange@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "io/",
+      "include/io/",
+      "tests/test-io-*"
+    ]
+  },
+  {
+    "Name": "User authorization",
+    "Mail": [
+      "Daniel P. Berrange <berrange@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "authz/",
+      "qapi/authz.json",
+      "include/authz/",
+      "tests/test-authz-*"
+    ]
+  },
+  {
+    "Name": "Sockets",
+    "Mail": [
+      "Daniel P. Berrange <berrange@redhat.com>",
+      "Gerd Hoffmann <kraxel@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "include/qemu/sockets.h",
+      "util/qemu-sockets.c",
+      "qapi/sockets.json"
+    ]
+  },
+  {
+    "Name": "File monitor",
+    "Mail": [
+      "Daniel P. Berrange <berrange@redhat.com>"
+    ],
+    "Status": "Odd fixes",
+    "Files": [
+      "util/filemonitor*.c",
+      "include/qemu/filemonitor.h",
+      "tests/test-util-filemonitor.c"
+    ]
+  },
+  {
+    "Name": "Throttling infrastructure",
+    "Mail": [
+      "Alberto Garcia <berto@igalia.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/throttle-groups.c",
+      "include/block/throttle-groups.h",
+      "include/qemu/throttle*.h",
+      "util/throttle.c",
+      "docs/throttle.txt",
+      "tests/test-throttle.c"
+    ]
+  },
+  {
+    "Name": "UUID",
+    "Mail": [
+      "Fam Zheng <fam@euphon.net>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "util/uuid.c",
+      "include/qemu/uuid.h",
+      "tests/test-uuid.c"
+    ]
+  },
+  {
+    "Name": "COLO Framework",
+    "Mail": [
+      "zhanghailiang <zhang.zhanghailiang@huawei.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "migration/colo*",
+      "include/migration/colo.h",
+      "include/migration/failover.h",
+      "docs/COLO-FT.txt"
+    ]
+  },
+  {
+    "Name": "COLO Proxy",
+    "Mail": [
+      "Zhang Chen <chen.zhang@intel.com>",
+      "Li Zhijian <lizhijian@cn.fujitsu.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "docs/colo-proxy.txt",
+      "net/colo*",
+      "net/filter-rewriter.c",
+      "net/filter-mirror.c"
+    ]
+  },
+  {
+    "Name": "Record/replay",
+    "Mail": [
+      "Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "replay/*",
+      "block/blkreplay.c",
+      "net/filter-replay.c",
+      "include/sysemu/replay.h",
+      "docs/replay.txt",
+      "stubs/replay.c"
+    ],
+    "Webpage": [
+      "https://wiki.qemu.org/Features/record-replay"
+    ],
+    "Reviewer": [
+      "Paolo Bonzini <pbonzini@redhat.com>"
+    ]
+  },
+  {
+    "Name": "IOVA Tree",
+    "Mail": [
+      "Peter Xu <peterx@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "include/qemu/iova-tree.h",
+      "util/iova-tree.c"
+    ]
+  },
+  {
+    "Name": "elf2dmp",
+    "Mail": [
+      "Viktor Prutyanov <viktor.prutyanov@phystech.edu>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "contrib/elf2dmp/"
+    ]
+  },
+  {
+    "Name": "I2C and SMBus",
+    "Mail": [
+      "Corey Minyard <cminyard@mvista.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/i2c/core.c",
+      "hw/i2c/smbus_slave.c",
+      "hw/i2c/smbus_master.c",
+      "hw/i2c/smbus_eeprom.c",
+      "include/hw/i2c/i2c.h",
+      "include/hw/i2c/smbus_master.h",
+      "include/hw/i2c/smbus_slave.h",
+      "include/hw/i2c/smbus_eeprom.h"
+    ]
+  },
+  {
+    "Name": "Usermode Emulation"
+  },
+  {
+    "Name": "Overall",
+    "Mail": [
+      "Riku Voipio <riku.voipio@iki.fi>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "thunk.c",
+      "accel/tcg/user-exec*.c"
+    ]
+  },
+  {
+    "Name": "BSD user",
+    "Status": "Orphan",
+    "Files": [
+      "bsd-user/",
+      "default-configs/*-bsd-user.mak"
+    ]
+  },
+  {
+    "Name": "Linux user",
+    "Mail": [
+      "Riku Voipio <riku.voipio@iki.fi>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "linux-user/",
+      "default-configs/*-linux-user.mak",
+      "scripts/qemu-binfmt-conf.sh"
+    ],
+    "Reviewer": [
+      "Laurent Vivier <laurent@vivier.eu>"
+    ]
+  },
+  {
+    "Name": "Tiny Code Generator (TCG)"
+  },
+  {
+    "Name": "Common code",
+    "Mail": [
+      "Richard Henderson <rth@twiddle.net>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tcg/"
+    ]
+  },
+  {
+    "Name": "AArch64 target",
+    "Mail": [
+      "Claudio Fontana <claudio.fontana@huawei.com>",
+      "Claudio Fontana <claudio.fontana@gmail.com>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tcg/aarch64/",
+      "disas/arm-a64.cc",
+      "disas/libvixl/"
+    ]
+  },
+  {
+    "Name": "ARM target",
+    "Mail": [
+      "Andrzej Zaborowski <balrogg@gmail.com>"
+    ],
+    "List": [
+      "qemu-arm@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tcg/arm/",
+      "disas/arm.c"
+    ]
+  },
+  {
+    "Name": "i386 target",
+    "Mail": [
+      "Richard Henderson <rth@twiddle.net>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tcg/i386/",
+      "disas/i386.c"
+    ]
+  },
+  {
+    "Name": "MIPS target",
+    "Mail": [
+      "Aurelien Jarno <aurelien@aurel32.net>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tcg/mips/",
+      "disas/mips.c"
+    ],
+    "Reviewer": [
+      "Aleksandar Rikalo <arikalo@wavecomp.com>"
+    ]
+  },
+  {
+    "Name": "PPC",
+    "Mail": [
+      "Richard Henderson <rth@twiddle.net>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "tcg/ppc/",
+      "disas/ppc.c"
+    ]
+  },
+  {
+    "Name": "RISC-V",
+    "Mail": [
+      "Palmer Dabbelt <palmer@sifive.com>",
+      "Alistair Francis <Alistair.Francis@wdc.com>"
+    ],
+    "List": [
+      "qemu-riscv@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tcg/riscv/",
+      "disas/riscv.c"
+    ]
+  },
+  {
+    "Name": "S390 target",
+    "Mail": [
+      "Richard Henderson <rth@twiddle.net>"
+    ],
+    "List": [
+      "qemu-s390x@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tcg/s390/",
+      "disas/s390.c"
+    ]
+  },
+  {
+    "Name": "SPARC target",
+    "Status": "Odd Fixes",
+    "Files": [
+      "tcg/sparc/",
+      "disas/sparc.c"
+    ]
+  },
+  {
+    "Name": "TCI target",
+    "Mail": [
+      "Stefan Weil <sw@weilnetz.de>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tcg/tci/",
+      "tcg/tci.c",
+      "disas/tci.c"
+    ]
+  },
+  {
+    "Name": "Block drivers"
+  },
+  {
+    "Name": "VMDK",
+    "Mail": [
+      "Fam Zheng <fam@euphon.net>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/vmdk.c"
+    ]
+  },
+  {
+    "Name": "RBD",
+    "Mail": [
+      "Josh Durgin <jdurgin@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/rbd.c"
+    ]
+  },
+  {
+    "Name": "Sheepdog",
+    "Mail": [
+      "Liu Yuan <namei.unix@gmail.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org",
+      "sheepdog@lists.wpkg.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "block/sheepdog.c"
+    ]
+  },
+  {
+    "Name": "VHDX",
+    "Mail": [
+      "Jeff Cody <codyprime@gmail.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/vhdx*"
+    ]
+  },
+  {
+    "Name": "VDI",
+    "Mail": [
+      "Stefan Weil <sw@weilnetz.de>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "block/vdi.c"
+    ]
+  },
+  {
+    "Name": "iSCSI",
+    "Mail": [
+      "Ronnie Sahlberg <ronniesahlberg@gmail.com>",
+      "Paolo Bonzini <pbonzini@redhat.com>",
+      "Peter Lieven <pl@kamp.de>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "block/iscsi.c",
+      "block/iscsi-opts.c"
+    ]
+  },
+  {
+    "Name": "Network Block Device (NBD)",
+    "Mail": [
+      "Eric Blake <eblake@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "block/nbd*",
+      "nbd/",
+      "include/block/nbd*",
+      "qemu-nbd.*",
+      "blockdev-nbd.c",
+      "docs/interop/nbd.txt"
+    ],
+    "Tree": "git https://repo.or.cz/qemu/ericb.git nbd"
+  },
+  {
+    "Name": "NFS",
+    "Mail": [
+      "Peter Lieven <pl@kamp.de>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "block/nfs.c"
+    ]
+  },
+  {
+    "Name": "SSH",
+    "Mail": [
+      "Richard W.M. Jones <rjones@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/ssh.c"
+    ]
+  },
+  {
+    "Name": "CURL",
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/curl.c"
+    ]
+  },
+  {
+    "Name": "GLUSTER",
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/gluster.c"
+    ]
+  },
+  {
+    "Name": "Null Block Driver",
+    "Mail": [
+      "Fam Zheng <fam@euphon.net>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/null.c"
+    ]
+  },
+  {
+    "Name": "NVMe Block Driver",
+    "Mail": [
+      "Fam Zheng <fam@euphon.net>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/nvme*"
+    ]
+  },
+  {
+    "Name": "Bootdevice",
+    "Mail": [
+      "Gonglei <arei.gonglei@huawei.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "bootdevice.c"
+    ]
+  },
+  {
+    "Name": "Quorum",
+    "Mail": [
+      "Alberto Garcia <berto@igalia.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/quorum.c"
+    ]
+  },
+  {
+    "Name": "blklogwrites",
+    "Mail": [
+      "Ari Sundholm <ari@tuxera.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/blklogwrites.c"
+    ]
+  },
+  {
+    "Name": "blkverify",
+    "Mail": [
+      "Stefan Hajnoczi <stefanha@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/blkverify.c"
+    ]
+  },
+  {
+    "Name": "bochs",
+    "Mail": [
+      "Stefan Hajnoczi <stefanha@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/bochs.c"
+    ]
+  },
+  {
+    "Name": "cloop",
+    "Mail": [
+      "Stefan Hajnoczi <stefanha@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/cloop.c"
+    ]
+  },
+  {
+    "Name": "dmg",
+    "Mail": [
+      "Stefan Hajnoczi <stefanha@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/dmg.c"
+    ]
+  },
+  {
+    "Name": "parallels",
+    "Mail": [
+      "Stefan Hajnoczi <stefanha@redhat.com>",
+      "Denis V. Lunev <den@openvz.org>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/parallels.c",
+      "docs/interop/parallels.txt"
+    ]
+  },
+  {
+    "Name": "qed",
+    "Mail": [
+      "Stefan Hajnoczi <stefanha@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/qed.c"
+    ]
+  },
+  {
+    "Name": "raw",
+    "Mail": [
+      "Kevin Wolf <kwolf@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/linux-aio.c",
+      "include/block/raw-aio.h",
+      "block/raw-format.c",
+      "block/file-posix.c",
+      "block/file-win32.c",
+      "block/win32-aio.c"
+    ]
+  },
+  {
+    "Name": "qcow2",
+    "Mail": [
+      "Kevin Wolf <kwolf@redhat.com>",
+      "Max Reitz <mreitz@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/qcow2*",
+      "docs/interop/qcow2.txt"
+    ]
+  },
+  {
+    "Name": "qcow",
+    "Mail": [
+      "Kevin Wolf <kwolf@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/qcow.c"
+    ]
+  },
+  {
+    "Name": "blkdebug",
+    "Mail": [
+      "Kevin Wolf <kwolf@redhat.com>",
+      "Max Reitz <mreitz@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/blkdebug.c"
+    ]
+  },
+  {
+    "Name": "vpc",
+    "Mail": [
+      "Kevin Wolf <kwolf@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/vpc.c"
+    ]
+  },
+  {
+    "Name": "vvfat",
+    "Mail": [
+      "Kevin Wolf <kwolf@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "block/vvfat.c"
+    ]
+  },
+  {
+    "Name": "Image format fuzzer",
+    "Mail": [
+      "Stefan Hajnoczi <stefanha@redhat.com>"
+    ],
+    "List": [
+      "qemu-block@nongnu.org"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "tests/image-fuzzer/"
+    ]
+  },
+  {
+    "Name": "Replication",
+    "Mail": [
+      "Wen Congyang <wencongyang2@huawei.com>",
+      "Xie Changlong <xiechanglong.d@gmail.com>"
+    ],
+    "Status": "Supported",
+    "Files": [
+      "replication*",
+      "block/replication.c",
+      "tests/test-replication.c",
+      "docs/block-replication.txt"
+    ]
+  },
+  {
+    "Name": "PVRDMA",
+    "Mail": [
+      "Yuval Shaia <yuval.shaia@oracle.com>",
+      "Marcel Apfelbaum <marcel.apfelbaum@gmail.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "hw/rdma/*",
+      "hw/rdma/vmw/*",
+      "docs/pvrdma.txt",
+      "contrib/rdmacm-mux/*",
+      "qapi/rdma.json"
+    ]
+  },
+  {
+    "Name": "Build and test automation"
+  },
+  {
+    "Name": "Build and test automation",
+    "Mail": [
+      "Alex Benn=C3=A9e <alex.bennee@linaro.org>",
+      "Fam Zheng <fam@euphon.net>"
+    ],
+    "List": [
+      "qemu-devel@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      ".travis.yml",
+      "scripts/travis/",
+      ".shippable.yml",
+      "tests/docker/",
+      "tests/vm/",
+      "scripts/archive-source.sh"
+    ],
+    "Webpage": [
+      "https://travis-ci.org/qemu/qemu",
+      "https://app.shippable.com/github/qemu/qemu",
+      "http://patchew.org/QEMU/"
+    ],
+    "Reviewer": [
+      "Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>"
+    ]
+  },
+  {
+    "Name": "FreeBSD Hosted Continuous Integration",
+    "Mail": [
+      "Ed Maste <emaste@freebsd.org>",
+      "Li-Wen Hsu <lwhsu@freebsd.org>"
+    ],
+    "List": [
+      "qemu-devel@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      ".cirrus.yml"
+    ],
+    "Webpage": [
+      "https://cirrus-ci.com/github/qemu/qemu"
+    ]
+  },
+  {
+    "Name": "GitLab Continuous Integration",
+    "Mail": [
+      "Thomas Huth <thuth@redhat.com>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      ".gitlab-ci.yml"
+    ]
+  },
+  {
+    "Name": "Guest Test Compilation Support",
+    "Mail": [
+      "Alex Benn=C3=A9e <alex.bennee@linaro.org>"
+    ],
+    "List": [
+      "qemu-devel@nongnu.org"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "tests/tcg/Makefile",
+      "tests/tcg/Makefile.include"
+    ],
+    "Reviewer": [
+      "Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>"
+    ]
+  },
+  {
+    "Name": "Documentation"
+  },
+  {
+    "Name": "Build system architecture",
+    "Mail": [
+      "Daniel P. Berrange <berrange@redhat.com>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "docs/devel/build-system.txt"
+    ]
+  },
+  {
+    "Name": "GIT Data Mining Config",
+    "Mail": [
+      "Alex Benn=C3=A9e <alex.bennee@linaro.org>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "gitdm.config",
+      "contrib/gitdm/*"
+    ]
+  },
+  {
+    "Name": "Incompatible changes",
+    "Files": [
+      "qemu-deprecated.texi"
+    ],
+    "Reviewer": [
+      "libvir-list@redhat.com"
+    ]
+  },
+  {
+    "Name": "Build System"
+  },
+  {
+    "Name": "GIT submodules",
+    "Mail": [
+      "Daniel P. Berrange <berrange@redhat.com>"
+    ],
+    "Status": "Odd Fixes",
+    "Files": [
+      "scripts/git-submodule.sh"
+    ]
+  },
+  {
+    "Name": "Sphinx documentation configuration and build machinery",
+    "Mail": [
+      "Peter Maydell <peter.maydell@linaro.org>"
+    ],
+    "Status": "Maintained",
+    "Files": [
+      "docs/conf.py",
+      "docs/*/conf.py"
+    ]
+  }
+]
--=20
2.20.1
