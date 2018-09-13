Received: from eggs.gnu.org ([2001:4830:134:3::10]:47697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8X-0003Qr-PA
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8W-0003IQ-P4
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1g0R8W-0003HC-Hm
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:20 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 13 Sep 2018 14:53:38 +0200
Message-Id: <20180913125343.10912-8-quintela@redhat.com>
In-Reply-To: <20180913125343.10912-1-quintela@redhat.com>
References: <20180913125343.10912-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 07/12] migration: use save_page_use_compression
 in flush_compressed_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It avoids to touch compression locks if xbzrle and compression
are both enabled

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20180906070101.27280-4-xiaoguangrong@tencent.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 65a563993d..747dd9208b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1932,11 +1932,13 @@ update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
     compression_counters.pages++;
 }
 
+static bool save_page_use_compression(RAMState *rs);
+
 static void flush_compressed_data(RAMState *rs)
 {
     int idx, len, thread_count;
 
-    if (!migrate_use_compression()) {
+    if (!save_page_use_compression(rs)) {
         return;
     }
     thread_count = migrate_compress_threads();
-- 
2.17.1
