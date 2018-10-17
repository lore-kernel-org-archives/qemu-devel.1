Received: from eggs.gnu.org ([2001:4830:134:3::10]:44859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCouJ-000717-6x
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCouG-000410-D9
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:42:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 17 Oct 2018 18:41:57 +0200
Message-Id: <20181017164200.22344-7-kwolf@redhat.com>
In-Reply-To: <20181017164200.22344-1-kwolf@redhat.com>
References: <20181017164200.22344-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 6/9] curl: Support auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

If read-only=3Doff, but auto-read-only=3Don is given, just degrade to
read-only.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/curl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index fabb2b4da7..db5d2bd8ef 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -684,10 +684,10 @@ static int curl_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
     const char *protocol_delimiter;
     int ret;
=20
-
-    if (flags & BDRV_O_RDWR) {
-        error_setg(errp, "curl block device does not support writes");
-        return -EROFS;
+    ret =3D bdrv_apply_auto_read_only(bs, "curl driver does not support =
writes",
+                                    errp);
+    if (ret < 0) {
+        return ret;
     }
=20
     if (!libcurl_initialized) {
--=20
2.19.1
