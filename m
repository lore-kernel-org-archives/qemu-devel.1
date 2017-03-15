Received: from eggs.gnu.org ([2001:4830:134:3::10]:53684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KD-0007OL-73
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KC-0003Sh-BJ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9KC-0003RN-5N
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:48 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2783313A60
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:50:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:50:05 +0100
Message-Id: <20170315135021.6978-16-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 15/31] ram: Move xbzrle_bytes into RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 234bdba..02bbe53 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -166,6 +166,8 @@ struct RAMState {
     uint64_t norm_pages;
     /* Iterations since start */
     uint64_t iterations;
+    /* xbzrle transmitted bytes */
+    uint64_t xbzrle_bytes;
 };
 typedef struct RAMState RAMState;
 
@@ -173,7 +175,6 @@ static RAMState ram_state;
 
 /* accounting for migration statistics */
 typedef struct AccountingInfo {
-    uint64_t xbzrle_bytes;
     uint64_t xbzrle_pages;
     uint64_t xbzrle_cache_miss;
     double xbzrle_cache_miss_rate;
@@ -199,7 +200,7 @@ uint64_t norm_mig_pages_transferred(void)
 
 uint64_t xbzrle_mig_bytes_transferred(void)
 {
-    return acct_info.xbzrle_bytes;
+    return ram_state.xbzrle_bytes;
 }
 
 uint64_t xbzrle_mig_pages_transferred(void)
@@ -527,7 +528,7 @@ static int save_xbzrle_page(QEMUFile *f, RAMState *rs, uint8_t **current_data,
     qemu_put_buffer(f, XBZRLE.encoded_buf, encoded_len);
     bytes_xbzrle += encoded_len + 1 + 2;
     acct_info.xbzrle_pages++;
-    acct_info.xbzrle_bytes += bytes_xbzrle;
+    rs->xbzrle_bytes += bytes_xbzrle;
     *bytes_transferred += bytes_xbzrle;
 
     return 1;
@@ -1928,6 +1929,7 @@ static int ram_save_init_globals(RAMState *rs)
     rs->zero_pages = 0;
     rs->norm_pages = 0;
     rs->iterations = 0;
+    rs->xbzrle_bytes = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
-- 
2.9.3
