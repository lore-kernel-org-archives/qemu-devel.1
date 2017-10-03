Received: from eggs.gnu.org ([2001:4830:134:3::10]:40171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWk-000250-SQ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWa-00045V-4p
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:26 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzNWZ-00044p-Ly
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:16 -0400
Received: by mail-wm0-x241.google.com with SMTP id k4so14906475wmc.1
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:46:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 15:45:33 +0200
Message-Id: <20171003134540.21625-4-pbonzini@redhat.com>
In-Reply-To: <20171003134540.21625-1-pbonzini@redhat.com>
References: <20171003134540.21625-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/10] i386: hvf: unify register enums between
 HVF and the rest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex@alex.org.uk, agraf@suse.de, sergio.g.delreal@gmail.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h            |  60 +++++++++++-------
 target/i386/hvf/vmx.h        |  10 +--
 target/i386/hvf/x86.c        |  10 +--
 target/i386/hvf/x86.h        | 145 +++++++++++++------------------------------
 target/i386/hvf/x86_decode.c |  80 ++++++++++++------------
 target/i386/hvf/x86_decode.h |   2 +-
 target/i386/hvf/x86_descr.c  |  26 ++++----
 target/i386/hvf/x86_descr.h  |  16 ++---
 target/i386/hvf/x86_emu.c    |  66 ++++++++++----------
 target/i386/hvf/x86_task.c   |  48 +++++++-------
 target/i386/hvf/x86hvf.c     |  32 +++++-----
 11 files changed, 224 insertions(+), 271 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 238d3e3535..fb38de7b0e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -59,30 +59,42 @@
 #include "fpu/softfloat.h"
 #endif
 
