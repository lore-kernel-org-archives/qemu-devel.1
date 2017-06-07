Received: from eggs.gnu.org ([2001:4830:134:3::10]:44744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIeZp-0000Nz-OQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIeZl-0000TO-Nx
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:17:01 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:53108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIeZl-0000RY-HZ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:16:57 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id ABB943D100
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 19:16:55 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 07 Jun 2017 19:16:52 +0200
Message-ID: <149685581222.12025.5541302490723329093.stgit@bahia.lan>
In-Reply-To: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 1/5] pnv_core: drop reference on ICPState
 object during CPU realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

Similarly to what was done to spapr with commit 249127d0dfeb, this patch
ensures that we don't keep an extra reference on the ICPState object. Also
since the object was just created and not reparented yet, the call to
object_property_add_child() should never fail: let's pass &error_abort to
make this clear.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 1b7ec70f033d..e8a9a94d5a24 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -119,7 +119,8 @@ static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error **errp)
     Object *obj;
 
     obj = object_new(TYPE_PNV_ICP);
-    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);
+    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
+    object_unref(obj);
     object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
