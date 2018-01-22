Received: from eggs.gnu.org ([2001:4830:134:3::10]:41663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edeXy-0006qe-VW
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edeXu-000323-Aw
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:02:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1edeXu-00031Q-3D
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:02:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 22 Jan 2018 16:00:47 +0000
Message-Id: <20180122160048.29571-6-stefanha@redhat.com>
In-Reply-To: <20180122160048.29571-1-stefanha@redhat.com>
References: <20180122160048.29571-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 5/6] block/parallels: replace some magic
 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Klim Kireev <klim.kireev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Klim Kireev <klim.kireev@virtuozzo.com>

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Message-id: 20180112090122.1702-5-klim.kireev@virtuozzo.com
CC: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.h | 2 ++
 block/parallels.c | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

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
-- 
2.14.3
