Received: from eggs.gnu.org ([2001:4830:134:3::10]:35177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fYmVg-0001Dh-ME
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fYmVa-0007Hu-Qy
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:03:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 29 Jun 2018 14:03:27 +0800
Message-Id: <20180629060328.4423-3-famz@redhat.com>
In-Reply-To: <20180629060328.4423-1-famz@redhat.com>
References: <20180629060328.4423-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] iscsi: Don't blindly use designator length
 in response for memcpy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Per SCSI definition the designator_length we receive from INQUIRY is 8,
12 or at most 16, but we should be careful because the remote iscsi
target may misbehave, otherwise we could have a buffer overflow.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/iscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 9f00fb47a5..4b7f574510 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2226,7 +2226,7 @@ static void iscsi_populate_target_desc(unsigned char *desc, IscsiLun *lun)
     desc[5] = (dd->designator_type & 0xF)
         | ((dd->association & 3) << 4);
     desc[7] = dd->designator_length;
-    memcpy(desc + 8, dd->designator, dd->designator_length);
+    memcpy(desc + 8, dd->designator, MIN(dd->designator_length, 20));
 
     desc[28] = 0;
     desc[29] = (lun->block_size >> 16) & 0xFF;
-- 
2.17.1
