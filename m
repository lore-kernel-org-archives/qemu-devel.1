Received: from eggs.gnu.org ([2001:4830:134:3::10]:42247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezTEA-0000aO-V1
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezTE9-0003nj-Uw
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ezTE9-0003nQ-Py
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:53 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 23 Mar 2018 20:23:41 +0000
Message-Id: <20180323202344.70640-3-dgilbert@redhat.com>
In-Reply-To: <20180323202344.70640-1-dgilbert@redhat.com>
References: <20180323202344.70640-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] migration: Fix rate limiting issue on RDMA
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, berrange@redhat.com, lidongchen@tencent.com, pl@kamp.de, peterx@redhat.com

From: Lidong Chen <jemmy858585@gmail.com>

RDMA migration implement save_page function for QEMUFile, but
ram_control_save_page do not increase bytes_xfer. So when doing
RDMA migration, it will use whole bandwidth.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Message-Id: <1520692378-1835-1-git-send-email-lidongchen@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/qemu-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index e85f501f86..bb63c779cc 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -253,7 +253,7 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
     if (f->hooks && f->hooks->save_page) {
         int ret = f->hooks->save_page(f, f->opaque, block_offset,
                                       offset, size, bytes_sent);
-
+        f->bytes_xfer += size;
         if (ret != RAM_SAVE_CONTROL_DELAYED) {
             if (bytes_sent && *bytes_sent > 0) {
                 qemu_update_position(f, *bytes_sent);
-- 
2.14.3
