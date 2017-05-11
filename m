Received: from eggs.gnu.org ([2001:4830:134:3::10]:37025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAe-0002Xu-NG
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAd-0007ix-SJ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:40 +0200
Message-Id: <1494513181-7900-38-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/58] qemu-io: Improve alignment checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Several copy-and-pasted alignment checks exist in qemu-io, which
could use some minor improvements:

- Manual comparison against 0x1ff is not as clean as using our
alignment macros (QEMU_IS_ALIGNED) from osdep.h.

- The error messages aren't quite grammatically correct.

Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20170429191419.30051-2-eblake@redhat.com
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-io-cmds.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 21af9e6..6a0024b 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -740,13 +740,13 @@ static int read_f(BlockBackend *blk, int argc, char=
 **argv)
     }
=20
     if (bflag) {
-        if (offset & 0x1ff) {
-            printf("offset %" PRId64 " is not sector aligned\n",
+        if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
+            printf("%" PRId64 " is not a sector-aligned value for 'offse=
t'\n",
                    offset);
             return 0;
         }
-        if (count & 0x1ff) {
-            printf("count %"PRId64" is not sector aligned\n",
+        if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
+            printf("%"PRId64" is not a sector-aligned value for 'count'\=
n",
                    count);
             return 0;
         }
@@ -1050,14 +1050,14 @@ static int write_f(BlockBackend *blk, int argc, c=
har **argv)
     }
=20
     if (bflag || cflag) {
-        if (offset & 0x1ff) {
-            printf("offset %" PRId64 " is not sector aligned\n",
+        if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
+            printf("%" PRId64 " is not a sector-aligned value for 'offse=
t'\n",
                    offset);
             return 0;
         }
=20
-        if (count & 0x1ff) {
-            printf("count %"PRId64" is not sector aligned\n",
+        if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
+            printf("%"PRId64" is not a sector-aligned value for 'count'\=
n",
                    count);
             return 0;
         }
@@ -1769,8 +1769,8 @@ static int alloc_f(BlockBackend *blk, int argc, cha=
r **argv)
     if (offset < 0) {
         print_cvtnum_err(offset, argv[1]);
         return 0;
-    } else if (offset & 0x1ff) {
-        printf("offset %" PRId64 " is not sector aligned\n",
+    } else if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
+        printf("%" PRId64 " is not a sector-aligned value for 'offset'\n=
",
                offset);
         return 0;
     }
--=20
1.8.3.1
