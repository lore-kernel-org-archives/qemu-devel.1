Received: from eggs.gnu.org ([2001:4830:134:3::10]:40511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fOf9Y-0000lH-NE
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fOf9X-0000nc-TI
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:11:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:28960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fOf9X-0000fl-Jb
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:11:15 -0400
From: junyan.he@gmx.com
Date: Fri,  1 Jun 2018 16:10:28 +0800
Message-Id: <1527840629-18648-7-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH V6 6/7] migration/ram: Add check and info
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
---
 migration/ram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index c53e836..aa0c6f0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3397,6 +3397,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
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
