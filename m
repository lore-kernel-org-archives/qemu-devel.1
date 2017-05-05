Received: from eggs.gnu.org ([2001:4830:134:3::10]:33911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6k9A-0004yX-4o
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6k97-0006UR-1x
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d6k96-0006Ty-PO
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:12 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45Khk8i122881
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 16:48:11 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8ecm23c3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 16:48:11 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 5 May 2017 17:48:08 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 17:47:44 -0300
In-Reply-To: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170505204746.14116-5-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v9 4/6] hw/ppc/spapr.c: migrate
 pending_dimm_unplugs of spapr state
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

To allow for a DIMM unplug event to resume its work if a migration
occurs in the middle of it, this patch migrates the non-empty
pending_dimm_unplugs QTAILQ that stores the DIMM information
that the spapr_lmb_release() callback uses.

It was considered an apprach where the DIMM states would be restored
on the post-_load after a migration. The problem is that there is
no way of knowing, from the sPAPRMachineState, if a given DIMM is going
through an unplug process and the callback needs the updated DIMM State.

We could migrate a flag indicating that there is an unplug event going
on for a certain DIMM, fetching this information from the start of the
spapr_del_lmbs call. But this would also require a scan on post_load to
figure out how many nr_lmbs are left. At this point we can just
migrate the nr_lmbs information as well, given that it is being calculated
at spapr_del_lmbs already, and spare a scanning/discovery in the
post-load. All that we need is inside the sPAPRDIMMState structure
that is added to the pending_dimm_unplugs queue at the start of the
spapr_del_lmbs, so it's convenient to just migrated this queue it if it's
not empty.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e190eb9..30f0b7b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1437,6 +1437,36 @@ static bool version_before_3(void *opaque, int version_id)
     return version_id < 3;
 }
 
+static bool spapr_pending_dimm_unplugs_needed(void *opaque)
+{
+    sPAPRMachineState *spapr = (sPAPRMachineState *)opaque;
+    return !QTAILQ_EMPTY(&spapr->pending_dimm_unplugs);
+}
+
+static const VMStateDescription vmstate_spapr_dimmstate = {
+    .name = "spapr_dimm_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(addr, sPAPRDIMMState),
+        VMSTATE_UINT32(nr_lmbs, sPAPRDIMMState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_spapr_pending_dimm_unplugs = {
+    .name = "spapr_pending_dimm_unplugs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_pending_dimm_unplugs_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_QTAILQ_V(pending_dimm_unplugs, sPAPRMachineState, 1,
+                         vmstate_spapr_dimmstate, sPAPRDIMMState,
+                         next),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool spapr_ov5_cas_needed(void *opaque)
 {
     sPAPRMachineState *spapr = opaque;
@@ -1535,6 +1565,7 @@ static const VMStateDescription vmstate_spapr = {
     .subsections = (const VMStateDescription*[]) {
         &vmstate_spapr_ov5_cas,
         &vmstate_spapr_patb_entry,
+        &vmstate_spapr_pending_dimm_unplugs,
         NULL
     }
 };
-- 
2.9.3
