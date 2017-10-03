Received: from eggs.gnu.org ([2001:4830:134:3::10]:40129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWf-00020W-Gu
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWa-00046E-S5
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:21 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzNWa-00045O-Hk
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:16 -0400
Received: by mail-wr0-x244.google.com with SMTP id z1so5918512wre.1
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:46:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 15:45:34 +0200
Message-Id: <20171003134540.21625-5-pbonzini@redhat.com>
In-Reply-To: <20171003134540.21625-1-pbonzini@redhat.com>
References: <20171003134540.21625-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 04/10] i386: hvf: remove more dead emulator code
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
 target/i386/hvf/hvf.c        |  2 --
 target/i386/hvf/x86.h        |  5 -----
 target/i386/hvf/x86_decode.c | 22 +++++++++++-----------
 target/i386/hvf/x86_emu.c    | 25 ++++++++-----------------
 target/i386/hvf/x86_flags.c  | 10 ----------
 target/i386/hvf/x86_flags.h  |  1 -
 target/i386/hvf/x86_mmu.c    |  6 ++----
 target/i386/hvf/x86_task.c   | 10 ----------
 8 files changed, 21 insertions(+), 60 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 863226cc9a..ae3ecad2a4 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -739,7 +739,6 @@ int hvf_vcpu_exec(CPUState *cpu)
             uint32_t port =  exit_qual >> 16;
             /*uint32_t rep = (exit_qual & 0x20) != 0;*/
 
-#if 1
             if (!string && in) {
                 uint64_t val = 0;
                 load_regs(cpu);
@@ -762,7 +761,6 @@ int hvf_vcpu_exec(CPUState *cpu)
                 macvm_set_rip(cpu, rip + ins_len);
                 break;
             }
-#endif
             struct x86_decode decode;
 
             load_regs(cpu);
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 650bb718bf..94ac67b5cb 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -103,10 +103,6 @@ typedef struct x86_reg_flags {
     };
 } __attribute__ ((__packed__)) x86_reg_flags;
 
-typedef struct x86_efer {
-    uint64_t efer;
-} __attribute__ ((__packed__)) x86_efer;
-
 typedef enum x86_reg_cr0 {
     CR0_PE =            (1L << 0),
     CR0_MP =            (1L << 1),
@@ -306,7 +302,6 @@ typedef struct HVFX86EmulatorState {
     struct x86_register regs[16];
     struct x86_reg_flags   rflags;
     struct lazy_flags   lflags;
-    struct x86_efer efer;
     uint8_t mmio_buf[4096];
 } HVFX86EmulatorState;
 
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 86e7c4ee7a..24c732d9f1 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -630,7 +630,7 @@ static void decode_aegroup(CPUX86State *env, struct x86_decode *decode)
         }
         break;
     default:
-        VM_PANIC_ON_EX(1, "0xae: reg %d\n", decode->modrm.reg);
+        VM_PANIC_EX("0xae: reg %d\n", decode->modrm.reg);
         break;
     }
 }
@@ -654,14 +654,14 @@ static void decode_d9_4(CPUX86State *env, struct x86_decode *decode)
         decode->cmd = X86_DECODE_CMD_FABS;
         break;
     case 0xe4:
-        VM_PANIC_ON_EX(1, "FTST");
+        VM_PANIC("FTST");
         break;
     case 0xe5:
         /* FXAM */
         decode->cmd = X86_DECODE_CMD_FXAM;
         break;
     default:
-        VM_PANIC_ON_EX(1, "FLDENV");
+        VM_PANIC("FLDENV");
         break;
     }
 }
@@ -670,16 +670,16 @@ static void decode_db_4(CPUX86State *env, struct x86_decode *decode)
 {
     switch (decode->modrm.modrm) {
     case 0xe0:
-        VM_PANIC_ON_EX(1, "unhandled FNENI: %x %x\n", decode->opcode[0],
-                       decode->modrm.modrm);
+        VM_PANIC_EX("unhandled FNENI: %x %x\n", decode->opcode[0],
+                    decode->modrm.modrm);
         break;
     case 0xe1:
-        VM_PANIC_ON_EX(1, "unhandled FNDISI: %x %x\n", decode->opcode[0],
-                       decode->modrm.modrm);
+        VM_PANIC_EX("unhandled FNDISI: %x %x\n", decode->opcode[0],
+                    decode->modrm.modrm);
         break;
     case 0xe2:
-        VM_PANIC_ON_EX(1, "unhandled FCLEX: %x %x\n", decode->opcode[0],
-                       decode->modrm.modrm);
+        VM_PANIC_EX("unhandled FCLEX: %x %x\n", decode->opcode[0],
+                    decode->modrm.modrm);
         break;
     case 0xe3:
         decode->cmd = X86_DECODE_CMD_FNINIT;
@@ -688,8 +688,8 @@ static void decode_db_4(CPUX86State *env, struct x86_decode *decode)
         decode->cmd = X86_DECODE_CMD_FNSETPM;
         break;
     default:
-        VM_PANIC_ON_EX(1, "unhandled fpu opcode: %x %x\n", decode->opcode[0],
-                       decode->modrm.modrm);
+        VM_PANIC_EX("unhandled fpu opcode: %x %x\n", decode->opcode[0],
+                    decode->modrm.modrm);
         break;
     }
 }
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index b64e490c2d..3a995fe687 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -837,7 +837,6 @@ void simulate_wrmsr(struct CPUState *cpu)
         abort();
         break;
     case MSR_EFER:
