Received: from eggs.gnu.org ([2001:4830:134:3::10]:34359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWh5-0002lD-ST
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWh2-0006f2-MA
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:23 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50544)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWh2-0006eU-3K
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:20 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:54:17 +0300
Message-ID: <154401445762.8440.8972233788056583038.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 24/39] windbg: [de]serialization cpu context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 target/i386/windbgstub.c |  374 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 372 insertions(+), 2 deletions(-)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index e2ed2b3105..7a091e1dee 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -280,7 +280,6 @@ static InitedAddr kdDebuggerDataBlock;
 static InitedAddr kdVersion;
 #endif /* TARGET_I386 */
 
-__attribute__ ((unused)) /* unused yet */
 static void windbg_set_dr(CPUState *cs, int index, target_ulong value)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -300,7 +299,6 @@ static void windbg_set_dr(CPUState *cs, int index, target_ulong value)
 }
 
 /* copy from gdbstub.c */
-__attribute__ ((unused)) /* unused yet */
 static void windbg_set_sr(CPUState *cs, int sreg, uint16_t selector)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -403,6 +401,378 @@ static void windbg_set_sr(CPUState *cs, int sreg, uint16_t selector)
     CASE_FIELD(stct, field, field_size, block)
 #endif /* TARGET_I386 */
 
