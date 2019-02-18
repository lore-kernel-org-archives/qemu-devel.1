Received: from eggs.gnu.org ([209.51.188.92]:34721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldO-0006GF-Sm
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldK-0002Mo-MP
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:08 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Feb 2019 17:18:12 +0100
Message-Id: <20190218161822.3573-3-kwolf@redhat.com>
In-Reply-To: <20190218161822.3573-1-kwolf@redhat.com>
References: <20190218161822.3573-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/12] virtio-blk: Increase in_flight for
 request restart BH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

virtio_blk_dma_restart_bh() submits new requests, so in order to make
sure that these requests are not started inside a drained section of the
attached BlockBackend, we need to make sure that draining the
BlockBackend waits for the BH to be executed.

This BH is still questionable because its scheduled in the main thread
instead of the configured iothread. Leave a FIXME comment for this.

But with this fix, enabling the data plane at least waits for these
requests (in bdrv_set_aio_context()) instead of changing the AioContext
under their feet and making them run in the wrong thread, causing
crashes and failures (e.g. due to missing locking).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index cf7f47eaba..e11e6e45d0 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -675,6 +675,7 @@ static void virtio_blk_dma_restart_bh(void *opaque)
     if (mrb.num_reqs) {
         virtio_blk_submit_multireq(s->blk, &mrb);
     }
+    blk_dec_in_flight(s->conf.conf.blk);
     aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
=20
@@ -688,8 +689,11 @@ static void virtio_blk_dma_restart_cb(void *opaque, =
int running,
     }
=20
     if (!s->bh) {
+        /* FIXME The data plane is not started yet, so these requests ar=
e
+         * processed in the main thread. */
         s->bh =3D aio_bh_new(blk_get_aio_context(s->conf.conf.blk),
                            virtio_blk_dma_restart_bh, s);
+        blk_inc_in_flight(s->conf.conf.blk);
         qemu_bh_schedule(s->bh);
     }
 }
--=20
2.20.1
