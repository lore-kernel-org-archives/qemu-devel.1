Received: from eggs.gnu.org ([2001:4830:134:3::10]:49779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6b-000449-2d
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6Z-0004DU-HO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:50 +0200
Message-Id: <20180629140959.6690-21-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/29] iscsi: Don't blindly use designator
 length in response for memcpy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Per SCSI definition the designator_length we receive from INQUIRY is 8,
12 or at most 16, but we should be careful because the remote iscsi
target may misbehave, otherwise we could have a buffer overflow.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index bc84b14e20..9beb06d498 100644
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
2.13.6
