Received: from eggs.gnu.org ([2001:4830:134:3::10]:52796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxok-0003EO-KF
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxoi-0005PM-Jg
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxoi-0005Ow-AV
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:24 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:21 +0100
Message-Id: <20170824192730.8440-24-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 23/32] vhost+postcopy: Call wakeups
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

Cause the vhost-user client to be woken up whenever:
  a) We place a page in postcopy mode
  b) We get a fault and the page has already been received

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 14 ++++++++++----
 migration/trace-events   |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 40b58a7912..7d0786ff04 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -490,7 +490,11 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
 
     trace_postcopy_request_shared_page(pcfd->idstr, qemu_ram_get_idstr(rb),
                                        rb_offset);
-    /* TODO: Check bitmap to see if we already have the page */
+    if (ramblock_recv_bitmap_test_byte_offset(rb, aligned_rbo)) {
+        trace_postcopy_request_shared_page_present(pcfd->idstr,
+                                        qemu_ram_get_idstr(rb), rb_offset);
+        return postcopy_wake_shared(pcfd, client_addr, rb);
+    }
     if (rb != mis->last_rb) {
         mis->last_rb = rb;
         migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
@@ -788,7 +792,8 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
     }
 
     trace_postcopy_place_page(host);
-    return 0;
+    return postcopy_notify_shared_wake(rb,
+                                       qemu_ram_block_host_offset(rb, host));
 }
 
 /*
@@ -812,6 +817,9 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
 
             return -e;
         }
+        return postcopy_notify_shared_wake(rb,
+                                           qemu_ram_block_host_offset(rb,
+                                                                      host));
     } else {
         /* The kernel can't use UFFDIO_ZEROPAGE for hugepages */
         if (!mis->postcopy_tmp_zero_page) {
@@ -831,8 +839,6 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
         return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
                                    rb);
     }
-
-    return 0;
 }
 
 /*
diff --git a/migration/trace-events b/migration/trace-events
index 535e7ad84b..10cff5a068 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -198,6 +198,7 @@ postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
 postcopy_request_shared_page(const char *sharer, const char *rb, uint64_t rb_offset) "for %s in %s offset 0x%"PRIx64
+postcopy_request_shared_page_present(const char *sharer, const char *rb, uint64_t rb_offset) "%s already %s offset 0x%"PRIx64
 postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"PRIx64" in %s"
 
 save_xbzrle_page_skipping(void) ""
-- 
2.13.5
