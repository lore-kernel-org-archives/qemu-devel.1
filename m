Received: from eggs.gnu.org ([2001:4830:134:3::10]:34833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gHomX-0003io-1Y
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gHomR-0001y8-0T
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:35:27 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 31 Oct 2018 11:35:02 +0000
Message-ID: <20181031113418.29796-9-anton.nefedov@virtuozzo.com>
References: <20181031113418.29796-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181031113418.29796-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 8/9] file-posix: account discard operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

This will help to identify how many of the user-issued discard operations
(accounted on a device level) have actually suceeded down on the host file
(even though the numbers will not be exactly the same if non-raw format
driver is used (e.g. qcow2 sending metadata discards)).

Note that these numbers will not include discards triggered by
write-zeroes + MAY_UNMAP calls.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/file-posix.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 2da3a76355..1a7126046c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -163,6 +163,11 @@ typedef struct BDRVRawState {
     bool has_fallocate;
     bool needs_alignment;
     bool check_cache_dropped;
+    struct {
+        int64_t discard_nb_ok;
+        int64_t discard_nb_failed;
+        int64_t discard_bytes_ok;
+    } stats;
=20
     PRManager *pr_mgr;
 } BDRVRawState;
@@ -2582,12 +2587,25 @@ static void coroutine_fn raw_co_invalidate_cache(Bl=
ockDriverState *bs,
 #endif /* !__linux__ */
 }
=20
+static void raw_account_discard(BDRVRawState *s, uint64_t nbytes, int ret)
+{
+    if (ret) {
+        s->stats.discard_nb_failed++;
+    } else {
+        s->stats.discard_nb_ok++;
+        s->stats.discard_bytes_ok +=3D nbytes;
+    }
+}
+
 static coroutine_fn int
 raw_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 {
     BDRVRawState *s =3D bs->opaque;
+    int ret;
=20
-    return paio_submit_co(bs, s->fd, offset, NULL, bytes, QEMU_AIO_DISCARD=
);
+    ret =3D paio_submit_co(bs, s->fd, offset, NULL, bytes, QEMU_AIO_DISCAR=
D);
+    raw_account_discard(s, bytes, ret);
+    return ret;
 }
=20
 static int coroutine_fn raw_co_pwrite_zeroes(
@@ -3084,10 +3102,14 @@ hdev_co_pdiscard(BlockDriverState *bs, int64_t offs=
et, int bytes)
=20
     ret =3D fd_open(bs);
     if (ret < 0) {
+        raw_account_discard(s, bytes, ret);
         return ret;
     }
-    return paio_submit_co(bs, s->fd, offset, NULL, bytes,
-                          QEMU_AIO_DISCARD | QEMU_AIO_BLKDEV);
+
+    ret =3D paio_submit_co(bs, s->fd, offset, NULL, bytes,
+                         QEMU_AIO_DISCARD | QEMU_AIO_BLKDEV);
+    raw_account_discard(s, bytes, ret);
+    return ret;
 }
=20
 static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
--=20
2.17.1
