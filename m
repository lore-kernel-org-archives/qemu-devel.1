Received: from eggs.gnu.org ([2001:4830:134:3::10]:60924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fmHDk-00067S-3y
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 07:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fmHDi-00057A-Et
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 07:29:12 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60362
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fmHDi-0004rc-7x
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 07:29:10 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  5 Aug 2018 12:28:50 +0100
Message-Id: <20180805112850.26063-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180805112850.26063-1-mark.cave-ayland@ilande.co.uk>
References: <20180805112850.26063-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/2] fw_cfg: set the get_boot_devices_list()
 ignore_suffixes parameter from machine property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, lersek@redhat.com, qemu-devel@nongnu.org

For the older machines (such as Mac and SPARC) the DT nodes representing
bootdevices for disk nodes are irregular for mainly historical reasons, and
should be handled on an individual basis via a custom FWPathProvider.

Since the majority of bootdevice nodes for these machines either do not have a
separate disk node or require different (custom) names then it is much easier
to allow the ignore_suffixes parameter to be set on a per-machine basis via
a machine property.

The default value for this new fwcfg_bootdevice_ignore_suffixes machine
property is false to preserve compatibility for existing machines.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/core/machine.c   | 3 +++
 hw/nvram/fw_cfg.c   | 5 ++++-
 include/hw/boards.h | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a9aeb22f03..fbadb35865 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -525,6 +525,9 @@ static void machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 128 * MiB;
     mc->rom_file_has_mr = true;
 
+    /* Default to using fwcfg bootdevice suffixes */
+    mc->fwcfg_bootdevice_ignore_suffixes = false;
+
     /* numa node memory size aligned on 8MB by default.
      * On Linux, each node's border has to be 8MB aligned
      */
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b23e7f64a8..ec6b8113ab 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -861,7 +861,10 @@ static void fw_cfg_machine_reset(void *opaque)
     void *ptr;
     size_t len;
     FWCfgState *s = opaque;
-    char *bootindex = get_boot_devices_list(&len, false);
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+
+    char *bootindex = get_boot_devices_list(&len,
+                          mc->fwcfg_bootdevice_ignore_suffixes);
 
     ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
     g_free(ptr);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index d139a431a6..2cf76d82a6 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -204,6 +204,7 @@ struct MachineClass {
     const char **valid_cpu_types;
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
+    bool fwcfg_bootdevice_ignore_suffixes;
     void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
 
-- 
2.11.0
