Received: from eggs.gnu.org ([2001:4830:134:3::10]:52677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxob-000369-Ug
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxoY-0005Hq-QW
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxoY-0005HB-IV
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:14 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:18 +0100
Message-Id: <20170824192730.8440-21-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 20/32] postcopy: wake shared
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

Send a 'wake' request on a userfaultfd for a shared process.
The address in the clients address space is specified together
with the RAMBlock it was resolved to.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 26 ++++++++++++++++++++++++++
 migration/postcopy-ram.h |  6 ++++++
 migration/trace-events   |  1 +
 3 files changed, 33 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 2d77674b94..2c9680ef7a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -458,6 +458,25 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
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
+                     __func__, client_addr, qemu_ram_get_idstr(rb),
+                     strerror(errno));
+    }
+    return ret;
+}
+
 /*
  * Callback from shared fault handlers to ask for a page,
  * the page must be specified by a RAMBlock and an offset in that rb
@@ -876,6 +895,13 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
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
index 69e88b0174..d2b2f5f4aa 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -162,6 +162,12 @@ struct PostCopyFD {
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
index 3a0b143f7e..535e7ad84b 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -198,6 +198,7 @@ postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
 postcopy_request_shared_page(const char *sharer, const char *rb, uint64_t rb_offset) "for %s in %s offset 0x%"PRIx64
+postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"PRIx64" in %s"
 
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
-- 
2.13.5
