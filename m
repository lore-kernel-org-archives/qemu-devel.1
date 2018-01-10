Received: from eggs.gnu.org ([2001:4830:134:3::10]:50541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZKJ4-0007uG-9T
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZKJ2-0000qX-SD
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:36:54 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
Date: Wed, 10 Jan 2018 20:36:34 +0300
Message-Id: <20180110173635.28255-5-klim.kireev@virtuozzo.com>
In-Reply-To: <20180110173635.28255-1-klim.kireev@virtuozzo.com>
References: <20180110173635.28255-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/5] block/parallels: replace some magic numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, qemu-block@nongnu.org

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 5 +++--
 block/parallels.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index f9a3b999ea..7a8e8b05a9 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -476,8 +476,9 @@ static int parallels_create(const char *filename, QemuOpts *opts, Error **errp)
     memcpy(header.magic, HEADER_MAGIC2, sizeof(header.magic));
     header.version = cpu_to_le32(HEADER_VERSION);
     /* don't care much about geometry, it is not used on image level */
-    header.heads = cpu_to_le32(16);
-    header.cylinders = cpu_to_le32(total_size / BDRV_SECTOR_SIZE / 16 / 32);
+    header.heads = cpu_to_le32(HEADS_NUMBER);
+    header.cylinders = cpu_to_le32(total_size / BDRV_SECTOR_SIZE
+                                   / HEADS_NUMBER / SEC_IN_CYL);
     header.tracks = cpu_to_le32(cl_size >> BDRV_SECTOR_BITS);
     header.bat_entries = cpu_to_le32(bat_entries);
     header.nb_sectors = cpu_to_le64(DIV_ROUND_UP(total_size, BDRV_SECTOR_SIZE));
diff --git a/block/parallels.h b/block/parallels.h
index 71183c0c8e..4b044079ef 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -34,6 +34,8 @@
 #include "qemu/coroutine.h"
 #include "qemu/typedefs.h"
 
+#define HEADS_NUMBER 16
+#define SEC_IN_CYL 32
 #define DEFAULT_CLUSTER_SIZE 1048576        /* 1 MiB */
 
 /* always little-endian */
-- 
2.14.3
