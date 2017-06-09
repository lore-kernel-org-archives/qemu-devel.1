Received: from eggs.gnu.org ([2001:4830:134:3::10]:46913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRt-0003uN-7e
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRs-0006bi-IG
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:35 +1000
Message-Id: <20170609052652.23200-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/20] spapr: fix memory leak in
 spapr_memory_pre_plug()
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

(Spotted by Coverity, CID 1375942)

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 91b4057..9b7ae28 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2615,8 +2615,11 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
         error_setg(errp, "Memory backend has bad page size. "
                    "Use 'memory-backend-file' with correct mem-path.");
-        return;
+        goto out;
     }
+
+out:
+    g_free(mem_dev);
 }
 
 struct sPAPRDIMMState {
-- 
2.9.4