-#define R_EAX 0
-#define R_ECX 1
-#define R_EDX 2
-#define R_EBX 3
-#define R_ESP 4
-#define R_EBP 5
-#define R_ESI 6
-#define R_EDI 7
-
-#define R_AL 0
-#define R_CL 1
-#define R_DL 2
-#define R_BL 3
-#define R_AH 4
-#define R_CH 5
-#define R_DH 6
-#define R_BH 7
-
-#define R_ES 0
-#define R_CS 1
-#define R_SS 2
-#define R_DS 3
-#define R_FS 4
-#define R_GS 5
+enum {
+    R_RAX = 0,
+    R_RCX = 1,
+    R_RDX = 2,
+    R_RBX = 3,
+    R_RSP = 4,
+    R_RBP = 5,
+    R_RSI = 6,
+    R_RDI = 7,
+    R_R8 = 8,
+    R_R9 = 9,
+    R_R10 = 10,
+    R_R11 = 11,
+    R_R12 = 12,
+    R_R13 = 13,
+    R_R14 = 14,
+    R_R15 = 15,
+
+    R_AL = 0,
+    R_CL = 1,
+    R_DL = 2,
+    R_BL = 3,
+    R_AH = 4,
+    R_CH = 5,
+    R_DH = 6,
+    R_BH = 7,
+};
+
+typedef enum X86Seg {
+    R_ES = 0,
+    R_CS = 1,
+    R_SS = 2,
+    R_DS = 3,
+    R_FS = 4,
+    R_GS = 5,
+} X86Seg;
 
 /* segment descriptor fields */
 #define DESC_G_SHIFT    23
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 102075d0d4..9dfcd2f2eb 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -88,14 +88,14 @@ static void enter_long_mode(hv_vcpuid_t vcpu, uint64_t cr0, uint64_t efer)
 {
     uint64_t entry_ctls;
 
-    efer |= EFER_LMA;
+    efer |= MSR_EFER_LMA;
     wvmcs(vcpu, VMCS_GUEST_IA32_EFER, efer);
     entry_ctls = rvmcs(vcpu, VMCS_ENTRY_CTLS);
     wvmcs(vcpu, VMCS_ENTRY_CTLS, rvmcs(vcpu, VMCS_ENTRY_CTLS) |
           VM_ENTRY_GUEST_LMA);
 
     uint64_t guest_tr_ar = rvmcs(vcpu, VMCS_GUEST_TR_ACCESS_RIGHTS);
-    if ((efer & EFER_LME) &&
+    if ((efer & MSR_EFER_LME) &&
         (guest_tr_ar & AR_TYPE_MASK) != AR_TYPE_BUSY_64_TSS) {
         wvmcs(vcpu, VMCS_GUEST_TR_ACCESS_RIGHTS,
               (guest_tr_ar & ~AR_TYPE_MASK) | AR_TYPE_BUSY_64_TSS);
@@ -109,7 +109,7 @@ static void exit_long_mode(hv_vcpuid_t vcpu, uint64_t cr0, uint64_t efer)
     entry_ctls = rvmcs(vcpu, VMCS_ENTRY_CTLS);
     wvmcs(vcpu, VMCS_ENTRY_CTLS, entry_ctls & ~VM_ENTRY_GUEST_LMA);
 
-    efer &= ~EFER_LMA;
+    efer &= ~MSR_EFER_LMA;
     wvmcs(vcpu, VMCS_GUEST_IA32_EFER, efer);
 }
 
@@ -121,7 +121,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
     uint64_t old_cr0 = rvmcs(vcpu, VMCS_GUEST_CR0);
 
     if ((cr0 & CR0_PG) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE) &&
-        !(efer & EFER_LME)) {
+        !(efer & MSR_EFER_LME)) {
         address_space_rw(&address_space_memory,
                          rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
                          MEMTXATTRS_UNSPECIFIED,
@@ -138,7 +138,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
     cr0 &= ~CR0_CD;
     wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE | CR0_ET);
 
-    if (efer & EFER_LME) {
+    if (efer & MSR_EFER_LME) {
         if (!(old_cr0 & CR0_PG) && (cr0 & CR0_PG)) {
             enter_long_mode(vcpu, cr0, efer);
         }
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 625ea6cac0..ca0ec2968a 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -134,13 +134,13 @@ bool x86_is_v8086(struct CPUState *cpu)
 
 bool x86_is_long_mode(struct CPUState *cpu)
 {
-    return rvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER) & EFER_LMA;
+    return rvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER) & MSR_EFER_LMA;
 }
 
 bool x86_is_long64_mode(struct CPUState *cpu)
 {
     struct vmx_segment desc;
-    vmx_read_segment_descriptor(cpu, &desc, REG_SEG_CS);
+    vmx_read_segment_descriptor(cpu, &desc, R_CS);
 
     return x86_is_long_mode(cpu) && ((desc.ar >> 13) & 1);
 }
@@ -157,13 +157,13 @@ bool x86_is_pae_enabled(struct CPUState *cpu)
     return cr4 & CR4_PAE;
 }
 
-addr_t linear_addr(struct CPUState *cpu, addr_t addr, x86_reg_segment seg)
+addr_t linear_addr(struct CPUState *cpu, addr_t addr, X86Seg seg)
 {
     return vmx_read_segment_base(cpu, seg) + addr;
 }
 
 addr_t linear_addr_size(struct CPUState *cpu, addr_t addr, int size,
-                        x86_reg_segment seg)
+                        X86Seg seg)
 {
     switch (size) {
     case 2:
@@ -180,5 +180,5 @@ addr_t linear_addr_size(struct CPUState *cpu, addr_t addr, int size,
 
 addr_t linear_rip(struct CPUState *cpu, addr_t rip)
 {
-    return linear_addr(cpu, rip, REG_SEG_CS);
+    return linear_addr(cpu, rip, R_CS);
 }
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index ae957fc895..650bb718bf 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -22,57 +22,6 @@
 #include "qemu-common.h"
 #include "x86_gen.h"
 
-/* exceptions */
-typedef enum x86_exception {
-    EXCEPTION_DE,           /* divide error */
-    EXCEPTION_DB,           /* debug fault */
-    EXCEPTION_NMI,          /* non-maskable interrupt */
-    EXCEPTION_BP,           /* breakpoint trap */
-    EXCEPTION_OF,           /* overflow trap */
-    EXCEPTION_BR,           /* boundary range exceeded fault */
-    EXCEPTION_UD,           /* undefined opcode */
-    EXCEPTION_NM,           /* device not available */
-    EXCEPTION_DF,           /* double fault */
-    EXCEPTION_RSVD,         /* not defined */
-    EXCEPTION_TS,           /* invalid TSS fault */
-    EXCEPTION_NP,           /* not present fault */
-    EXCEPTION_GP,           /* general protection fault */
-    EXCEPTION_PF,           /* page fault */
-    EXCEPTION_RSVD2,        /* not defined */
-} x86_exception;
-
-/* general purpose regs */
-typedef enum x86_reg_name {
-    REG_RAX = 0,
-    REG_RCX = 1,
-    REG_RDX = 2,
-    REG_RBX = 3,
-    REG_RSP = 4,
-    REG_RBP = 5,
-    REG_RSI = 6,
-    REG_RDI = 7,
-    REG_R8 = 8,
-    REG_R9 = 9,
-    REG_R10 = 10,
-    REG_R11 = 11,
-    REG_R12 = 12,
-    REG_R13 = 13,
-    REG_R14 = 14,
-    REG_R15 = 15,
-} x86_reg_name;
-
-/* segment regs */
-typedef enum x86_reg_segment {
-    REG_SEG_ES = 0,
-    REG_SEG_CS = 1,
-    REG_SEG_SS = 2,
-    REG_SEG_DS = 3,
-    REG_SEG_FS = 4,
-    REG_SEG_GS = 5,
-    REG_SEG_LDTR = 6,
-    REG_SEG_TR = 7,
-} x86_reg_segment;
-
 typedef struct x86_register {
     union {
         struct {
@@ -154,15 +103,6 @@ typedef struct x86_reg_flags {
     };
 } __attribute__ ((__packed__)) x86_reg_flags;
 
-typedef enum x86_reg_efer {
-    EFER_SCE =          (1L << 0),
-    EFER_LME =          (1L << 8),
-    EFER_LMA =          (1L << 10),
-    EFER_NXE =          (1L << 11),
-    EFER_SVME =         (1L << 12),
-    EFER_FXSR =         (1L << 14),
-} x86_reg_efer;
-
 typedef struct x86_efer {
     uint64_t efer;
 } __attribute__ ((__packed__)) x86_efer;
@@ -384,54 +324,54 @@ struct hvf_xsave_buf {
 #define EFLAGS(cpu) (cpu->hvf_emul->rflags.eflags)
 
 #define RRX(cpu, reg) (cpu->hvf_emul->regs[reg].rrx)
-#define RAX(cpu)        RRX(cpu, REG_RAX)
-#define RCX(cpu)        RRX(cpu, REG_RCX)
-#define RDX(cpu)        RRX(cpu, REG_RDX)
-#define RBX(cpu)        RRX(cpu, REG_RBX)
-#define RSP(cpu)        RRX(cpu, REG_RSP)
-#define RBP(cpu)        RRX(cpu, REG_RBP)
-#define RSI(cpu)        RRX(cpu, REG_RSI)
-#define RDI(cpu)        RRX(cpu, REG_RDI)
-#define R8(cpu)         RRX(cpu, REG_R8)
-#define R9(cpu)         RRX(cpu, REG_R9)
-#define R10(cpu)        RRX(cpu, REG_R10)
-#define R11(cpu)        RRX(cpu, REG_R11)
-#define R12(cpu)        RRX(cpu, REG_R12)
-#define R13(cpu)        RRX(cpu, REG_R13)
-#define R14(cpu)        RRX(cpu, REG_R14)
-#define R15(cpu)        RRX(cpu, REG_R15)
+#define RAX(cpu)        RRX(cpu, R_RAX)
+#define RCX(cpu)        RRX(cpu, R_RCX)
+#define RDX(cpu)        RRX(cpu, R_RDX)
+#define RBX(cpu)        RRX(cpu, R_RBX)
+#define RSP(cpu)        RRX(cpu, R_RSP)
+#define RBP(cpu)        RRX(cpu, R_RBP)
+#define RSI(cpu)        RRX(cpu, R_RSI)
+#define RDI(cpu)        RRX(cpu, R_RDI)
+#define R8(cpu)         RRX(cpu, R_R8)
+#define R9(cpu)         RRX(cpu, R_R9)
+#define R10(cpu)        RRX(cpu, R_R10)
+#define R11(cpu)        RRX(cpu, R_R11)
+#define R12(cpu)        RRX(cpu, R_R12)
+#define R13(cpu)        RRX(cpu, R_R13)
+#define R14(cpu)        RRX(cpu, R_R14)
+#define R15(cpu)        RRX(cpu, R_R15)
 
 #define ERX(cpu, reg)   (cpu->hvf_emul->regs[reg].erx)
-#define EAX(cpu)        ERX(cpu, REG_RAX)
-#define ECX(cpu)        ERX(cpu, REG_RCX)
-#define EDX(cpu)        ERX(cpu, REG_RDX)
-#define EBX(cpu)        ERX(cpu, REG_RBX)
-#define ESP(cpu)        ERX(cpu, REG_RSP)
-#define EBP(cpu)        ERX(cpu, REG_RBP)
-#define ESI(cpu)        ERX(cpu, REG_RSI)
-#define EDI(cpu)        ERX(cpu, REG_RDI)
+#define EAX(cpu)        ERX(cpu, R_RAX)
+#define ECX(cpu)        ERX(cpu, R_RCX)
+#define EDX(cpu)        ERX(cpu, R_RDX)
+#define EBX(cpu)        ERX(cpu, R_RBX)
+#define ESP(cpu)        ERX(cpu, R_RSP)
+#define EBP(cpu)        ERX(cpu, R_RBP)
+#define ESI(cpu)        ERX(cpu, R_RSI)
+#define EDI(cpu)        ERX(cpu, R_RDI)
 
 #define RX(cpu, reg)   (cpu->hvf_emul->regs[reg].rx)
-#define AX(cpu)        RX(cpu, REG_RAX)
-#define CX(cpu)        RX(cpu, REG_RCX)
-#define DX(cpu)        RX(cpu, REG_RDX)
-#define BP(cpu)        RX(cpu, REG_RBP)
-#define SP(cpu)        RX(cpu, REG_RSP)
-#define BX(cpu)        RX(cpu, REG_RBX)
-#define SI(cpu)        RX(cpu, REG_RSI)
-#define DI(cpu)        RX(cpu, REG_RDI)
+#define AX(cpu)        RX(cpu, R_RAX)
+#define CX(cpu)        RX(cpu, R_RCX)
+#define DX(cpu)        RX(cpu, R_RDX)
+#define BP(cpu)        RX(cpu, R_RBP)
+#define SP(cpu)        RX(cpu, R_RSP)
+#define BX(cpu)        RX(cpu, R_RBX)
+#define SI(cpu)        RX(cpu, R_RSI)
+#define DI(cpu)        RX(cpu, R_RDI)
 
 #define RL(cpu, reg)   (cpu->hvf_emul->regs[reg].lx)
-#define AL(cpu)        RL(cpu, REG_RAX)
-#define CL(cpu)        RL(cpu, REG_RCX)
-#define DL(cpu)        RL(cpu, REG_RDX)
-#define BL(cpu)        RL(cpu, REG_RBX)
+#define AL(cpu)        RL(cpu, R_RAX)
+#define CL(cpu)        RL(cpu, R_RCX)
+#define DL(cpu)        RL(cpu, R_RDX)
+#define BL(cpu)        RL(cpu, R_RBX)
 
 #define RH(cpu, reg)   (cpu->hvf_emul->regs[reg].hx)
-#define AH(cpu)        RH(cpu, REG_RAX)
-#define CH(cpu)        RH(cpu, REG_RCX)
-#define DH(cpu)        RH(cpu, REG_RDX)
-#define BH(cpu)        RH(cpu, REG_RBX)
+#define AH(cpu)        RH(cpu, R_RAX)
+#define CH(cpu)        RH(cpu, R_RCX)
+#define DH(cpu)        RH(cpu, R_RDX)
+#define BH(cpu)        RH(cpu, R_RBX)
 
 /* deal with GDT/LDT descriptors in memory */
 bool x86_read_segment_descriptor(struct CPUState *cpu,
@@ -453,9 +393,10 @@ bool x86_is_long64_mode(struct CPUState *cpu);
 bool x86_is_paging_mode(struct CPUState *cpu);
 bool x86_is_pae_enabled(struct CPUState *cpu);
 
-addr_t linear_addr(struct CPUState *cpu, addr_t addr, x86_reg_segment seg);
+enum X86Seg;
+addr_t linear_addr(struct CPUState *cpu, addr_t addr, enum X86Seg seg);
 addr_t linear_addr_size(struct CPUState *cpu, addr_t addr, int size,
-                        x86_reg_segment seg);
+                        enum X86Seg seg);
 addr_t linear_rip(struct CPUState *cpu, addr_t rip);
 
 static inline uint64_t rdtscp(void)
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 623c051339..86e7c4ee7a 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -120,7 +120,7 @@ static void decode_rax(CPUX86State *env, struct x86_decode *decode,
                        struct x86_decode_op *op)
 {
     op->type = X86_VAR_REG;
-    op->reg = REG_RAX;
+    op->reg = R_RAX;
     op->ptr = get_reg_ref(env, op->reg, 0, decode->operand_size);
 }
 
@@ -212,22 +212,22 @@ static void decode_pushseg(CPUX86State *env, struct x86_decode *decode)
     decode->op[0].type = X86_VAR_REG;
     switch (op) {
     case 0xe:
-        decode->op[0].reg = REG_SEG_CS;
+        decode->op[0].reg = R_CS;
         break;
     case 0x16:
-        decode->op[0].reg = REG_SEG_SS;
+        decode->op[0].reg = R_SS;
         break;
     case 0x1e:
-        decode->op[0].reg = REG_SEG_DS;
+        decode->op[0].reg = R_DS;
         break;
     case 0x06:
-        decode->op[0].reg = REG_SEG_ES;
+        decode->op[0].reg = R_ES;
         break;
     case 0xa0:
-        decode->op[0].reg = REG_SEG_FS;
+        decode->op[0].reg = R_FS;
         break;
     case 0xa8:
-        decode->op[0].reg = REG_SEG_GS;
+        decode->op[0].reg = R_GS;
         break;
     }
 }
@@ -239,22 +239,22 @@ static void decode_popseg(CPUX86State *env, struct x86_decode *decode)
     decode->op[0].type = X86_VAR_REG;
     switch (op) {
     case 0xf:
-        decode->op[0].reg = REG_SEG_CS;
+        decode->op[0].reg = R_CS;
         break;
     case 0x17:
-        decode->op[0].reg = REG_SEG_SS;
+        decode->op[0].reg = R_SS;
         break;
     case 0x1f:
-        decode->op[0].reg = REG_SEG_DS;
+        decode->op[0].reg = R_DS;
         break;
     case 0x07:
-        decode->op[0].reg = REG_SEG_ES;
+        decode->op[0].reg = R_ES;
         break;
     case 0xa1:
-        decode->op[0].reg = REG_SEG_FS;
+        decode->op[0].reg = R_FS;
         break;
     case 0xa9:
-        decode->op[0].reg = REG_SEG_GS;
+        decode->op[0].reg = R_GS;
         break;
     }
 }
@@ -411,7 +411,7 @@ static void decode_rcx(CPUX86State *env, struct x86_decode *decode,
                        struct x86_decode_op *op)
 {
     op->type = X86_VAR_REG;
-    op->reg = REG_RCX;
+    op->reg = R_RCX;
     op->ptr = get_reg_ref(env, op->reg, decode->rex.b, decode->operand_size);
 }
 
@@ -1638,7 +1638,7 @@ void calc_modrm_operand16(CPUX86State *env, struct x86_decode *decode,
                           struct x86_decode_op *op)
 {
     addr_t ptr = 0;
-    x86_reg_segment seg = REG_SEG_DS;
+    X86Seg seg = R_DS;
 
     if (!decode->modrm.mod && 6 == decode->modrm.rm) {
         op->ptr = (uint16_t)decode->displacement;
@@ -1658,11 +1658,11 @@ void calc_modrm_operand16(CPUX86State *env, struct x86_decode *decode,
         break;
     case 2:
         ptr += BP(env) + SI(env);
-        seg = REG_SEG_SS;
+        seg = R_SS;
         break;
     case 3:
         ptr += BP(env) + DI(env);
-        seg = REG_SEG_SS;
+        seg = R_SS;
         break;
     case 4:
         ptr += SI(env);
@@ -1672,7 +1672,7 @@ void calc_modrm_operand16(CPUX86State *env, struct x86_decode *decode,
         break;
     case 6:
         ptr += BP(env);
-        seg = REG_SEG_SS;
+        seg = R_SS;
         break;
     case 7:
         ptr += BX(env);
@@ -1692,7 +1692,7 @@ addr_t get_reg_ref(CPUX86State *env, int reg, int is_extended, int size)
     int which = 0;
 
     if (is_extended) {
-        reg |= REG_R8;
+        reg |= R_R8;
     }
 
 
@@ -1722,7 +1722,7 @@ addr_t get_reg_val(CPUX86State *env, int reg, int is_extended, int size)
 }
 
 static addr_t get_sib_val(CPUX86State *env, struct x86_decode *decode,
-                          x86_reg_segment *sel)
+                          X86Seg *sel)
 {
     addr_t base = 0;
     addr_t scaled_index = 0;
@@ -1730,23 +1730,23 @@ static addr_t get_sib_val(CPUX86State *env, struct x86_decode *decode,
     int base_reg = decode->sib.base;
     int index_reg = decode->sib.index;
 
-    *sel = REG_SEG_DS;
+    *sel = R_DS;
 
-    if (decode->modrm.mod || base_reg != REG_RBP) {
+    if (decode->modrm.mod || base_reg != R_RBP) {
         if (decode->rex.b) {
-            base_reg |= REG_R8;
+            base_reg |= R_R8;
         }
-        if (REG_RSP == base_reg || REG_RBP == base_reg) {
-            *sel = REG_SEG_SS;
+        if (base_reg == R_RSP || base_reg == R_RBP) {
+            *sel = R_SS;
         }
         base = get_reg_val(env, decode->sib.base, decode->rex.b, addr_size);
     }
 
     if (decode->rex.x) {
-        index_reg |= REG_R8;
+        index_reg |= R_R8;
     }
 
-    if (index_reg != REG_RSP) {
+    if (index_reg != R_RSP) {
         scaled_index = get_reg_val(env, index_reg, decode->rex.x, addr_size) <<
                                    decode->sib.scale;
     }
@@ -1756,7 +1756,7 @@ static addr_t get_sib_val(CPUX86State *env, struct x86_decode *decode,
 void calc_modrm_operand32(CPUX86State *env, struct x86_decode *decode,
                           struct x86_decode_op *op)
 {
-    x86_reg_segment seg = REG_SEG_DS;
+    X86Seg seg = R_DS;
     addr_t ptr = 0;
     int addr_size = decode->addressing_size;
 
@@ -1773,8 +1773,8 @@ void calc_modrm_operand32(CPUX86State *env, struct x86_decode *decode,
             ptr = decode->displacement;
         }
     } else {
-        if (REG_RBP == decode->modrm.rm || REG_RSP == decode->modrm.rm) {
-            seg = REG_SEG_SS;
+        if (decode->modrm.rm == R_RBP || decode->modrm.rm == R_RSP) {
+            seg = R_SS;
         }
         ptr += get_reg_val(env, decode->modrm.rm, decode->rex.b, addr_size);
     }
@@ -1789,7 +1789,7 @@ void calc_modrm_operand32(CPUX86State *env, struct x86_decode *decode,
 void calc_modrm_operand64(CPUX86State *env, struct x86_decode *decode,
                           struct x86_decode_op *op)
 {
-    x86_reg_segment seg = REG_SEG_DS;
+    X86Seg seg = R_DS;
     int32_t offset = 0;
     int mod = decode->modrm.mod;
     int rm = decode->modrm.rm;
@@ -1894,7 +1894,7 @@ void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
     } else if (!x86_is_long_mode(ENV_GET_CPU(env))) {
         /* protected */
         struct vmx_segment cs;
-        vmx_read_segment_descriptor(ENV_GET_CPU(env), &cs, REG_SEG_CS);
+        vmx_read_segment_descriptor(ENV_GET_CPU(env), &cs, R_CS);
         /* check db */
         if ((cs.ar >> 14) & 1) {
             if (decode->addr_size_override) {
@@ -1931,7 +1931,7 @@ void set_operand_size(CPUX86State *env, struct x86_decode *decode)
     } else if (!x86_is_long_mode(ENV_GET_CPU(env))) {
         /* protected */
         struct vmx_segment cs;
-        vmx_read_segment_descriptor(ENV_GET_CPU(env), &cs, REG_SEG_CS);
+        vmx_read_segment_descriptor(ENV_GET_CPU(env), &cs, R_CS);
         /* check db */
         if ((cs.ar >> 14) & 1) {
             if (decode->op_size_override) {
@@ -2158,26 +2158,26 @@ const char *decode_cmd_to_string(enum x86_decode_cmd cmd)
 }
 
 addr_t decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
-                          addr_t addr, x86_reg_segment seg)
+                          addr_t addr, X86Seg seg)
 {
     switch (decode->segment_override) {
     case PREFIX_CS_SEG_OVEERIDE:
-        seg = REG_SEG_CS;
+        seg = R_CS;
         break;
     case PREFIX_SS_SEG_OVEERIDE:
-        seg = REG_SEG_SS;
+        seg = R_SS;
         break;
     case PREFIX_DS_SEG_OVEERIDE:
-        seg = REG_SEG_DS;
+        seg = R_DS;
         break;
     case PREFIX_ES_SEG_OVEERIDE:
-        seg = REG_SEG_ES;
+        seg = R_ES;
         break;
     case PREFIX_FS_SEG_OVEERIDE:
-        seg = REG_SEG_FS;
+        seg = R_FS;
         break;
     case PREFIX_GS_SEG_OVEERIDE:
-        seg = REG_SEG_GS;
+        seg = R_GS;
         break;
     default:
         break;
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index 50957819f6..1b73a1f5b6 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -309,7 +309,7 @@ addr_t get_reg_val(CPUX86State *env, int reg, int is_extended, int size);
 void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
                         struct x86_decode_op *op);
 addr_t decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
-                          addr_t addr, x86_reg_segment seg);
+                          addr_t addr, enum X86Seg seg);
 
 void init_decoder(void);
 void calc_modrm_operand16(CPUX86State *env, struct x86_decode *decode,
diff --git a/target/i386/hvf/x86_descr.c b/target/i386/hvf/x86_descr.c
index 0b9562818f..269c46f53a 100644
--- a/target/i386/hvf/x86_descr.c
+++ b/target/i386/hvf/x86_descr.c
@@ -21,12 +21,12 @@
 #include "vmx.h"
 #include "x86_descr.h"
 
-#define VMX_SEGMENT_FIELD(seg)                      \
-    [REG_SEG_##seg] = {                           \
-        .selector = VMCS_GUEST_##seg##_SELECTOR,             \
-        .base = VMCS_GUEST_##seg##_BASE,                     \
-        .limit = VMCS_GUEST_##seg##_LIMIT,                   \
-        .ar_bytes = VMCS_GUEST_##seg##_ACCESS_RIGHTS,             \
+#define VMX_SEGMENT_FIELD(seg)                        \
+    [R_##seg] = {                                     \
+        .selector = VMCS_GUEST_##seg##_SELECTOR,      \
+        .base = VMCS_GUEST_##seg##_BASE,              \
+        .limit = VMCS_GUEST_##seg##_LIMIT,            \
+        .ar_bytes = VMCS_GUEST_##seg##_ACCESS_RIGHTS, \
 }
 
 static const struct vmx_segment_field {
@@ -45,34 +45,34 @@ static const struct vmx_segment_field {
     VMX_SEGMENT_FIELD(TR),
 };
 
-uint32_t vmx_read_segment_limit(CPUState *cpu, x86_reg_segment seg)
+uint32_t vmx_read_segment_limit(CPUState *cpu, X86Seg seg)
 {
     return (uint32_t)rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].limit);
 }
 
-uint32_t vmx_read_segment_ar(CPUState *cpu, x86_reg_segment seg)
+uint32_t vmx_read_segment_ar(CPUState *cpu, X86Seg seg)
 {
     return (uint32_t)rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].ar_bytes);
 }
 
-uint64_t vmx_read_segment_base(CPUState *cpu, x86_reg_segment seg)
+uint64_t vmx_read_segment_base(CPUState *cpu, X86Seg seg)
 {
     return rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].base);
 }
 
-x68_segment_selector vmx_read_segment_selector(CPUState *cpu, x86_reg_segment seg)
+x68_segment_selector vmx_read_segment_selector(CPUState *cpu, X86Seg seg)
 {
     x68_segment_selector sel;
     sel.sel = rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].selector);
     return sel;
 }
 
-void vmx_write_segment_selector(struct CPUState *cpu, x68_segment_selector selector, x86_reg_segment seg)
+void vmx_write_segment_selector(struct CPUState *cpu, x68_segment_selector selector, X86Seg seg)
 {
     wvmcs(cpu->hvf_fd, vmx_segment_fields[seg].selector, selector.sel);
 }
 
-void vmx_read_segment_descriptor(struct CPUState *cpu, struct vmx_segment *desc, x86_reg_segment seg)
+void vmx_read_segment_descriptor(struct CPUState *cpu, struct vmx_segment *desc, X86Seg seg)
 {
     desc->sel = rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].selector);
     desc->base = rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].base);
@@ -80,7 +80,7 @@ void vmx_read_segment_descriptor(struct CPUState *cpu, struct vmx_segment *desc,
     desc->ar = rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].ar_bytes);
 }
 
-void vmx_write_segment_descriptor(CPUState *cpu, struct vmx_segment *desc, x86_reg_segment seg)
+void vmx_write_segment_descriptor(CPUState *cpu, struct vmx_segment *desc, X86Seg seg)
 {
     const struct vmx_segment_field *sf = &vmx_segment_fields[seg];
 
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/hvf/x86_descr.h
index 034d8e95c5..25a2b1731c 100644
--- a/target/i386/hvf/x86_descr.h
+++ b/target/i386/hvf/x86_descr.h
@@ -30,18 +30,18 @@ typedef struct vmx_segment {
 
 /* deal with vmstate descriptors */
 void vmx_read_segment_descriptor(struct CPUState *cpu,
-                                 struct vmx_segment *desc, x86_reg_segment seg);
+                                 struct vmx_segment *desc, enum X86Seg seg);
 void vmx_write_segment_descriptor(CPUState *cpu, struct vmx_segment *desc,
-                                  x86_reg_segment seg);
+                                  enum X86Seg seg);
 
 x68_segment_selector vmx_read_segment_selector(struct CPUState *cpu,
-                                               x86_reg_segment seg);
+                                               enum X86Seg seg);
 void vmx_write_segment_selector(struct CPUState *cpu,
                                 x68_segment_selector selector,
-                                x86_reg_segment seg);
+                                enum X86Seg seg);
 
-uint64_t vmx_read_segment_base(struct CPUState *cpu, x86_reg_segment seg);
-void vmx_write_segment_base(struct CPUState *cpu, x86_reg_segment seg,
+uint64_t vmx_read_segment_base(struct CPUState *cpu, enum X86Seg seg);
+void vmx_write_segment_base(struct CPUState *cpu, enum X86Seg seg,
                             uint64_t base);
 
 void x86_segment_descriptor_to_vmx(struct CPUState *cpu,
@@ -49,8 +49,8 @@ void x86_segment_descriptor_to_vmx(struct CPUState *cpu,
                                    struct x86_segment_descriptor *desc,
                                    struct vmx_segment *vmx_desc);
 
-uint32_t vmx_read_segment_limit(CPUState *cpu, x86_reg_segment seg);
-uint32_t vmx_read_segment_ar(CPUState *cpu, x86_reg_segment seg);
+uint32_t vmx_read_segment_limit(CPUState *cpu, enum X86Seg seg);
+uint32_t vmx_read_segment_ar(CPUState *cpu, enum X86Seg seg);
 void vmx_segment_to_x86_descriptor(struct CPUState *cpu,
                                    struct vmx_segment *vmx_desc,
                                    struct x86_segment_descriptor *desc);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index f0f68f1c30..b64e490c2d 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -294,7 +294,7 @@ static void fetch_operands(struct CPUX86State *env, struct x86_decode *decode,
         case X86_VAR_OFFSET:
             decode->op[i].ptr = decode_linear_addr(env, decode,
                                                    decode->op[i].ptr,
-                                                   REG_SEG_DS);
+                                                   R_DS);
             if (calc_val[i]) {
                 decode->op[i].val = read_val_ext(env, decode->op[i].ptr,
                                                  decode->operand_size);
@@ -514,10 +514,10 @@ static inline void string_rep(struct CPUX86State *env, struct x86_decode *decode
                               void (*func)(struct CPUX86State *env,
                                            struct x86_decode *ins), int rep)
 {
-    addr_t rcx = read_reg(env, REG_RCX, decode->addressing_size);
+    addr_t rcx = read_reg(env, R_RCX, decode->addressing_size);
     while (rcx--) {
         func(env, decode);
-        write_reg(env, REG_RCX, rcx, decode->addressing_size);
+        write_reg(env, R_RCX, rcx, decode->addressing_size);
         if ((PREFIX_REP == rep) && !get_ZF(env)) {
             break;
         }
@@ -530,13 +530,13 @@ static inline void string_rep(struct CPUX86State *env, struct x86_decode *decode
 static void exec_ins_single(struct CPUX86State *env, struct x86_decode *decode)
 {
     addr_t addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
-                                   REG_SEG_ES);
+                                   R_ES);
 
     hvf_handle_io(ENV_GET_CPU(env), DX(env), env->hvf_emul->mmio_buf, 0,
                   decode->operand_size, 1);
     vmx_write_mem(ENV_GET_CPU(env), addr, env->hvf_emul->mmio_buf, decode->operand_size);
 
-    string_increment_reg(env, REG_RDI, decode);
+    string_increment_reg(env, R_RDI, decode);
 }
 
 static void exec_ins(struct CPUX86State *env, struct x86_decode *decode)
@@ -552,13 +552,13 @@ static void exec_ins(struct CPUX86State *env, struct x86_decode *decode)
 
 static void exec_outs_single(struct CPUX86State *env, struct x86_decode *decode)
 {
-    addr_t addr = decode_linear_addr(env, decode, RSI(env), REG_SEG_DS);
+    addr_t addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
     vmx_read_mem(ENV_GET_CPU(env), env->hvf_emul->mmio_buf, addr, decode->operand_size);
     hvf_handle_io(ENV_GET_CPU(env), DX(env), env->hvf_emul->mmio_buf, 1,
                   decode->operand_size, 1);
 
-    string_increment_reg(env, REG_RSI, decode);
+    string_increment_reg(env, R_RSI, decode);
 }
 
 static void exec_outs(struct CPUX86State *env, struct x86_decode *decode)
@@ -578,15 +578,15 @@ static void exec_movs_single(struct CPUX86State *env, struct x86_decode *decode)
     addr_t dst_addr;
     addr_t val;
 
-    src_addr = decode_linear_addr(env, decode, RSI(env), REG_SEG_DS);
+    src_addr = decode_linear_addr(env, decode, RSI(env), R_DS);
     dst_addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
-                                REG_SEG_ES);
+                                R_ES);
 
     val = read_val_ext(env, src_addr, decode->operand_size);
     write_val_ext(env, dst_addr, val, decode->operand_size);
 
-    string_increment_reg(env, REG_RSI, decode);
-    string_increment_reg(env, REG_RDI, decode);
+    string_increment_reg(env, R_RSI, decode);
+    string_increment_reg(env, R_RDI, decode);
 }
 
 static void exec_movs(struct CPUX86State *env, struct x86_decode *decode)
@@ -605,9 +605,9 @@ static void exec_cmps_single(struct CPUX86State *env, struct x86_decode *decode)
     addr_t src_addr;
     addr_t dst_addr;
 
-    src_addr = decode_linear_addr(env, decode, RSI(env), REG_SEG_DS);
+    src_addr = decode_linear_addr(env, decode, RSI(env), R_DS);
     dst_addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
-                                REG_SEG_ES);
+                                R_ES);
 
     decode->op[0].type = X86_VAR_IMMEDIATE;
     decode->op[0].val = read_val_ext(env, src_addr, decode->operand_size);
@@ -616,8 +616,8 @@ static void exec_cmps_single(struct CPUX86State *env, struct x86_decode *decode)
 
     EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
 
-    string_increment_reg(env, REG_RSI, decode);
-    string_increment_reg(env, REG_RDI, decode);
+    string_increment_reg(env, R_RSI, decode);
+    string_increment_reg(env, R_RDI, decode);
 }
 
 static void exec_cmps(struct CPUX86State *env, struct x86_decode *decode)
@@ -636,11 +636,11 @@ static void exec_stos_single(struct CPUX86State *env, struct x86_decode *decode)
     addr_t addr;
     addr_t val;
 
-    addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size, REG_SEG_ES);
-    val = read_reg(env, REG_RAX, decode->operand_size);
+    addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size, R_ES);
+    val = read_reg(env, R_RAX, decode->operand_size);
     vmx_write_mem(ENV_GET_CPU(env), addr, &val, decode->operand_size);
 
