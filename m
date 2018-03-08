Received: from eggs.gnu.org ([2001:4830:134:3::10]:47518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gc-0003SO-RW
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gY-0006Ix-AL
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eu1gY-0006Ic-51
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94CA8406E97D
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 19:58:41 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  8 Mar 2018 19:58:01 +0000
Message-Id: <20180308195811.24894-20-dgilbert@redhat.com>
In-Reply-To: <20180308195811.24894-1-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 19/29] postcopy: helper for waking shared
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

Provide a helper to send a 'wake' request on a userfaultfd for
a shared process.
The address in the clients address space is specified together
with the RAMBlock it was resolved to.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 26 ++++++++++++++++++++++++++
 migration/postcopy-ram.h |  6 ++++++
 migration/trace-events   |  1 +
 3 files changed, 33 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 83780576ca..d3e7f10c5a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -525,6 +525,25 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
     return 0;
 }
 
+int postcopy_wake_shared(struct PostCopyFD *pcfd,
+                         uint64_t client_addr,
+                         RAMBlock *rb)
+{
+    size_t pagesize = qemu_ram_pagesize(rb);
+    struct uffdio_range range;
+    int ret;
+    trace_postcopy_wake_shared(client_addr, qemu_ram_get_idstr(rb));
+    range.start = client_addr & ~(pagesize - 1);
+    range.len = pagesize;
+    ret = ioctl(pcfd->fd, UFFDIO_WAKE, &range);
+    if (ret) {
+        error_report("%s: Failed to wake: %zx in %s (%s)",
+                     __func__, (size_t)client_addr, qemu_ram_get_idstr(rb),
+                     strerror(errno));
+    }
+    return ret;
+}
+
 /*
  * Callback from shared fault handlers to ask for a page,
  * the page must be specified by a RAMBlock and an offset in that rb
@@ -954,6 +973,13 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
     return NULL;
 }
 
+int postcopy_wake_shared(struct PostCopyFD *pcfd,
+                         uint64_t client_addr,
+                         RAMBlock *rb)
+{
+    assert(0);
+    return -1;
+}
 #endif
 
 /* ------------------------------------------------------------------------- */
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index d7afab07d7..f02fa36127 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -164,6 +164,12 @@ struct PostCopyFD {
  */
 void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
 void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
+/* Notify a client ufd that a page is available
+ * Note: The 'client_address' is in the address space of the client
+ * program not QEMU
+ */
+int postcopy_wake_shared(struct PostCopyFD *pcfd, uint64_t client_addr,
+                         RAMBlock *rb);
 /* Callback from shared fault handlers to ask for a page */
 int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
                                  uint64_t client_addr, uint64_t offset);
diff --git a/migration/trace-events b/migration/trace-events
index 7c910b5479..b0acaaa8a0 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -199,6 +199,7 @@ postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
 postcopy_request_shared_page(const char *sharer, const char *rb, uint64_t rb_offset) "for %s in %s offset 0x%"PRIx64
+postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"PRIx64" in %s"
 
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
-- 
2.14.3
