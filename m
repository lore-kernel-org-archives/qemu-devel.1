Received: from eggs.gnu.org ([2001:4830:134:3::10]:33382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGA92-0002Wd-Tl
	for qemu-devel@nongnu.org; Tue, 08 May 2018 17:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGA92-0002j8-3D
	for qemu-devel@nongnu.org; Tue, 08 May 2018 17:27:36 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  8 May 2018 16:27:18 -0500
Message-Id: <20180508212718.1482663-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] iscsi: Avoid potential for get_status overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>

Detected by Coverity: Multiplying two 32-bit int and assigning
the result to a 64-bit number is a risk of overflow.  Prior to
the conversion to byte-based interfaces, the block layer took
care of ensuring that a status request never exceeded 2G in
the driver; but after that conversion, the block layer expects
drivers to deal with any size request (the driver can always
truncate the request size back down, as long as it makes
progress).  So, in the off-chance that someone makes a large
request, we are at the mercy of whether iscsi_get_lba_status_task()
will cap things to at most INT_MAX / iscsilun->block_size when
it populates lbasd->num_blocks; since I could not easily audit
that, it's better to be safe than sorry by just forcing a 64-bit
multiply.

Fixes: 92809c36
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/iscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 35423ded03b..a6311b9a320 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -732,7 +732,7 @@ retry:
         goto out_unlock;
     }

-    *pnum = lbasd->num_blocks * iscsilun->block_size;
+    *pnum = (int64_t) lbasd->num_blocks * iscsilun->block_size;

     if (lbasd->provisioning == SCSI_PROVISIONING_TYPE_DEALLOCATED ||
         lbasd->provisioning == SCSI_PROVISIONING_TYPE_ANCHORED) {
-- 
2.14.3