-    string_increment_reg(env, REG_RDI, decode);
+    string_increment_reg(env, R_RDI, decode);
 }
 
 
@@ -659,18 +659,18 @@ static void exec_scas_single(struct CPUX86State *env, struct x86_decode *decode)
 {
     addr_t addr;
 
-    addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size, REG_SEG_ES);
+    addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size, R_ES);
     decode->op[1].type = X86_VAR_IMMEDIATE;
     vmx_read_mem(ENV_GET_CPU(env), &decode->op[1].val, addr, decode->operand_size);
 
     EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
-    string_increment_reg(env, REG_RDI, decode);
+    string_increment_reg(env, R_RDI, decode);
 }
 
 static void exec_scas(struct CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
-    decode->op[0].reg = REG_RAX;
+    decode->op[0].reg = R_RAX;
     if (decode->rep) {
         string_rep(env, decode, exec_scas_single, decode->rep);
     } else {
@@ -685,11 +685,11 @@ static void exec_lods_single(struct CPUX86State *env, struct x86_decode *decode)
     addr_t addr;
     addr_t val = 0;
 
-    addr = decode_linear_addr(env, decode, RSI(env), REG_SEG_DS);
+    addr = decode_linear_addr(env, decode, RSI(env), R_DS);
     vmx_read_mem(ENV_GET_CPU(env), &val, addr,  decode->operand_size);
-    write_reg(env, REG_RAX, val, decode->operand_size);
+    write_reg(env, R_RAX, val, decode->operand_size);
 
-    string_increment_reg(env, REG_RSI, decode);
+    string_increment_reg(env, R_RSI, decode);
 }
 
 static void exec_lods(struct CPUX86State *env, struct x86_decode *decode)
@@ -840,7 +840,7 @@ void simulate_wrmsr(struct CPUState *cpu)
         env->hvf_emul->efer.efer = data;
         /*printf("new efer %llx\n", EFER(cpu));*/
         wvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER, data);
