Received: from eggs.gnu.org ([2001:4830:134:3::10]:54916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTK4t-0008Ph-1l
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 00:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTK4s-00014X-6s
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 00:41:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Jun 2018 14:41:24 +1000
Message-Id: <20180614044129.13606-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180614044129.13606-1-david@gibson.dropbear.id.au>
References: <20180614044129.13606-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv3 2/7] pnv: Fix some error handling cpu
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
succession, which will go badly if they both cause errors.  In fact, a
failure in either of them indicates a qemu internal error, so we can just
use &error_abort in both cases.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 13ad7d9e04..01f47c8037 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -172,12 +172,9 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
         object_initialize(obj, size, typename);
 
         snprintf(name, sizeof(name), "thread[%d]", i);
-        object_property_add_child(OBJECT(pc), name, obj, &local_err);
+        object_property_add_child(OBJECT(pc), name, obj, &error_abort);
         object_property_add_alias(obj, "core-pir", OBJECT(pc),
-                                  "pir", &local_err);
-        if (local_err) {
-            goto err;
-        }
+                                  "pir", &error_abort);
         object_unref(obj);
     }
 
-- 
2.17.1
