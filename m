Received: from eggs.gnu.org ([2001:4830:134:3::10]:57220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRfL3-0002Ix-G2
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRfKz-00060t-1a
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRfKy-0005zH-SN
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 12 Jan 2017 11:46:09 +0000
Message-Id: <20170112114612.14520-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio: revert
 virtio_queue_set_notification() nesting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Doug Goldstein <cardoe@cardoe.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The virtio_queue_set_notification() nesting introduced for AioContext polling
raised an assertion with virtio-net (even in non-polling mode).  Converting
virtio-net and virtio-crypto to use virtio_queue_set_notification() in a
nesting fashion would be invasive and isn't worth it.

Patch 1 contains the revert to resolve the bug that Doug noticed.

Patch 2 is a less efficient but safe alternative.

Stefan Hajnoczi (2):
  Revert "virtio: turn vq->notification into a nested counter"
  virtio: disable notifications again after poll succeeded

 hw/virtio/virtio.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

-- 
2.9.3
