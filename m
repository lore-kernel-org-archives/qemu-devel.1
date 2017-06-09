Received: from eggs.gnu.org ([2001:4830:134:3::10]:46925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRt-0003uU-PV
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRs-0006bh-I1
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:34 +1000
Message-Id: <20170609052652.23200-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/20] target/ppc: fix memory leak in
 kvmppc_is_mem_backend_page_size_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The string returned by object_property_get_str() is dynamically allocated.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8881762..f2f7c53 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -486,6 +486,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 
     if (mempath) {
         pagesize = qemu_mempath_getpagesize(mempath);
+        g_free(mempath);
     } else {
         pagesize = getpagesize();
     }
-- 
2.9.4
