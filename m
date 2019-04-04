Received: from eggs.gnu.org ([209.51.188.92]:40460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hBqkT-0008Su-HR
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hBqkR-0005ab-Dm
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:00:57 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:41352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hBqkL-0005U8-O4
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:00:51 -0400
Received: by mail-pl1-x635.google.com with SMTP id d1so264845plj.8
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 18:00:48 -0700 (PDT)
Date: Wed,  3 Apr 2019 17:55:23 -0700
Message-Id: <20190404005523.6513-3-palmer@sifive.com>
In-Reply-To: <20190404005523.6513-1-palmer@sifive.com>
References: <20190404005523.6513-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 2/2] riscv: plic: Log guest errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Instead of using error_report() to print guest errors let's use
qemu_log_mask(LOG_GUEST_ERROR,...) to log the error.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_plic.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 70a85cd07578..7f373d6c9d2c 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -262,7 +262,9 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
     }
 
 err:
-    error_report("plic: invalid register read: %08x", (uint32_t)addr);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: Invalid register read 0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
     return 0;
 }
 
@@ -289,7 +291,9 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
     } else if (addr >= plic->pending_base && /* 1 bit per source */
                addr < plic->pending_base + (plic->num_sources >> 3))
     {
-        error_report("plic: invalid pending write: %08x", (uint32_t)addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid pending write: 0x%" HWADDR_PRIx "",
+                      __func__, addr);
         return;
     } else if (addr >= plic->enable_base && /* 1 bit per source */
         addr < plic->enable_base + plic->num_addrs * plic->enable_stride)
@@ -339,7 +343,9 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
     }
 
 err:
-    error_report("plic: invalid register write: %08x", (uint32_t)addr);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: Invalid register write 0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
 }
 
 static const MemoryRegionOps sifive_plic_ops = {
-- 
2.19.2
