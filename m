Received: from eggs.gnu.org ([2001:4830:134:3::10]:36227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ffk0l-0003Lj-Ty
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ffk0i-0007jV-Os
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:48:47 -0400
Received: from ssl.serverraum.org ([2a01:4f8:151:8464::1:2]:35585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1ffk0i-0007it-C5
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:48:44 -0400
From: Michael Walle <michael@walle.cc>
Date: Wed, 18 Jul 2018 12:48:34 +0200
Message-Id: <20180718104836.18488-1-michael@walle.cc>
Subject: [Qemu-devel] [PATCH 1/3] milkymist-pfpu: more accurate emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Walle <michael@walle.cc>

Emulate write collisions, stray writes and microcode which has no VECTOUT
opcode. Although the latter was supported before, the emulation was
incorrect.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 hw/misc/milkymist-pfpu.c | 105 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 30 deletions(-)

diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 86f5e383b0..1548e054b7 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -1,7 +1,7 @@
 /*
  *  QEMU model of the Milkymist programmable FPU.
  *
- *  Copyright (c) 2010 Michael Walle <michael@walle.cc>
+ *  Copyright (c) 2010-2018 Michael Walle <michael@walle.cc>
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -121,6 +121,12 @@ static const char *opcode_to_str[] = {
 #define MILKYMIST_PFPU(obj) \
     OBJECT_CHECK(MilkymistPFPUState, (obj), TYPE_MILKYMIST_PFPU)
 
+struct OutputQueueEntry {
+    bool valid;
+    uint32_t value;
+};
+typedef struct OutputQueueEntry OutputQueueEntry;
+
 struct MilkymistPFPUState {
     SysBusDevice parent_obj;
 
@@ -133,7 +139,7 @@ struct MilkymistPFPUState {
     uint32_t microcode[MICROCODE_WORDS];
 
     int output_queue_pos;
-    uint32_t output_queue[MAX_LATENCY];
+    OutputQueueEntry output_queue[MAX_LATENCY];
 };
 typedef struct MilkymistPFPUState MilkymistPFPUState;
 
@@ -146,26 +152,37 @@ get_dma_address(uint32_t base, uint32_t x, uint32_t y)
 static inline void
 output_queue_insert(MilkymistPFPUState *s, uint32_t val, int pos)
 {
-    s->output_queue[(s->output_queue_pos + pos) % MAX_LATENCY] = val;
+    pos = (s->output_queue_pos + pos) % MAX_LATENCY;
+
+    /* if this output is already set, we have a collision */
+    if (s->output_queue[pos].valid == true) {
+        s->regs[R_COLLISIONS]++;
+    }
+    s->output_queue[pos].value = val;
+    s->output_queue[pos].valid = true;
 }
 
 static inline uint32_t
-output_queue_remove(MilkymistPFPUState *s)
+output_queue_get(MilkymistPFPUState *s)
 {
-    return s->output_queue[s->output_queue_pos];
+    return s->output_queue[s->output_queue_pos].value;
+}
+
+static inline bool
+output_queue_valid(MilkymistPFPUState *s)
+{
+    return s->output_queue[s->output_queue_pos].valid;
 }
 
 static inline void
 output_queue_advance(MilkymistPFPUState *s)
 {
-    s->output_queue[s->output_queue_pos] = 0;
+    s->output_queue[s->output_queue_pos].valid = false;
     s->output_queue_pos = (s->output_queue_pos + 1) % MAX_LATENCY;
 }
 
-static int pfpu_decode_insn(MilkymistPFPUState *s)
+static int pfpu_decode_insn(MilkymistPFPUState *s, uint32_t insn)
 {
-    uint32_t pc = s->regs[R_PC];
-    uint32_t insn = s->microcode[pc];
     uint32_t reg_a = (insn >> 18) & 0x7f;
     uint32_t reg_b = (insn >> 11) & 0x7f;
     uint32_t op = (insn >> 7) & 0xf;
@@ -237,7 +254,8 @@ static int pfpu_decode_insn(MilkymistPFPUState *s)
         cpu_physical_memory_write(dma_ptr, &a, 4);
         cpu_physical_memory_write(dma_ptr + 4, &b, 4);
         s->regs[R_LASTDMA] = dma_ptr + 4;
-        D_EXEC(qemu_log("VECTOUT a=%08x b=%08x dma=%08x\n", a, b, dma_ptr));
+        D_EXEC(qemu_log("VECTOUT a=%08x b=%08x dma=%08" HWADDR_PRIx "\n",
+                    a, b, dma_ptr));
         trace_milkymist_pfpu_vectout(a, b, dma_ptr);
     } break;
     case OP_SIN:
@@ -327,10 +345,13 @@ static int pfpu_decode_insn(MilkymistPFPUState *s)
     }
 
     /* store output for this cycle */
