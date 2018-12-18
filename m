Received: from eggs.gnu.org ([2001:4830:134:3::10]:47360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAG3-0006Ls-1s
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAG1-0003at-FO
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:38 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 18 Dec 2018 07:57:34 +0000
Message-ID: <20181218075707.12006-4-anton.nefedov@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v11 03/10] quorum: set supported write flags
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

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/quorum.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/quorum.c b/block/quorum.c
index 16b3c8067c..d21a6a3b8e 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -857,6 +857,19 @@ static QemuOptsList quorum_runtime_opts =3D {
     },
 };
=20
+static void quorum_set_supported_flags(BlockDriverState *bs)
+{
+    BDRVQuorumState *s =3D bs->opaque;
+    int i;
+
+    bs->supported_write_flags =3D BDRV_REQ_FUA;
+    for (i =3D 0; i < s->num_children; i++) {
+        bs->supported_write_flags &=3D s->children[i]->bs->supported_write=
_flags;
+    }
+
+    bs->supported_write_flags |=3D BDRV_REQ_WRITE_UNCHANGED;
+}
+
 static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
                        Error **errp)
 {
@@ -950,7 +963,7 @@ static int quorum_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     }
     s->next_child_index =3D s->num_children;
=20
-    bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED;
+    quorum_set_supported_flags(bs);
=20
     g_free(opened);
     goto exit;
@@ -1025,6 +1038,8 @@ static void quorum_add_child(BlockDriverState *bs, Bl=
ockDriverState *child_bs,
     s->children =3D g_renew(BdrvChild *, s->children, s->num_children + 1)=
;
     s->children[s->num_children++] =3D child;
=20
+    quorum_set_supported_flags(bs);
+
 out:
     bdrv_drained_end(bs);
 }
@@ -1063,6 +1078,8 @@ static void quorum_del_child(BlockDriverState *bs, Bd=
rvChild *child,
     bdrv_unref_child(bs, child);
=20
     bdrv_drained_end(bs);
+
+    quorum_set_supported_flags(bs);
 }
=20
 static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
--=20
2.17.1
