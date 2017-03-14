Received: from eggs.gnu.org ([2001:4830:134:3::10]:48902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnnPN-0003a7-Qb
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnnPL-0001IN-3y
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:26:41 -0400
Received: from mail-db5eur01on0118.outbound.protection.outlook.com
	([104.47.2.118]:17086
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <janne.huttunen@nokia.com>)
	id 1cnnPK-0001HN-KJ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:26:39 -0400
From: Janne Huttunen <janne.huttunen@nokia.com>
Date: Tue, 14 Mar 2017 14:50:11 +0200
Message-ID: <4ec5dcb3630754046a91ce19d0ce5197156b9a7a.1489494746.git.janne.huttunen@nokia.com>
In-Reply-To: <cover.1489494746.git.janne.huttunen@nokia.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC][PATCH 4/6] Clear the boot once list after it has
 been used.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: janne.huttunen@nokia.com

When the list is cleared, any attached properties are set to -1.
To do this, a reference to the property needs to be stored in
the list element.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
---
 bootdevice.c            | 26 ++++++++++++++++++++++----
 hw/nvram/fw_cfg.c       |  2 ++
 hw/ppc/spapr.c          |  2 ++
 hw/s390x/ipl.c          |  2 ++
 include/sysemu/sysemu.h |  1 +
 5 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index b5515f8..e94d78d 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -42,6 +42,7 @@ typedef struct {
 
 struct FWBootEntry {
     QTAILQ_ENTRY(FWBootEntry) link;
+    BootIndexProperty *prop;
     int32_t bootindex;
     DeviceState *dev;
     char *suffix;
@@ -171,8 +172,10 @@ void del_boot_device_path(DeviceState *dev, const char *suffix)
     do_del_boot_device_path(&fw_boot_order, dev, suffix);
 }
 
-static void do_add_boot_device_path(FWBootList *bootlist, int32_t bootindex,
-                                    DeviceState *dev, const char *suffix)
+static void do_add_boot_device_path(FWBootList *bootlist,
+                                    BootIndexProperty *prop,
+                                    int32_t bootindex, DeviceState *dev,
+                                    const char *suffix)
 {
     FWBootEntry *node, *i;
 
@@ -186,6 +189,7 @@ static void do_add_boot_device_path(FWBootList *bootlist, int32_t bootindex,
     do_del_boot_device_path(bootlist, dev, suffix);
 
     node = g_malloc0(sizeof(FWBootEntry));
+    node->prop = prop;
     node->bootindex = bootindex;
     node->suffix = g_strdup(suffix);
     node->dev = dev;
@@ -206,7 +210,7 @@ static void do_add_boot_device_path(FWBootList *bootlist, int32_t bootindex,
 void add_boot_device_path(int32_t bootindex, DeviceState *dev,
                           const char *suffix)
 {
-    do_add_boot_device_path(&fw_boot_order, bootindex, dev, suffix);
+    do_add_boot_device_path(&fw_boot_order, NULL, bootindex, dev, suffix);
 }
 
 DeviceState *get_boot_device(uint32_t position)
@@ -227,6 +231,20 @@ DeviceState *get_boot_device(uint32_t position)
     return res;
 }
 
+void clear_boot_once_list(void)
+{
+    FWBootEntry *i, *next;
+
+    QTAILQ_FOREACH_SAFE(i, &fw_boot_once, link, next) {
+        if (i->prop) {
+            *i->prop->bootindex = -1;
+        }
+        QTAILQ_REMOVE(&fw_boot_once, i, link);
+        g_free(i->suffix);
+        g_free(i);
+    }
+}
+
 /*
  * This function returns null terminated string that consist of new line
  * separated device paths.
@@ -322,7 +340,7 @@ static void device_set_bootindex(Object *obj, Visitor *v, const char *name,
     /* change bootindex to a new one */
     *prop->bootindex = boot_index;
 
-    do_add_boot_device_path(prop->bootlist, *prop->bootindex,
+    do_add_boot_device_path(prop->bootlist, prop, *prop->bootindex,
                             prop->dev, prop->suffix);
 
 out:
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 316fca9..7a707fa 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -898,6 +898,8 @@ static void fw_cfg_machine_reset(void *opaque)
     FWCfgState *s = opaque;
     char *bootindex = get_boot_devices_list(&len, false);
 
+    clear_boot_once_list();
+
     ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
     g_free(ptr);
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e465d7a..68ff980 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -803,6 +803,8 @@ static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
     size_t cb = 0;
     char *bootlist = get_boot_devices_list(&cb, true);
 
+    clear_boot_once_list();
+
     _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
 
     _FDT(fdt_setprop_string(fdt, chosen, "bootargs", machine->kernel_cmdline));
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 2e2664f..0a59058 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -253,6 +253,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
             return true;
         }
+
+        clear_boot_once_list();
     }
 
     return false;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 9acf2d9..bf3e618 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -207,6 +207,7 @@ void hmp_info_usb(Monitor *mon, const QDict *qdict);
 void add_boot_device_path(int32_t bootindex, DeviceState *dev,
                           const char *suffix);
 char *get_boot_devices_list(size_t *size, bool ignore_suffixes);
+void clear_boot_once_list(void);
 
 DeviceState *get_boot_device(uint32_t position);
 void check_boot_index(int32_t bootindex, Error **errp);
-- 
2.7.4
