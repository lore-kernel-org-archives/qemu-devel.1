Received: from eggs.gnu.org ([2001:4830:134:3::10]:43189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZvDd-0003Dn-Eq
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZvDZ-0000Ij-OM
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:01:45 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
Date: Fri, 12 Jan 2018 12:01:20 +0300
Message-Id: <20180112090122.1702-4-klim.kireev@virtuozzo.com>
In-Reply-To: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
References: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/5] block/parallels: move some structures into
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, qemu-block@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

To implement xml format, some defines and structures
from parallels.c are required.

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 53 +---------------------------------
 block/parallels.h | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 52 deletions(-)
 create mode 100644 block/parallels.h

diff --git a/block/parallels.c b/block/parallels.c
index 9545761f49..f9a3b999ea 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -36,6 +36,7 @@
 #include "qemu/bswap.h"
 #include "qemu/bitmap.h"
 #include "migration/blocker.h"
+#include "parallels.h"
 
 /**************************************************************/
 
@@ -45,30 +46,6 @@
 #define HEADER_INUSE_MAGIC  (0x746F6E59)
 #define MAX_PARALLELS_IMAGE_FACTOR (1ull << 32)
 
-#define DEFAULT_CLUSTER_SIZE 1048576        /* 1 MiB */
-
-
-// always little-endian
-typedef struct ParallelsHeader {
-    char magic[16]; // "WithoutFreeSpace"
-    uint32_t version;
-    uint32_t heads;
-    uint32_t cylinders;
-    uint32_t tracks;
-    uint32_t bat_entries;
-    uint64_t nb_sectors;
-    uint32_t inuse;
-    uint32_t data_off;
-    char padding[12];
-} QEMU_PACKED ParallelsHeader;
-
-
-typedef enum ParallelsPreallocMode {
-    PRL_PREALLOC_MODE_FALLOCATE = 0,
-    PRL_PREALLOC_MODE_TRUNCATE = 1,
-    PRL_PREALLOC_MODE__MAX = 2,
-} ParallelsPreallocMode;
-
 static QEnumLookup prealloc_mode_lookup = {
     .array = (const char *const[]) {
         "falloc",
@@ -77,34 +54,6 @@ static QEnumLookup prealloc_mode_lookup = {
     .size = PRL_PREALLOC_MODE__MAX
 };
 
-typedef struct BDRVParallelsState {
-    /** Locking is conservative, the lock protects
-     *   - image file extending (truncate, fallocate)
-     *   - any access to block allocation table
-     */
-    CoMutex lock;
-
-    ParallelsHeader *header;
-    uint32_t header_size;
-    bool header_unclean;
-
-    unsigned long *bat_dirty_bmap;
-    unsigned int  bat_dirty_block;
-
-    uint32_t *bat_bitmap;
-    unsigned int bat_size;
-
-    int64_t  data_end;
-    uint64_t prealloc_size;
-    ParallelsPreallocMode prealloc_mode;
-
-    unsigned int tracks;
-
-    unsigned int off_multiplier;
-    Error *migration_blocker;
-} BDRVParallelsState;
-
-
 #define PARALLELS_OPT_PREALLOC_MODE     "prealloc-mode"
 #define PARALLELS_OPT_PREALLOC_SIZE     "prealloc-size"
 
diff --git a/block/parallels.h b/block/parallels.h
new file mode 100644
index 0000000000..71183c0c8e
--- /dev/null
+++ b/block/parallels.h
@@ -0,0 +1,86 @@
+/*
+* Block driver for Parallels disk image format
+*
+* Copyright (c) 2015-2017 Virtuozzo, Inc.
+* Authors:
+*         2016-2017 Klim S. Kireev <klim.kireev@virtuozzo.com>
+*         2015 Denis V. Lunev <den@openvz.org>
+*
+* This code was originally based on comparing different disk images created
+* by Parallels. Currently it is based on opened OpenVZ sources
+* available at
+*     https://github.com/OpenVZ/ploop
+*
+* Permission is hereby granted, free of charge, to any person obtaining a copy
+* of this software and associated documentation files (the "Software"), to deal
+* in the Software without restriction, including without limitation the rights
+* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+* copies of the Software, and to permit persons to whom the Software is
+* furnished to do so, subject to the following conditions:
+*
+* The above copyright notice and this permission notice shall be included in
+* all copies or substantial portions of the Software.
+*
+* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+* THE SOFTWARE.
+*/
+#ifndef BLOCK_PARALLELS_H
+#define BLOCK_PARALLELS_H
+#include "qemu/coroutine.h"
+#include "qemu/typedefs.h"
+
+#define DEFAULT_CLUSTER_SIZE 1048576        /* 1 MiB */
+
+/* always little-endian */
+typedef struct ParallelsHeader {
+    char magic[16]; /* "WithoutFreeSpace" */
+    uint32_t version;
+    uint32_t heads;
+    uint32_t cylinders;
+    uint32_t tracks;
+    uint32_t bat_entries;
+    uint64_t nb_sectors;
+    uint32_t inuse;
+    uint32_t data_off;
+    char padding[12];
+} QEMU_PACKED ParallelsHeader;
+
+typedef enum ParallelsPreallocMode {
+    PRL_PREALLOC_MODE_FALLOCATE = 0,
+    PRL_PREALLOC_MODE_TRUNCATE = 1,
+    PRL_PREALLOC_MODE__MAX = 2,
+} ParallelsPreallocMode;
+
+typedef struct BDRVParallelsState {
+    /** Locking is conservative, the lock protects
+     *   - image file extending (truncate, fallocate)
+     *   - any access to block allocation table
+     */
+    CoMutex lock;
+
+    ParallelsHeader *header;
+    uint32_t header_size;
+    bool header_unclean;
+
+    unsigned long *bat_dirty_bmap;
+    unsigned int  bat_dirty_block;
+
+    uint32_t *bat_bitmap;
+    unsigned int bat_size;
+
+    int64_t  data_end;
+    uint64_t prealloc_size;
+    ParallelsPreallocMode prealloc_mode;
+
+    unsigned int tracks;
+
+    unsigned int off_multiplier;
+    Error *migration_blocker;
+} BDRVParallelsState;
+
+#endif
-- 
2.14.3
