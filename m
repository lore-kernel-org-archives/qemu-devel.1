Received: from eggs.gnu.org ([2001:4830:134:3::10]:56938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da47t-0001rW-5J
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da47q-0001TV-4x
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:09 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:48314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da47p-0001T2-UJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:06 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 71FAB11658C
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:00:04 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 19:59:56 +0200
Message-ID: <150100559681.27487.12465113775325434061.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 09/26] spapr_drc: pass object
 ownership to parent/owner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

DRC objects attach themselves to an owner as a child
property. unref afterward to allow them to be finalized
when their owner is finalized.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
Changes since RFC:
- rebased against ppc-for-2.10
---
 hw/ppc/spapr_drc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 105ce85b6d04..eb8024d37c54 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -544,6 +544,7 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
     prop_name = g_strdup_printf("dr-connector[%"PRIu32"]",
                                 spapr_drc_index(drc));
     object_property_add_child(owner, prop_name, OBJECT(drc), NULL);
+    object_unref(OBJECT(drc));
     object_property_set_bool(OBJECT(drc), true, "realized", NULL);
     g_free(prop_name);
 
