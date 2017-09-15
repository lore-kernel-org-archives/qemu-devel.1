Received: from eggs.gnu.org ([2001:4830:134:3::10]:54254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfN-0006mb-Tb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfM-0003QT-AX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:24 +1000
Message-Id: <20170915035130.8354-13-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/18] xics: fix several error leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

If object_property_get_link() fails then it allocates an error, which
must be freed before returning. The error_get_pretty() function is
merely an accessor to the error message and doesn't free anything.

The error.h header indicates how to do it right:

 * Pass an existing error to the caller with the message modified:
 *     error_propagate(errp, err);
 *     error_prepend(errp, "Could not frobnicate '%s': ", name);

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index a84ba51ad8..80c33be02e 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -306,8 +306,8 @@ static void icp_realize(DeviceState *dev, Error **errp)
 
     obj = object_property_get_link(OBJECT(dev), ICP_PROP_XICS, &err);
     if (!obj) {
-        error_setg(errp, "%s: required link '" ICP_PROP_XICS "' not found: %s",
-                   __func__, error_get_pretty(err));
+        error_propagate(errp, err);
+        error_prepend(errp, "required link '" ICP_PROP_XICS "' not found: ");
         return;
     }
 
@@ -315,8 +315,8 @@ static void icp_realize(DeviceState *dev, Error **errp)
 
     obj = object_property_get_link(OBJECT(dev), ICP_PROP_CPU, &err);
     if (!obj) {
-        error_setg(errp, "%s: required link '" ICP_PROP_CPU "' not found: %s",
-                   __func__, error_get_pretty(err));
+        error_propagate(errp, err);
+        error_prepend(errp, "required link '" ICP_PROP_CPU "' not found: ");
         return;
     }
 
@@ -641,8 +641,8 @@ static void ics_base_realize(DeviceState *dev, Error **errp)
 
     obj = object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &err);
     if (!obj) {
-        error_setg(errp, "%s: required link '" ICS_PROP_XICS "' not found: %s",
-                   __func__, error_get_pretty(err));
+        error_propagate(errp, err);
+        error_prepend(errp, "required link '" ICS_PROP_XICS "' not found: ");
         return;
     }
     ics->xics = XICS_FABRIC(obj);
-- 
2.13.5
