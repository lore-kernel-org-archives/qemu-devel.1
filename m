Received: from eggs.gnu.org ([2001:4830:134:3::10]:43023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dL7oz-000543-SI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dL7oy-0006rB-MX
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:54:53 -0400
From: Laurent Vivier <lvivier@redhat.com>
References: <20170608172743.10132-1-lvivier@redhat.com>
	<20170608172743.10132-2-lvivier@redhat.com>
	<20170612143711.GK18542@umbus>
	<655ad598-f23d-6f58-7f35-88d254551b10@redhat.com>
Message-ID: <823fc823-00de-985c-7842-cd6e0e721239@redhat.com>
Date: Wed, 14 Jun 2017 14:54:46 +0200
MIME-Version: 1.0
In-Reply-To: <655ad598-f23d-6f58-7f35-88d254551b10@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr: disable hotplugging without
 OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 13/06/2017 22:18, Laurent Vivier wrote:
> On 12/06/2017 16:37, David Gibson wrote:
>> On Thu, Jun 08, 2017 at 07:27:42PM +0200, Laurent Vivier wrote:
>>> If the OS is not started, QEMU sends an event to the OS
>>> that is lost and cannot be recovered. An unplug is not
>>> able to restore QEMU in a coherent state.
>>> So, while the OS is not started, disable CPU and memory hotplug.
>>> We guess the OS is started if the CAS has been negotiated.
>>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>
>> It seems a pain to introduce a whole new (migrated) variable just to
>> check this.  Could we instead tweak the allocation of spapr->ov5_cas,
>> so it is NULL until CAS is completed?
> 
> I think it's a good idea to use ov5_cas, but we need to modify some
> functions to manage the NULL pointer (spapr_ovec_test(),
> spapr_ovec_populate_dt()), and I have some issues to manage the NULL
> pointer in migration:
> 
> - with the previous releases, if it is NULL, we don't want to migrate it
> because previous releases are not able to manage a NULL pointer, so we
> don't migrate it (spapr_ov5_cas_needed() should be false if ov5_cas is
> NULL) letting it to its default value (initialized but empty) in this
> case on the destination,
> 
> - with the current version, if it is not NULL, we to want migrate it,
> but the destination guest crashes because the pointer on the destination
> is NULL and there is no memory the receive the data.
> 
> I think the problem is we can't migrate ov5_cas if it is not initialized
> on the destination side[0]. Perhaps I've missed something but it seems a
> NULL pointer can't be migrated and thus cannot be used as a state marker.
> 
> Any idea?
> 
> Thanks,
> Laurent
> 
> [0] Perhaps we could use a VMSTATE_XXX() with a VMS_ALLOC flag instead
> of VMSTATE_STRUCT_POINTER_V() to allocate the memory on the destination?
> 

This is what I've tried but migration crashes if the OS is started on
source guest (ov5_cas != NULL, because on destination guest ov5_cas ==
NULL and the guest doesn't allocate the memory on migration). I think my
v2 looks cleaner.

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b2951d7..742cbe7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1343,7 +1343,7 @@ static void ppc_spapr_reset(void)
      * negotiated options and start from scratch */
     if (!spapr->cas_reboot) {
         spapr_ovec_cleanup(spapr->ov5_cas);
-        spapr->ov5_cas = spapr_ovec_new();
+        spapr->ov5_cas = NULL;
     }

     fdt = spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
@@ -1457,6 +1457,10 @@ static bool spapr_ov5_cas_needed(void *opaque)
     sPAPROptionVector *ov5_removed = spapr_ovec_new();
     bool cas_needed;

+    if (spapr->ov5_cas == NULL) {
+        return false;
+    }
+
     /* Prior to the introduction of sPAPROptionVector, we had two option
      * vectors we dealt with: OV5_FORM1_AFFINITY, and OV5_DRCONF_MEMORY.
      * Both of these options encode machine topology into the device-tree
@@ -2105,7 +2109,7 @@ static void ppc_spapr_init(MachineState *machine)

     /* Set up containers for ibm,client-set-architecture negotiated
options */
     spapr->ov5 = spapr_ovec_new();
-    spapr->ov5_cas = spapr_ovec_new();
+    spapr->ov5_cas = NULL;

     if (smc->dr_lmb_enabled) {
         spapr_ovec_set(spapr->ov5, OV5_DRCONF_MEMORY);
@@ -2604,6 +2608,7 @@ out:
 static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev,
DeviceState *dev,
                                   Error **errp)
 {
+    sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm);
@@ -2616,6 +2621,15 @@ static void spapr_memory_pre_plug(HotplugHandler
*hotplug_dev, DeviceState *dev,
         return;
     }

+    if (dev->hotplugged) {
+        if (!runstate_check(RUN_STATE_PRELAUNCH) &&
+            !runstate_check(RUN_STATE_INMIGRATE) &&
+            ms->ov5_cas == NULL) {
+            error_setg(errp, "Memory hotplug not supported without OS");
+            return;
+        }
+    }
+
     mem_dev = object_property_get_str(OBJECT(dimm),
PC_DIMM_MEMDEV_PROP, NULL);
     if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
         error_setg(errp, "Memory backend has bad page size. "
@@ -2919,6 +2933,7 @@ static void spapr_core_pre_plug(HotplugHandler
*hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
     MachineState *machine = MACHINE(OBJECT(hotplug_dev));
+    sPAPRMachineState *ms = SPAPR_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
     Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
@@ -2927,9 +2942,18 @@ static void spapr_core_pre_plug(HotplugHandler
*hotplug_dev, DeviceState *dev,
     CPUArchId *core_slot;
     int index;

-    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
-        error_setg(&local_err, "CPU hotplug not supported for this
machine");
-        goto out;
+    if (dev->hotplugged) {
+        if (!mc->has_hotpluggable_cpus) {
+            error_setg(&local_err,
+                       "CPU hotplug not supported for this machine");
+            goto out;
+        }
+        if (!runstate_check(RUN_STATE_PRELAUNCH) &&
+            !runstate_check(RUN_STATE_INMIGRATE) &&
+            ms->ov5_cas == NULL) {
+            error_setg(&local_err, "CPU hotplug not supported without OS");
+            goto out;
+        }
     }

     if (strcmp(base_core_type, type)) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index aa1ffea..fa25a34 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1133,6 +1133,10 @@ static target_ulong
h_client_architecture_support(PowerPCCPU *cpu,
     guest_radix = spapr_ovec_test(ov5_guest, OV5_MMU_RADIX_300);
     spapr_ovec_clear(ov5_guest, OV5_MMU_RADIX_300);

+    if (spapr->ov5_cas == NULL) {
+        spapr->ov5_cas = spapr_ovec_new();
+    }
+
     /* NOTE: there are actually a number of ov5 bits where input from the
      * guest is always zero, and the platform/QEMU enables them
independently
      * of guest input. To model these properly we'd want some sort of mask,
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 41df4c3..5f0c2d9 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -128,9 +128,12 @@ void spapr_ovec_clear(sPAPROptionVector *ov, long
bitnr)

 bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr)
 {
-    g_assert(ov);
     g_assert_cmpint(bitnr, <, OV_MAXBITS);

+    if (ov == NULL) {
+        return false;
+    }
+
     return test_bit(bitnr, ov->bitmap) ? true : false;
 }

@@ -217,7 +220,10 @@ int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
     unsigned long lastbit;
     int i;

-    g_assert(ov);
+    if (ov == NULL) {
+        vec[0] = 0;
+        return fdt_setprop(fdt, fdt_offset, name, vec, 2);
+    }
