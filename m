Received: from eggs.gnu.org ([2001:4830:134:3::10]:51215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mh-00071G-0e
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mg-0008NE-05
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mf-0008Mt-Pr
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:57 -0400
Date: Tue, 20 Mar 2018 05:17:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-41-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 40/50] postcopy: helper for waking shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Provide a helper to send a 'wake' request on a userfaultfd for
a shared process.
The address in the clients address space is specified together
with the RAMBlock it was resolved to.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 migration/postcopy-ram.h | 10 ++++++++++
 migration/postcopy-ram.c | 26 ++++++++++++++++++++++++++
 migration/trace-events   |  1 +
 3 files changed, 37 insertions(+)

diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index d7afab0..fcd53b8 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -164,6 +164,16 @@ struct PostCopyFD {
  */
 void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
 void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
+/* postcopy_wake_shared: Notify a client ufd that a page is available
+ *
+ * Returns 0 on success
+ *
+ * @pcfd: Structure with fd, handler and name as above
+ * @client_addr: Address in the client program, not QEMU
+ * @rb: The RAMBlock the page is in
+ */
+int postcopy_wake_shared(struct PostCopyFD *pcfd, uint64_t client_addr,
+                         RAMBlock *rb);
 /* Callback from shared fault handlers to ask for a page */
 int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
                                  uint64_t client_addr, uint64_t offset);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 146bc09..11cb096 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -525,6 +525,25 @@ static int ram_block_enable_notify(const char *block=
_name, void *host_addr,
     return 0;
 }
=20
+int postcopy_wake_shared(struct PostCopyFD *pcfd,
+                         uint64_t client_addr,
+                         RAMBlock *rb)
+{
+    size_t pagesize =3D qemu_ram_pagesize(rb);
+    struct uffdio_range range;
+    int ret;
+    trace_postcopy_wake_shared(client_addr, qemu_ram_get_idstr(rb));
+    range.start =3D client_addr & ~(pagesize - 1);
+    range.len =3D pagesize;
+    ret =3D ioctl(pcfd->fd, UFFDIO_WAKE, &range);
+    if (ret) {
+        error_report("%s: Failed to wake: %zx in %s (%s)",
+                     __func__, (size_t)client_addr, qemu_ram_get_idstr(r=
b),
+                     strerror(errno));
+    }
+    return ret;
+}
+
 /*
  * Callback from shared fault handlers to ask for a page,
  * the page must be specified by a RAMBlock and an offset in that rb
@@ -954,6 +973,13 @@ void *postcopy_get_tmp_page(MigrationIncomingState *=
mis)
     return NULL;
 }
=20
+int postcopy_wake_shared(struct PostCopyFD *pcfd,
+                         uint64_t client_addr,
+                         RAMBlock *rb)
+{
+    assert(0);
+    return -1;
+}
 #endif
=20
 /* ---------------------------------------------------------------------=
---- */
diff --git a/migration/trace-events b/migration/trace-events
index 7c910b5..b0acaaa 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -199,6 +199,7 @@ postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
 postcopy_request_shared_page(const char *sharer, const char *rb, uint64_=
t rb_offset) "for %s in %s offset 0x%"PRIx64
+postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"PRIx6=
4" in %s"
=20
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
--=20
MST
