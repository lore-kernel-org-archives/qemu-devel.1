Received: from eggs.gnu.org ([209.51.188.92]:49611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCCtS-0002gZ-1z
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCCtR-0003G8-3e
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:42 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:40621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hCCtQ-00039e-Qr
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:41 -0400
Received: by mail-pg1-x52a.google.com with SMTP id u9so2078189pgo.7
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 17:39:40 -0700 (PDT)
Date: Thu,  4 Apr 2019 17:39:24 -0700
Message-Id: <20190405003924.1906-3-palmer@sifive.com>
In-Reply-To: <20190405003924.1906-1-palmer@sifive.com>
References: <20190405003924.1906-1-palmer@sifive.com>
MIME-Version: 1.0
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
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_plic.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 0315e035e5fb..07a032d93d2e 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -263,7 +263,9 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
     }
 
 err:
-    error_report("plic: invalid register read: %08x", (uint32_t)addr);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: Invalid register read 0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
     return 0;
 }
 
@@ -290,7 +292,9 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
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
@@ -340,7 +344,9 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
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
