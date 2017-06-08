Received: from eggs.gnu.org ([2001:4830:134:3::10]:47333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2Vb-0005oP-1r
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2VZ-0001Po-EK
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:15 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dJ2VZ-0001Oi-4m
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:13 -0400
Received: by mail-wm0-x242.google.com with SMTP id d17so3821402wme.3
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 11:50:12 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu,  8 Jun 2017 21:49:41 +0300
Message-Id: <20170608184944.19406-7-mrolnik@gmail.com>
In-Reply-To: <20170608184944.19406-1-mrolnik@gmail.com>
References: <20170608184944.19406-1-mrolnik@gmail.com>
Subject: [Qemu-devel] [PATCH RFC v19 06/13] target-avr: adding helpers for
 IN, OUT, SLEEP, WBR & unsupported instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anichang@protonmail.ch, Michael Rolnik <mrolnik@gmail.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <1471522070-77598-7-git-send-email-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/avr/cpu.h       |  10 +++
 target/avr/helper.c    | 216 ++++++++++++++++++++++++++++++++++++++++++++++++-
 target/avr/helper.h    |   7 ++
 target/avr/translate.c |   8 ++
 4 files changed, 239 insertions(+), 2 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 54dc58c0df..92143244f7 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -139,6 +139,7 @@ struct CPUAVRState {
     uint32_t sp; /* 16 bits */
 
     uint64_t intsrc; /* interrupt sources */
+    bool fullacc;/* CPU/MEM if true MEM only otherwise */
 
     uint32_t features;
 
@@ -181,6 +182,10 @@ int avr_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
 int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *buf,
                                 int len, bool is_write);
 
+enum {
+    TB_FLAGS_FULL_ACCESS = 1,
+};
+
 static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong *pc,
                                 target_ulong *cs_base, uint32_t *pflags)
 {
@@ -188,6 +193,11 @@ static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong *pc,
 
     *pc = env->pc_w * 2;
     *cs_base = 0;
+
+    if (env->fullacc) {
+        flags |= TB_FLAGS_FULL_ACCESS;
+    }
+
     *pflags = flags;
 }
 
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 61255fdff3..bc53053a57 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -28,6 +28,7 @@
 #include "exec/cpu_ldst.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
+#include "exec/ioport.h"
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
@@ -79,11 +80,11 @@ void avr_cpu_do_interrupt(CPUState *cs)
 
     if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
         cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
-        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >>  8);
+        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
         cpu_stb_data(env, env->sp--, (ret & 0xff0000) >> 16);
     } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
         cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
-        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >>  8);
+        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
     } else {
         cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
     }
@@ -126,7 +127,19 @@ void tlb_fill(CPUState *cs, target_ulong vaddr, MMUAccessType access_type,
     if (mmu_idx == MMU_CODE_IDX) {
         paddr = PHYS_BASE_CODE + vaddr - VIRT_BASE_CODE;
         prot = PAGE_READ | PAGE_EXEC;
+    } else if (vaddr - VIRT_BASE_REGS < AVR_REGS) {
+        /*
+         * this is a write into CPU registers, exit and rebuilt this TB
+         * to use full write
+         */
+        AVRCPU *cpu = AVR_CPU(cs);
+        CPUAVRState *env = &cpu->env;
+        env->fullacc = 1;
+        cpu_loop_exit_restore(cs, retaddr);
     } else {
+        /*
+         * this is a write into memory. nothing special
+         */
         paddr = PHYS_BASE_DATA + vaddr - VIRT_BASE_DATA;
         prot = PAGE_READ | PAGE_WRITE;
     }
@@ -134,6 +147,30 @@ void tlb_fill(CPUState *cs, target_ulong vaddr, MMUAccessType access_type,
     tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, prot, mmu_idx, page_size);
 }
 
