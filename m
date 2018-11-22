Received: from eggs.gnu.org ([2001:4830:134:3::10]:37283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gPsFX-0001q1-Cv
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gPsFV-0000yT-E6
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:43 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 22 Nov 2018 17:54:29 +0100
Message-Id: <20181122165432.4437-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] vfio-ccw: support hsch/csch (kernel part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>

[This is the Linux kernel part, git tree is available at
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-caps

The companion QEMU patches are available at
https://github.com/cohuck/qemu vfio-ccw-caps]

Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
device. This tends to work well for the most common 'good path' scenarios;
however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
clearing pending requests at the device is currently not supported.
This may be a problem for e.g. error recovery.

This patch series introduces capabilities (similar to what vfio-pci uses)
and exposes a new async region for handling hsch/csch.

Very lightly tested (I can interact with a dasd as before; I have not
found a reliable way to trigger hsch/csch in the Linux dasd guest driver.)

Cornelia Huck (3):
  vfio-ccw: add capabilities chain
  s390/cio: export hsch to modules
  vfio-ccw: add handling for asnyc channel instructions

 drivers/s390/cio/Makefile           |   3 +-
 drivers/s390/cio/ioasm.c            |   1 +
 drivers/s390/cio/vfio_ccw_async.c   |  88 +++++++++++++
 drivers/s390/cio/vfio_ccw_drv.c     |  48 +++++--
 drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++-
 drivers/s390/cio/vfio_ccw_ops.c     | 195 ++++++++++++++++++++++++----
 drivers/s390/cio/vfio_ccw_private.h |  44 +++++++
 include/uapi/linux/vfio.h           |   5 +
 include/uapi/linux/vfio_ccw.h       |  12 ++
 9 files changed, 509 insertions(+), 45 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_async.c

-- 
2.17.2
