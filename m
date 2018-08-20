Received: from eggs.gnu.org ([2001:4830:134:3::10]:50768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqjW-0001W3-Lp
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqjU-00008O-Ss
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:25:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1frqjU-000076-2t
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:25:00 -0400
Date: Mon, 20 Aug 2018 23:24:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180820104045.133968-7-mst@redhat.com>
References: <20180820104045.133968-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820104045.133968-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] migration/ram: Add check and info message
 to nvdimm post copy.
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

The nvdimm kind memory does not support post copy now.
We disable post copy if we have nvdimm memory and print some
log hint to user.

Signed-off-by: Junyan He <junyan.he@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 migration/ram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 24dea2730c..5beefae7f5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3906,6 +3906,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
 static bool ram_has_postcopy(void *opaque)
 {
+    RAMBlock *rb;
+    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
+        if (ramblock_is_pmem(rb)) {
+            info_report("Block: %s, host: %p is a nvdimm memory, postcopy"
+                         "is not supported now!", rb->idstr, rb->host);
+            return false;
+        }
+    }
+
     return migrate_postcopy_ram();
 }
 
-- 
MST
