Received: from eggs.gnu.org ([2001:4830:134:3::10]:32784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV1Mf-0006eO-Ly
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV1Mc-0008Dk-Jv
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:02:33 -0400
Received: from chuckie.co.uk ([82.165.15.123]:34861
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV1Mc-0008D6-Cq
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:02:30 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 21:02:11 +0100
Message-Id: <1499803333-9052-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499803333-9052-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499803333-9052-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv8 1/3] fw_cfg: switch fw_cfg_find() to locate
 the fw_cfg device by type rather than path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

This will enable the fw_cfg device to be placed anywhere within the QOM tree
regardless of its machine location.

Note that we also add a comment to document the behaviour that we return NULL to
indicate failure where either no fw_cfg device or multiple fw_cfg devices are
found.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 99bdbc2..8ef889a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1017,7 +1017,12 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
 
 FWCfgState *fw_cfg_find(void)
 {
-    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
+    /* Returns FWCfgState if only one fw_cfg device type exists. If zero or
+       more than one fw_cfg device are found then NULL is returned as per the
+       object_resolve_path_type() documentation. This behaviour is correct as
+       it ensures that we detect both missing fw_cfg devices and multiple
+       fw_cfg devices which could result in unpredictable behaviour. */
+    return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
 }
 
 static void fw_cfg_class_init(ObjectClass *klass, void *data)
-- 
1.7.10.4
