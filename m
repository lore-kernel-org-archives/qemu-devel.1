Received: from eggs.gnu.org ([2001:4830:134:3::10]:51074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGjWl-0002aq-4l
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dGjWg-0006iX-5n
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:09:55 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:44693)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dGjWf-0006i2-Va
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:09:50 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7396D101064
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 12:09:48 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 02 Jun 2017 12:09:35 +0200
Message-ID: <149639817593.15167.7338592152743589651.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr/drc: don't migrate DRC of cold-plugged
 CPUs and LMBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

As explained in commit 5c0139a8c2f0 ("spapr: fix default DRC state for
coldplugged LMBs"), guests expect cold-plugged LMBs to be pre-allocated
and unisolated. The same goes for cold-plugged CPUs.

While here, let's convert g_assert(false) to the better self documenting
g_assert_not_reached().

Signed-off-by: Greg Kurz <groug@kaod.org>
---

FWIW

$ git grep -i -E '(g_)?assert\((0|false)\)' | wc -l
100
$ git grep g_assert_not_reached | wc -l
244
---
 hw/ppc/spapr_drc.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index cc2400bcd57f..ab5f7cdf569c 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -538,20 +538,16 @@ static bool spapr_drc_needed(void *opaque)
      */
     switch (drc->type) {
     case SPAPR_DR_CONNECTOR_TYPE_PCI:
-        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) &&
-               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) &&
-               drc->configured && drc->signalled && !drc->awaiting_release);
-        break;
     case SPAPR_DR_CONNECTOR_TYPE_CPU:
     case SPAPR_DR_CONNECTOR_TYPE_LMB:
-        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_ISOLATED) &&
-               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) &&
+        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) &&
+               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) &&
                drc->configured && drc->signalled && !drc->awaiting_release);
         break;
     case SPAPR_DR_CONNECTOR_TYPE_PHB:
     case SPAPR_DR_CONNECTOR_TYPE_VIO:
     default:
-        g_assert(false);
+        g_assert_not_reached();
     }
     return rc;
 }
