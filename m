Received: from eggs.gnu.org ([2001:4830:134:3::10]:47692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gFDKG-0006gx-Fh
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gFDKD-0004cN-B0
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:11:32 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gFDKB-0004a6-6i
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:11:27 -0400
Received: by mail-pl1-x643.google.com with SMTP id bh10-v6so1836504plb.4
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 00:11:26 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 24 Oct 2018 00:11:20 -0700
Message-Id: <1540365080-6844-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] fw_cfg_reboot: ensure reboot_time is nonegative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lersek@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

This can avoid setting a negative value to
etc/boot-fail-wait.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/nvram/fw_cfg.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index f4a52d8..276dcb1 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -199,12 +199,17 @@ static void fw_cfg_reboot(FWCfgState *s)
             reboot_timeout = strtol(p, &p, 10);
         }
     }
-    /* validate the input */
-    if (reboot_timeout > 0xffff) {
-        error_report("reboot timeout is larger than 65535, force it to 65535.");
-        reboot_timeout = 0xffff;
+
+    if (reboot_timeout >= 0) {
+        /* validate the input */
+        if (reboot_timeout > 0xffff) {
+            error_report("reboot timeout is larger than 65535,"
+                         "force it to 65535.");
+            reboot_timeout = 0xffff;
+        }
+        fw_cfg_add_file(s, "etc/boot-fail-wait",
+                        g_memdup(&reboot_timeout, 4), 4);
     }
-    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&reboot_timeout, 4), 4);
 }
 
 static void fw_cfg_write(FWCfgState *s, uint8_t value)
-- 
1.8.3.1
