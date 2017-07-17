Received: from eggs.gnu.org ([2001:4830:134:3::10]:34464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6u-0003Ls-CS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6r-0003ie-0i
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXB6q-0003he-Qa
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:08 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Jul 2017 15:50:43 -0300
Message-Id: <20170717185051.18740-8-ehabkost@redhat.com>
In-Reply-To: <20170717185051.18740-1-ehabkost@redhat.com>
References: <20170717185051.18740-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 07/15] fw_cfg: switch fw_cfg_find() to locate
 the fw_cfg device by type rather than path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This will enable the fw_cfg device to be placed anywhere within the QOM tree
regardless of its machine location.

Note that we also add a comment to document the behaviour that we return NULL to
indicate failure where either no fw_cfg device or multiple fw_cfg devices are
found.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <1500025208-14827-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/nvram/fw_cfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index e881e3b..3a988b6 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1017,7 +1017,8 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
 
 FWCfgState *fw_cfg_find(void)
 {
-    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
+    /* Returns NULL unless there is exactly one fw_cfg device */
+    return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
 }
 
 static void fw_cfg_class_init(ObjectClass *klass, void *data)
-- 
2.9.4
