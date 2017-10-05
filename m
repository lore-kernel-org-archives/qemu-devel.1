Received: from eggs.gnu.org ([2001:4830:134:3::10]:58970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e0Blp-0002LW-11
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e0Bll-0001o6-Pd
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:25:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e0Bll-0001mn-E6
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:25:17 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v95JOlvq051670
	for <qemu-devel@nongnu.org>; Thu, 5 Oct 2017 15:25:12 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ddqq2b1pr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 15:25:11 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 5 Oct 2017 13:25:09 -0600
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu,  5 Oct 2017 16:24:58 -0300
Message-Id: <20171005192458.610-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] hw/ppc/spapr_drc.c: adding drc->dev into
 detach quiesce condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

In cases where a device is hotplugged and hot-unplugged shortly after,
there is a chance of QEMU breaking with the following message:

hw/ppc/spapr_drc.c:417:spapr_drc_detach: assertion failed: (drc->dev)
Aborted

spapr_drc_detach makes a g_assert(drc->dev) to ensure that the following
spapr_drc_release call is able to execute the appropriate callback
using drc->dev as a parameter. However, in a scenario where a hotplug
is quickly followed by a hot-unplug, this g_assert can be reached before
the hotplug operation sets drc->dev in spapr_drc_attach.

This patch makes use of the awaiting quiesce mechanism inside
spapr_drc_detach to fix this scenario. Inside spapr_drc_detach there is a
quiesce condition that relies on drc->state being equal to drck->empty_state.
If this doesn't happen, it is considered that the drc is not ready to be
detached. By extending this condition to include drc->dev being non-null
we cover this situation where the drc is still being attached and drc->dev
isn't set yet during the detach.

Fixes: https://bugs.launchpad.net/qemu/+bug/1718118
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 915e9b51c4..6ad8190360 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -414,11 +414,9 @@ void spapr_drc_detach(sPAPRDRConnector *drc)
 
     trace_spapr_drc_detach(spapr_drc_index(drc));
 
-    g_assert(drc->dev);
-
     drc->unplug_requested = true;
 
-    if (drc->state != drck->empty_state) {
+    if (!drc->dev || (drc->state != drck->empty_state)) {
         trace_spapr_drc_awaiting_quiesce(spapr_drc_index(drc));
         return;
     }
-- 
2.13.6
