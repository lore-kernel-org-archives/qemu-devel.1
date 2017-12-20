Received: from eggs.gnu.org ([2001:4830:134:3::10]:48061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijM-0004eo-S3
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijE-0002jl-Fx
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRijD-0002i5-W2
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BF0AC0587D6
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:27 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-46.ams2.redhat.com
	[10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AA2E45B809
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:56 +0100
Message-Id: <20171220180358.29316-18-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/19] i386: hvf: remove addr_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use target_ulong for virtual addresses and uint64_t for physical
addresses.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c        |  4 ++--
 target/i386/hvf/x86.c        | 15 +++++++------
 target/i386/hvf/x86.h        | 12 +++++-----
 target/i386/hvf/x86_decode.c | 38 ++++++++++++++++----------------
 target/i386/hvf/x86_decode.h | 14 ++++++------
 target/i386/hvf/x86_emu.c    | 52 ++++++++++++++++++++++----------------------
 target/i386/hvf/x86_emu.h    | 14 ++++++------
 target/i386/hvf/x86_flags.c  | 14 ++++++------
 target/i386/hvf/x86_gen.h    |  2 --
 target/i386/hvf/x86_mmu.c    | 29 ++++++++++++------------
 target/i386/hvf/x86_mmu.h    |  6 ++---
 11 files changed, 99 insertions(+), 101 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index f7fe258a3a..75a27ad5eb 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -289,7 +289,7 @@ void hvf_cpu_synchronize_post_init(CPUState *cpu_state)
     run_on_cpu(cpu_state, _hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
 }
 
-static bool ept_emulation_fault(hvf_slot *slot, addr_t gpa, uint64_t ept_qual)
+static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
 {
     int read, write;
 
@@ -704,7 +704,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         case EXIT_REASON_EPT_FAULT:
         {
             hvf_slot *slot;
-            addr_t gpa = rvmcs(cpu->hvf_fd, VMCS_GUEST_PHYSICAL_ADDRESS);
+            uint64_t gpa = rvmcs(cpu->hvf_fd, VMCS_GUEST_PHYSICAL_ADDRESS);
 
             if (((idtvec_info & VMCS_IDT_VEC_VALID) == 0) &&
                 ((exit_qual & EXIT_QUAL_NMIUDTI) != 0)) {
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index efb28c373c..3afcedc7fc 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 
+#include "cpu.h"
 #include "qemu-common.h"
 #include "x86_decode.h"
 #include "x86_emu.h"
@@ -50,7 +51,7 @@ bool x86_read_segment_descriptor(struct CPUState *cpu,
                                  struct x86_segment_descriptor *desc,
                                  x68_segment_selector sel)
 {
-    addr_t base;
+    target_ulong base;
     uint32_t limit;
 
     memset(desc, 0, sizeof(*desc));
@@ -80,7 +81,7 @@ bool x86_write_segment_descriptor(struct CPUState *cpu,
                                   struct x86_segment_descriptor *desc,
                                   x68_segment_selector sel)
 {
-    addr_t base;
+    target_ulong base;
     uint32_t limit;
     
     if (GDT_SEL == sel.ti) {
@@ -102,7 +103,7 @@ bool x86_write_segment_descriptor(struct CPUState *cpu,
 bool x86_read_call_gate(struct CPUState *cpu, struct x86_call_gate *idt_desc,
                         int gate)
 {
-    addr_t base  = rvmcs(cpu->hvf_fd, VMCS_GUEST_IDTR_BASE);
+    target_ulong base  = rvmcs(cpu->hvf_fd, VMCS_GUEST_IDTR_BASE);
     uint32_t limit = rvmcs(cpu->hvf_fd, VMCS_GUEST_IDTR_LIMIT);
 
     memset(idt_desc, 0, sizeof(*idt_desc));
@@ -158,13 +159,13 @@ bool x86_is_pae_enabled(struct CPUState *cpu)
     return cr4 & CR4_PAE;
 }
 
-addr_t linear_addr(struct CPUState *cpu, addr_t addr, X86Seg seg)
+target_ulong linear_addr(struct CPUState *cpu, target_ulong addr, X86Seg seg)
 {
     return vmx_read_segment_base(cpu, seg) + addr;
 }
 
-addr_t linear_addr_size(struct CPUState *cpu, addr_t addr, int size,
-                        X86Seg seg)
+target_ulong linear_addr_size(struct CPUState *cpu, target_ulong addr, int size,
+                              X86Seg seg)
 {
     switch (size) {
     case 2:
@@ -179,7 +180,7 @@ addr_t linear_addr_size(struct CPUState *cpu, addr_t addr, int size,
     return linear_addr(cpu, addr, seg);
 }
 
-addr_t linear_rip(struct CPUState *cpu, addr_t rip)
+target_ulong linear_rip(struct CPUState *cpu, target_ulong rip)
 {
     return linear_addr(cpu, rip, R_CS);
 }
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index cfcb9c95cc..ae877f0022 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -289,8 +289,8 @@ typedef struct x68_segment_selector {
 } __attribute__ ((__packed__)) x68_segment_selector;
 
 typedef struct lazy_flags {
-    addr_t result;
-    addr_t auxbits;
+    target_ulong result;
+    target_ulong auxbits;
 } lazy_flags;
 
 /* Definition of hvf_x86_state is here */
@@ -381,10 +381,10 @@ bool x86_is_paging_mode(struct CPUState *cpu);
 bool x86_is_pae_enabled(struct CPUState *cpu);
 
 enum X86Seg;
-addr_t linear_addr(struct CPUState *cpu, addr_t addr, enum X86Seg seg);
-addr_t linear_addr_size(struct CPUState *cpu, addr_t addr, int size,
-                        enum X86Seg seg);
-addr_t linear_rip(struct CPUState *cpu, addr_t rip);
+target_ulong linear_addr(struct CPUState *cpu, target_ulong addr, enum X86Seg seg);
+target_ulong linear_addr_size(struct CPUState *cpu, target_ulong addr, int size,
+                              enum X86Seg seg);
+target_ulong linear_rip(struct CPUState *cpu, target_ulong rip);
 
 static inline uint64_t rdtscp(void)
 {
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 4bfd85f2df..71d0c3d115 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -64,7 +64,7 @@ uint64_t sign(uint64_t val, int size)
 static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
                                     int size)
 {
-    addr_t val = 0;
+    target_ulong val = 0;
     
     switch (size) {
     case 1:
@@ -76,7 +76,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         VM_PANIC_EX("%s invalid size %d\n", __func__, size);
         break;
     }
-    addr_t va  = linear_rip(ENV_GET_CPU(env), RIP(env)) + decode->len;
+    target_ulong va  = linear_rip(ENV_GET_CPU(env), RIP(env)) + decode->len;
     vmx_read_mem(ENV_GET_CPU(env), &val, va, size);
     decode->len += size;
     
@@ -430,7 +430,7 @@ struct decode_tbl {
     void (*decode_op4)(CPUX86State *env, struct x86_decode *decode,
                        struct x86_decode_op *op4);
     void (*decode_postfix)(CPUX86State *env, struct x86_decode *decode);
-    addr_t flags_mask;
+    uint32_t flags_mask;
 };
 
 struct decode_x87_tbl {
@@ -446,7 +446,7 @@ struct decode_x87_tbl {
     void (*decode_op2)(CPUX86State *env, struct x86_decode *decode,
                        struct x86_decode_op *op2);
     void (*decode_postfix)(CPUX86State *env, struct x86_decode *decode);
-    addr_t flags_mask;
+    uint32_t flags_mask;
 };
 
 struct decode_tbl invl_inst = {0x0, 0, 0, false, NULL, NULL, NULL, NULL,
@@ -1638,7 +1638,7 @@ struct decode_x87_tbl _x87_inst[] = {
 void calc_modrm_operand16(CPUX86State *env, struct x86_decode *decode,
                           struct x86_decode_op *op)
 {
-    addr_t ptr = 0;
+    target_ulong ptr = 0;
     X86Seg seg = R_DS;
 
     if (!decode->modrm.mod && 6 == decode->modrm.rm) {
@@ -1687,9 +1687,9 @@ calc_addr:
     }
 }
 
-addr_t get_reg_ref(CPUX86State *env, int reg, int is_extended, int size)
+target_ulong get_reg_ref(CPUX86State *env, int reg, int is_extended, int size)
 {
-    addr_t ptr = 0;
+    target_ulong ptr = 0;
     int which = 0;
 
     if (is_extended) {
@@ -1701,32 +1701,32 @@ addr_t get_reg_ref(CPUX86State *env, int reg, int is_extended, int size)
     case 1:
         if (is_extended || reg < 4) {
             which = 1;
-            ptr = (addr_t)&RL(env, reg);
+            ptr = (target_ulong)&RL(env, reg);
         } else {
             which = 2;
-            ptr = (addr_t)&RH(env, reg - 4);
+            ptr = (target_ulong)&RH(env, reg - 4);
         }
         break;
     default:
         which = 3;
-        ptr = (addr_t)&RRX(env, reg);
+        ptr = (target_ulong)&RRX(env, reg);
         break;
     }
     return ptr;
 }
 
-addr_t get_reg_val(CPUX86State *env, int reg, int is_extended, int size)
+target_ulong get_reg_val(CPUX86State *env, int reg, int is_extended, int size)
 {
-    addr_t val = 0;
+    target_ulong val = 0;
     memcpy(&val, (void *)get_reg_ref(env, reg, is_extended, size), size);
     return val;
 }
 
-static addr_t get_sib_val(CPUX86State *env, struct x86_decode *decode,
+static target_ulong get_sib_val(CPUX86State *env, struct x86_decode *decode,
                           X86Seg *sel)
 {
-    addr_t base = 0;
-    addr_t scaled_index = 0;
+    target_ulong base = 0;
+    target_ulong scaled_index = 0;
     int addr_size = decode->addressing_size;
     int base_reg = decode->sib.base;
     int index_reg = decode->sib.index;
@@ -1758,7 +1758,7 @@ void calc_modrm_operand32(CPUX86State *env, struct x86_decode *decode,
                           struct x86_decode_op *op)
 {
     X86Seg seg = R_DS;
-    addr_t ptr = 0;
+    target_ulong ptr = 0;
     int addr_size = decode->addressing_size;
 
     if (decode->displacement_size) {
@@ -1794,7 +1794,7 @@ void calc_modrm_operand64(CPUX86State *env, struct x86_decode *decode,
     int32_t offset = 0;
     int mod = decode->modrm.mod;
     int rm = decode->modrm.rm;
-    addr_t ptr;
+    target_ulong ptr;
     int src = decode->modrm.rm;
 
     if (decode->displacement_size) {
@@ -2157,8 +2157,8 @@ const char *decode_cmd_to_string(enum x86_decode_cmd cmd)
     return cmds[cmd];
 }
 
-addr_t decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
-                          addr_t addr, X86Seg seg)
+target_ulong decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
+                               target_ulong addr, X86Seg seg)
 {
     switch (decode->segment_override) {
     case PREFIX_CS_SEG_OVEERIDE:
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index b3dc88e167..5ab6f31fa5 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -264,9 +264,9 @@ typedef struct x86_decode_op {
     int size;
 
     int reg;
-    addr_t val;
+    target_ulong val;
 
-    addr_t ptr;
+    target_ulong ptr;
 } x86_decode_op;
 
 typedef struct x86_decode {
@@ -295,7 +295,7 @@ typedef struct x86_decode {
     struct x86_modrm modrm;
     struct x86_decode_op op[4];
     bool is_fpu;
-    addr_t flags_mask;
+    uint32_t flags_mask;
 
 } x86_decode;
 
@@ -303,12 +303,12 @@ uint64_t sign(uint64_t val, int size);
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
 
-addr_t get_reg_ref(CPUX86State *env, int reg, int is_extended, int size);
-addr_t get_reg_val(CPUX86State *env, int reg, int is_extended, int size);
+target_ulong get_reg_ref(CPUX86State *env, int reg, int is_extended, int size);
+target_ulong get_reg_val(CPUX86State *env, int reg, int is_extended, int size);
 void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
                         struct x86_decode_op *op);
-addr_t decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
-                          addr_t addr, enum X86Seg seg);
+target_ulong decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
+                               target_ulong addr, enum X86Seg seg);
 
 void init_decoder(void);
 void calc_modrm_operand16(CPUX86State *env, struct x86_decode *decode,
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 31b0807add..6abcea9d92 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -91,7 +91,7 @@ void hvf_handle_io(struct CPUState *cpu, uint16_t port, void *data,
     }                                                   \
 }                                                       \
 
-addr_t read_reg(CPUX86State *env, int reg, int size)
+target_ulong read_reg(CPUX86State *env, int reg, int size)
 {
     switch (size) {
     case 1:
@@ -108,7 +108,7 @@ addr_t read_reg(CPUX86State *env, int reg, int size)
     return 0;
 }
 
-void write_reg(CPUX86State *env, int reg, addr_t val, int size)
+void write_reg(CPUX86State *env, int reg, target_ulong val, int size)
 {
     switch (size) {
     case 1:
@@ -128,9 +128,9 @@ void write_reg(CPUX86State *env, int reg, addr_t val, int size)
     }
 }
 
-addr_t read_val_from_reg(addr_t reg_ptr, int size)
+target_ulong read_val_from_reg(target_ulong reg_ptr, int size)
 {
-    addr_t val;
+    target_ulong val;
     
     switch (size) {
     case 1:
@@ -151,7 +151,7 @@ addr_t read_val_from_reg(addr_t reg_ptr, int size)
     return val;
 }
 
-void write_val_to_reg(addr_t reg_ptr, addr_t val, int size)
+void write_val_to_reg(target_ulong reg_ptr, target_ulong val, int size)
 {
     switch (size) {
     case 1:
@@ -171,12 +171,12 @@ void write_val_to_reg(addr_t reg_ptr, addr_t val, int size)
     }
 }
 
-static bool is_host_reg(struct CPUX86State *env, addr_t ptr)
+static bool is_host_reg(struct CPUX86State *env, target_ulong ptr)
 {
-    return (ptr - (addr_t)&env->hvf_emul->regs[0]) < sizeof(env->hvf_emul->regs);
+    return (ptr - (target_ulong)&env->hvf_emul->regs[0]) < sizeof(env->hvf_emul->regs);
 }
 
-void write_val_ext(struct CPUX86State *env, addr_t ptr, addr_t val, int size)
+void write_val_ext(struct CPUX86State *env, target_ulong ptr, target_ulong val, int size)
 {
     if (is_host_reg(env, ptr)) {
         write_val_to_reg(ptr, val, size);
@@ -185,16 +185,16 @@ void write_val_ext(struct CPUX86State *env, addr_t ptr, addr_t val, int size)
     vmx_write_mem(ENV_GET_CPU(env), ptr, &val, size);
 }
 
-uint8_t *read_mmio(struct CPUX86State *env, addr_t ptr, int bytes)
+uint8_t *read_mmio(struct CPUX86State *env, target_ulong ptr, int bytes)
 {
     vmx_read_mem(ENV_GET_CPU(env), env->hvf_emul->mmio_buf, ptr, bytes);
     return env->hvf_emul->mmio_buf;
 }
 
 
-addr_t read_val_ext(struct CPUX86State *env, addr_t ptr, int size)
+target_ulong read_val_ext(struct CPUX86State *env, target_ulong ptr, int size)
 {
-    addr_t val;
+    target_ulong val;
     uint8_t *mmio_ptr;
 
     if (is_host_reg(env, ptr)) {
@@ -420,7 +420,7 @@ static void exec_out(struct CPUX86State *env, struct x86_decode *decode)
 
 static void exec_in(struct CPUX86State *env, struct x86_decode *decode)
 {
-    addr_t val = 0;
+    target_ulong val = 0;
     switch (decode->opcode[0]) {
     case 0xe4:
         hvf_handle_io(ENV_GET_CPU(env), decode->op[0].val, &AL(env), 0, 1, 1);
@@ -456,7 +456,7 @@ static void exec_in(struct CPUX86State *env, struct x86_decode *decode)
 static inline void string_increment_reg(struct CPUX86State *env, int reg,
                                         struct x86_decode *decode)
 {
-    addr_t val = read_reg(env, reg, decode->addressing_size);
+    target_ulong val = read_reg(env, reg, decode->addressing_size);
     if (env->hvf_emul->rflags.df) {
         val -= decode->operand_size;
     } else {
@@ -469,7 +469,7 @@ static inline void string_rep(struct CPUX86State *env, struct x86_decode *decode
                               void (*func)(struct CPUX86State *env,
                                            struct x86_decode *ins), int rep)
 {
-    addr_t rcx = read_reg(env, R_ECX, decode->addressing_size);
+    target_ulong rcx = read_reg(env, R_ECX, decode->addressing_size);
     while (rcx--) {
         func(env, decode);
         write_reg(env, R_ECX, rcx, decode->addressing_size);
@@ -484,7 +484,7 @@ static inline void string_rep(struct CPUX86State *env, struct x86_decode *decode
 
 static void exec_ins_single(struct CPUX86State *env, struct x86_decode *decode)
 {
-    addr_t addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
+    target_ulong addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
                                    R_ES);
 
     hvf_handle_io(ENV_GET_CPU(env), DX(env), env->hvf_emul->mmio_buf, 0,
@@ -507,7 +507,7 @@ static void exec_ins(struct CPUX86State *env, struct x86_decode *decode)
 
 static void exec_outs_single(struct CPUX86State *env, struct x86_decode *decode)
 {
-    addr_t addr = decode_linear_addr(env, decode, RSI(env), R_DS);
+    target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
     vmx_read_mem(ENV_GET_CPU(env), env->hvf_emul->mmio_buf, addr, decode->operand_size);
     hvf_handle_io(ENV_GET_CPU(env), DX(env), env->hvf_emul->mmio_buf, 1,
@@ -529,9 +529,9 @@ static void exec_outs(struct CPUX86State *env, struct x86_decode *decode)
 
 static void exec_movs_single(struct CPUX86State *env, struct x86_decode *decode)
 {
-    addr_t src_addr;
-    addr_t dst_addr;
-    addr_t val;
+    target_ulong src_addr;
+    target_ulong dst_addr;
+    target_ulong val;
 
     src_addr = decode_linear_addr(env, decode, RSI(env), R_DS);
     dst_addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
@@ -557,8 +557,8 @@ static void exec_movs(struct CPUX86State *env, struct x86_decode *decode)
 
 static void exec_cmps_single(struct CPUX86State *env, struct x86_decode *decode)
 {
-    addr_t src_addr;
-    addr_t dst_addr;
+    target_ulong src_addr;
+    target_ulong dst_addr;
 
     src_addr = decode_linear_addr(env, decode, RSI(env), R_DS);
     dst_addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
@@ -588,8 +588,8 @@ static void exec_cmps(struct CPUX86State *env, struct x86_decode *decode)
 
 static void exec_stos_single(struct CPUX86State *env, struct x86_decode *decode)
 {
-    addr_t addr;
-    addr_t val;
+    target_ulong addr;
+    target_ulong val;
 
     addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size, R_ES);
     val = read_reg(env, R_EAX, decode->operand_size);
@@ -612,7 +612,7 @@ static void exec_stos(struct CPUX86State *env, struct x86_decode *decode)
 
 static void exec_scas_single(struct CPUX86State *env, struct x86_decode *decode)
 {
-    addr_t addr;
+    target_ulong addr;
 
     addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size, R_ES);
     decode->op[1].type = X86_VAR_IMMEDIATE;
@@ -637,8 +637,8 @@ static void exec_scas(struct CPUX86State *env, struct x86_decode *decode)
 
 static void exec_lods_single(struct CPUX86State *env, struct x86_decode *decode)
 {
-    addr_t addr;
-    addr_t val = 0;
+    target_ulong addr;
+    target_ulong val = 0;
 
     addr = decode_linear_addr(env, decode, RSI(env), R_DS);
     vmx_read_mem(ENV_GET_CPU(env), &val, addr,  decode->operand_size);
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index cd4acb0030..fbb4832576 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -31,13 +31,13 @@ void store_regs(struct CPUState *cpu);
 void simulate_rdmsr(struct CPUState *cpu);
 void simulate_wrmsr(struct CPUState *cpu);
 
-addr_t read_reg(CPUX86State *env, int reg, int size);
-void write_reg(CPUX86State *env, int reg, addr_t val, int size);
-addr_t read_val_from_reg(addr_t reg_ptr, int size);
-void write_val_to_reg(addr_t reg_ptr, addr_t val, int size);
-void write_val_ext(struct CPUX86State *env, addr_t ptr, addr_t val, int size);
-uint8_t *read_mmio(struct CPUX86State *env, addr_t ptr, int bytes);
-addr_t read_val_ext(struct CPUX86State *env, addr_t ptr, int size);
+target_ulong read_reg(CPUX86State *env, int reg, int size);
+void write_reg(CPUX86State *env, int reg, target_ulong val, int size);
+target_ulong read_val_from_reg(target_ulong reg_ptr, int size);
+void write_val_to_reg(target_ulong reg_ptr, target_ulong val, int size);
+void write_val_ext(struct CPUX86State *env, target_ulong ptr, target_ulong val, int size);
+uint8_t *read_mmio(struct CPUX86State *env, target_ulong ptr, int bytes);
+target_ulong read_val_ext(struct CPUX86State *env, target_ulong ptr, int size);
 
 void exec_movzx(struct CPUX86State *env, struct x86_decode *decode);
 void exec_shl(struct CPUX86State *env, struct x86_decode *decode);
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index b0686c7962..28398ae680 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -60,9 +60,9 @@
 
 /* size, carries, result */
 #define SET_FLAGS_OSZAPC_SIZE(size, lf_carries, lf_result) { \
-    addr_t temp = ((lf_carries) & (LF_MASK_AF)) | \
+    target_ulong temp = ((lf_carries) & (LF_MASK_AF)) | \
     (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
-    env->hvf_emul->lflags.result = (addr_t)(int##size##_t)(lf_result); \
+    env->hvf_emul->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
     if ((size) == 32) { \
         temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
     } else if ((size) == 16) { \
@@ -72,7 +72,7 @@
     } else { \
         VM_PANIC("unimplemented");  \
     } \
-    env->hvf_emul->lflags.auxbits = (addr_t)(uint32_t)temp; \
+    env->hvf_emul->lflags.auxbits = (target_ulong)(uint32_t)temp; \
 }
 
 /* carries, result */
@@ -88,7 +88,7 @@
 /* ******************* */
 /* size, carries, result */
 #define SET_FLAGS_OSZAP_SIZE(size, lf_carries, lf_result) { \
-    addr_t temp = ((lf_carries) & (LF_MASK_AF)) | \
+    target_ulong temp = ((lf_carries) & (LF_MASK_AF)) | \
     (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
     if ((size) == 32) { \
         temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
@@ -99,10 +99,10 @@
     } else { \
         VM_PANIC("unimplemented");      \
     } \
-    env->hvf_emul->lflags.result = (addr_t)(int##size##_t)(lf_result); \
-    addr_t delta_c = (env->hvf_emul->lflags.auxbits ^ temp) & LF_MASK_CF; \
+    env->hvf_emul->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
+    target_ulong delta_c = (env->hvf_emul->lflags.auxbits ^ temp) & LF_MASK_CF; \
     delta_c ^= (delta_c >> 1); \
-    env->hvf_emul->lflags.auxbits = (addr_t)(uint32_t)(temp ^ delta_c); \
+    env->hvf_emul->lflags.auxbits = (target_ulong)(uint32_t)(temp ^ delta_c); \
 }
 
 /* carries, result */
diff --git a/target/i386/hvf/x86_gen.h b/target/i386/hvf/x86_gen.h
index e5739f1de5..96d6c5a811 100644
--- a/target/i386/hvf/x86_gen.h
+++ b/target/i386/hvf/x86_gen.h
@@ -18,8 +18,6 @@
 #ifndef __X86_GEN_H__
 #define __X86_GEN_H__
 
-typedef uint64_t addr_t;
-
 #define VM_PANIC(x) {\
     printf("%s\n", x); \
     abort(); \
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 1084670c1d..af11635fba 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -43,8 +43,8 @@
 #define PAE_PTE_LARGE_PAGE_MASK     ((-1llu << (21)) & ((1llu << 52) - 1))
 
 struct gpt_translation {
-    addr_t  gva;
-    addr_t gpa;
+    target_ulong  gva;
+    uint64_t gpa;
     int    err_code;
     uint64_t pte[5];
     bool write_access;
@@ -64,7 +64,7 @@ static int gpt_top_level(struct CPUState *cpu, bool pae)
     return 3;
 }
 
-static inline int gpt_entry(addr_t addr, int level, bool pae)
+static inline int gpt_entry(target_ulong addr, int level, bool pae)
 {
     int level_shift = pae ? 9 : 10;
     return (addr >> (level_shift * (level - 1) + 12)) & ((1 << level_shift) - 1);
@@ -81,8 +81,8 @@ static bool get_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
 {
     int index;
     uint64_t pte = 0;
-    addr_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
-    addr_t gpa = pt->pte[level] & page_mask;
+    uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
+    uint64_t gpa = pt->pte[level] & page_mask;
 
     if (level == 3 && !x86_is_long_mode(cpu)) {
         gpa = pt->pte[level];
@@ -114,7 +114,6 @@ static bool test_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
     }
 
     if (!pte_present(pte)) {
-        /* addr_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK; */
         return false;
     }
 
@@ -130,7 +129,7 @@ static bool test_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
         pt->err_code |= MMU_PAGE_PT;
     }
 
-    addr_t cr0 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0);
+    uint32_t cr0 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0);
     /* check protection */
     if (cr0 & CR0_WP) {
         if (pt->write_access && !pte_write_access(pte)) {
@@ -170,13 +169,13 @@ static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae)
 
 
 
-static bool walk_gpt(struct CPUState *cpu, addr_t addr, int err_code,
+static bool walk_gpt(struct CPUState *cpu, target_ulong addr, int err_code,
                      struct gpt_translation *pt, bool pae)
 {
     int top_level, level;
     bool is_large = false;
-    addr_t cr3 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR3);
-    addr_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
+    target_ulong cr3 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR3);
+    uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
     
     memset(pt, 0, sizeof(*pt));
     top_level = gpt_top_level(cpu, pae);
@@ -209,7 +208,7 @@ static bool walk_gpt(struct CPUState *cpu, addr_t addr, int err_code,
 }
 
 
-bool mmu_gva_to_gpa(struct CPUState *cpu, addr_t gva, addr_t *gpa)
+bool mmu_gva_to_gpa(struct CPUState *cpu, target_ulong gva, uint64_t *gpa)
 {
     bool res;
     struct gpt_translation pt;
@@ -229,9 +228,9 @@ bool mmu_gva_to_gpa(struct CPUState *cpu, addr_t gva, addr_t *gpa)
     return false;
 }
 
-void vmx_write_mem(struct CPUState *cpu, addr_t gva, void *data, int bytes)
+void vmx_write_mem(struct CPUState *cpu, target_ulong gva, void *data, int bytes)
 {
-    addr_t gpa;
+    uint64_t gpa;
 
     while (bytes > 0) {
         /* copy page */
@@ -250,9 +249,9 @@ void vmx_write_mem(struct CPUState *cpu, addr_t gva, void *data, int bytes)
     }
 }
 
-void vmx_read_mem(struct CPUState *cpu, void *data, addr_t gva, int bytes)
+void vmx_read_mem(struct CPUState *cpu, void *data, target_ulong gva, int bytes)
 {
-    addr_t gpa;
+    uint64_t gpa;
 
     while (bytes > 0) {
         /* copy page */
diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/hvf/x86_mmu.h
index b786af280b..ae02cb6916 100644
--- a/target/i386/hvf/x86_mmu.h
+++ b/target/i386/hvf/x86_mmu.h
@@ -37,9 +37,9 @@
 #define MMU_PAGE_US             (1 << 2)
 #define MMU_PAGE_NX             (1 << 3)
 
-bool mmu_gva_to_gpa(struct CPUState *cpu, addr_t gva, addr_t *gpa);
+bool mmu_gva_to_gpa(struct CPUState *cpu, target_ulong gva, uint64_t *gpa);
 
-void vmx_write_mem(struct CPUState *cpu, addr_t gva, void *data, int bytes);
-void vmx_read_mem(struct CPUState *cpu, void *data, addr_t gva, int bytes);
+void vmx_write_mem(struct CPUState *cpu, target_ulong gva, void *data, int bytes);
+void vmx_read_mem(struct CPUState *cpu, void *data, target_ulong gva, int bytes);
 
 #endif /* __X86_MMU_H__ */
-- 
2.14.3
