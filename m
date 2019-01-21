Received: from eggs.gnu.org ([209.51.188.92]:45321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1glXOY-0003Aa-6O
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1glXOL-00054L-LZ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:05:30 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 21 Jan 2019 12:05:06 +0100
Message-Id: <20190121110508.2320-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] vfio-ccw: support hsch/csch (QEMU part)
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

[This is the QEMU part, git tree is available at
https://github.com/cohuck/qemu vfio-ccw-caps

The companion Linux kernel patches are available at
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-eagain-caps]

Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
device. This tends to work well for the most common 'good path' scenarios;
however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
clearing pending requests at the device is currently not supported.
This may be a problem for e.g. error recovery.

This patch series makes use of the newly introduced async command region
to issue hsch/csch; if it is not present, continue to emulate hsch/csch,
as before.

Note that the kernel side now returns -EAGAIN to trigger a retry in more
cases; QEMU should already be fine with that.

[I'm not quite happy with how this async processing hooks up in css.c;
ideas welcome.]

Lightly tested (I can interact with a dasd as before, and reserve/release
seems to work well.) Not sure if there is a better way to test this, ideas
welcome.

Changes v1->v2:
- update kernel header to v2 of kernel patches
- rebased on master

Cornelia Huck (2):
  vfio-ccw: new capability chain support
  vfio-ccw: support async command subregion

 hw/s390x/css.c                 |  27 ++++++--
 hw/vfio/ccw.c                  | 109 ++++++++++++++++++++++++++++++++-
 include/hw/s390x/s390-ccw.h    |   3 +
 linux-headers/linux/vfio.h     |   4 ++
 linux-headers/linux/vfio_ccw.h |  12 ++++
 5 files changed, 149 insertions(+), 6 deletions(-)

-- 
2.17.2
