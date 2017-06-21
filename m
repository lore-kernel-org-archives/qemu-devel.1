Received: from eggs.gnu.org ([2001:4830:134:3::10]:46031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNc2L-0005Ha-OG
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNc2I-0001GT-LR
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:34:57 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 21 Jun 2017 17:34:44 +0800
Message-Id: <20170621093444.30115-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH for-2.9 stable] target/ppc: fix memory leak in
 kvmppc_is_mem_backend_page_size_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The string returned by object_property_get_str() is dynamically allocated.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 2d3e302ec2246d703ffa8d8f8769a3fa448d8145)
---
 target/ppc/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9f1f132..e7f7b29 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -423,6 +423,7 @@ bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
 
     if (mempath) {
         pagesize = qemu_mempath_getpagesize(mempath);
+        g_free(mempath);
     } else {
         pagesize = getpagesize();
     }
-- 
2.9.4
