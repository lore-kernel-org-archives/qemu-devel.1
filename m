Received: from eggs.gnu.org ([2001:4830:134:3::10]:47486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAG8-0006PE-6r
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAG4-0003dg-PV
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:43 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 18 Dec 2018 07:57:38 +0000
Message-ID: <20181218075707.12006-6-anton.nefedov@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v11 05/10] block: treat BDRV_REQ_ALLOCATE as
 serialising
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

The idea is that ALLOCATE requests may overlap with other requests.
Reuse the existing block layer infrastructure for serialising requests.
Use the following approach:
  - mark ALLOCATE also SERIALISING, so subsequent requests to the area wait
  - ALLOCATE request itself must never wait if another request is in flight
    already. Return EAGAIN, let the caller reconsider.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 include/block/block.h |  3 +++
 block/io.c            | 31 ++++++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 643d32f4b8..dfc0fc1b8f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -88,6 +88,9 @@ typedef enum {
      * efficiently allocate the space so it reads as zeroes, or return an =
error.
      * If this flag is set then BDRV_REQ_ZERO_WRITE must also be set.
      * This flag cannot be set together with BDRV_REQ_MAY_UNMAP.
+     * This flag implicitly sets BDRV_REQ_SERIALISING meaning it is protec=
ted
+     * from conflicts with overlapping requests. If such conflict is detec=
ted,
+     * -EAGAIN is returned.
      */
     BDRV_REQ_ALLOCATE           =3D 0x100,
=20
diff --git a/block/io.c b/block/io.c
index 66006a089d..4451714a60 100644
--- a/block/io.c
+++ b/block/io.c
@@ -720,12 +720,13 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
     bdrv_wakeup(bs);
 }
=20
-static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *sel=
f)
+static bool coroutine_fn find_or_wait_serialising_requests(
+    BdrvTrackedRequest *self, bool wait)
 {
     BlockDriverState *bs =3D self->bs;
     BdrvTrackedRequest *req;
     bool retry;
-    bool waited =3D false;
+    bool found =3D false;
=20
     if (!atomic_read(&bs->serialising_in_flight)) {
         return false;
@@ -751,11 +752,14 @@ static bool coroutine_fn wait_serialising_requests(Bd=
rvTrackedRequest *self)
                  * will wait for us as soon as it wakes up, then just go o=
n
                  * (instead of producing a deadlock in the former case). *=
/
                 if (!req->waiting_for) {
+                    found =3D true;
+                    if (!wait) {
+                        break;
+                    }
                     self->waiting_for =3D req;
                     qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
                     self->waiting_for =3D NULL;
                     retry =3D true;
-                    waited =3D true;
                     break;
                 }
             }
@@ -763,7 +767,12 @@ static bool coroutine_fn wait_serialising_requests(Bdr=
vTrackedRequest *self)
         qemu_co_mutex_unlock(&bs->reqs_lock);
     } while (retry);
=20
-    return waited;
+    return found;
+}
+
+static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *sel=
f)
+{
+    return find_or_wait_serialising_requests(self, true);
 }
=20
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
@@ -1585,7 +1594,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t o=
ffset, uint64_t bytes,
                           BdrvTrackedRequest *req, int flags)
 {
     BlockDriverState *bs =3D child->bs;
-    bool waited;
+    bool found;
     int64_t end_sector =3D DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
=20
     if (bs->read_only) {
@@ -1602,9 +1611,13 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t =
offset, uint64_t bytes,
         mark_request_serialising(req, bdrv_get_cluster_size(bs));
     }
=20
-    waited =3D wait_serialising_requests(req);
+    found =3D find_or_wait_serialising_requests(req,
+                                              !(flags & BDRV_REQ_ALLOCATE)=
);
+    if (found && (flags & BDRV_REQ_ALLOCATE)) {
+        return -EAGAIN;
+    }
=20
-    assert(!waited || !req->serialising ||
+    assert(!found || !req->serialising ||
            is_request_serialising_and_aligned(req));
     assert(req->overlap_offset <=3D offset);
     assert(offset + bytes <=3D req->overlap_offset + req->overlap_bytes);
@@ -1864,6 +1877,10 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     assert(!((flags & BDRV_REQ_ALLOCATE) && (flags & BDRV_REQ_MAY_UNMAP)))=
;
     assert(!((flags & BDRV_REQ_ALLOCATE) && !(flags & BDRV_REQ_ZERO_WRITE)=
));
=20
+    if (flags & BDRV_REQ_ALLOCATE) {
+        flags |=3D BDRV_REQ_SERIALISING;
+    }
+
     trace_bdrv_co_pwritev(child->bs, offset, bytes, flags);
=20
     if (!bs->drv) {
--=20
2.17.1
