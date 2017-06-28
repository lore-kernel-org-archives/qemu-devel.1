Received: from eggs.gnu.org ([2001:4830:134:3::10]:40862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEe-0005Nu-QM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEb-00005R-J2
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIEb-000059-AZ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:41 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:40 +0100
Message-Id: <20170628190047.26159-23-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 22/29] vhost+postcopy: Call wakeups
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

Cause the vhost-user client to be woken up whenever:
  a) We place a page in postcopy mode
  b) We get a fault and the page has already been received

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 14 ++++++++++----
 migration/trace-events   |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index e6b8160f09..b97fc9398b 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -491,7 +491,11 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
 
     trace_postcopy_request_shared_page(pcfd->idstr, qemu_ram_get_idstr(rb),
                                        rb_offset);
-    /* TODO: Check bitmap to see if we already have the page */
+    if (ramblock_recv_bitmap_test_byte_offset(aligned_rbo, rb)) {
+        trace_postcopy_request_shared_page_present(pcfd->idstr,
+                                        qemu_ram_get_idstr(rb), rb_offset);
+        return postcopy_wake_shared(pcfd, client_addr, rb);
+    }
     if (rb != mis->last_rb) {
         mis->last_rb = rb;
         migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
@@ -792,7 +796,8 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
     }
 
     trace_postcopy_place_page(host);
-    return 0;
+    return postcopy_notify_shared_wake(rb,
+                                       qemu_ram_block_host_offset(rb, host));
 }
 
 /*
@@ -813,6 +818,9 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
 
             return -e;
         }
+        return postcopy_notify_shared_wake(rb,
+                                           qemu_ram_block_host_offset(rb,
+                                                                      host));
     } else {
         /* The kernel can't use UFFDIO_ZEROPAGE for hugepages */
         if (!mis->postcopy_tmp_zero_page) {
@@ -832,8 +840,6 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
         return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
                                    rb);
     }
-
-    return 0;
 }
 
 /*
diff --git a/migration/trace-events b/migration/trace-events
index 85a35be518..b2f7d85704 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -198,6 +198,7 @@ postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
 postcopy_request_shared_page(const char *sharer, const char *rb, uint64_t rb_offset) "for %s in %s offset %"PRIx64
+postcopy_request_shared_page_present(const char *sharer, const char *rb, uint64_t rb_offset) "%s already %s offset %"PRIx64
 postcopy_wake_shared(uint64_t client_addr, const char *rb) "at %"PRIx64" in %s"
 
 save_xbzrle_page_skipping(void) ""
-- 
2.13.0
