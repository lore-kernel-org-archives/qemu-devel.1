Received: from eggs.gnu.org ([2001:4830:134:3::10]:39465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fcpuo-0003ow-P9
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fcpun-000898-Uk
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:30:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:54550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fcpun-0007jf-M7
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:30:37 -0400
From: junyan.he@gmx.com
Date: Tue, 10 Jul 2018 18:30:19 +0800
Message-Id: <1531218620-14645-7-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1531218620-14645-1-git-send-email-junyan.he@gmx.com>
References: <1531218620-14645-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 6/7 V9] migration/ram: Add check and info
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 migration/ram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 1cd98d6..9c03e2b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3895,6 +3895,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
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
