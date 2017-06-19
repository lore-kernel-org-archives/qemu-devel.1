Received: from eggs.gnu.org ([2001:4830:134:3::10]:45593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dMwH8-0003O7-1M
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dMwH7-0002KQ-4a
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:59:26 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60317
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dMwH6-0002Jx-Tx
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:59:25 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 19 Jun 2017 13:59:07 +0100
Message-Id: <1497877149-19253-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv6 3/5] fw_cfg: move assert() and linking of
 fw_cfg device to the machine into instance_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

In preparation for calling fw_cfg_init1() during realize rather than during
init, move the assert() checking for existing fw_cfg devices and the linking
of the device to the machine with object_property_add_child() to a new
fw_cfg instance_init() function.

This guarantees that we will still assert() correctly if more than one fw_cfg
device is instantiated by accident.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/nvram/fw_cfg.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 99bdbc2..af45012 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -915,10 +915,6 @@ static void fw_cfg_init1(DeviceState *dev)
     MachineState *machine = MACHINE(qdev_get_machine());
     uint32_t version = FW_CFG_VERSION;
 
-    assert(!object_resolve_path(FW_CFG_PATH, NULL));
-
-    object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s), NULL);
-
     qdev_init_nofail(dev);
 
     fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
@@ -1020,6 +1016,15 @@ FWCfgState *fw_cfg_find(void)
     return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
 }
 
+static void fw_cfg_init(Object *obj)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+
+    assert(!object_resolve_path(FW_CFG_PATH, NULL));
+
+    object_property_add_child(OBJECT(machine), FW_CFG_NAME, obj, NULL);
+}
+
 static void fw_cfg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1033,6 +1038,7 @@ static const TypeInfo fw_cfg_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .abstract      = true,
     .instance_size = sizeof(FWCfgState),
+    .instance_init = fw_cfg_init,
     .class_init    = fw_cfg_class_init,
 };
 
-- 
1.7.10.4