-        if (data & EFER_NXE) {
+        if (data & MSR_EFER_NXE) {
             hv_vcpu_invalidate_tlb(cpu->hvf_fd);
         }
         break;
@@ -1465,14 +1465,14 @@ void load_regs(struct CPUState *cpu)
     CPUX86State *env = &x86_cpu->env;
 
     int i = 0;
-    RRX(env, REG_RAX) = rreg(cpu->hvf_fd, HV_X86_RAX);
-    RRX(env, REG_RBX) = rreg(cpu->hvf_fd, HV_X86_RBX);
-    RRX(env, REG_RCX) = rreg(cpu->hvf_fd, HV_X86_RCX);
-    RRX(env, REG_RDX) = rreg(cpu->hvf_fd, HV_X86_RDX);
-    RRX(env, REG_RSI) = rreg(cpu->hvf_fd, HV_X86_RSI);
-    RRX(env, REG_RDI) = rreg(cpu->hvf_fd, HV_X86_RDI);
-    RRX(env, REG_RSP) = rreg(cpu->hvf_fd, HV_X86_RSP);
-    RRX(env, REG_RBP) = rreg(cpu->hvf_fd, HV_X86_RBP);
+    RRX(env, R_RAX) = rreg(cpu->hvf_fd, HV_X86_RAX);
+    RRX(env, R_RBX) = rreg(cpu->hvf_fd, HV_X86_RBX);
+    RRX(env, R_RCX) = rreg(cpu->hvf_fd, HV_X86_RCX);
+    RRX(env, R_RDX) = rreg(cpu->hvf_fd, HV_X86_RDX);
+    RRX(env, R_RSI) = rreg(cpu->hvf_fd, HV_X86_RSI);
+    RRX(env, R_RDI) = rreg(cpu->hvf_fd, HV_X86_RDI);
+    RRX(env, R_RSP) = rreg(cpu->hvf_fd, HV_X86_RSP);
+    RRX(env, R_RBP) = rreg(cpu->hvf_fd, HV_X86_RBP);
     for (i = 8; i < 16; i++) {
         RRX(env, i) = rreg(cpu->hvf_fd, HV_X86_RAX + i);
     }
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 22fde7fc39..6dbb1c6ce1 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -55,12 +55,12 @@ static void save_state_to_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
     tss->esi = ESI(env);
     tss->edi = EDI(env);
 
-    tss->es = vmx_read_segment_selector(cpu, REG_SEG_ES).sel;
-    tss->cs = vmx_read_segment_selector(cpu, REG_SEG_CS).sel;
-    tss->ss = vmx_read_segment_selector(cpu, REG_SEG_SS).sel;
-    tss->ds = vmx_read_segment_selector(cpu, REG_SEG_DS).sel;
-    tss->fs = vmx_read_segment_selector(cpu, REG_SEG_FS).sel;
-    tss->gs = vmx_read_segment_selector(cpu, REG_SEG_GS).sel;
+    tss->es = vmx_read_segment_selector(cpu, R_ES).sel;
+    tss->cs = vmx_read_segment_selector(cpu, R_CS).sel;
+    tss->ss = vmx_read_segment_selector(cpu, R_SS).sel;
+    tss->ds = vmx_read_segment_selector(cpu, R_DS).sel;
+    tss->fs = vmx_read_segment_selector(cpu, R_FS).sel;
+    tss->gs = vmx_read_segment_selector(cpu, R_GS).sel;
 }
 
 static void load_state_from_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
