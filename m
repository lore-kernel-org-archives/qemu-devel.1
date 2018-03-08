Received: from eggs.gnu.org ([2001:4830:134:3::10]:47342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gQ-0003G2-Vd
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gP-0006BV-HR
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eu1gP-0006BL-CJ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB11476FB9
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 19:58:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  8 Mar 2018 19:57:55 +0000
Message-Id: <20180308195811.24894-14-dgilbert@redhat.com>
In-Reply-To: <20180308195811.24894-1-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 13/29] migration/ram:
 ramblock_recv_bitmap_test_byte_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Utility for testing the map when you already know the offset
in the RAMBlock.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 5 +++++
 migration/ram.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 3b6c077964..3d754422e8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -169,6 +169,11 @@ int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr)
                     rb->receivedmap);
 }
 
+bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset)
+{
+    return test_bit(byte_offset >> TARGET_PAGE_BITS, rb->receivedmap);
+}
+
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr)
 {
     set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
diff --git a/migration/ram.h b/migration/ram.h
index 53f0021c51..5030be110a 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -60,6 +60,7 @@ int ram_postcopy_incoming_init(MigrationIncomingState *mis);
 void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
 
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
+bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
 
-- 
2.14.3
