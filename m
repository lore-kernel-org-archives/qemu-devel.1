Received: from eggs.gnu.org ([2001:4830:134:3::10]:50892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fnU0R-0000mN-AW
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fnU0O-0001U8-4u
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:20:27 -0400
Received: from chuckie.co.uk ([82.165.15.123]:41483
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fnU0N-0001Sb-Qi
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:20:24 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  8 Aug 2018 20:19:51 +0100
Message-Id: <20180808191951.23193-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] fw_cfg: add bootdevice-ignore-suffixes property
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
bootdevices for disk nodes are irregular for mainly historical reasons.

Since the majority of bootdevice nodes for these machines either do not have a
separate disk node or require different (custom) names then it is much easier
to disable all suffixes for a particular machine by setting the ignore_suffixes
parameter to get_boot_devices_list() to true, and customise the disk nodes as
required.

Here we add a new bootdevice-ignore-suffixes property to the FW_CFG device to
allow the generation of disk suffixes to be controlled on a per-machine basis.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c         | 9 ++++++++-
 include/hw/nvram/fw_cfg.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b23e7f64a8..52488b999f 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -861,7 +861,8 @@ static void fw_cfg_machine_reset(void *opaque)
     void *ptr;
     size_t len;
     FWCfgState *s = opaque;
-    char *bootindex = get_boot_devices_list(&len, false);
+    char *bootindex = get_boot_devices_list(&len,
+                                            s->bootdevice_ignore_suffixes);
 
     ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
     g_free(ptr);
@@ -990,12 +991,18 @@ FWCfgState *fw_cfg_find(void)
     return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
 }
 
+static Property fw_cfg_properties[] = {
+    DEFINE_PROP_BOOL("bootdevice-ignore-suffixes", FWCfgState,
+                     bootdevice_ignore_suffixes, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
 
 static void fw_cfg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = fw_cfg_reset;
+    dc->props = fw_cfg_properties;
     dc->vmsd = &vmstate_fw_cfg;
 }
 
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index b2259cc4a3..848c83aef4 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -58,6 +58,7 @@ struct FWCfgState {
     uint16_t cur_entry;
     uint32_t cur_offset;
     Notifier machine_ready;
+    bool bootdevice_ignore_suffixes;
 
     int fw_cfg_order_override;
 
-- 
2.11.0