@@ -83,22 +83,22 @@ static void load_state_from_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
     RSI(env) = tss->esi;
     RDI(env) = tss->edi;
 
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ldt}}, REG_SEG_LDTR);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->es}}, REG_SEG_ES);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->cs}}, REG_SEG_CS);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ss}}, REG_SEG_SS);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ds}}, REG_SEG_DS);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->fs}}, REG_SEG_FS);
-    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->gs}}, REG_SEG_GS);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ldt}}, R_LDTR);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->es}}, R_ES);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->cs}}, R_CS);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ss}}, R_SS);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ds}}, R_DS);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->fs}}, R_FS);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->gs}}, R_GS);
 
 #if 0
-    load_segment(cpu, REG_SEG_LDTR, tss->ldt);
-    load_segment(cpu, REG_SEG_ES, tss->es);
-    load_segment(cpu, REG_SEG_CS, tss->cs);
-    load_segment(cpu, REG_SEG_SS, tss->ss);
-    load_segment(cpu, REG_SEG_DS, tss->ds);
-    load_segment(cpu, REG_SEG_FS, tss->fs);
-    load_segment(cpu, REG_SEG_GS, tss->gs);
+    load_segment(cpu, R_LDTR, tss->ldt);
+    load_segment(cpu, R_ES, tss->es);
+    load_segment(cpu, R_CS, tss->cs);
+    load_segment(cpu, R_SS, tss->ss);
+    load_segment(cpu, R_DS, tss->ds);
+    load_segment(cpu, R_FS, tss->fs);
+    load_segment(cpu, R_GS, tss->gs);
 #endif
 }
 
