Received: from eggs.gnu.org ([2001:4830:134:3::10]:43373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmF-0001Ki-RU
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmD-0004dL-Og
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:03 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  9 Feb 2018 18:51:30 +0000
Message-Id: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 00/12] cuda: various fixes, tidy-ups,
 and move 6522 to separate device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

The Mac CUDA device (also known as via-cuda) consists of two parts: a 6522 VIA
acting as an interface chip and the CUDA device itself.

Currently there are at least 2 other upcoming Mac devices that include their
own 6522 VIA implementations: Ben's via-pmu device and Laurent's mac_via
device with their own hacks based upon the existing CUDA device. So rather than
keep duplicating this same functionality with slightly different hacks, let's
move the 6522 into its own separate device.

Patches 1 converts CUDA away from using old_mmio accesses, whilst patches 2-3
came about from studying Laurent and Ben's implementations (and appear to have
no ill effects in my testing so far).

Patches 4-8 do the majority of the work which is to isolate the hacks required
by MacOS into separate functions so that a separate 6522 device can operate in
a standard way, yet allow a CUDA implementation to hook into the right places.

Patch 9 introduces a new mos6522 device for the shared functionality with the
relevant hook points for delayed SR interrupt delivery and MacOS timer
calibration hacks implemented as device class methods.

Patch 10 switches CUDA over from using its own 6522 implementation over
to using an embedded mos6522 device, allowing the duplicate code to be removed.

Finally patches 11-12 perform some additional tidy-up by moving the CUDA
definitions into a new cuda.h file and converting CUDA over to use trace-events.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


v2:
- Add R-B tags from Laurent and Philippe
- Add David to CC as PPC maintainer and qemu-ppc for further comment
- Use DEVICE_BIG_ENDIAN in patch 1 as suggested by Laurent
- Rename *_INT constants in patch 9 to match those used in Ben's PMU patches
- Add patch 11 to move CUDA definitions into a new cuda.h file
- Add patch 12 to convert CUDA over to use trace-events


Mark Cave-Ayland (12):
  cuda: do not use old_mmio accesses
  cuda: don't allow writes to port output pins
  cuda: don't call cuda_update() when writing to ACR register
  cuda: introduce CUDAState parameter to get_counter()
  cuda: rename frequency property to tb_frequency
  cuda: minor cosmetic tidy-ups to get_next_irq_time()
  cuda: set timer 1 frequency property to CUDA_TIMER_FREQ
  cuda: factor out timebase-derived counter value and load time
  misc: introduce new mos6522 VIA device and enable it for ppc builds
  cuda: convert to use the shared mos6522 device
  ppc: move CUDAState and other CUDA-related definitions into separate
    cuda.h file
  cuda: convert to trace-events

 Makefile.objs                   |   1 +
 default-configs/ppc-softmmu.mak |   1 +
 hw/misc/Makefile.objs           |   3 +
 hw/misc/macio/cuda.c            | 666 +++++++++++-----------------------------
 hw/misc/macio/macio.c           |   3 +-
 hw/misc/macio/trace-events      |  11 +
 hw/misc/mos6522.c               | 505 ++++++++++++++++++++++++++++++
 hw/misc/trace-events            |   7 +
 hw/ppc/mac.h                    |  76 +----
 include/hw/misc/macio/cuda.h    | 107 +++++++
 include/hw/misc/mos6522.h       | 152 +++++++++
 11 files changed, 963 insertions(+), 569 deletions(-)
 create mode 100644 hw/misc/macio/trace-events
 create mode 100644 hw/misc/mos6522.c
 create mode 100644 include/hw/misc/macio/cuda.h
 create mode 100644 include/hw/misc/mos6522.h

-- 
2.11.0
