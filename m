Received: from eggs.gnu.org ([2001:4830:134:3::10]:45843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1eytey-0004HY-4P
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 02:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1eytev-0003eq-1C
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 02:25:12 -0400
Received: from synology.com ([59.124.61.242]:38488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuchenlin@synology.com>)
	id 1eyteu-0003dQ-G0
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 02:25:08 -0400
From: yuchenlin@synology.com
Date: Thu, 22 Mar 2018 14:24:47 +0800
Message-Id: <20180322062447.16537-1-yuchenlin@synology.com>
Subject: [Qemu-devel] [PATCH v2] vmdk: return ERROR when cluster sector is
 larger than vmdk limitation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, yuchenlin <yuchenlin@synology.com>

From: yuchenlin <yuchenlin@synology.com>

VMDK has a hard limitation of extent size, which is due to the size of grain
table entry is 32 bits. It means it can only point to a grain located at
offset = 2^32. To avoid writing the user data beyond limitation and record a useless offset
in grain table. We should return ERROR here.

Signed-off-by: yuchenlin <yuchenlin@synology.com>
---
v1->v2:
 - change commit message
 - check before allocating
 - should be >=
 - the unit is sector now

 thanks

 block/vmdk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index f94c49a9c0..a1c21dbbba 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -47,6 +47,8 @@
 #define VMDK4_FLAG_MARKER (1 << 17)
 #define VMDK4_GD_AT_END 0xffffffffffffffffULL
 
+#define VMDK_EXTENT_MAX_SECTORS (4294967296)
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
2.16.2
