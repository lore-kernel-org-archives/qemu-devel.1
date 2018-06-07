Received: from eggs.gnu.org ([2001:4830:134:3::10]:55874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9N-0002tZ-Cu
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9J-0001xt-5s
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:37 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Jun 2018 18:52:14 +0200
Message-Id: <20180607165218.9558-5-david@redhat.com>
In-Reply-To: <20180607165218.9558-1-david@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/8] spapr: local error handling in hotplug
 handler functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>

Let's introduce and use local error variables in the hotplug handler
functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a12be24ca9..4447cb197f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3576,11 +3576,14 @@ out:
 static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        spapr_memory_plug(hotplug_dev, dev, errp);
+        spapr_memory_plug(hotplug_dev, dev, &local_err);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
-        spapr_core_plug(hotplug_dev, dev, errp);
+        spapr_core_plug(hotplug_dev, dev, &local_err);
     }
+    error_propagate(errp, local_err);
 }
 
 static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
@@ -3588,10 +3591,11 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     sPAPRMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(sms);
+    Error *local_err = NULL;
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
-            spapr_memory_unplug_request(hotplug_dev, dev, errp);
+            spapr_memory_unplug_request(hotplug_dev, dev, &local_err);
         } else {
             /* NOTE: this means there is a window after guest reset, prior to
              * CAS negotiation, where unplug requests will fail due to the
@@ -3599,25 +3603,32 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
              * the case with PCI unplug, where the events will be queued and
              * eventually handled by the guest after boot
              */
-            error_setg(errp, "Memory hot unplug not supported for this guest");
+            error_setg(&local_err,
+                       "Memory hot unplug not supported for this guest");
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         if (!mc->has_hotpluggable_cpus) {
-            error_setg(errp, "CPU hot unplug not supported on this machine");
-            return;
+            error_setg(&local_err,
+                       "CPU hot unplug not supported on this machine");
+            goto out;
         }
-        spapr_core_unplug_request(hotplug_dev, dev, errp);
+        spapr_core_unplug_request(hotplug_dev, dev, &local_err);
     }
+out:
+    error_propagate(errp, local_err);
 }
 
 static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        spapr_memory_pre_plug(hotplug_dev, dev, errp);
+        spapr_memory_pre_plug(hotplug_dev, dev, &local_err);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
-        spapr_core_pre_plug(hotplug_dev, dev, errp);
+        spapr_core_pre_plug(hotplug_dev, dev, &local_err);
     }
+    error_propagate(errp, local_err);
 }
 
 static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
-- 
2.17.0
