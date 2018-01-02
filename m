Received: from eggs.gnu.org ([2001:4830:134:3::10]:58709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eWSMi-0003KE-BG
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 14:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eWSMf-0000OY-8P
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 14:36:48 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue,  2 Jan 2018 11:36:18 -0800
Message-Id: <20180102193622.27215-8-andrew.smirnov@gmail.com>
In-Reply-To: <20180102193622.27215-1-andrew.smirnov@gmail.com>
References: <20180102193622.27215-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 07/11] imx_fec: Emulate SHIFT16 in ENETx_RACC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

Needed to support latest Linux kernel driver which relies on that
functionality.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/net/imx_fec.c         | 23 +++++++++++++++++++++++
 include/hw/net/imx_fec.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 6feda18742..825c879a28 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1037,6 +1037,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
     uint8_t *crc_ptr;
     unsigned int buf_len;
     size_t size = len;
+    bool shift16 = s->regs[ENET_RACC] & ENET_RACC_SHIFT16;
 
     FEC_PRINTF("len %d\n", (int)size);
 
@@ -1051,6 +1052,10 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
     crc = cpu_to_be32(crc32(~0, buf, size));
     crc_ptr = (uint8_t *) &crc;
 
+    if (shift16) {
+        size += 2;
+    }
+
     /* Huge frames are truncted.  */
     if (size > s->regs[ENET_FTRL]) {
         size = s->regs[ENET_FTRL];
@@ -1087,6 +1092,24 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
             buf_len += size - 4;
         }
         buf_addr = bd.data;
+
+        if (shift16) {
+            /*
+             * If SHIFT16 bit of ENETx_RACC register is set we need to
+             * align the payload to 4-byte boundary.
+             */
+            const uint8_t zeros[2] = { 0 };
+
+            dma_memory_write(&address_space_memory, buf_addr,
+                             zeros, sizeof(zeros));
+
+            buf_addr += sizeof(zeros);
+            buf_len  -= sizeof(zeros);
+
+            /* We only do this once per Ethernet frame */
+            shift16 = false;
+        }
+
         dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
         buf += buf_len;
         if (size < 4) {
diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index a390d704a6..af0840a0fa 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -170,6 +170,8 @@
 #define ENET_TWFR_TFWR_LENGTH  (6)
 #define ENET_TWFR_STRFWD       (1 << 8)
 
+#define ENET_RACC_SHIFT16      BIT(7)
+
 /* Buffer Descriptor.  */
 typedef struct {
     uint16_t length;
-- 
2.14.3
