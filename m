Received: from eggs.gnu.org ([209.51.188.92]:36234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gopoq-0000sR-S9
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gopop-0005hC-Ru
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:22:20 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Jan 2019 14:22:06 +0100
Message-Id: <20190130132212.7376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/6] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>

[This is the Linux kernel part, git tree is available at
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-eagain-caps-v3

The companion QEMU patches are available at
https://github.com/cohuck/qemu vfio-ccw-caps
This is the previously posted v2 version, which should continue to work.]

Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
device. This tends to work well for the most common 'good path' scenarios;
however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
clearing pending requests at the device is currently not supported.
This may be a problem for e.g. error recovery.

This patch series introduces capabilities (similar to what vfio-pci uses)
and exposes a new async region for handling hsch/csch.

Lightly tested (I can interact with a dasd as before, and reserve/release
seems to work well.) Not sure if there is a better way to test this, ideas
welcome.

Changes v2->v3:
- Unb0rked patch 1, improved scope
- Split out the new mutex from patch 2 into new patch 3; added missing
  locking and hopefully improved description
- Patch 2 now reworks the state handling by splitting the BUSY state
  into CP_PROCESSING and CP_PENDING
- Patches 3 and 5 adapted on top of the reworked patches; hsch/csch
  are allowed in CP_PENDING, but not in CP_PROCESSING (did not add
  any R-b due to that)
- Added missing free in patch 5
- Probably some small changes I forgot to note down

Changes v1->v2:
- New patch 1: make it safe to use the cp accessors at any time; this
  should avoid problems with unsolicited interrupt handling
- New patch 2: handle concurrent accesses to the io region; the idea is
  to return -EAGAIN to userspace more often (so it can simply retry)
- also handle concurrent accesses to the async io region
- change VFIO_REGION_TYPE_CCW
- merge events for halt and clear to a single async event; this turned out
  to make the code quite a bit simpler
- probably some small changes I forgot to note down

Cornelia Huck (6):
  vfio-ccw: make it safe to access channel programs
  vfio-ccw: rework ssch state handling
  vfio-ccw: protect the I/O region
  vfio-ccw: add capabilities chain
  s390/cio: export hsch to modules
  vfio-ccw: add handling for async channel instructions

 drivers/s390/cio/Makefile           |   3 +-
 drivers/s390/cio/ioasm.c            |   1 +
 drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++
 drivers/s390/cio/vfio_ccw_cp.c      |  20 ++-
 drivers/s390/cio/vfio_ccw_cp.h      |   2 +
 drivers/s390/cio/vfio_ccw_drv.c     |  57 ++++++--
 drivers/s390/cio/vfio_ccw_fsm.c     | 143 ++++++++++++++++++-
 drivers/s390/cio/vfio_ccw_ops.c     | 210 +++++++++++++++++++++++-----
 drivers/s390/cio/vfio_ccw_private.h |  48 ++++++-
 include/uapi/linux/vfio.h           |   4 +
 include/uapi/linux/vfio_ccw.h       |  12 ++
 11 files changed, 531 insertions(+), 57 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_async.c

-- 
2.17.2