@@ -140,8 +140,8 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
 
     struct x86_segment_descriptor curr_tss_desc, next_tss_desc;
     int ret;
-    x68_segment_selector old_tss_sel = vmx_read_segment_selector(cpu, REG_SEG_TR);
-    uint64_t old_tss_base = vmx_read_segment_base(cpu, REG_SEG_TR);
+    x68_segment_selector old_tss_sel = vmx_read_segment_selector(cpu, R_TR);
+    uint64_t old_tss_base = vmx_read_segment_base(cpu, R_TR);
     uint32_t desc_limit;
     struct x86_call_gate task_gate_desc;
     struct vmx_segment vmx_seg;
@@ -158,7 +158,7 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
         ret = x86_read_call_gate(cpu, &task_gate_desc, gate);
 
         dpl = task_gate_desc.dpl;
-        x68_segment_selector cs = vmx_read_segment_selector(cpu, REG_SEG_CS);
+        x68_segment_selector cs = vmx_read_segment_selector(cpu, R_CS);
         if (tss_sel.rpl > dpl || cs.rpl > dpl)
             ;//DPRINTF("emulate_gp");
     }
@@ -192,7 +192,7 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
 
     macvm_set_cr0(cpu->hvf_fd, rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0) | CR0_TS);
     x86_segment_descriptor_to_vmx(cpu, tss_sel, &next_tss_desc, &vmx_seg);
