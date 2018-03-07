Received: from eggs.gnu.org ([2001:4830:134:3::10]:52940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etaGl-0002fl-7i
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etaGk-0004pm-Gd
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:42:15 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  7 Mar 2018 14:42:01 +0000
Message-Id: <20180307144205.20619-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/4] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

v3:
 * Rebase on qemu.git/master after AIO_WAIT_WHILE() was merged [Fam]
v2:
 * Tackle the .ioeventfd_stop() vs vq handler race by removing the ioeventfd
   from a BH in the IOThread [Fam]

There are several race conditions in virtio-blk/virtio-scsi dataplane code.
This patch series addresses them, see the commit description for details on the
individual cases.

Stefan Hajnoczi (4):
  block: add aio_wait_bh_oneshot()
  virtio-blk: fix race between .ioeventfd_stop() and vq handler
  virtio-scsi: fix race between .ioeventfd_stop() and vq handler
  vl: introduce vm_shutdown()

 include/block/aio-wait.h        | 13 +++++++++++++
 include/sysemu/iothread.h       |  1 -
 include/sysemu/sysemu.h         |  1 +
 cpus.c                          | 16 +++++++++++++---
 hw/block/dataplane/virtio-blk.c | 24 +++++++++++++++++-------
 hw/scsi/virtio-scsi-dataplane.c |  9 +++++----
 iothread.c                      | 31 -------------------------------
 util/aio-wait.c                 | 31 +++++++++++++++++++++++++++++++
 vl.c                            | 13 +++----------
 9 files changed, 83 insertions(+), 56 deletions(-)

-- 
2.14.3
