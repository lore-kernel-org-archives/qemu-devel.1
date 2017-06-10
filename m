Received: from eggs.gnu.org ([2001:4830:134:3::10]:42199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJfXV-0006iB-Oa
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJfXU-0001dX-FR
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:49 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33302
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dJfXU-0001cl-92
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:48 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 10 Jun 2017 13:30:16 +0100
Message-Id: <1497097821-32754-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/6] fw_cfg: move initialisation of FWCfgState
 into instance_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 316fca9..144e0c6 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1017,6 +1017,15 @@ FWCfgState *fw_cfg_find(void)
     return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
 }
 
+static void fw_cfg_init(Object *obj)
+{
+    FWCfgState *s = FW_CFG(obj);
+
+    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
+    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
+    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
+}
+
 static void fw_cfg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1030,6 +1039,7 @@ static const TypeInfo fw_cfg_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .abstract      = true,
     .instance_size = sizeof(FWCfgState),
+    .instance_init = fw_cfg_init,
     .class_init    = fw_cfg_class_init,
 };
 
@@ -1052,10 +1062,6 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
                    file_slots_max);
         return;
     }
-
-    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
-    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
-    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
 }
 
 static Property fw_cfg_io_properties[] = {
-- 
1.7.10.4
