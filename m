Received: from eggs.gnu.org ([2001:4830:134:3::10]:34516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzZ0W-0001JS-Cl
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzZ0V-0006LT-IY
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:01:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  3 Oct 2017 21:00:40 -0500
Message-Id: <20171004020048.26379-16-eblake@redhat.com>
In-Reply-To: <20171004020048.26379-1-eblake@redhat.com>
References: <20171004020048.26379-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 15/23] qemu-img: Add find_nonzero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

During 'qemu-img compare', when we are checking that an allocated
portion of one file is all zeros, we don't need to waste time
computing how many additional sectors after the first non-zero
byte are also non-zero.  Create a new helper find_nonzero() to do
the check for a first non-zero sector, and rebase
check_empty_sectors() to use it.

The new interface intentionally uses bytes in its interface, even
though it still crawls the buffer a sector at a time; it is robust
to a partial sector at the end of the buffer.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v4-v5: no change
v3: new patch
---
 qemu-img.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 43e3038894..12881f008e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1065,6 +1065,28 @@ done:
 }

 /*
+ * Returns -1 if 'buf' contains only zeroes, otherwise the byte index
+ * of the first sector boundary within buf where the sector contains a
+ * non-zero byte.  This function is robust to a buffer that is not
+ * sector-aligned.
+ */
+static int64_t find_nonzero(const uint8_t *buf, int64_t n)
+{
+    int64_t i;
+    int64_t end = QEMU_ALIGN_DOWN(n, BDRV_SECTOR_SIZE);
+
+    for (i = 0; i < end; i += BDRV_SECTOR_SIZE) {
+        if (!buffer_is_zero(buf + i, BDRV_SECTOR_SIZE)) {
+            return i;
+        }
+    }
+    if (i < n && !buffer_is_zero(buf + i, n - end)) {
+        return i;
+    }
+    return -1;
+}
+
+/*
  * Returns true iff the first sector pointed to by 'buf' contains at least
  * a non-NUL byte.
  *
@@ -1189,7 +1211,9 @@ static int check_empty_sectors(BlockBackend *blk, int64_t sect_num,
                                int sect_count, const char *filename,
                                uint8_t *buffer, bool quiet)
 {
-    int pnum, ret = 0;
+    int ret = 0;
+    int64_t idx;
+
     ret = blk_pread(blk, sect_num << BDRV_SECTOR_BITS, buffer,
                     sect_count << BDRV_SECTOR_BITS);
     if (ret < 0) {
@@ -1197,10 +1221,10 @@ static int check_empty_sectors(BlockBackend *blk, int64_t sect_num,
                      sectors_to_bytes(sect_num), filename, strerror(-ret));
         return ret;
     }
-    ret = is_allocated_sectors(buffer, sect_count, &pnum);
-    if (ret || pnum != sect_count) {
+    idx = find_nonzero(buffer, sect_count * BDRV_SECTOR_SIZE);
+    if (idx >= 0) {
         qprintf(quiet, "Content mismatch at offset %" PRId64 "!\n",
-                sectors_to_bytes(ret ? sect_num : sect_num + pnum));
+                sectors_to_bytes(sect_num) + idx);
         return 1;
     }

-- 
2.13.6
