Received: from eggs.gnu.org ([2001:4830:134:3::10]:34110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSziX-0002vI-R7
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSziX-0006WR-1f
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:57:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 13 Jun 2018 16:57:02 +1000
Message-Id: <20180613065707.30766-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180613065707.30766-1-david@gibson.dropbear.id.au>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 2/7] pnv: Add missing error check during cpu
 realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

In pnv_core_realize() we call two functions with an Error * parameter in
succession, which means if they both cause errors we'll lose the first one.
Add an extra test/escape to fix this.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 13ad7d9e04..efb68226bb 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -173,6 +173,9 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
 
         snprintf(name, sizeof(name), "thread[%d]", i);
         object_property_add_child(OBJECT(pc), name, obj, &local_err);
+        if (local_err) {
+            goto err;
+        }
         object_property_add_alias(obj, "core-pir", OBJECT(pc),
                                   "pir", &local_err);
         if (local_err) {
-- 
2.17.1
