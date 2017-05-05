Received: from eggs.gnu.org ([2001:4830:134:3::10]:33942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6k9D-000537-D8
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6k9A-0006X9-Q2
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d6k9A-0006Vs-HV
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45KhmPO011169
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 16:48:15 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8yxy1tgf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 16:48:15 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 5 May 2017 17:48:12 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 17:47:45 -0300
In-Reply-To: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170505204746.14116-6-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v9 5/6] migration: spapr: migrate ccs_list in
 spapr state
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

From: Jianjun Duan <duanj@linux.vnet.ibm.com>

ccs_list in spapr state maintains the device tree related
information on the rtas side for hotplugged devices. In racing
situations between hotplug events and migration operation, a rtas
hotplug event could be migrated from the source guest to target
guest, or the source guest could have not yet finished fetching
the device tree when migration is started, the target will try
to finish fetching the device tree. By migrating ccs_list, the
target can fetch the device tree properly.

In theory there would be other alternatives besides migrating the
css_list to fix this. For example, we could add a flag that indicates
whether a device is in the middle of the configure_connector during the
migration process, in the post_load we can detect if this flag
is active and then return an error informing the guest to restart the
hotplug process. However, the DRC state can still be modified outside of
hotplug. Using:

   drmgr -c pci -s <drc_index> -r
   drmgr -c pci -s <drc_index> -a

it is possible to return a device to firmware and then later take it
back and reconfigure it. This is not a common case but it's not prohibited,
and performing a migration between these 2 operations would fail because
the default coldplug state on target assumes a configured state in
the source*. Migrating ccs_list is one solution that cover this
case as well.

ccs_list is put in a subsection in the spapr state VMSD to make
sure migration across different versions is not broken.

* see http://lists.nongnu.org/archive/html/qemu-devel/2016-10/msg01763.html
for more information on this discussion.

Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 30f0b7b..bc56249 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1467,6 +1467,37 @@ static const VMStateDescription vmstate_spapr_pending_dimm_unplugs = {
     },
 };
 
+static bool spapr_ccs_list_needed(void *opaque)
+{
+    sPAPRMachineState *spapr = (sPAPRMachineState *)opaque;
+    return !QTAILQ_EMPTY(&spapr->ccs_list);
+}
+
+static const VMStateDescription vmstate_spapr_ccs = {
+    .name = "spapr_configure_connector_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(drc_index, sPAPRConfigureConnectorState),
+        VMSTATE_INT32(fdt_offset, sPAPRConfigureConnectorState),
+        VMSTATE_INT32(fdt_depth, sPAPRConfigureConnectorState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_spapr_ccs_list = {
+    .name = "spapr_ccs_list",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_ccs_list_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_QTAILQ_V(ccs_list, sPAPRMachineState, 1,
+                         vmstate_spapr_ccs, sPAPRConfigureConnectorState,
+                         next),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool spapr_ov5_cas_needed(void *opaque)
 {
     sPAPRMachineState *spapr = opaque;
@@ -1566,6 +1597,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_ov5_cas,
         &vmstate_spapr_patb_entry,
         &vmstate_spapr_pending_dimm_unplugs,
+        &vmstate_spapr_ccs_list,
         NULL
     }
 };
-- 
2.9.3
