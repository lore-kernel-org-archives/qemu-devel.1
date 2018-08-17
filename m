Received: from eggs.gnu.org ([2001:4830:134:3::10]:57786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqjXC-000221-Hb
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqjX7-0006VI-S5
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:31:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqjX7-0006Us-Jo
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:31:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 17 Aug 2018 15:30:26 -0300
Message-Id: <20180817183026.32662-4-ehabkost@redhat.com>
In-Reply-To: <20180817183026.32662-1-ehabkost@redhat.com>
References: <20180817183026.32662-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] fw_cfg: ignore suffixes in the bootdevice
 list dependent on machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

For the older machines (such as Mac and SPARC) the DT nodes representing
bootdevices for disk nodes are irregular for mainly historical reasons.

Since the majority of bootdevice nodes for these machines either do not have a
separate disk node or require different (custom) names then it is much easier
for processing to just disable all suffixes for a particular machine.

Introduce a new ignore_boot_device_suffixes MachineClass property to control
bootdevice suffix generation, defaulting to false in order to preserve
compatibility.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20180810124027.10698-1-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h     | 1 +
 include/sysemu/sysemu.h | 2 +-
 bootdevice.c            | 5 ++++-
 hw/nvram/fw_cfg.c       | 2 +-
 hw/ppc/spapr.c          | 3 ++-
 5 files changed, 9 insertions(+), 4 deletions(-)

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
index 421b2dd09b..e5d825374e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1160,7 +1160,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
     const char *boot_device = machine->boot_order;
     char *stdout_path = spapr_vio_stdout_path(spapr->vio_bus);
     size_t cb = 0;
-    char *bootlist = get_boot_devices_list(&cb, true);
+    char *bootlist = get_boot_devices_list(&cb);
 
     _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
 
@@ -3949,6 +3949,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     InterruptStatsProviderClass *ispc = INTERRUPT_STATS_PROVIDER_CLASS(oc);
 
     mc->desc = "pSeries Logical Partition (PAPR compliant)";
+    mc->ignore_boot_device_suffixes = true;
 
     /*
      * We set up the default / latest behaviour here.  The class_init
-- 
2.18.0.rc1.1.g3f1ff2140
