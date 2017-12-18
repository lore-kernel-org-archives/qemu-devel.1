Received: from eggs.gnu.org ([2001:4830:134:3::10]:57240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eQtIQ-00037V-M7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eQtIK-0007YR-Uz
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:09:22 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 18 Dec 2017 14:09:10 +0300
Message-Id: <1513595351-5899-5-git-send-email-den@openvz.org>
In-Reply-To: <1513595351-5899-1-git-send-email-den@openvz.org>
References: <1513595351-5899-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 4/5] block/parallels: replace some magic numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Klim Kireev <klim.kireev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

From: Klim Kireev <klim.kireev@virtuozzo.com>

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.h | 2 ++
 block/parallels.c | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/parallels.h b/block/parallels.h
index 7d0fb73..9be29fe 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -31,6 +31,8 @@
 #define BLOCK_PARALLELS_H
 #include "qemu/module.h"
 
+#define HEADS_NUMBER 16
+#define SEC_IN_CYL 32
 #define DEFAULT_CLUSTER_SIZE 1048576        /* 1 MiB */
 
 /* always little-endian */
diff --git a/block/parallels.c b/block/parallels.c
index f9a3b99..7a8e8b0 100644
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
-- 
2.7.4
