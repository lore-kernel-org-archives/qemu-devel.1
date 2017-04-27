Received: from eggs.gnu.org ([2001:4830:134:3::10]:33615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YW0-0007UA-4p
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YVz-00044n-83
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:40 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Apr 2017 20:46:15 -0500
Message-Id: <20170427014626.11553-7-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-1-eblake@redhat.com>
References: <20170427014626.11553-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 06/17] qemu-io: Don't open-code
 QEMU_IS_ALIGNED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Manual comparison against 0x1ff is not as clean as using our
alignment macros from osdep.h.

Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v10: new patch
---
 qemu-io-cmds.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 21af9e6..fabc394 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -740,12 +740,12 @@ static int read_f(BlockBackend *blk, int argc, char=
 **argv)
     }

     if (bflag) {
-        if (offset & 0x1ff) {
+        if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
             printf("offset %" PRId64 " is not sector aligned\n",
                    offset);
             return 0;
         }
-        if (count & 0x1ff) {
+        if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
             printf("count %"PRId64" is not sector aligned\n",
                    count);
             return 0;
@@ -1050,13 +1050,13 @@ static int write_f(BlockBackend *blk, int argc, c=
har **argv)
     }

     if (bflag || cflag) {
-        if (offset & 0x1ff) {
+        if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
             printf("offset %" PRId64 " is not sector aligned\n",
                    offset);
             return 0;
         }

-        if (count & 0x1ff) {
+        if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
             printf("count %"PRId64" is not sector aligned\n",
                    count);
             return 0;
@@ -1769,7 +1769,7 @@ static int alloc_f(BlockBackend *blk, int argc, cha=
r **argv)
     if (offset < 0) {
         print_cvtnum_err(offset, argv[1]);
         return 0;
-    } else if (offset & 0x1ff) {
+    } else if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
         printf("offset %" PRId64 " is not sector aligned\n",
                offset);
         return 0;
--=20
2.9.3
