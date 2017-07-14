Received: from eggs.gnu.org ([2001:4830:134:3::10]:43554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtt1-000151-Jy
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtt0-00026y-AA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Jul 2017 16:15:09 +1000
Message-Id: <20170714061521.28300-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170714061521.28300-1-david@gibson.dropbear.id.au>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/18] spapr: Abort on delete failure in
 spapr_drc_release()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, groug@kaod.org, sjitindarsingh@gmail.com, sbobroff@au1.ibm.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

We currently ignore errors from the object_property_del() in
spapr_drc_release().  But the only way that could fail is if the property
doesn't exist, in which case it's a bug that we're in spapr_drc_release()
at all.  So change from ignoring to abort()ing on errors.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 89ba3d6b79..35b779451d 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -367,7 +367,7 @@ static void spapr_drc_release(sPAPRDRConnector *drc)
     g_free(drc->fdt);
     drc->fdt = NULL;
     drc->fdt_start_offset = 0;
-    object_property_del(OBJECT(drc), "device", NULL);
+    object_property_del(OBJECT(drc), "device", &error_abort);
     drc->dev = NULL;
 }
 
-- 
2.13.0
