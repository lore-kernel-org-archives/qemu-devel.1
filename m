Received: from eggs.gnu.org ([2001:4830:134:3::10]:36677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI6BB-0005Xn-Ti
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI6B7-0003Z6-0b
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:10:05 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gI6B6-0003Yq-Qe
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:10:00 -0400
Received: by mail-pg1-x544.google.com with SMTP id z17-v6so8524088pgv.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 23:10:00 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 31 Oct 2018 23:09:54 -0700
Message-Id: <1541052594-29132-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] hw: fw_cfg: ensure reboot_time is
 nonegative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, armbru@redhat.com, philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

This can avoid setting a negative value to
etc/boot-fail-wait.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/nvram/fw_cfg.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 3fcfa35..dff6e06 100644
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
