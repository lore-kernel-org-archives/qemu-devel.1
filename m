Received: from eggs.gnu.org ([2001:4830:134:3::10]:50788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqjY-0001X3-NM
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqjX-0000BR-Ra
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:25:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1frqjW-00009h-Hf
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:25:02 -0400
Date: Mon, 20 Aug 2018 23:24:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180820104045.133968-8-mst@redhat.com>
References: <20180820104045.133968-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820104045.133968-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] migration/ram: ensure write persistence on
 loading all data to PMEM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Junyan He <junyan.he@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Junyan He <junyan.he@intel.com>

Because we need to make sure the pmem kind memory data is synced
after migration, we choose to call pmem_persist() when the migration
finish. This will make sure the data of pmem is safe and will not
lose if power is off.

Signed-off-by: Junyan He <junyan.he@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/pmem.h | 6 ++++++
 migration/ram.c     | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
index ebdb070210..dfb6d0da62 100644
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
index 5beefae7f5..fa79d0a5b9 100644
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
@@ -3547,6 +3548,13 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
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
MST
