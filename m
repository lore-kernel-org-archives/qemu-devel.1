Received: from eggs.gnu.org ([209.51.188.92]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCCtQ-0002fj-Cf
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCCtP-00034s-3k
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:40 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hCCtO-00031F-QQ
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:39 -0400
Received: by mail-pf1-x444.google.com with SMTP id i17so2258616pfo.6
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 17:39:38 -0700 (PDT)
Date: Thu,  4 Apr 2019 17:39:23 -0700
Message-Id: <20190405003924.1906-2-palmer@sifive.com>
In-Reply-To: <20190405003924.1906-1-palmer@sifive.com>
References: <20190405003924.1906-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 1/2] riscv: plic: Fix incorrect irq calculation
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

This patch fixes four different things, to maintain bisectability they
have been merged into a single patch. The following fixes are below:

sifive_plic: Fix incorrect irq calculation
The irq is incorrectly calculated to be off by one. It has worked in the
past as the priority_base offset has also been set incorrectly. We are
about to fix the priority_base offset so first first the irq
calculation.

sifive_u: Fix PLIC priority base offset and numbering
According to the FU540 manual the PLIC source priority address starts at
an offset of 0x04 and not 0x00. The same manual also specifies that the
PLIC only has 53 source priorities. Fix these two incorrect header
files.

We also need to over extend the plic_gpios[] array as the PLIC sources
count from 1 and not 0.

riscv: sifive_e: Fix PLIC priority base offset
According to the FE31 manual the PLIC source priority address starts at
an offset of 0x04 and not 0x00.

riscv: virt: Fix PLIC priority base offset
Update the virt offsets based on the newly updated SiFive U and SiFive E
offsets.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_plic.c      | 4 ++--
 include/hw/riscv/sifive_e.h | 2 +-
 include/hw/riscv/sifive_u.h | 4 ++--
 include/hw/riscv/virt.h     | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index ac768e6c27f8..0315e035e5fb 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -207,7 +207,7 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
     if (addr >= plic->priority_base && /* 4 bytes per source */
         addr < plic->priority_base + (plic->num_sources << 2))
     {
-        uint32_t irq = (addr - plic->priority_base) >> 2;
+        uint32_t irq = ((addr - plic->priority_base) >> 2) + 1;
         if (RISCV_DEBUG_PLIC) {
             qemu_log("plic: read priority: irq=%d priority=%d\n",
                 irq, plic->source_priority[irq]);
@@ -280,7 +280,7 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
     if (addr >= plic->priority_base && /* 4 bytes per source */
         addr < plic->priority_base + (plic->num_sources << 2))
     {
-        uint32_t irq = (addr - plic->priority_base) >> 2;
+        uint32_t irq = ((addr - plic->priority_base) >> 2) + 1;
         plic->source_priority[irq] = value & 7;
         if (RISCV_DEBUG_PLIC) {
             qemu_log("plic: write priority: irq=%d priority=%d\n",
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 7b6d8aed968f..f715f8606fa6 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -70,7 +70,7 @@ enum {
 #define SIFIVE_E_PLIC_HART_CONFIG "M"
 #define SIFIVE_E_PLIC_NUM_SOURCES 127
 #define SIFIVE_E_PLIC_NUM_PRIORITIES 7
-#define SIFIVE_E_PLIC_PRIORITY_BASE 0x0
+#define SIFIVE_E_PLIC_PRIORITY_BASE 0x04
 #define SIFIVE_E_PLIC_PENDING_BASE 0x1000
 #define SIFIVE_E_PLIC_ENABLE_BASE 0x2000
 #define SIFIVE_E_PLIC_ENABLE_STRIDE 0x80
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index be13cc1304cc..892f0eee21bc 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -68,9 +68,9 @@ enum {
 };
 
 #define SIFIVE_U_PLIC_HART_CONFIG "MS"
-#define SIFIVE_U_PLIC_NUM_SOURCES 127
+#define SIFIVE_U_PLIC_NUM_SOURCES 54
 #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
-#define SIFIVE_U_PLIC_PRIORITY_BASE 0x0
+#define SIFIVE_U_PLIC_PRIORITY_BASE 0x04
 #define SIFIVE_U_PLIC_PENDING_BASE 0x1000
 #define SIFIVE_U_PLIC_ENABLE_BASE 0x2000
 #define SIFIVE_U_PLIC_ENABLE_STRIDE 0x80
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index f12deaebd697..568764b57088 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -59,7 +59,7 @@ enum {
 #define VIRT_PLIC_HART_CONFIG "MS"
 #define VIRT_PLIC_NUM_SOURCES 127
 #define VIRT_PLIC_NUM_PRIORITIES 7
-#define VIRT_PLIC_PRIORITY_BASE 0x0
+#define VIRT_PLIC_PRIORITY_BASE 0x04
 #define VIRT_PLIC_PENDING_BASE 0x1000
 #define VIRT_PLIC_ENABLE_BASE 0x2000
 #define VIRT_PLIC_ENABLE_STRIDE 0x80
-- 
2.19.2
