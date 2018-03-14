Received: from eggs.gnu.org ([2001:4830:134:3::10]:41951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew52F-0003Zj-EH
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew52E-0004s3-IX
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew52E-0004rm-DF
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3BFD8182D16
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:57:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Mar 2018 11:56:11 +0000
Message-Id: <20180314115618.28831-23-dgilbert@redhat.com>
In-Reply-To: <20180314115618.28831-1-dgilbert@redhat.com>
References: <20180314115618.28831-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v6 22/29] vhost+postcopy: Call wakeups
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

Cause the vhost-user client to be woken up whenever:
  a) We place a page in postcopy mode
  b) We get a fault and the page has already been received

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 14 ++++++++++----
 migration/trace-events   |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index d14a051b4b..7754913c12 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -558,7 +558,11 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
 
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
@@ -866,7 +870,8 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
     }
 
     trace_postcopy_place_page(host);
-    return 0;
+    return postcopy_notify_shared_wake(rb,
+                                       qemu_ram_block_host_offset(rb, host));
 }
 
 /*
@@ -890,6 +895,9 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
 
             return -e;
         }
+        return postcopy_notify_shared_wake(rb,
+                                           qemu_ram_block_host_offset(rb,
+                                                                      host));
     } else {
         /* The kernel can't use UFFDIO_ZEROPAGE for hugepages */
         if (!mis->postcopy_tmp_zero_page) {
@@ -909,8 +917,6 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
         return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
                                    rb);
     }
-
-    return 0;
 }
 
 /*
diff --git a/migration/trace-events b/migration/trace-events
index b0acaaa8a0..1e353a317f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -199,6 +199,7 @@ postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
 postcopy_request_shared_page(const char *sharer, const char *rb, uint64_t rb_offset) "for %s in %s offset 0x%"PRIx64
+postcopy_request_shared_page_present(const char *sharer, const char *rb, uint64_t rb_offset) "%s already %s offset 0x%"PRIx64
 postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"PRIx64" in %s"
 
 save_xbzrle_page_skipping(void) ""
-- 
2.14.3
