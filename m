Received: from eggs.gnu.org ([2001:4830:134:3::10]:60389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fzxaj-0003jq-M1
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 01:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fzxXA-0007dg-Nn
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 01:17:52 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fzxXA-0007dU-HR
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 01:17:48 -0400
Received: by mail-pg1-x541.google.com with SMTP id 2-v6so414743pgo.4
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 22:17:48 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 11 Sep 2018 22:17:41 -0700
Message-Id: <1536729461-2692-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] fw_cfg_mem: add read memory region callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, ehabkost@redhat.com, lersek@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

The write/read should be paired, this can avoid the
NULL-deref while the guest reads the fw_cfg port.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/nvram/fw_cfg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index d79a568f54..6de7809f1a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -434,6 +434,11 @@ static bool fw_cfg_data_mem_valid(void *opaque, hwaddr addr,
     return addr == 0;
 }
 
+static uint64_t fw_cfg_ctl_mem_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
 static void fw_cfg_ctl_mem_write(void *opaque, hwaddr addr,
                                  uint64_t value, unsigned size)
 {
@@ -468,6 +473,7 @@ static bool fw_cfg_comb_valid(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps fw_cfg_ctl_mem_ops = {
+    .read = fw_cfg_ctl_mem_read,
     .write = fw_cfg_ctl_mem_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid.accepts = fw_cfg_ctl_mem_valid,
-- 
2.11.0
