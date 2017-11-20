Received: from eggs.gnu.org ([2001:4830:134:3::10]:60636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGer5-00010x-5I
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 00:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGer4-0004AW-4W
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 00:42:51 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 20 Nov 2017 16:42:39 +1100
Message-Id: <20171120054239.8739-3-david@gibson.dropbear.id.au>
In-Reply-To: <20171120054239.8739-1-david@gibson.dropbear.id.au>
References: <20171120054239.8739-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/2] spapr: reset DRCs after devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

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
---
 hw/ppc/spapr.c     | 21 +++++++++++++++++++++
 hw/ppc/spapr_drc.c |  7 -------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6841bd294b..6285f7211f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1411,6 +1411,19 @@ static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
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
@@ -1434,6 +1447,14 @@ static void ppc_spapr_reset(void)
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
index 915e9b51c4..e3b122968e 100644
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
     gchar *name;
 
     trace_spapr_drc_unrealize(spapr_drc_index(drc));
-    qemu_unregister_reset(drc_reset, drc);
     vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
     root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
     name = g_strdup_printf("%x", spapr_drc_index(drc));
-- 
2.14.3
