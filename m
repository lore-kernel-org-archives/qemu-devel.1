Received: from eggs.gnu.org ([2001:4830:134:3::10]:41078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fGRKQ-0000ae-2P
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fGRKM-00066C-U1
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:30 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  9 May 2018 17:48:20 +0200
Message-Id: <20180509154822.23510-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/2] vfio-ccw: support for {halt,
 clear} subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Hi,

this (RFC) is an initial stab at passing the halt and clear subchannel
operations to the host device. Today, host userspace is emulating
those two operations, but we really want to execute them on the host
device (e.g. for error recovery situations).

The nice thing about this approach is that is independent from userspace
changes: Unless userspace forwards halt/clear requests, we behave as
before. Conversely, userspace can simply try to submit halt/clear, and
old kernels will simply indicate that it is not supported.

This survives triggering clear subchannel in the guest (hacked in by
myself) together with an update QEMU (to be posted in a moment).

Obviously, this needs some more work. Better support for async handling
comes to mind. We probably also want to support other channel I/O
instructions.

Cornelia Huck (2):
  s390/cio: export hsch to modules
  vfio-ccw: support for halt/clear subchannel

 drivers/s390/cio/ioasm.c        |  1 +
 drivers/s390/cio/vfio_ccw_drv.c | 10 ++++-
 drivers/s390/cio/vfio_ccw_fsm.c | 94 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 93 insertions(+), 12 deletions(-)

-- 
2.14.3