+#define GEN_WINDBG_CONTEXT_RW(fun_name, is_read)                               \
+static int fun_name(CPUState *cs, uint8_t *buf, int buf_size,                  \
+                    int offset, int len)                                       \
+{                                                                              \
+    X86CPU *cpu = X86_CPU(cs);                                                 \
+    CPUX86State *env = &cpu->env;                                              \
+    uint32_t ctx_flags = CPU_CONTEXT_ALL;                                      \
+    uint32_t tmp32, i;                                                         \
+    uint32_t f_size = 0;                                                       \
+                                                                               \
+    if (len < 0 || len > buf_size) {                                           \
+        WINDBG_ERROR("" #fun_name ": incorrect length %d", len);               \
+        return 1;                                                              \
+    }                                                                          \
+                                                                               \
+    if (offset < 0 || offset + len > sizeof(CPU_CONTEXT)) {                    \
+        WINDBG_ERROR("" #fun_name ": incorrect offset %d", offset);            \
+        return 2;                                                              \
+    }                                                                          \
+                                                                               \
+    len = MIN(len, sizeof(CPU_CONTEXT) - offset);                              \
+                                                                               \
+    while (offset < len) {                                                     \
+        switch (offset) {                                                      \
+        CASE_FIELD(CPU_CONTEXT, ContextFlags, f_size, {                        \
+            rwl_p(buf, ctx_flags, is_read);                                    \
+        });                                                                    \
+        /* DEBUG REGISTERS */                                                  \
+        CASE_FIELD(CPU_CONTEXT, Dr0, f_size, {                                 \
+            if (ctx_flags & CPU_CONTEXT_DEBUG_REGISTERS) {                     \
+                RW_DR(buf, cs, 0, is_read);                                    \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, Dr1, f_size, {                                 \
+            if (ctx_flags & CPU_CONTEXT_DEBUG_REGISTERS) {                     \
+                RW_DR(buf, cs, 1, is_read);                                    \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, Dr2, f_size, {                                 \
+            if (ctx_flags & CPU_CONTEXT_DEBUG_REGISTERS) {                     \
+                RW_DR(buf, cs, 2, is_read);                                    \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, Dr3, f_size, {                                 \
+            if (ctx_flags & CPU_CONTEXT_DEBUG_REGISTERS) {                     \
+                RW_DR(buf, cs, 3, is_read);                                    \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, Dr6, f_size, {                                 \
+            if (ctx_flags & CPU_CONTEXT_DEBUG_REGISTERS) {                     \
+                RW_DR(buf, cs, 6, is_read);                                    \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, Dr7, f_size, {                                 \
+            if (ctx_flags & CPU_CONTEXT_DEBUG_REGISTERS) {                     \
+                RW_DR(buf, cs, 7, is_read);                                    \
+            }                                                                  \
+        });                                                                    \
+        /* SEGMENT REGISTERS */                                                \
+        CASE_FIELD(CPU_CONTEXT, SegCs, f_size, {                               \
+            if (ctx_flags & CPU_CONTEXT_SEGMENTS) {                            \
+                RW_SR(buf, cs, R_CS, is_read);                                 \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, SegDs, f_size, {                               \
+            if (ctx_flags & CPU_CONTEXT_SEGMENTS) {                            \
+                RW_SR(buf, cs, R_DS, is_read);                                 \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, SegEs, f_size, {                               \
+            if (ctx_flags & CPU_CONTEXT_SEGMENTS) {                            \
+                RW_SR(buf, cs, R_ES, is_read);                                 \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, SegFs, f_size, {                               \
+            if (ctx_flags & CPU_CONTEXT_SEGMENTS) {                            \
+                RW_SR(buf, cs, R_FS, is_read);                                 \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, SegGs, f_size, {                               \
+            if (ctx_flags & CPU_CONTEXT_SEGMENTS) {                            \
+                RW_SR(buf, cs, R_GS, is_read);                                 \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, SegSs, f_size, {                               \
+            if (ctx_flags & CPU_CONTEXT_SEGMENTS) {                            \
+                RW_SR(buf, cs, R_SS, is_read);                                 \
+            }                                                                  \
+        });                                                                    \
+        /* INTEGER REGISTERS */                                                \
+        CASE_FIELD_X32_64(CPU_CONTEXT, Eax, Rax, f_size, {                     \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[R_EAX], is_read);                       \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X32_64(CPU_CONTEXT, Ecx, Rcx, f_size, {                     \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[R_ECX], is_read);                       \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X32_64(CPU_CONTEXT, Edx, Rdx, f_size, {                     \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[R_EDX], is_read);                       \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X32_64(CPU_CONTEXT, Ebx, Rbx, f_size, {                     \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[R_EBX], is_read);                       \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X32_64(CPU_CONTEXT, Esi, Rsi, f_size, {                     \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[R_ESI], is_read);                       \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X32_64(CPU_CONTEXT, Edi, Rdi, f_size, {                     \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[R_EDI], is_read);                       \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, R8, f_size, {                              \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[8], is_read);                           \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, R9, f_size, {                              \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[9], is_read);                           \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, R10, f_size, {                             \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[10], is_read);                          \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, R11, f_size, {                             \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[11], is_read);                          \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, R12, f_size, {                             \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[12], is_read);                          \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, R13, f_size, {                             \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[13], is_read);                          \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, R14, f_size, {                             \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[14], is_read);                          \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, R15, f_size, {                             \
+            if (ctx_flags & CPU_CONTEXT_INTEGER) {                             \
+                rwtul_p(buf, env->regs[15], is_read);                          \
+            }                                                                  \
+        });                                                                    \
+        /* CONTROL REGISTERS */                                                \
+        CASE_FIELD_X32_64(CPU_CONTEXT, Esp, Rsp, f_size, {                     \
+            if (ctx_flags & CPU_CONTEXT_CONTROL) {                             \
+                rwtul_p(buf, env->regs[R_ESP], is_read);                       \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X32_64(CPU_CONTEXT, Ebp, Rbp, f_size, {                     \
+            if (ctx_flags & CPU_CONTEXT_CONTROL) {                             \
+                rwtul_p(buf, env->regs[R_EBP], is_read);                       \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X32_64(CPU_CONTEXT, Eip, Rip, f_size, {                     \
+            if (ctx_flags & CPU_CONTEXT_CONTROL) {                             \
+                rwtul_p(buf, env->eip, is_read);                               \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, EFlags, f_size, {                              \
+            if (ctx_flags & CPU_CONTEXT_CONTROL) {                             \
+                rwl_p(buf, env->eflags, is_read);                              \
+            }                                                                  \
+        });                                                                    \
+        /* FLOAT REGISTERS */                                                  \
+        CASE_FIELD(CPU_CONTEXT, FloatSave.ControlWord, f_size, {               \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                if (is_read) {                                                 \
+                    cpu_set_fpuc(env, TARGET_SAFE(ldl_p, lduw_p)(buf));        \
+                } else {                                                       \
+                    TARGET_SAFE(stl_p, stw_p)(buf, env->fpuc);                 \
+                }                                                              \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, FloatSave.StatusWord, f_size, {                \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                if (is_read) {                                                 \
+                    tmp32 = TARGET_SAFE(ldl_p, lduw_p)(buf);                   \
+                    env->fpstt = (tmp32 >> 11) & 7;                            \
+                    env->fpus = tmp32 & ~0x3800;                               \
+                } else {                                                       \
+                    tmp32 = env->fpus & ~(7 << 11);                            \
+                    tmp32 |= (env->fpstt & 7) << 11;                           \
+                    TARGET_SAFE(stl_p, stw_p)(buf, tmp32);                     \
+                }                                                              \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, FloatSave.TagWord, f_size, {                   \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                if (is_read) {                                                 \
+                    tmp32 = TARGET_SAFE(ldl_p(buf), buf[0]);                   \
+                    for (i = 0; i < 8; ++i) {                                  \
+                        env->fptags[i] = !((tmp32 >> i) & 1);                  \
+                    }                                                          \
+                } else {                                                       \
+                    tmp32 = 0;                                                 \
+                    for (i = 0; i < 8; ++i) {                                  \
+                        tmp32 |= (!env->fptags[i]) << i;                       \
+                    }                                                          \
+                    TARGET_SAFE(stl_p, stb_p)(buf, tmp32);                     \
+                }                                                              \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, FloatSave.Reserved1, f_size, {});          \
+        CASE_FIELD_X64(CPU_CONTEXT, FloatSave.ErrorOpcode, f_size, {           \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                rwuw_p(buf, env->fpop, is_read);                               \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, FloatSave.ErrorOffset, f_size, {               \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                if (is_read) {                                                 \
+                    env->fpip &= ~0xffffffffL;                                 \
+                    env->fpip |= ldl_p(buf);                                   \
+                } else {                                                       \
+                    stl_p(buf, env->fpip & 0xffffffff);                        \
+                }                                                              \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, FloatSave.ErrorSelector, f_size, {             \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                if (is_read) {                                                 \
+                    env->fpip &= 0xffffffffL;                                  \
+                    env->fpip |= ((uint64_t) ldl_p(buf)) << 32;                \
+                } else {                                                       \
+                    stl_p(buf, (env->fpip >> 32) & 0xffffffff);                \
+                }                                                              \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, FloatSave.Reserved2, f_size, {});          \
+        CASE_FIELD(CPU_CONTEXT, FloatSave.DataOffset, f_size, {                \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                if (is_read) {                                                 \
+                    env->fpdp &= ~0xffffffffL;                                 \
+                    env->fpdp |= ldl_p(buf);                                   \
+                } else {                                                       \
+                    stl_p(buf, env->fpdp & 0xffffffff);                        \
+                }                                                              \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_CONTEXT, FloatSave.DataSelector, f_size, {              \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                if (is_read) {                                                 \
+                    env->fpdp &= 0xffffffffL;                                  \
+                    env->fpdp |= ((uint64_t) ldl_p(buf)) << 32;                \
+                } else {                                                       \
+                    stl_p(buf, (env->fpdp >> 32) & 0xffffffff);                \
+                }                                                              \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, FloatSave.Reserved3, f_size, {});          \
+        CASE_FIELD_X32(CPU_CONTEXT, FloatSave.Cr0NpxState, f_size, {           \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                rwl_p(buf, env->xcr0, is_read);                                \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, FloatSave.MxCsr, f_size, {                 \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                rwl_p(buf, env->mxcsr, is_read);                               \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, FloatSave.MxCsr_Mask, f_size, {            \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                /* FIXME: this is unimplemented in qemu? */                    \
+                /* rwl_p(buf, env->mxcsr_mask, is_read); */                    \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X32_64(CPU_CONTEXT, FloatSave.RegisterArea,                 \
+                                       FloatSave.FloatRegisters, f_size, {     \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                uint8_t *mem = buf;                                            \
+                for (i = 0; i < 8; ++i, mem += TARGET_SAFE(10, 16)) {          \
+                    floatx80 fl = env->fpregs[i].d;                            \
+                    if (is_read) {                                             \
+                        fl.low = ldq_p(mem);                                   \
+                        fl.high = TARGET_SAFE(lduw_p, ldq_p)(mem + 8);         \
+                    } else {                                                   \
+                        stq_p(mem, fl.low);                                    \
+                        TARGET_SAFE(stw_p, stq_p)(mem + 8, fl.high);           \
+                    }                                                          \
+                }                                                              \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, FloatSave.XmmRegisters, f_size, {          \
+            if (ctx_flags & CPU_CONTEXT_FLOATING_POINT) {                      \
+                uint8_t *mem = buf;                                            \
+                if (is_read) {                                                 \
+                    for (i = 0; i < CPU_NB_REGS; ++i, mem += 16) {             \
+                        env->xmm_regs[i].ZMM_Q(0) = ldl_p(mem);                \
+                        env->xmm_regs[i].ZMM_Q(1) = ldl_p(mem + 8);            \
+                    }                                                          \
+                } else {                                                       \
+                    for (i = 0; i < CPU_NB_REGS; ++i, mem += 16) {             \
+                        stq_p(mem, env->xmm_regs[i].ZMM_Q(0));                 \
+                        stq_p(mem + 8, env->xmm_regs[i].ZMM_Q(1));             \
+                    }                                                          \
+                }                                                              \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, FloatSave.Reserved4, f_size, {});          \
+        /* EXTENDED REGISTERS I386 */                                          \
+        CASE_FIELD_X32(CPU_CONTEXT, ExtendedRegisters, f_size, {               \
+            if (ctx_flags & CPU_CONTEXT_EXTENDED_REGISTERS) {                  \
+                uint8_t *mem = buf + 160;                                      \
+                if (is_read) {                                                 \
+                    for (i = 0; i < CPU_NB_REGS; ++i, mem += 16) {             \
+                        env->xmm_regs[i].ZMM_Q(0) = ldl_p(mem);                \
+                        env->xmm_regs[i].ZMM_Q(1) = ldl_p(mem + 8);            \
+                    }                                                          \
+                    cpu_set_mxcsr(env, ldl_p(mem + 24));                       \
+                } else {                                                       \
+                    for (i = 0; i < CPU_NB_REGS; ++i, mem += 16) {             \
+                        stq_p(mem, env->xmm_regs[i].ZMM_Q(0));                 \
+                        stq_p(mem + 8, env->xmm_regs[i].ZMM_Q(1));             \
+                    }                                                          \
+                    stl_p(mem + 24, env->mxcsr);                               \
+                }                                                              \
+            }                                                                  \
+        });                                                                    \
+        /* UNKNOWN REGISTERS */                                                \
+        CASE_FIELD_X64(CPU_CONTEXT, P1Home, f_size, {});                       \
+        CASE_FIELD_X64(CPU_CONTEXT, P2Home, f_size, {});                       \
+        CASE_FIELD_X64(CPU_CONTEXT, P3Home, f_size, {});                       \
+        CASE_FIELD_X64(CPU_CONTEXT, P4Home, f_size, {});                       \
+        CASE_FIELD_X64(CPU_CONTEXT, P5Home, f_size, {});                       \
+        CASE_FIELD_X64(CPU_CONTEXT, P6Home, f_size, {});                       \
+        CASE_FIELD_X64(CPU_CONTEXT, MxCsr, f_size, {                           \
+            if (is_read) {                                                     \
+                cpu_set_mxcsr(env, ldl_p(buf));                                \
+            } else {                                                           \
+                stl_p(buf, env->mxcsr);                                        \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_CONTEXT, VectorRegister, f_size, {});               \
+        CASE_FIELD_X64(CPU_CONTEXT, VectorControl, f_size, {});                \
+        CASE_FIELD_X64(CPU_CONTEXT, DebugControl, f_size, {});                 \
+        CASE_FIELD_X64(CPU_CONTEXT, LastBranchToRip, f_size, {});              \
+        CASE_FIELD_X64(CPU_CONTEXT, LastBranchFromRip, f_size, {});            \
+        CASE_FIELD_X64(CPU_CONTEXT, LastExceptionToRip, f_size, {});           \
+        CASE_FIELD_X64(CPU_CONTEXT, LastExceptionFromRip, f_size, {});         \
+        default:                                                               \
+            f_size = 1;                                                        \
+        }                                                                      \
+        offset += f_size;                                                      \
+        buf += f_size;                                                         \
+    }                                                                          \
+    return 0;                                                                  \
+}
+
+__attribute__ ((unused)) /* unused yet */
+GEN_WINDBG_CONTEXT_RW(windbg_read_context, false)
+
+__attribute__ ((unused)) /* unused yet */
+GEN_WINDBG_CONTEXT_RW(windbg_write_context, true)
+
 static bool find_KPCR(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
