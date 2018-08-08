Received: from eggs.gnu.org ([2001:4830:134:3::10]:58779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fnUWc-0004nE-C5
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fnUWZ-0005mr-8J
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:53:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fnUWY-0005lP-Vg
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:53:39 -0400
Date: Wed, 8 Aug 2018 16:53:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180808195334.GX23195@localhost.localdomain>
References: <20180808191951.23193-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808191951.23193-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: add bootdevice-ignore-suffixes
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: marcel.apfelbaum@gmail.com, lersek@redhat.com, qemu-devel@nongnu.org

On Wed, Aug 08, 2018 at 08:19:51PM +0100, Mark Cave-Ayland wrote:
> For the older machines (such as Mac and SPARC) the DT nodes representing
> bootdevices for disk nodes are irregular for mainly historical reasons.
> 
> Since the majority of bootdevice nodes for these machines either do not have a
> separate disk node or require different (custom) names then it is much easier
> to disable all suffixes for a particular machine by setting the ignore_suffixes
> parameter to get_boot_devices_list() to true, and customise the disk nodes as
> required.
> 
> Here we add a new bootdevice-ignore-suffixes property to the FW_CFG device to
> allow the generation of disk suffixes to be controlled on a per-machine basis.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

But I would prefer to see this merged only after we see machines
actually using the property.  Can you send that as a single
series later?

Also, maybe we can do it in a simpler way:

I now see that fw_cfg is not the only user of
get_boot_devices_list().  I didn't want to have a fw_cfg-specific
field in MachineClass, but but we can make it not fw_cfg-specific
if we make it affect all get_boot_devices_list() calls.

What do you think of the patch below?

(Patch is untested)

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
diff --git a/include/hw/boards.h b/include/hw/boards.h
index d139a431a6..f82f28468b 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -206,6 +206,7 @@ struct MachineClass {
     bool auto_enable_numa_with_memhp;
     void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
+    bool ignore_boot_device_suffixes;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 76ef6196a7..8d6095d98b 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -182,7 +182,7 @@ void hmp_info_usb(Monitor *mon, const QDict *qdict);
 
 void add_boot_device_path(int32_t bootindex, DeviceState *dev,
                           const char *suffix);
-char *get_boot_devices_list(size_t *size, bool ignore_suffixes);
+char *get_boot_devices_list(size_t *size);
 
 DeviceState *get_boot_device(uint32_t position);
 void check_boot_index(int32_t bootindex, Error **errp);
diff --git a/bootdevice.c b/bootdevice.c
index 1141009114..1d225202f9 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
 #include "hw/qdev-core.h"
+#include "hw/boards.h"
 
 typedef struct FWBootEntry FWBootEntry;
 
@@ -208,11 +209,13 @@ DeviceState *get_boot_device(uint32_t position)
  * memory pointed by "size" is assigned total length of the array in bytes
  *
  */
-char *get_boot_devices_list(size_t *size, bool ignore_suffixes)
+char *get_boot_devices_list(size_t *size)
 {
     FWBootEntry *i;
     size_t total = 0;
     char *list = NULL;
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    bool ignore_suffixes = mc->ignore_boot_device_suffixes;
 
     QTAILQ_FOREACH(i, &fw_boot_order, link) {
         char *devpath = NULL,  *suffix = NULL;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b23e7f64a8..d79a568f54 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -861,7 +861,7 @@ static void fw_cfg_machine_reset(void *opaque)
     void *ptr;
     size_t len;
     FWCfgState *s = opaque;
-    char *bootindex = get_boot_devices_list(&len, false);
+    char *bootindex = get_boot_devices_list(&len);
 
     ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
     g_free(ptr);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 421b2dd09b..47bc63b085 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1160,7 +1160,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
     const char *boot_device = machine->boot_order;
     char *stdout_path = spapr_vio_stdout_path(spapr->vio_bus);
     size_t cb = 0;
-    char *bootlist = get_boot_devices_list(&cb, true);
+    char *bootlist = get_boot_devices_list(&cb);
 
     _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
 
@@ -3950,6 +3950,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "pSeries Logical Partition (PAPR compliant)";
 
+    mc->ignore_boot_device_suffixes = true;
     /*
      * We set up the default / latest behaviour here.  The class_init
      * functions for the specific versioned machine types can override
