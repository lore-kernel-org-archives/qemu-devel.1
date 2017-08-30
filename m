Received: from eggs.gnu.org ([2001:4830:134:3::10]:57245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dn7cv-00056P-GJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dn7cr-0006Rs-7m
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:22:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44322
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dn7cr-0006Ra-1f
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:22:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UIJliG014217
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 14:22:04 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cnx0xu48r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 14:22:04 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 14:22:03 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 15:21:41 -0300
In-Reply-To: <20170830182141.19996-1-danielhb@linux.vnet.ibm.com>
References: <20170830182141.19996-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170830182141.19996-4-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.11 v3 3/3] hw/ppc: CAS reset on early
 device hotplug
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

This patch is a follow up on the discussions made in patch
"hw/ppc: disable hotplug before CAS is completed" that can be
found at [1].

At this moment, we do not support CPU/memory hotplug in early
boot stages, before CAS. When a hotplug occurs, the event is logged
in an internal RTAS event log queue and an IRQ pulse is fired. In
regular conditions, the guest handles the interrupt by executing
check_exception, fetching the generated hotplug event and enabling
the device for use.

In early boot, this IRQ isn't caught (SLOF does not handle hotplug
events), leaving the event in the rtas event log queue. If the guest
executes check_exception due to another hotplug event, the re-assertion
of the IRQ ends up de-queuing the first hotplug event as well. In short,
a device hotplugged before CAS is considered coldplugged by SLOF.
This leads to device misbehavior and, in some cases, guest kernel
Ooops when trying to unplug the device.

A proper fix would be to turn every device hotplugged before CAS
as a colplugged device. This is not trivial to do with the current
code base though - the FDT is written in the guest memory at
ppc_spapr_reset and can't be retrieved without adding extra state
(fdt_size for example) that will need to managed and migrated. Adding
the hotplugged DT in the middle of CAS negotiation via the updated DT
tree works with CPU devs, but panics the guest kernel at boot. Additional
analysis would be necessary for LMBs and PCI devices. There are
questions to be made in QEMU/SLOF/kernel level about how we can make
this change in a sustainable way.

With Linux guests, a fix would be the kernel executing check_exception
at boot time, de-queueing the events that happened in early boot and
processing them. However, even if/when the newer kernels start
fetching these events at boot time, we need to take care of older
kernels that won't be doing that.

This patch works around the situation by issuing a CAS reset if a hotplugged
device is detected during CAS:

- the DRC conditions that warrant a CAS reset is the same as those that
triggers a DRC migration - the DRC must have a device attached and
the DRC state is not equal to its ready_state. With that in mind, this
patch makes use of 'spapr_drc_needed' to determine if a CAS reset
is needed.

- In the middle of CAS negotiations, the function
'spapr_hotplugged_dev_before_cas' goes through all the DRCs to see
if there are any DRC that requires a reset, using spapr_drc_needed. If
that happens, returns '1' in 'spapr_h_cas_compose_response' which will set
spapr->cas_reboot to true, causing the machine to reboot.

No changes are made for coldplug devices.

[1] http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02855.html

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c             | 26 +++++++++++++++++++++++++-
 hw/ppc/spapr_drc.c         |  2 +-
 include/hw/ppc/spapr_drc.h |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 085415c..067f571 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -790,6 +790,26 @@ out:
     return ret;
 }
 
+static bool spapr_hotplugged_dev_before_cas(void)
+{
+    Object *drc_container, *obj;
+    ObjectProperty *prop;
+    ObjectPropertyIterator iter;
+
+    drc_container = container_get(object_get_root(), "/dr-connector");
+    object_property_iter_init(&iter, drc_container);
+    while ((prop = object_property_iter_next(&iter))) {
+        if (!strstart(prop->type, "link<", NULL)) {
+            continue;
+        }
+        obj = object_property_get_link(drc_container, prop->name, NULL);
+        if (spapr_drc_needed(obj)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
                                  target_ulong addr, target_ulong size,
                                  sPAPROptionVector *ov5_updates)
@@ -797,9 +817,13 @@ int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
     void *fdt, *fdt_skel;
     sPAPRDeviceTreeUpdateHeader hdr = { .version_id = 1 };
 
+    if (spapr_hotplugged_dev_before_cas()) {
+        return 1;
+    }
+
     size -= sizeof(hdr);
 
-    /* Create sceleton */
+    /* Create skeleton */
     fdt_skel = g_malloc0(size);
     _FDT((fdt_create(fdt_skel, size)));
     _FDT((fdt_begin_node(fdt_skel, "")));
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 6670a76..915e9b5 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -460,7 +460,7 @@ static void drc_reset(void *opaque)
     spapr_drc_reset(SPAPR_DR_CONNECTOR(opaque));
 }
 
-static bool spapr_drc_needed(void *opaque)
+bool spapr_drc_needed(void *opaque)
 {
     sPAPRDRConnector *drc = (sPAPRDRConnector *)opaque;
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index a7958d0..f8d9f5b 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -257,6 +257,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
 void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                       int fdt_start_offset, Error **errp);
 void spapr_drc_detach(sPAPRDRConnector *drc);
+bool spapr_drc_needed(void *opaque);
 
 static inline bool spapr_drc_unplug_requested(sPAPRDRConnector *drc)
 {
-- 
2.9.4
