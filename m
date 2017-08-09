Received: from eggs.gnu.org ([2001:4830:134:3::10]:46706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2W-0006Dl-7w
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2V-00040q-95
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:24 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Aug 2017 17:03:56 +1000
Message-Id: <20170809070357.28723-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170809070357.28723-1-david@gibson.dropbear.id.au>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 5/6] spapr_drc: abort if
 object_property_add_child() fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

object_property_add_child() can only fail in two cases:
- the child already has a parent, which shouldn't happen since the DRC was
  allocated a few lines above
- the parent already has a child with the same name, which would mean the
  caller tries to create a DRC that already exists

In both case, this is a QEMU bug and we should abort.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 47d94e782a..5260b5d363 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -541,7 +541,7 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
     drc->owner = owner;
     prop_name = g_strdup_printf("dr-connector[%"PRIu32"]",
                                 spapr_drc_index(drc));
-    object_property_add_child(owner, prop_name, OBJECT(drc), NULL);
+    object_property_add_child(owner, prop_name, OBJECT(drc), &error_abort);
     object_property_set_bool(OBJECT(drc), true, "realized", NULL);
     g_free(prop_name);
 
-- 
2.13.4
