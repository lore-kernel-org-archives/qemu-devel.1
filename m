Received: from eggs.gnu.org ([2001:4830:134:3::10]:46729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU9F-0005Q5-A6
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU9D-0005LQ-Uf
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:29 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBU9D-0005L8-MO
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:27 -0400
Received: by mail-pg0-x244.google.com with SMTP id n9so1677655pgq.5
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 16:48:27 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Apr 2018 11:45:25 +1200
Message-Id: <1524699938-6764-23-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-1-git-send-email-mjc@sifive.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 22/35] RISC-V: Use atomic_cmpxchg to update
 PLIC bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

The PLIC previously used a mutex to protect against concurrent
access to the claimed and pending bitfields. Instead of using
a mutex, we update the bitfields using atomic_cmpxchg.

Rename sifive_plic_num_irqs_pending to sifive_plic_irqs_pending
and add an early out if any interrupts are pending as the
count of pending interrupts is not used.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_plic.c         | 36 +++++++++++++++---------------------
 include/hw/riscv/sifive_plic.h |  1 -
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 874de2e..04e39e4 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -84,33 +84,28 @@ static void sifive_plic_print_state(SiFivePLICState *plic)
 static
 void sifive_plic_set_pending(SiFivePLICState *plic, int irq, bool pending)
 {
-    qemu_mutex_lock(&plic->lock);
     uint32_t word = irq >> 5;
-    if (pending) {
-        plic->pending[word] |= (1 << (irq & 31));
-    } else {
-        plic->pending[word] &= ~(1 << (irq & 31));
-    }
-    qemu_mutex_unlock(&plic->lock);
+    uint32_t old, new;
+    do {
+        old = atomic_read(&plic->pending[word]);
+        new = (old & ~(1 << (irq & 31))) | (-!!pending & (1 << (irq & 31)));
+    } while (atomic_cmpxchg(&plic->pending[word], old, new) != old);
 }
 
 static
 void sifive_plic_set_claimed(SiFivePLICState *plic, int irq, bool claimed)
 {
-    qemu_mutex_lock(&plic->lock);
     uint32_t word = irq >> 5;
-    if (claimed) {
-        plic->claimed[word] |= (1 << (irq & 31));
-    } else {
-        plic->claimed[word] &= ~(1 << (irq & 31));
-    }
-    qemu_mutex_unlock(&plic->lock);
+    uint32_t old, new;
+    do {
+        old = atomic_read(&plic->claimed[word]);
+        new = (old & ~(1 << (irq & 31))) | (-!!claimed & (1 << (irq & 31)));
+    } while (atomic_cmpxchg(&plic->claimed[word], old, new) != old);
 }
 
-static
-int sifive_plic_num_irqs_pending(SiFivePLICState *plic, uint32_t addrid)
+static int sifive_plic_irqs_pending(SiFivePLICState *plic, uint32_t addrid)
 {
-    int i, j, count = 0;
+    int i, j;
     for (i = 0; i < plic->bitfield_words; i++) {
         uint32_t pending_enabled_not_claimed =
             (plic->pending[i] & ~plic->claimed[i]) &
@@ -123,11 +118,11 @@ int sifive_plic_num_irqs_pending(SiFivePLICState *plic, uint32_t addrid)
             uint32_t prio = plic->source_priority[irq];
             int enabled = pending_enabled_not_claimed & (1 << j);
             if (enabled && prio > plic->target_priority[addrid]) {
-                count++;
+                return 1;
             }
         }
     }
-    return count;
+    return 0;
 }
 
 static void sifive_plic_update(SiFivePLICState *plic)
@@ -143,7 +138,7 @@ static void sifive_plic_update(SiFivePLICState *plic)
         if (!env) {
             continue;
         }
-        int level = sifive_plic_num_irqs_pending(plic, addrid) > 0;
+        int level = sifive_plic_irqs_pending(plic, addrid);
         switch (mode) {
         case PLICMode_M:
             riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_MEIP, level);
@@ -440,7 +435,6 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&plic->mmio, OBJECT(dev), &sifive_plic_ops, plic,
                           TYPE_SIFIVE_PLIC, plic->aperture_size);
     parse_hart_config(plic);
-    qemu_mutex_init(&plic->lock);
     plic->bitfield_words = (plic->num_sources + 31) >> 5;
     plic->source_priority = g_new0(uint32_t, plic->num_sources);
     plic->target_priority = g_new(uint32_t, plic->num_addrs);
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
index 11a5a98..ff09a28 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -55,7 +55,6 @@ typedef struct SiFivePLICState {
     uint32_t *pending;
     uint32_t *claimed;
     uint32_t *enable;
-    QemuMutex lock;
     qemu_irq *irqs;
 
     /* config */
-- 
2.7.0
