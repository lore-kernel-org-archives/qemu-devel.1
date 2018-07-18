Received: from eggs.gnu.org ([2001:4830:134:3::10]:56590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffhCH-00024s-KA
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffhCG-0003t0-O8
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:48:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:63886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1ffhCG-0003XX-Do
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:48:28 -0400
From: junyan.he@gmx.com
Date: Wed, 18 Jul 2018 15:48:03 +0800
Message-Id: <1531900083-18167-8-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1531900083-18167-1-git-send-email-junyan.he@gmx.com>
References: <1531900083-18167-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 7/7 V11] migration/ram: ensure write
 persistence on loading all data to PMEM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, yi.z.zhang@intel.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

Because we need to make sure the pmem kind memory data is synced
after migration, we choose to call pmem_persist() when the migration
finish. This will make sure the data of pmem is safe and will not
lose if power is off.

Signed-off-by: Junyan He <junyan.he@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/qemu/pmem.h | 6 ++++++
 migration/ram.c     | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
index ebdb070..dfb6d0d 100644
--- a/include/qemu/pmem.h
+++ b/include/qemu/pmem.h
@@ -25,6 +25,12 @@ pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
     return NULL;
 }
 
+static inline void
+pmem_persist(const void *addr, size_t len)
+{
+    g_assert_not_reached();
+}
+
 #endif /* CONFIG_LIBPMEM */
 
 #endif /* !QEMU_PMEM_H */
diff --git a/migration/ram.c b/migration/ram.c
index 309b567..67b620b 100644
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
@@ -3540,6 +3541,13 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
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
 
-- 
2.7.4
