Received: from eggs.gnu.org ([2001:4830:134:3::10]:53262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drWp1-00080U-12
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 18:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drWow-0006JS-VI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 18:04:51 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:36492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drWow-0006JI-P5
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 18:04:46 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id F0521917B0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 00:04:44 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Sep 2017 00:04:40 +0200
Message-ID: <150516748034.6883.2205624415045931101.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] xics: fix several error leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Cedric Le Goater <clg@kaod.org>

If object_property_get_link() fails then it allocates an error, which
must be freed before returning. The error_get_pretty() function is
merely an accessor to the error message and doesn't free anything.

The error.h header indicates how to do it right:

 * Pass an existing error to the caller with the message modified:
 *     error_propagate(errp, err);
 *     error_prepend(errp, "Could not frobnicate '%s': ", name);

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index a84ba51ad8ff..80c33be02e5e 100644
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
