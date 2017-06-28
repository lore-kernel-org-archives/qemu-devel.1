Received: from eggs.gnu.org ([2001:4830:134:3::10]:40238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDR-0004N3-6c
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDQ-00081i-DV
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIDQ-00081T-7B
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:28 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:23 +0100
Message-Id: <20170628190047.26159-6-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 05/29] postcopy: use UFFDIO_ZEROPAGE only when
 available
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

Use the recently added migration flag to hold whether
each RAMBlock has the UFFDIO_ZEROPAGE capability, use it
when it's available.

This allows the use of postcopy on tmpfs as well as hugepage
backed files.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.h    |  4 ++++
 migration/postcopy-ram.c | 12 +++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index d9a268a3af..d109635d08 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -20,6 +20,10 @@
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
 
+/* Migration flags to be set using qemu_ram_set_migration_flags */
+/* Postcopy can atomically zero pages in this RAMBlock */
+#define QEMU_MIGFLAG_POSTCOPY_ZERO   0x00000001
+
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index be2a8f8e02..96338a8070 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -408,6 +408,12 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
         error_report("%s userfault: Region doesn't support COPY", __func__);
         return -1;
     }
+    if (reg_struct.ioctls & ((__u64)1 << _UFFDIO_ZEROPAGE)) {
+        RAMBlock *rb = qemu_ram_block_by_name(block_name);
+        qemu_ram_set_migration_flags(rb, qemu_ram_get_migration_flags(rb) |
+                                         QEMU_MIGFLAG_POSTCOPY_ZERO);
+    }
+
 
     return 0;
 }
@@ -620,11 +626,11 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
 int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
                              RAMBlock *rb)
 {
+    size_t pagesize = qemu_ram_pagesize(rb);
     trace_postcopy_place_page_zero(host);
 
-    if (qemu_ram_pagesize(rb) == getpagesize()) {
-        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, getpagesize(),
-                                rb)) {
+    if (qemu_ram_get_migration_flags(rb) & QEMU_MIGFLAG_POSTCOPY_ZERO) {
+        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, pagesize, rb)) {
             int e = errno;
             error_report("%s: %s zero host: %p",
                          __func__, strerror(e), host);
-- 
2.13.0
