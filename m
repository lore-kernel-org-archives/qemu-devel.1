Received: from eggs.gnu.org ([209.51.188.92]:48051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpE7x-0004Ic-LM
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpE7v-0007fT-IW
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:19:41 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 31 Jan 2019 16:19:10 +0100
Message-Id: <20190131151914.164903-2-sgarzare@redhat.com>
In-Reply-To: <20190131151914.164903-1-sgarzare@redhat.com>
References: <20190131151914.164903-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/5] virtio-blk: add acct_failed param to
 virtio_blk_handle_rw_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

We add acct_failed param in order to use virtio_blk_handle_rw_error()
also when is not required to call block_acct_failed(). (eg. a discard
operation is failed)

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/block/virtio-blk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index f208c6ddb9..8a6754d9a2 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -61,7 +61,7 @@ static void virtio_blk_req_complete(VirtIOBlockReq *req=
, unsigned char status)
 }
=20
 static int virtio_blk_handle_rw_error(VirtIOBlockReq *req, int error,
-    bool is_read)
+    bool is_read, bool acct_failed)
 {
     BlockErrorAction action =3D blk_get_error_action(req->dev->blk,
                                                    is_read, error);
@@ -75,7 +75,9 @@ static int virtio_blk_handle_rw_error(VirtIOBlockReq *r=
eq, int error,
         s->rq =3D req;
     } else if (action =3D=3D BLOCK_ERROR_ACTION_REPORT) {
         virtio_blk_req_complete(req, VIRTIO_BLK_S_IOERR);
-        block_acct_failed(blk_get_stats(s->blk), &req->acct);
+        if (acct_failed) {
+            block_acct_failed(blk_get_stats(s->blk), &req->acct);
+        }
         virtio_blk_free_request(req);
     }
=20
@@ -113,7 +115,7 @@ static void virtio_blk_rw_complete(void *opaque, int =
ret)
              * the memory until the request is completed (which will
              * happen on the other side of the migration).
              */
-            if (virtio_blk_handle_rw_error(req, -ret, is_read)) {
+            if (virtio_blk_handle_rw_error(req, -ret, is_read, true)) {
                 continue;
             }
         }
@@ -132,7 +134,7 @@ static void virtio_blk_flush_complete(void *opaque, i=
nt ret)
=20
     aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     if (ret) {
-        if (virtio_blk_handle_rw_error(req, -ret, 0)) {
+        if (virtio_blk_handle_rw_error(req, -ret, 0, true)) {
             goto out;
         }
     }
--=20
2.20.1