-    vmx_write_segment_descriptor(cpu, &vmx_seg, REG_SEG_TR);
+    vmx_write_segment_descriptor(cpu, &vmx_seg, R_TR);
 
     store_regs(cpu);
 
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 83eb3be065..087deac6a9 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -107,28 +107,28 @@ void hvf_put_segments(CPUState *cpu_state)
     macvm_set_cr0(cpu_state->hvf_fd, env->cr[0]);
 
     hvf_set_segment(cpu_state, &seg, &env->segs[R_CS], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_CS);
+    vmx_write_segment_descriptor(cpu_state, &seg, R_CS);
     
     hvf_set_segment(cpu_state, &seg, &env->segs[R_DS], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_DS);
+    vmx_write_segment_descriptor(cpu_state, &seg, R_DS);
 
     hvf_set_segment(cpu_state, &seg, &env->segs[R_ES], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_ES);
+    vmx_write_segment_descriptor(cpu_state, &seg, R_ES);
 
     hvf_set_segment(cpu_state, &seg, &env->segs[R_SS], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_SS);
+    vmx_write_segment_descriptor(cpu_state, &seg, R_SS);
 
     hvf_set_segment(cpu_state, &seg, &env->segs[R_FS], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_FS);
+    vmx_write_segment_descriptor(cpu_state, &seg, R_FS);
 
     hvf_set_segment(cpu_state, &seg, &env->segs[R_GS], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_GS);
