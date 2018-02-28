Received: from eggs.gnu.org ([2001:4830:134:3::10]:46014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1er6KZ-00082m-C8
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1er6KX-0000h4-A2
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:19:55 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 28 Feb 2018 18:19:42 +0000
Message-Id: <20180228181946.22958-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

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
