Received: from eggs.gnu.org ([2001:4830:134:3::10]:52120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzNdE-00017F-DB
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzNdA-0005Wu-Ld
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:57:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Sep 2018 22:56:14 +0800
Message-Id: <20180910145616.8598-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio-scsi: Fix QEMU hang with vIOMMU and
 ATS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, peterx@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

The first patch describes the bug and the reproducer.

The VQ poll handler that is called by mistake within virtio_scsi_dataplane_stop
enters a dead loop because it fails to detect an error state. Fix both sides of
the problem: the handler should break out from the loop if no progress can be
made due to virtio_error; the handler shouldn't be called in that situation in
the first place.

Fam Zheng (2):
  virtio: Return true from virtio_queue_empty if broken
  virtio-scsi/virtio-blk: Disable poll handlers when stopping vq handler

 hw/block/dataplane/virtio-blk.c | 2 ++
 hw/scsi/virtio-scsi-dataplane.c | 2 ++
 hw/virtio/virtio.c              | 8 ++++++++
 3 files changed, 12 insertions(+)

-- 
2.17.1
