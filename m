Received: from eggs.gnu.org ([2001:4830:134:3::10]:52086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnQ-0001vR-F7
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnP-0004L1-Hy
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxnP-0004KW-Br
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:03 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:03 +0100
Message-Id: <20170824192730.8440-6-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 05/32] migration/ram:
 ramblock_recv_bitmap_test_byte_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Utility for testing the map when you already know the offset
in the RAMBlock.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 5 +++++
 migration/ram.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index affb20cb5a..fbb874fb83 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -164,6 +164,11 @@ int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr)
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
index 4db992298a..8720b9de73 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -54,6 +54,7 @@ int ram_postcopy_incoming_init(MigrationIncomingState *mis);
 void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
 
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
+bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
 void ramblock_recv_bitmap_clear(RAMBlock *rb, void *host_addr);
-- 
2.13.5
