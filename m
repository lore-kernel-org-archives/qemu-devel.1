Received: from eggs.gnu.org ([2001:4830:134:3::10]:44918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XBe-00022C-IU
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XBd-0007OH-MY
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XBd-0007OB-HM
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C9AD341ADC
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:57:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:01 +0200
Message-Id: <20170421115646.15544-21-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 20/65] ram: Move xbzrle_bytes into RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 3e500ae..4dc7869 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -172,6 +172,8 @@ struct RAMState {
     uint64_t norm_pages;
     /* Iterations since start */
     uint64_t iterations;
+    /* xbzrle transmitted bytes */
+    uint64_t xbzrle_bytes;
 };
 typedef struct RAMState RAMState;
 
@@ -179,7 +181,6 @@ static RAMState ram_state;
 
 /* accounting for migration statistics */
 typedef struct AccountingInfo {
-    uint64_t xbzrle_bytes;
     uint64_t xbzrle_pages;
     uint64_t xbzrle_cache_miss;
     double xbzrle_cache_miss_rate;
@@ -205,7 +206,7 @@ uint64_t norm_mig_pages_transferred(void)
 
 uint64_t xbzrle_mig_bytes_transferred(void)
 {
-    return acct_info.xbzrle_bytes;
+    return ram_state.xbzrle_bytes;
 }
 
 uint64_t xbzrle_mig_pages_transferred(void)
@@ -544,7 +545,7 @@ static int save_xbzrle_page(RAMState *rs, QEMUFile *f, uint8_t **current_data,
     qemu_put_buffer(f, XBZRLE.encoded_buf, encoded_len);
     bytes_xbzrle += encoded_len + 1 + 2;
     acct_info.xbzrle_pages++;
-    acct_info.xbzrle_bytes += bytes_xbzrle;
+    rs->xbzrle_bytes += bytes_xbzrle;
     *bytes_transferred += bytes_xbzrle;
 
     return 1;
@@ -1996,6 +1997,7 @@ static int ram_save_init_globals(RAMState *rs)
     rs->zero_pages = 0;
     rs->norm_pages = 0;
     rs->iterations = 0;
+    rs->xbzrle_bytes = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
-- 
2.9.3
