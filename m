Received: from eggs.gnu.org ([209.51.188.92]:39085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIfe-0002aF-9o
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY2-0006hS-OE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:06:56 -0400
Received: from m12-14.163.com ([220.181.12.14]:54537)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY1-0006fH-8q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:06:54 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 24 Apr 2019 07:06:41 -0700
Message-Id: <20190424140643.62457-4-liq3ea@163.com>
In-Reply-To: <20190424140643.62457-1-liq3ea@163.com>
References: <20190424140643.62457-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2 3/5] fw_cfg: reboot: store reboot-timeout as
 little endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com, thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

So that if the guest and host endianess does not match it
can still work as expection.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/nvram/fw_cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 5c3a46ce6f..df4242fc9c 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -178,6 +178,7 @@ static void fw_cfg_reboot(FWCfgState *s)
 {
     const char *reboot_timeout = NULL;
     int64_t rt_val = -1;
+    uint32_t rt_le32;
 
     /* get user configuration */
     QemuOptsList *plist = qemu_find_opts("boot-opts");
@@ -194,7 +195,8 @@ static void fw_cfg_reboot(FWCfgState *s)
         }
     }
 
-    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_val, 4), 4);
+    rt_le32 = cpu_to_le32(rt_val);
+    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_le32, 4), 4);
 }
 
 static void fw_cfg_write(FWCfgState *s, uint8_t value)
-- 
2.17.1
