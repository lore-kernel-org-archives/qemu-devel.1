Received: from eggs.gnu.org ([2001:4830:134:3::10]:48505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwD-0007ii-Rp
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwC-00006S-Kq
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:53 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:20 +0200
Message-Id: <20170704220346.29244-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/35] block: bdrv_create() and
 bdrv_debug_event() are coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Called from coroutine.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/block/block_int.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 93eb2a9528..a183c72b7c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -126,7 +126,7 @@ struct BlockDriver {
     int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flag=
s,
                           Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
-    int (*bdrv_create)(const char *filename, QemuOpts *opts, Error **err=
p);
+    int coroutine_fn (*bdrv_create)(const char *filename, QemuOpts *opts=
, Error **errp);
     int (*bdrv_set_key)(BlockDriverState *bs, const char *key);
     int (*bdrv_make_empty)(BlockDriverState *bs);
=20
@@ -267,7 +267,7 @@ struct BlockDriver {
                               BlockDriverAmendStatusCB *status_cb,
                               void *cb_opaque);
=20
-    void (*bdrv_debug_event)(BlockDriverState *bs, BlkdebugEvent event);
+    void coroutine_fn (*bdrv_debug_event)(BlockDriverState *bs, Blkdebug=
Event event);
=20
     /* TODO Better pass a option string/QDict/QemuOpts to add any rule? =
*/
     int (*bdrv_debug_breakpoint)(BlockDriverState *bs, const char *event=
,
--=20
2.13.1.395.gf7b71de06
