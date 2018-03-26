Received: from eggs.gnu.org ([2001:4830:134:3::10]:51855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0Ybu-0003zl-Lq
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0Ybt-0000Ie-Qx
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:20:54 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 26 Mar 2018 22:20:39 +0200
Message-Id: <20180326202039.21070-5-mreitz@redhat.com>
In-Reply-To: <20180326202039.21070-1-mreitz@redhat.com>
References: <20180326202039.21070-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] vmdk: return ERROR when cluster sector is
 larger than vmdk limitation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: yuchenlin <yuchenlin@synology.com>

VMDK has a hard limitation of extent size, which is due to the size of grain
table entry is 32 bits. It means it can only point to a grain located at
offset = 2^32. To avoid writing the user data beyond limitation and record a useless offset
in grain table. We should return ERROR here.

Signed-off-by: yuchenlin <yuchenlin@synology.com>
Message-id: 20180322133337.28024-1-yuchenlin@synology.com
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vmdk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index f94c49a9c0..84f8bbe480 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -47,6 +47,8 @@
 #define VMDK4_FLAG_MARKER (1 << 17)
 #define VMDK4_GD_AT_END 0xffffffffffffffffULL
 
+#define VMDK_EXTENT_MAX_SECTORS (1ULL << 32)
+
 #define VMDK_GTE_ZEROED 0x1
 
 /* VMDK internal error codes */
@@ -1250,6 +1252,10 @@ static int get_cluster_offset(BlockDriverState *bs,
             return zeroed ? VMDK_ZEROED : VMDK_UNALLOC;
         }
 
+        if (extent->next_cluster_sector >= VMDK_EXTENT_MAX_SECTORS) {
+            return VMDK_ERROR;
+        }
+
         cluster_sector = extent->next_cluster_sector;
         extent->next_cluster_sector += extent->cluster_sectors;
 
-- 
2.14.3
