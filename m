Received: from eggs.gnu.org ([2001:4830:134:3::10]:55536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fScna-0002d1-H5
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fScnZ-00085b-NF
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:28:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:5531)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fScnZ-0007y3-Cg
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:28:57 -0400
From: junyan.he@gmx.com
Date: Tue, 12 Jun 2018 14:28:19 +0800
Message-Id: <1528784900-7310-7-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1528784900-7310-1-git-send-email-junyan.he@gmx.com>
References: <1528784900-7310-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 6/7 V7] migration/ram: Add check and info
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
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

The nvdimm kind memory does not support post copy now.
We disable post copy if we have nvdimm memory and print some
log hint to user.

Signed-off-by: Junyan He <junyan.he@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 migration/ram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index a500015..d9093a7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3419,6 +3419,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
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
