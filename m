Received: from eggs.gnu.org ([2001:4830:134:3::10]:43595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLL-0004Vl-5E
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLJ-0005j6-Uj
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:07 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:43 -0500
Message-Id: <20180723201748.25573-95-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 94/99] iscsi: Avoid potential for get_status
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

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
Message-Id: <20180508212718.1482663-1-eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
(cherry picked from commit 8ee1cef4593a7bda076891470c0620e79333c0d0)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/iscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index f5aecfc883..871947feae 100644
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
2.17.1
