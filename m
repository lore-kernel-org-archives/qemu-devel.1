Received: from eggs.gnu.org ([2001:4830:134:3::10]:38058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAw2z-0007g8-5Y
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAw2y-0005zS-Bl
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:56:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 12 Oct 2018 13:55:30 +0200
Message-Id: <20181012115532.12645-7-kwolf@redhat.com>
In-Reply-To: <20181012115532.12645-1-kwolf@redhat.com>
References: <20181012115532.12645-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 6/8] curl: Support auto-read-only option
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
