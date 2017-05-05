Received: from eggs.gnu.org ([2001:4830:134:3::10]:41370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6j3T-0004WT-9O
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6j3P-0003lb-Bu
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6j3P-0003kV-2Q
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:38:15 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 May 2017 14:38:05 -0500
Message-Id: <20170505193810.2934-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/5] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com

v2 was here:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03185.html
v3 and v4 were dead on arrival
v5 was here:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05564.html

Since then:
- rework the enum to be internal only
- add a 'none' slot to the enum, so that we are back to comparison
to 0 rather than -1 as the no-request-yet state
- drop the RFC patch that would expose the reasons through QAPI (Dan's
take, at least on IRC, is that even with finer-grained reasons from
qemu, the most libvirt would do is log the reason and then still just
expose a boolean higher up).  We can revive that patch if desired, but
doing so also implies adding a 'query-shutdown' command, and I didn't
think it was worth it for now (no need to over-engineer until we know
we have a client that wants it)
- fix replay to preserve status
- split the patches slightly differently, so that internal wiring and
event additions are separated

Eric Blake (5):
  shutdown: Simplify shutdown_signal
  shutdown: Prepare for use of an enum in reset/shutdown_request
  shutdown: Add source information to SHUTDOWN and RESET
  shutdown: Preserve shutdown cause through replay
  shutdown: Expose bool cause in SHUTDOWN and RESET events

 qapi/event.json             | 17 ++++++++---
 include/sysemu/replay.h     |  3 +-
 include/sysemu/sysemu.h     | 27 ++++++++++++++----
 replay/replay-internal.h    |  3 +-
 vl.c                        | 69 +++++++++++++++++++++++++++------------------
 hw/acpi/core.c              |  4 +--
 hw/arm/highbank.c           |  4 +--
 hw/arm/integratorcp.c       |  2 +-
 hw/arm/musicpal.c           |  2 +-
 hw/arm/omap1.c              | 10 ++++---
 hw/arm/omap2.c              |  2 +-
 hw/arm/spitz.c              |  2 +-
 hw/arm/stellaris.c          |  2 +-
 hw/arm/tosa.c               |  2 +-
 hw/i386/pc.c                |  2 +-
 hw/i386/xen/xen-hvm.c       |  9 ++++--
 hw/input/pckbd.c            |  4 +--
 hw/ipmi/ipmi.c              |  4 +--
 hw/isa/lpc_ich9.c           |  2 +-
 hw/mips/boston.c            |  2 +-
 hw/mips/mips_malta.c        |  2 +-
 hw/mips/mips_r4k.c          |  4 +--
 hw/misc/arm_sysctl.c        |  8 +++---
 hw/misc/cbus.c              |  2 +-
 hw/misc/macio/cuda.c        |  4 +--
 hw/misc/slavio_misc.c       |  4 +--
 hw/misc/zynq_slcr.c         |  2 +-
 hw/pci-host/apb.c           |  4 +--
 hw/pci-host/bonito.c        |  2 +-
 hw/pci-host/piix.c          |  2 +-
 hw/ppc/e500.c               |  2 +-
 hw/ppc/mpc8544_guts.c       |  2 +-
 hw/ppc/ppc.c                |  2 +-
 hw/ppc/ppc405_uc.c          |  2 +-
 hw/ppc/spapr_hcall.c        |  2 +-
 hw/ppc/spapr_rtas.c         |  4 +--
 hw/s390x/ipl.c              |  2 +-
 hw/sh4/r2d.c                |  2 +-
 hw/timer/etraxfs_timer.c    |  2 +-
 hw/timer/m48t59.c           |  4 +--
 hw/timer/milkymist-sysctl.c |  4 +--
 hw/timer/pxa2xx_timer.c     |  2 +-
 hw/watchdog/watchdog.c      |  2 +-
 hw/xenpv/xen_domainbuild.c  |  2 +-
 hw/xtensa/xtfpga.c          |  2 +-
 kvm-all.c                   |  6 ++--
 migration/colo.c            |  2 +-
 migration/savevm.c          |  2 +-
 os-win32.c                  |  2 +-
 qmp.c                       |  4 +--
 replay/replay.c             |  9 +++---
 target/alpha/sys_helper.c   |  4 +--
 target/arm/psci.c           |  4 +--
 target/i386/excp_helper.c   |  2 +-
 target/i386/hax-all.c       |  6 ++--
 target/i386/helper.c        |  2 +-
 target/i386/kvm.c           |  2 +-
 target/s390x/helper.c       |  2 +-
 target/s390x/kvm.c          |  4 +--
 target/s390x/misc_helper.c  |  4 +--
 target/sparc/int32_helper.c |  2 +-
 ui/sdl.c                    |  2 +-
 ui/sdl2.c                   |  4 +--
 tests/qemu-iotests/071.out  |  4 +--
 tests/qemu-iotests/081.out  |  2 +-
 tests/qemu-iotests/087.out  | 12 ++++----
 tests/qemu-iotests/094.out  |  2 +-
 tests/qemu-iotests/117.out  |  2 +-
 tests/qemu-iotests/119.out  |  2 +-
 tests/qemu-iotests/120.out  |  2 +-
 tests/qemu-iotests/140.out  |  2 +-
 tests/qemu-iotests/143.out  |  2 +-
 tests/qemu-iotests/156.out  |  2 +-
 trace-events                |  2 +-
 ui/cocoa.m                  |  2 +-
 75 files changed, 194 insertions(+), 147 deletions(-)

-- 
2.9.3