-    if (reg_d) {
-        uint32_t val = output_queue_remove(s);
+    if (output_queue_valid(s)) {
+        uint32_t val = output_queue_get(s);
         D_EXEC(qemu_log("R%03d <- 0x%08x\n", reg_d, val));
         s->gp_regs[reg_d] = val;
+        if (!reg_d) {
+            s->regs[R_STRAYWRITES]++;
+        }
     }
 
     output_queue_advance(s);
@@ -340,16 +361,21 @@ static int pfpu_decode_insn(MilkymistPFPUState *s)
         output_queue_insert(s, r, latency-1);
     }
 
-    /* advance PC */
-    s->regs[R_PC]++;
-
     return 1;
 };
 
 static void pfpu_start(MilkymistPFPUState *s)
 {
     int x, y;
-    int i;
+    int running;
+
+    /* indicate we are running */
+    s->regs[R_CTL] = CTL_START_BUSY;
+
+    /* starting the PFPU also clears some registers */
+    s->regs[R_VERTICES] = 0;
+    s->regs[R_COLLISIONS] = 0;
+    s->regs[R_STRAYWRITES] = 0;
 
     for (y = 0; y <= s->regs[R_VMESHLAST]; y++) {
         for (x = 0; x <= s->regs[R_HMESHLAST]; x++) {
@@ -359,23 +385,30 @@ static void pfpu_start(MilkymistPFPUState *s)
             s->gp_regs[GPR_X] = x;
             s->gp_regs[GPR_Y] = y;
 
-            /* run microcode on this position */
-            i = 0;
-            while (pfpu_decode_insn(s)) {
-                /* decode at most MICROCODE_WORDS instructions */
-                if (++i >= MICROCODE_WORDS) {
-                    error_report("milkymist_pfpu: too many instructions "
-                            "executed in microcode. No VECTOUT?");
-                    break;
-                }
+            /* reset pc */
+            s->regs[R_PC] = 0;
+
+            /* Run microcode. We decode at most MICROCODE_WORDS instructions,
+             * because there are no branches. The real hardware will spin
+             * endlessly if there is no VECTOUT instruction. */
+            do {
+                uint32_t insn = s->microcode[s->regs[R_PC]];
+                running = pfpu_decode_insn(s, insn);
+                s->regs[R_PC]++;
+            } while (running && (s->regs[R_PC] < MICROCODE_WORDS));
+
+            /* if there was no VECTOUT instructions, we just return and thus
+             * keeping the busy flag set */
+            if (running) {
+                return;
             }
 
-            /* reset pc for next run */
-            s->regs[R_PC] = 0;
+            s->regs[R_VERTICES]++;
         }
     }
 
-    s->regs[R_VERTICES] = x * y;
+    /* we are done */
+    s->regs[R_CTL] = 0;
 
     trace_milkymist_pfpu_pulse_irq();
     qemu_irq_pulse(s->irq);
@@ -493,7 +526,7 @@ static void milkymist_pfpu_reset(DeviceState *d)
     }
     s->output_queue_pos = 0;
     for (i = 0; i < MAX_LATENCY; i++) {
-        s->output_queue[i] = 0;
+        s->output_queue[i].valid = false;
     }
 }
 
@@ -510,6 +543,17 @@ static int milkymist_pfpu_init(SysBusDevice *dev)
     return 0;
 }
 
+static const VMStateDescription vmstate_output_queue_entry = {
+    .name = "milkymist-pfpu-output-queue-entry",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(valid, OutputQueueEntry),
+        VMSTATE_UINT32(value, OutputQueueEntry),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_milkymist_pfpu = {
     .name = "milkymist-pfpu",
     .version_id = 1,
@@ -519,7 +563,8 @@ static const VMStateDescription vmstate_milkymist_pfpu = {
         VMSTATE_UINT32_ARRAY(gp_regs, MilkymistPFPUState, 128),
         VMSTATE_UINT32_ARRAY(microcode, MilkymistPFPUState, MICROCODE_WORDS),
         VMSTATE_INT32(output_queue_pos, MilkymistPFPUState),
-        VMSTATE_UINT32_ARRAY(output_queue, MilkymistPFPUState, MAX_LATENCY),
+        VMSTATE_STRUCT_ARRAY(output_queue, MilkymistPFPUState, MAX_LATENCY, 1,
+                vmstate_output_queue_entry, OutputQueueEntry),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.11.0
