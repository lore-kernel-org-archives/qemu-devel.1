Received: from eggs.gnu.org ([209.51.188.92]:49755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gt4Ux-00021L-4a
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 00:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gt4Uw-0002gs-9d
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 00:51:19 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 11 Feb 2019 13:50:35 +0800
Message-Id: <20190211055040.13528-5-stefanha@redhat.com>
In-Reply-To: <20190211055040.13528-1-stefanha@redhat.com>
References: <20190211055040.13528-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/9] virtio-blk: add acct_failed param to
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
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Pankaj Gupta <pagupta@redhat.com>

From: Stefano Garzarella <sgarzare@redhat.com>

We add acct_failed param in order to use virtio_blk_handle_rw_error()
also when is not required to call block_acct_failed(). (eg. a discard
operation is failed)

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Pankaj Gupta <pagupta@redhat.com>
Message-id: 20190208134950.187665-2-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 843bb2bec8..c95a6f4c9b 100644
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
     VirtIOBlock *s =3D req->dev;
     BlockErrorAction action =3D blk_get_error_action(s->blk, is_read, er=
ror);
@@ -74,7 +74,9 @@ static int virtio_blk_handle_rw_error(VirtIOBlockReq *r=
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
@@ -112,7 +114,7 @@ static void virtio_blk_rw_complete(void *opaque, int =
ret)
              * the memory until the request is completed (which will
              * happen on the other side of the migration).
              */
-            if (virtio_blk_handle_rw_error(req, -ret, is_read)) {
+            if (virtio_blk_handle_rw_error(req, -ret, is_read, true)) {
                 continue;
             }
         }
@@ -131,7 +133,7 @@ static void virtio_blk_flush_complete(void *opaque, i=
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
