Received: from eggs.gnu.org ([209.51.188.92]:48763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUur-00082M-7d
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-00025M-Qg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:23 +0200
Message-Id: <20190430154244.30083-7-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/27] block/vhdx: Use IEC binary prefixes for
 size constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Stefano Garzarella <sgarzare@redhat.com>

Using IEC binary prefixes in order to make the code more readable,
with the exception of DEFAULT_LOG_SIZE because it's passed to
stringify().

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx.h     | 10 ++++++----
 block/vhdx-log.c |  2 +-
 block/vhdx.c     |  4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/vhdx.h b/block/vhdx.h
index bf72090c8f..0b74924cee 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -20,6 +20,8 @@
 #include "qemu/units.h"
=20
 #define DEFAULT_LOG_SIZE 1048576 /* 1MiB */
+/* Note: can't use 1 * MiB, because it's passed to stringify() */
+
 /* Structures and fields present in the VHDX file */
=20
 /* The header section has the following blocks,
@@ -32,7 +34,7 @@
  * 0.........64KB...........128KB........192KB..........256KB...........=
.....1MB
  */
=20
-#define VHDX_HEADER_BLOCK_SIZE      (64 * 1024)
+#define VHDX_HEADER_BLOCK_SIZE      (64 * KiB)
=20
 #define VHDX_FILE_ID_OFFSET         0
 #define VHDX_HEADER1_OFFSET         (VHDX_HEADER_BLOCK_SIZE * 1)
@@ -81,7 +83,7 @@ typedef struct QEMU_PACKED MSGUID {
 #define guid_eq(a, b) \
     (memcmp(&(a), &(b), sizeof(MSGUID)) =3D=3D 0)
=20
-#define VHDX_HEADER_SIZE (4 * 1024)   /* although the vhdx_header struct=
 in disk
+#define VHDX_HEADER_SIZE (4 * KiB)    /* although the vhdx_header struct=
 in disk
                                          is only 582 bytes, for purposes=
 of crc
                                          the header is the first 4KB of =
the 64KB
                                          block */
@@ -157,8 +159,8 @@ typedef struct QEMU_PACKED VHDXRegionTableEntry {
=20
=20
 /* ---- LOG ENTRY STRUCTURES ---- */
-#define VHDX_LOG_MIN_SIZE (1024 * 1024)
-#define VHDX_LOG_SECTOR_SIZE 4096
+#define VHDX_LOG_MIN_SIZE (1 * MiB)
+#define VHDX_LOG_SECTOR_SIZE (4 * KiB)
 #define VHDX_LOG_HDR_SIZE 64
 #define VHDX_LOG_SIGNATURE 0x65676f6c
 typedef struct QEMU_PACKED VHDXLogEntryHeader {
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 3149ff08d8..5e946846f1 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -551,7 +551,7 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVV=
HDXState *s,
         }
         if (file_length < desc_entries->hdr.last_file_offset) {
             new_file_size =3D desc_entries->hdr.last_file_offset;
-            if (new_file_size % (1024*1024)) {
+            if (new_file_size % (1 * MiB)) {
                 /* round up to nearest 1MB boundary */
                 new_file_size =3D QEMU_ALIGN_UP(new_file_size, MiB);
                 if (new_file_size > INT64_MAX) {
diff --git a/block/vhdx.c b/block/vhdx.c
index 7cd1fc3731..a143a57657 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1175,7 +1175,7 @@ static int vhdx_allocate_block(BlockDriverState *bs=
, BDRVVHDXState *s,
     *new_offset =3D current_len;
=20
     /* per the spec, the address for a block is in units of 1MB */
-    *new_offset =3D ROUND_UP(*new_offset, 1024 * 1024);
+    *new_offset =3D ROUND_UP(*new_offset, 1 * MiB);
     if (*new_offset > INT64_MAX) {
         return -EINVAL;
     }
@@ -1338,7 +1338,7 @@ static coroutine_fn int vhdx_co_writev(BlockDriverS=
tate *bs, int64_t sector_num,
             case PAYLOAD_BLOCK_FULLY_PRESENT:
                 /* if the file offset address is in the header zone,
                  * there is a problem */
-                if (sinfo.file_offset < (1024 * 1024)) {
+                if (sinfo.file_offset < (1 * MiB)) {
                     ret =3D -EFAULT;
                     goto error_bat_restore;
                 }
--=20
2.20.1
