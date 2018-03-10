Received: from eggs.gnu.org ([2001:4830:134:3::10]:47729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1eufYh-000352-Uu
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 09:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1eufYd-0007Y0-2Y
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 09:33:15 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1eufYc-0007Xj-Rl
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 09:33:10 -0500
Received: by mail-pl0-x244.google.com with SMTP id 61-v6so6838994plf.3
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 06:33:10 -0800 (PST)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sat, 10 Mar 2018 22:32:58 +0800
Message-Id: <1520692378-1835-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH] migration: Fix rate limiting issue on RDMA
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

RDMA migration implement save_page function for QEMUFile, but
ram_control_save_page do not increase bytes_xfer. So when doing
RDMA migration, it will use whole bandwidth.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/qemu-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 2ab2bf3..217609d 100644
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
1.8.3.1