+void helper_sleep(CPUAVRState *env)
+{
+    CPUState *cs = CPU(avr_env_get_cpu(env));
+
+    cs->exception_index = EXCP_HLT;
+    cpu_loop_exit(cs);
+}
+
+void helper_unsupported(CPUAVRState *env)
+{
+    CPUState *cs = CPU(avr_env_get_cpu(env));
+
+    /*
+     *  I count not find what happens on the real platform, so
+     *  it's EXCP_DEBUG for meanwhile
+     */
+    cs->exception_index = EXCP_DEBUG;
+    if (qemu_loglevel_mask(LOG_UNIMP)) {
+        qemu_log("UNSUPPORTED\n");
+        cpu_dump_state(cs, qemu_logfile, fprintf, 0);
+    }
+    cpu_loop_exit(cs);
+}
+
 void helper_debug(CPUAVRState *env)
 {
     CPUState *cs = CPU(avr_env_get_cpu(env));
@@ -141,3 +178,178 @@ void helper_debug(CPUAVRState *env)
     cs->exception_index = EXCP_DEBUG;
     cpu_loop_exit(cs);
 }
+
+void helper_wdr(CPUAVRState *env)
+{
+    CPUState *cs = CPU(avr_env_get_cpu(env));
+
+    /* WD is not implemented yet, placeholder */
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
+
+/*
+ * This function implements IN instruction
+ *
+ * It does the following
+ * a.  if an IO register belongs to CPU, its value is read and returned
+ * b.  otherwise io address is translated to mem address and physical memory
+ *     is read.
+ * c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementation
+ *
+ */
+target_ulong helper_inb(CPUAVRState *env, uint32_t port)
+{
+    target_ulong data = 0;
+
+    switch (port) {
+    case 0x38: /* RAMPD */
+        data = 0xff & (env->rampD >> 16);
+        break;
+    case 0x39: /* RAMPX */
+        data = 0xff & (env->rampX >> 16);
+        break;
+    case 0x3a: /* RAMPY */
+        data = 0xff & (env->rampY >> 16);
+        break;
+    case 0x3b: /* RAMPZ */
+        data = 0xff & (env->rampZ >> 16);
+        break;
+    case 0x3c: /* EIND */
+        data = 0xff & (env->eind >> 16);
+        break;
+    case 0x3d: /* SPL */
+        data = env->sp & 0x00ff;
+        break;
+    case 0x3e: /* SPH */
+        data = env->sp >> 8;
+        break;
+    case 0x3f: /* SREG */
+        data = cpu_get_sreg(env);
+        break;
+    default:
+        /*
+         * CPU does not know how to read this register, pass it to the
+         * device/board
+         */
+        cpu_physical_memory_read(PHYS_BASE_REGS + port + AVR_CPU_IO_REGS_BASE,
+                                 &data, 1);
+    }
+
+    return data;
+}
+
+/*
+ *  This function implements OUT instruction
+ *
+ *  It does the following
+ *  a.  if an IO register belongs to CPU, its value is written into the register
+ *  b.  otherwise io address is translated to mem address and physical memory
+ *      is written.
+ *  c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementation
+ *
+ */
+void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
+{
+    data &= 0x000000ff;
+
+    switch (port) {
+    case 0x04:
+        {
+            CPUState *cpu = CPU(avr_env_get_cpu(env));
+            qemu_irq irq = qdev_get_gpio_in(DEVICE(cpu), 3);
+            qemu_set_irq(irq, 1);
+        }
+        break;
+    case 0x38: /* RAMPD */
+        if (avr_feature(env, AVR_FEATURE_RAMPD)) {
+            env->rampD = (data & 0xff) << 16;
+        }
+        break;
+    case 0x39: /* RAMPX */
+        if (avr_feature(env, AVR_FEATURE_RAMPX)) {
+            env->rampX = (data & 0xff) << 16;
+        }
+        break;
+    case 0x3a: /* RAMPY */
+        if (avr_feature(env, AVR_FEATURE_RAMPY)) {
+            env->rampY = (data & 0xff) << 16;
+        }
+        break;
+    case 0x3b: /* RAMPZ */
+        if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
+            env->rampZ = (data & 0xff) << 16;
+        }
+        break;
+    case 0x3c: /* EIDN */
+        env->eind = (data & 0xff) << 16;
+        break;
+    case 0x3d: /* SPL */
+        env->sp = (env->sp & 0xff00) | (data);
+        break;
+    case 0x3e: /* SPH */
+        if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
+            env->sp = (env->sp & 0x00ff) | (data << 8);
+        }
+        break;
+    case 0x3f: /* SREG */
+        cpu_set_sreg(env, data);
+        break;
+    default:
+        /*
+         * CPU does not know how to write this register, pass it to the
+         * device/board
+         */
+        cpu_physical_memory_write(PHYS_BASE_REGS + port + AVR_CPU_IO_REGS_BASE,
+                                  &data, 1);
+    }
+}
+
+/*
+ *  this function implements LD instruction when there is a posibility to read
+ *  from a CPU register
+ */
+target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
+{
+    uint8_t data;
+
+    env->fullacc = false;
+    switch (addr) {
+    case AVR_CPU_REGS_BASE ... AVR_CPU_REGS_LAST:
+        /* CPU registers */
+        data = env->r[addr - AVR_CPU_REGS_BASE];
+        break;
+    case AVR_CPU_IO_REGS_BASE ... AVR_CPU_IO_REGS_LAST:
+        /* CPU IO registers */
+        data = helper_inb(env, addr);
+        break;
+    default:
+        /* memory */
+        cpu_physical_memory_read(PHYS_BASE_DATA + addr - VIRT_BASE_DATA,
+                                 &data, 1);
+    }
+    return data;
+}
+
+/*
+ *  this function implements LD instruction when there is a posibility to write
+ *  into a CPU register
+ */
+void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
+{
+    env->fullacc = false;
+    switch (addr) {
+    case AVR_CPU_REGS_BASE ... AVR_CPU_REGS_LAST:
+        /* CPU registers */
+        env->r[addr - AVR_CPU_REGS_BASE] = data;
+        break;
+    case AVR_CPU_IO_REGS_BASE ... AVR_CPU_IO_REGS_LAST:
+        /* CPU IO registers */
+        helper_outb(env, data, addr);
+        break;
+    default:
+        /* memory */
+        cpu_physical_memory_write(PHYS_BASE_DATA + addr - VIRT_BASE_DATA,
+                                  &data, 1);
+    }
+}
diff --git a/target/avr/helper.h b/target/avr/helper.h
index b5ef3bfb93..603631520a 100644
--- a/target/avr/helper.h
+++ b/target/avr/helper.h
@@ -18,4 +18,11 @@
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
 
+DEF_HELPER_1(wdr, void, env)
 DEF_HELPER_1(debug, void, env)
+DEF_HELPER_1(sleep, void, env)
+DEF_HELPER_1(unsupported, void, env)
+DEF_HELPER_3(outb, void, env, i32, i32)
+DEF_HELPER_2(inb, tl, env, i32)
+DEF_HELPER_3(fullwr, void, env, i32, i32)
+DEF_HELPER_2(fullrd, tl, env, i32)
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 7926b7162f..daf4a6afc7 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -128,6 +128,14 @@ void gen_intermediate_code(CPUAVRState *env, struct TranslationBlock *tb)
     if (max_insns > TCG_MAX_INSNS) {
         max_insns = TCG_MAX_INSNS;
     }
+    if (tb->flags & TB_FLAGS_FULL_ACCESS) {
+        /*
+            this flag is set by ST/LD instruction
+            we will regenerate it ONLY with mem/cpu memory access
+            instead of mem access
+        */
+        max_insns = 1;
+    }
 
     gen_tb_start(tb);
 
-- 
2.11.0 (Apple Git-81)