+    vmx_write_segment_descriptor(cpu_state, &seg, R_GS);
 
     hvf_set_segment(cpu_state, &seg, &env->tr, true);
-    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_TR);
+    vmx_write_segment_descriptor(cpu_state, &seg, R_TR);
 
     hvf_set_segment(cpu_state, &seg, &env->ldt, false);
-    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_LDTR);
+    vmx_write_segment_descriptor(cpu_state, &seg, R_LDTR);
     
     hv_vcpu_flush(cpu_state->hvf_fd);
 }
@@ -183,28 +183,28 @@ void hvf_get_segments(CPUState *cpu_state)
 
     env->interrupt_injected = -1;
 
-    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_CS);
+    vmx_read_segment_descriptor(cpu_state, &seg, R_CS);
     hvf_get_segment(&env->segs[R_CS], &seg);
     
-    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_DS);
+    vmx_read_segment_descriptor(cpu_state, &seg, R_DS);
     hvf_get_segment(&env->segs[R_DS], &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_ES);
+    vmx_read_segment_descriptor(cpu_state, &seg, R_ES);
     hvf_get_segment(&env->segs[R_ES], &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_FS);
+    vmx_read_segment_descriptor(cpu_state, &seg, R_FS);
     hvf_get_segment(&env->segs[R_FS], &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_GS);
+    vmx_read_segment_descriptor(cpu_state, &seg, R_GS);
     hvf_get_segment(&env->segs[R_GS], &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_SS);
+    vmx_read_segment_descriptor(cpu_state, &seg, R_SS);
     hvf_get_segment(&env->segs[R_SS], &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_TR);
+    vmx_read_segment_descriptor(cpu_state, &seg, R_TR);
     hvf_get_segment(&env->tr, &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_LDTR);
+    vmx_read_segment_descriptor(cpu_state, &seg, R_LDTR);
     hvf_get_segment(&env->ldt, &seg);
 
     env->idt.limit = rvmcs(cpu_state->hvf_fd, VMCS_GUEST_IDTR_LIMIT);
-- 
2.13.6
