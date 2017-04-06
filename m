Received: from eggs.gnu.org ([2001:4830:134:3::10]:50208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7Aa-0005kA-6W
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7AZ-0008Aa-8h
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7AZ-0008AH-2r
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3105E7F7B1
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:09:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:08:40 +0200
Message-Id: <20170406130913.2232-22-quintela@redhat.com>
In-Reply-To: <20170406130913.2232-1-quintela@redhat.com>
References: <20170406130913.2232-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 21/54] ram: Move xbzrle_pages into RAMState
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
Reviewed-by: Peter Xu <peterx@redhat.com>

--

Comment why we need bytes and pages

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4dc7869..cf6681c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -172,8 +172,11 @@ struct RAMState {
     uint64_t norm_pages;
     /* Iterations since start */
     uint64_t iterations;
-    /* xbzrle transmitted bytes */
+    /* xbzrle transmitted bytes.  Notice that this is with
+     * compression, they can't be calculated from the pages */
     uint64_t xbzrle_bytes;
+    /* xbzrle transmmited pages */
+    uint64_t xbzrle_pages;
 };
 typedef struct RAMState RAMState;
 
@@ -181,7 +184,6 @@ static RAMState ram_state;
 
 /* accounting for migration statistics */
 typedef struct AccountingInfo {
-    uint64_t xbzrle_pages;
     uint64_t xbzrle_cache_miss;
     double xbzrle_cache_miss_rate;
     uint64_t xbzrle_overflows;
@@ -211,7 +213,7 @@ uint64_t xbzrle_mig_bytes_transferred(void)
 
 uint64_t xbzrle_mig_pages_transferred(void)
 {
-    return acct_info.xbzrle_pages;
+    return ram_state.xbzrle_pages;
 }
 
 uint64_t xbzrle_mig_pages_cache_miss(void)
@@ -544,7 +546,7 @@ static int save_xbzrle_page(RAMState *rs, QEMUFile *f, uint8_t **current_data,
     qemu_put_be16(f, encoded_len);
     qemu_put_buffer(f, XBZRLE.encoded_buf, encoded_len);
     bytes_xbzrle += encoded_len + 1 + 2;
-    acct_info.xbzrle_pages++;
+    rs->xbzrle_pages++;
     rs->xbzrle_bytes += bytes_xbzrle;
     *bytes_transferred += bytes_xbzrle;
 
@@ -1998,6 +2000,7 @@ static int ram_save_init_globals(RAMState *rs)
     rs->norm_pages = 0;
     rs->iterations = 0;
     rs->xbzrle_bytes = 0;
+    rs->xbzrle_pages = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
-- 
2.9.3
