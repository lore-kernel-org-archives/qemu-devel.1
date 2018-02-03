Received: from eggs.gnu.org ([2001:4830:134:3::10]:50425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCh-0001yl-Lm
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCe-0008SK-8c
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:51 -0500
Received: from chuckie.co.uk ([82.165.15.123]:36236
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ehvCd-0008OZ-T6
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:48 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat,  3 Feb 2018 10:37:17 +0000
Message-Id: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 00/10] cuda: various fixes,
 and move 6522 to separate device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com

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

Finally patch 10 switches CUDA over from using its own 6522 implementation over
to using an embedded mos6522 device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (10):
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

 default-configs/ppc-softmmu.mak |   1 +
 hw/misc/Makefile.objs           |   3 +
 hw/misc/macio/cuda.c            | 623 ++++++++++------------------------------
 hw/misc/macio/macio.c           |   2 +-
 hw/misc/mos6522.c               | 505 ++++++++++++++++++++++++++++++++
 hw/misc/trace-events            |   7 +
 hw/ppc/mac.h                    |  89 +++---
 include/hw/misc/mos6522.h       | 149 ++++++++++
 8 files changed, 871 insertions(+), 508 deletions(-)
 create mode 100644 hw/misc/mos6522.c
 create mode 100644 include/hw/misc/mos6522.h

-- 
2.11.0
