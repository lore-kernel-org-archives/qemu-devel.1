Received: from eggs.gnu.org ([2001:4830:134:3::10]:41854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew520-0003Np-C5
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51y-0004mA-Bh
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew51y-0004m0-6V
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFA614040070
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:57:17 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Mar 2018 11:56:06 +0000
Message-Id: <20180314115618.28831-18-dgilbert@redhat.com>
In-Reply-To: <20180314115618.28831-1-dgilbert@redhat.com>
References: <20180314115618.28831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 17/29] vhost+postcopy: Helper to send
 requests to source for shared pages
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

Provide a helper to be used by shared waker functions to request
shared pages from the source.
The last_rb pointer is moved into the incoming state since this
helper can update it as well as the main fault thread function.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/migration.h    |  2 ++
 migration/postcopy-ram.c | 32 +++++++++++++++++++++++++++++---
 migration/postcopy-ram.h |  3 +++
 migration/trace-events   |  2 ++
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index d02a759331..83dc36b57a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -49,6 +49,8 @@ struct MigrationIncomingState {
     int       userfault_event_fd;
     QEMUFile *to_src_file;
     QemuMutex rp_mutex;    /* We send replies from multiple threads */
+    /* RAMBlock of last request sent to source */
+    RAMBlock *last_rb;
     void     *postcopy_tmp_page;
     void     *postcopy_tmp_zero_page;
     /* PostCopyFD's for external userfaultfds & handlers of shared memor=
y */
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 6ce157741f..146bc09c17 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -525,6 +525,32 @@ static int ram_block_enable_notify(const char *block=
_name, void *host_addr,
     return 0;
 }
=20
+/*
+ * Callback from shared fault handlers to ask for a page,
+ * the page must be specified by a RAMBlock and an offset in that rb
+ * Note: Only for use by shared fault handlers (in fault thread)
+ */
+int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
+                                 uint64_t client_addr, uint64_t rb_offse=
t)
+{
+    size_t pagesize =3D qemu_ram_pagesize(rb);
+    uint64_t aligned_rbo =3D rb_offset & ~(pagesize - 1);
+    MigrationIncomingState *mis =3D migration_incoming_get_current();
+
+    trace_postcopy_request_shared_page(pcfd->idstr, qemu_ram_get_idstr(r=
b),
+                                       rb_offset);
+    /* TODO: Check bitmap to see if we already have the page */
+    if (rb !=3D mis->last_rb) {
+        mis->last_rb =3D rb;
+        migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
+                                  aligned_rbo, pagesize);
+    } else {
+        /* Save some space */
+        migrate_send_rp_req_pages(mis, NULL, aligned_rbo, pagesize);
+    }
+    return 0;
+}
+
 /*
  * Handle faults detected by the USERFAULT markings
  */
@@ -535,9 +561,9 @@ static void *postcopy_ram_fault_thread(void *opaque)
     int ret;
     size_t index;
     RAMBlock *rb =3D NULL;
-    RAMBlock *last_rb =3D NULL; /* last RAMBlock we sent part of */
=20
     trace_postcopy_ram_fault_thread_entry();
+    mis->last_rb =3D NULL; /* last RAMBlock we sent part of */
     qemu_sem_post(&mis->fault_thread_sem);
=20
     struct pollfd *pfd;
@@ -636,8 +662,8 @@ static void *postcopy_ram_fault_thread(void *opaque)
              * Send the request to the source - we want to request one
              * of our host page sizes (which is >=3D TPS)
              */
-            if (rb !=3D last_rb) {
-                last_rb =3D rb;
+            if (rb !=3D mis->last_rb) {
+                mis->last_rb =3D rb;
                 migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
                                          rb_offset, qemu_ram_pagesize(rb=
));
             } else {
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index c8ced3470b..d7afab07d7 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -164,5 +164,8 @@ struct PostCopyFD {
  */
 void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
 void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
+/* Callback from shared fault handlers to ask for a page */
+int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
+                                 uint64_t client_addr, uint64_t offset);
=20
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index 1e617ad7a6..7c910b5479 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -198,6 +198,8 @@ postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
+postcopy_request_shared_page(const char *sharer, const char *rb, uint64_=
t rb_offset) "for %s in %s offset 0x%"PRIx64
+
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait=
: %" PRIu64 " milliseconds, %d iterations"
--=20
2.14.3
