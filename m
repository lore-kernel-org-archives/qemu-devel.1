Received: from eggs.gnu.org ([2001:4830:134:3::10]:45354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fclnX-0007r6-5E
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fclnW-0007Or-6v
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:06:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:23582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fclnV-0007HY-V1
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:06:50 -0400
From: junyan.he@gmx.com
Date: Tue, 10 Jul 2018 14:06:29 +0800
Message-Id: <1531202789-31006-8-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1531202789-31006-1-git-send-email-junyan.he@gmx.com>
References: <1531202789-31006-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 7/7 V8] migration/ram: ensure write persistence
 on loading all data to PMEM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

Because we need to make sure the pmem kind memory data is synced
after migration, we choose to call pmem_persist() when the migration
finish. This will make sure the data of pmem is safe and will not
lose if power is off.

Signed-off-by: Junyan He <junyan.he@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/qemu/pmem.h |  1 +
 migration/ram.c     | 10 +++++++++-
 stubs/pmem.c        |  4 ++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
index 00d6680..8f52b08 100644
--- a/include/qemu/pmem.h
+++ b/include/qemu/pmem.h
@@ -17,6 +17,7 @@
 #else  /* !CONFIG_LIBPMEM */
 
 void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len);
+void pmem_persist(const void *addr, size_t len);
 
 #endif /* CONFIG_LIBPMEM */
 
diff --git a/migration/ram.c b/migration/ram.c
index 9c03e2b..62dfe75 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -33,6 +33,7 @@
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
 #include "qemu/main-loop.h"
+#include "qemu/pmem.h"
 #include "xbzrle.h"
 #include "ram.h"
 #include "migration.h"
@@ -3541,6 +3542,13 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
 static int ram_load_cleanup(void *opaque)
 {
     RAMBlock *rb;
+
+    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
+        if (ramblock_is_pmem(rb)) {
+            pmem_persist(rb->host, rb->used_length);
+        }
+    }
+
     xbzrle_load_cleanup();
     compress_threads_load_cleanup();
 
@@ -3896,7 +3904,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 static bool ram_has_postcopy(void *opaque)
 {
     RAMBlock *rb;
-    RAMBLOCK_FOREACH(rb) {
+    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
         if (ramblock_is_pmem(rb)) {
             info_report("Block: %s, host: %p is a nvdimm memory, postcopy"
                          "is not supported now!", rb->idstr, rb->host);
diff --git a/stubs/pmem.c b/stubs/pmem.c
index b4ec72d..f794262 100644
--- a/stubs/pmem.c
+++ b/stubs/pmem.c
@@ -17,3 +17,7 @@ void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
 {
     return memcpy(pmemdest, src, len);
 }
+
+void pmem_persist(const void *addr, size_t len)
+{
+}
-- 
2.7.4
