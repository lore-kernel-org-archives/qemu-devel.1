Received: from eggs.gnu.org ([2001:4830:134:3::10]:49782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCd-0000tv-W8
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCb-0000vr-4K
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51950
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCa-0000vL-V3
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:53 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE9Qp024373
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:52 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epm4y6u1x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:51 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:51 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:37 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-45-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 44/55] spapr: reset DRCs after devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

A DRC with a pending unplug request releases its associated device at
machine reset time.

In the case of LMB, when all DRCs for a DIMM device have been reset,
the DIMM gets unplugged, causing guest memory to disappear. This may
be very confusing for anything still using this memory.

This is exactly what happens with vhost backends, and QEMU aborts
with:

qemu-system-ppc64: used ring relocated for ring 2
qemu-system-ppc64: qemu/hw/virtio/vhost.c:649: vhost_commit: Assertion
 `r >= 0' failed.

The issue is that each DRC registers a QEMU reset handler, and we
don't control the order in which these handlers are called (ie,
a LMB DRC will unplug a DIMM before the virtio device using the
memory on this DIMM could stop its vhost backend).

To avoid such situations, let's reset DRCs after all devices
have been reset.

Reported-by: Mallesh N. Koti <mallesh@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 82512483940c756e2db1bd67ea91b02bc29c5e01)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c     | 21 +++++++++++++++++++++
 hw/ppc/spapr_drc.c |  7 -------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 954fd1a747..8630281d0e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1393,6 +1393,19 @@ static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
     }
 }
 
+static int spapr_reset_drcs(Object *child, void *opaque)
+{
+    sPAPRDRConnector *drc =
+        (sPAPRDRConnector *) object_dynamic_cast(child,
+                                                 TYPE_SPAPR_DR_CONNECTOR);
+
+    if (drc) {
+        spapr_drc_reset(drc);
+    }
+
+    return 0;
+}
+
 static void ppc_spapr_reset(void)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
@@ -1416,6 +1429,14 @@ static void ppc_spapr_reset(void)
     }
 
     qemu_devices_reset();
+
+    /* DRC reset may cause a device to be unplugged. This will cause troubles
+     * if this device is used by another device (eg, a running vhost backend
+     * will crash QEMU if the DIMM holding the vring goes away). To avoid such
+     * situations, we reset DRCs after all devices have been reset.
+     */
+    object_child_foreach_recursive(object_get_root(), spapr_reset_drcs, NULL);
+
     spapr_clear_pending_events(spapr);
 
     /*
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 50df361187..85f4e7d324 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -455,11 +455,6 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
     }
 }
 
-static void drc_reset(void *opaque)
-{
-    spapr_drc_reset(SPAPR_DR_CONNECTOR(opaque));
-}
-
 bool spapr_drc_needed(void *opaque)
 {
     sPAPRDRConnector *drc = (sPAPRDRConnector *)opaque;
@@ -518,7 +513,6 @@ static void realize(DeviceState *d, Error **errp)
     }
     vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_drc,
                      drc);
-    qemu_register_reset(drc_reset, drc);
     trace_spapr_drc_realize_complete(spapr_drc_index(drc));
 }
 
@@ -529,7 +523,6 @@ static void unrealize(DeviceState *d, Error **errp)
     char name[256];
 
     trace_spapr_drc_unrealize(spapr_drc_index(drc));
-    qemu_unregister_reset(drc_reset, drc);
     vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
     root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
     snprintf(name, sizeof(name), "%x", spapr_drc_index(drc));
-- 
2.11.0
