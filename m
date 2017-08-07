Received: from eggs.gnu.org ([2001:4830:134:3::10]:43474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dells-00045H-Uh
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dello-0002DD-19
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:24:52 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:33993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1delln-0002Cf-Rt
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:24:47 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 73E828B487
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 19:24:46 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 07 Aug 2017 19:24:39 +0200
Message-ID: <150212667952.12227.2933198220121691613.stgit@bahia>
In-Reply-To: <150212666472.12227.5292551535430570753.stgit@bahia>
References: <150212666472.12227.5292551535430570753.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.10 PATCH 1/3] spapr_drc: abort if
 object_property_add_child() fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

object_property_add_child() can only fail in two cases:
- the child already has a parent, which shouldn't happen since the DRC was
  allocated a few lines above
- the parent already has a child with the same name, which would mean the
  caller tries to create a DRC that already exists

In both case, this is a QEMU bug and we should abort.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_drc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 47d94e782ac2..5260b5d363a0 100644
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
 