-        env->hvf_emul->efer.efer = data;
         /*printf("new efer %llx\n", EFER(cpu));*/
         wvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER, data);
         if (data & MSR_EFER_NXE) {
@@ -1511,23 +1510,15 @@ bool exec_instruction(struct CPUX86State *env, struct x86_decode *ins)
     printf("%d, %llx: exec_instruction %s\n", hvf_vcpu_id(cpu),  RIP(cpu),
           decode_cmd_to_string(ins->cmd));*/
 
-    if (0 && ins->is_fpu) {
-        VM_PANIC("emulate fpu\n");
-    } else {
-        if (!_cmd_handler[ins->cmd].handler) {
-            printf("Unimplemented handler (%llx) for %d (%x %x) \n", RIP(env),
-                    ins->cmd, ins->opcode[0],
-                    ins->opcode_len > 1 ? ins->opcode[1] : 0);
-            RIP(env) += ins->len;
-            return true;
-        }
-
-        VM_PANIC_ON_EX(!_cmd_handler[ins->cmd].handler,
-                "Unimplemented handler (%llx) for %d (%x %x) \n", RIP(env),
-                 ins->cmd, ins->opcode[0],
-                 ins->opcode_len > 1 ? ins->opcode[1] : 0);
-        _cmd_handler[ins->cmd].handler(env, ins);
+    if (!_cmd_handler[ins->cmd].handler) {
+        printf("Unimplemented handler (%llx) for %d (%x %x) \n", RIP(env),
+                ins->cmd, ins->opcode[0],
+                ins->opcode_len > 1 ? ins->opcode[1] : 0);
+        RIP(env) += ins->len;
+        return true;
     }
+
+    _cmd_handler[ins->cmd].handler(env, ins);
     return true;
 }
 
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index c833774485..e7bbce75e1 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -301,16 +301,6 @@ void set_SF(CPUX86State *env, bool val)
     env->hvf_emul->lflags.auxbits ^= (temp_sf ^ val) << LF_BIT_SD;
 }
 
-void set_OSZAPC(CPUX86State *env, uint32_t flags32)
-{
-    set_OF(env, env->hvf_emul->rflags.of);
-    set_SF(env, env->hvf_emul->rflags.sf);
-    set_ZF(env, env->hvf_emul->rflags.zf);
-    set_AF(env, env->hvf_emul->rflags.af);
-    set_PF(env, env->hvf_emul->rflags.pf);
-    set_CF(env, env->hvf_emul->rflags.cf);
-}
-
 void lflags_to_rflags(CPUX86State *env)
 {
     env->hvf_emul->rflags.cf = get_CF(env);
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/hvf/x86_flags.h
index 57a524240c..3e487535ea 100644
--- a/target/i386/hvf/x86_flags.h
+++ b/target/i386/hvf/x86_flags.h
@@ -190,7 +190,6 @@ bool get_SF(CPUX86State *env);
 void set_SF(CPUX86State *env, bool val);
 bool get_OF(CPUX86State *env);
 void set_OF(CPUX86State *env, bool val);
-void set_OSZAPC(CPUX86State *env, uint32_t flags32);
 
 void SET_FLAGS_OxxxxC(CPUX86State *env, uint32_t new_of, uint32_t new_cf);
 
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 26e9e95b0b..1084670c1d 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -238,8 +238,7 @@ void vmx_write_mem(struct CPUState *cpu, addr_t gva, void *data, int bytes)
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_ON_EX(1, "%s: mmu_gva_to_gpa %llx failed\n", __func__,
-                           gva);
+            VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
         } else {
             address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
                              data, copy, 1);
@@ -260,8 +259,7 @@ void vmx_read_mem(struct CPUState *cpu, void *data, addr_t gva, int bytes)
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_ON_EX(1, "%s: mmu_gva_to_gpa %llx failed\n", __func__,
-                           gva);
+            VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
         }
         address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
                          data, copy, 0);
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 6dbb1c6ce1..b6ce2a151b 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -90,16 +90,6 @@ static void load_state_from_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
     vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ds}}, R_DS);
     vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->fs}}, R_FS);
     vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->gs}}, R_GS);
-
-#if 0
-    load_segment(cpu, R_LDTR, tss->ldt);
-    load_segment(cpu, R_ES, tss->es);
-    load_segment(cpu, R_CS, tss->cs);
-    load_segment(cpu, R_SS, tss->ss);
-    load_segment(cpu, R_DS, tss->ds);
-    load_segment(cpu, R_FS, tss->fs);
-    load_segment(cpu, R_GS, tss->gs);
-#endif
 }
 
 static int task_switch_32(CPUState *cpu, x68_segment_selector tss_sel, x68_segment_selector old_tss_sel,
-- 
2.13.6
