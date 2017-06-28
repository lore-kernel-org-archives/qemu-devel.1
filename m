Received: from eggs.gnu.org ([2001:4830:134:3::10]:40179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDM-0004Io-Q5
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDL-0007zg-WC
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56429)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIDL-0007zQ-Qu
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:23 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:22 +0100
Message-Id: <20170628190047.26159-5-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 04/29] migration/ram:
 ramblock_recv_bitmap_test_byte_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Utility for testing the map when you already know the offset
in the RAMBlock.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 5 +++++
 migration/ram.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 3daa69b2c3..6dcb9e8b43 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -165,6 +165,11 @@ int ramblock_recv_bitmap_test(void *host_addr, RAMBlock *rb)
                     rb->receivedmap);
 }
 
+bool ramblock_recv_bitmap_test_byte_offset(uint64_t byte_offset, RAMBlock *rb)
+{
+    return test_bit(byte_offset >> TARGET_PAGE_BITS, rb->receivedmap);
+}
+
 void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb)
 {
     set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
diff --git a/migration/ram.h b/migration/ram.h
index 98d68df03d..0fcf85d904 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -55,6 +55,7 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
 
 void ramblock_recv_map_init(void);
 int ramblock_recv_bitmap_test(void *host_addr, RAMBlock *rb);
+bool ramblock_recv_bitmap_test_byte_offset(uint64_t byte_offset, RAMBlock *rb);
 void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb);
 void ramblock_recv_bitmap_clear(void *host_addr, RAMBlock *rb);
 
-- 
2.13.0
