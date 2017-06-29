Received: from eggs.gnu.org ([2001:4830:134:3::10]:35002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dQa6d-0006CN-Sb
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dQa6c-00070l-Ul
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:39 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60705
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dQa6c-00070G-O8
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:38 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 29 Jun 2017 15:07:18 +0100
Message-Id: <1498745240-30658-5-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv7 4/6] fw_cfg: add assert() to ensure the
 fw_cfg device has been added as a child property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

This will currently always succeed until the check is moved from init to realize.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 0fe7404..2291121 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -907,6 +907,17 @@ static void fw_cfg_machine_ready(struct Notifier *n, void *data)
     qemu_register_reset(fw_cfg_machine_reset, s);
 }
 
+static int fw_cfg_unattached_foreach(Object *obj, void *opaque)
+{
+    return (object_dynamic_cast(obj, TYPE_FW_CFG) != NULL);
+}
+
+static int fw_cfg_unattached_at_realize(void)
+{
+    Object *obj = container_get(qdev_get_machine(), "/unattached");
+
+    return object_child_foreach(obj, fw_cfg_unattached_foreach, NULL);
+}
 
 
 static void fw_cfg_init1(DeviceState *dev)
@@ -921,6 +932,8 @@ static void fw_cfg_init1(DeviceState *dev)
 
     qdev_init_nofail(dev);
 
+    assert(!fw_cfg_unattached_at_realize());
+
     fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
     fw_cfg_add_bytes(s, FW_CFG_UUID, &qemu_uuid, 16);
     fw_cfg_add_i16(s, FW_CFG_NOGRAPHIC, (uint16_t)!machine->enable_graphics);
-- 
1.7.10.4
