Received: from eggs.gnu.org ([2001:4830:134:3::10]:33561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fxoI8-0001R8-Uk
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fxoI8-0008Fh-4V
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:01:24 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:46850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fxoI7-0008EE-F4
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:01:24 -0400
Received: by mail-pl1-x62a.google.com with SMTP id t19-v6so4509586ply.13
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 00:01:23 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu,  6 Sep 2018 15:01:01 +0800
Message-Id: <20180906070101.27280-4-xiaoguangrong@tencent.com>
In-Reply-To: <20180906070101.27280-1-xiaoguangrong@tencent.com>
References: <20180906070101.27280-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v6 3/3] migration: use
 save_page_use_compression in flush_compressed_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It avoids to touch compression locks if xbzrle and compression
are both enabled

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
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
2.14.4
