Received: from eggs.gnu.org ([2001:4830:134:3::10]:50214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffJXW-0003BT-Ed
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffJXR-0007iw-DG
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:25037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1ffJXR-0007iM-19
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:45 -0400
From: junyan.he@gmx.com
Date: Tue, 17 Jul 2018 14:32:09 +0800
Message-Id: <1531809130-31088-7-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
References: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 6/7 V10] migration/ram: Add check and info
 message to nvdimm post copy.
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

The nvdimm kind memory does not support post copy now.
We disable post copy if we have nvdimm memory and print some
log hint to user.

Signed-off-by: Junyan He <junyan.he@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 migration/ram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 52dd678..fd7cba1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3899,6 +3899,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
 static bool ram_has_postcopy(void *opaque)
 {
+    RAMBlock *rb;
+    RAMBLOCK_FOREACH(rb) {
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
2.7.4
