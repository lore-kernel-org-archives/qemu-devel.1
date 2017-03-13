Received: from eggs.gnu.org ([2001:4830:134:3::10]:42734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4S-0000Zg-8q
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4P-0002It-7s
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:55:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4O-0002I5-Vi
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:55:53 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B211CC04BFD3
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:55:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:17 -0500
Message-Id: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 v2 00/30] trace type mismatch cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

We have a number of tracepoints that mistakenly truncate 64-bit
values into 32-bit printouts, making the trace less useful than
what is fully possible.

Previously posted patch 1 here:
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg01918.html

At which point I realized the problem may be more pervasive, so I
started a much bigger audit (aided by patch 30 of this series).

Proposing the (bulk of this) series for 2.9.  Patches 1-3 are ready
to go, and definitely belong in 2.9 as bug-fixes; 4-29 can probably
be treated as bug-fixes and included per maintainer discretion, but
may need further tweaks on platforms with different typing setups
than what I tested with (for example, I have not attempted a 32-bit
build, which will likely flag some additional misuse of "%lx" that
should have been "%"PRIx64, and I know that mingw still trips
things up).

Patch 30 is NOT 2.9 material - it has too much risk of causing
compilation failures on platforms with different types, where the
current behavior of just (silently) switching between types allows
compilation (even if it is not accurate traces).  But if we like
the approach, there are enough potential merge-conflict magnets
that the overall series should probably go early into 2.10 (other
than the bug-fixes picked into 2.9), and patch 30 is essential to
keeping us from regressing into future type mismatches.

Eric Blake (30):
  trace: Fix backwards mirror_yield parameters
  trace: Fix incorrect megasas trace parameters
  trace: Avoid abuse of amdvi_mmio_read
  trace: Fix parameter types in block
  trace: Fix parameter types in io
  trace: Fix parameter types in migration
  trace: Fix parameter types in ui
  trace: Fix parameter types in top level
  trace: Fix parameter types in linux-user
  trace: Fix parameter types in hw/acpi
  trace: Fix parameter types in hw/audio
  trace: Fix parameter types in hw/block
  trace: Fix parameter types in hw/char
  trace: Fix parameter types in hw/display
  trace: Fix parameter types in hw/dma
  trace: Fix parameter types in hw/i386
  trace: Fix parameter types in hw/input
  trace: Fix parameter types in hw/intc
  trace: Fix parameter types in hw/isa
  trace: Fix parameter types in hw/misc
  trace: Fix parameter types in hw/net
  trace: Fix parameter types in hw/nvram
  trace: Fix parameter types in hw/ppc
  trace: Fix parameter types in hw/sd
  trace: Fix parameter types in hw/scsi
  trace: Fix parameter types in hw/timer
  trace: Fix parameter types in hw/usb
  trace: Fix parameter types in hw/vfio
  trace: Fix parameter types in hw/virtio
  trace: Force compiler warnings on trace parameter type mismatches

 scripts/tracetool/format/h.py |  13 +++++
 block/mirror.c                |   5 +-
 cpu-exec.c                    |   6 +--
 hw/block/virtio-blk.c         |   4 +-
 hw/char/escc.c                |   4 +-
 hw/i386/amd_iommu.c           |   3 +-
 hw/intc/apic_common.c         |   2 +-
 hw/net/e1000e_core.c          |  10 ++--
 hw/nvram/fw_cfg.c             |   2 +-
 hw/scsi/esp-pci.c             |   2 +-
 hw/scsi/megasas.c             |  14 +++---
 hw/timer/grlib_gptimer.c      |   6 +--
 hw/usb/hcd-ehci.c             |   9 ++--
 hw/usb/hcd-xhci.c             |   4 +-
 hw/vfio/pci.c                 |   3 +-
 io/channel-command.c          |   2 +-
 linux-user/signal.c           | 106 +++++++++++++++++++--------------------
 translate-all.c               |   2 +-
 block/trace-events            |   4 +-
 hw/acpi/trace-events          |   6 +--
 hw/audio/trace-events         |   8 +--
 hw/char/trace-events          |  14 +++---
 hw/display/trace-events       |  20 ++++----
 hw/dma/trace-events           |   8 +--
 hw/i386/trace-events          |   3 +-
 hw/input/trace-events         |   4 +-
 hw/intc/trace-events          |  40 +++++++--------
 hw/isa/trace-events           |   4 +-
 hw/misc/trace-events          |  44 ++++++++--------
 hw/net/trace-events           |  58 ++++++++++-----------
 hw/nvram/trace-events         |   4 +-
 hw/ppc/trace-events           |  16 +++---
 hw/scsi/trace-events          | 114 +++++++++++++++++++++---------------------
 hw/sd/trace-events            |   4 +-
 hw/timer/trace-events         |  14 +++---
 hw/usb/trace-events           |  84 +++++++++++++++----------------
 hw/vfio/trace-events          |  14 +++---
 hw/virtio/trace-events        |   2 +-
 migration/trace-events        |   4 +-
 trace-events                  |   2 +-
 ui/trace-events               |   8 +--
 41 files changed, 347 insertions(+), 329 deletions(-)

-- 
2.9.3
