Received: from eggs.gnu.org ([2001:4830:134:3::10]:41907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsL9-0000bb-M1
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsL5-0005kf-7V
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:11 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60274)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsL3-0005jc-1Z
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:07 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:00:58 +0300
Message-ID: <154409765859.5432.12915507765102369275.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 25/39] windbg: [de]serialization cpu spec
 registers
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
 target/i386/windbgstub.c |  123 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 7a091e1dee..a1d27b8aca 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -767,12 +767,135 @@ static int fun_name(CPUState *cs, uint8_t *buf, int buf_size,                  \
     return 0;                                                                  \
 }
 
+#define GEN_WINDBG_KSPEC_REGS_RW(fun_name, is_read)                            \
+static int fun_name(CPUState *cs, uint8_t *buf, int buf_size,                  \
+                    int offset, int len)                                       \
+{                                                                              \
+    X86CPU *cpu = X86_CPU(cs);                                                 \
+    CPUX86State *env = &cpu->env;                                              \
+    uint32_t f_size = 0;                                                       \
+                                                                               \
+    if (len < 0 || len > buf_size) {                                           \
+        WINDBG_ERROR("" #fun_name ": incorrect length %d", len);               \
+        return 1;                                                              \
+    }                                                                          \
+                                                                               \
+    if (offset < 0 || offset + len > sizeof(CPU_KSPECIAL_REGISTERS)) {         \
+        WINDBG_ERROR("" #fun_name ": incorrect offset %d", f_size);            \
+        return 2;                                                              \
+    }                                                                          \
+                                                                               \
+    len = MIN(len, sizeof(CPU_KSPECIAL_REGISTERS) - offset);                   \
+                                                                               \
+    while (offset < len) {                                                     \
+        switch (offset) {                                                      \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Cr0, f_size, {                      \
+            RW_CR(buf, cs, 0, is_read);                                        \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Cr2, f_size, {                      \
+            if (is_read) {                                                     \
+                env->cr[2] = (int32_t) ldtul_p(buf);                           \
+            } else {                                                           \
+                sttul_p(buf, (target_ulong) env->cr[2]);                       \
+            }                                                                  \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Cr3, f_size, {                      \
+            RW_CR(buf, cs, 3, is_read);                                        \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Cr4, f_size, {                      \
+            RW_CR(buf, cs, 4, is_read);                                        \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, KernelDr0, f_size, {                \
+            RW_DR(buf, cs, 0, is_read);                                        \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, KernelDr1, f_size, {                \
+            RW_DR(buf, cs, 1, is_read);                                        \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, KernelDr2, f_size, {                \
+            RW_DR(buf, cs, 2, is_read);                                        \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, KernelDr3, f_size, {                \
+            RW_DR(buf, cs, 3, is_read);                                        \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, KernelDr6, f_size, {                \
+            RW_DR(buf, cs, 6, is_read);                                        \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, KernelDr7, f_size, {                \
+            RW_DR(buf, cs, 7, is_read);                                        \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Gdtr.Pad, f_size, {});              \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Gdtr.Limit, f_size, {               \
+            rwuw_p(buf, env->gdt.limit, is_read);                              \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Gdtr.Base, f_size, {                \
+            rwtul_p(buf, env->gdt.base, is_read);                              \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Idtr.Pad, f_size, {});              \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Idtr.Limit, f_size, {               \
+            rwuw_p(buf, env->idt.limit, is_read);                              \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Idtr.Base, f_size, {                \
+            rwtul_p(buf, env->idt.base, is_read);                              \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Tr, f_size, {                       \
+            rwuw_p(buf, env->tr.selector, is_read);                            \
+        });                                                                    \
+        CASE_FIELD(CPU_KSPECIAL_REGISTERS, Ldtr, f_size, {                     \
+            rwuw_p(buf, env->tr.selector, is_read);                            \
+        });                                                                    \
+        CASE_FIELD_X32(CPU_KSPECIAL_REGISTERS, Reserved, f_size, {});          \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, MxCsr, f_size, {                \
+            rwl_p(buf, env->mxcsr, is_read);                                   \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, DebugControl, f_size, {});      \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, LastBranchToRip, f_size, {});   \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, LastBranchFromRip, f_size, {}); \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, LastExceptionToRip, f_size, {});\
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, LastExceptionFromRip, f_size, { \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, Cr8, f_size, {});               \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, MsrGsBase, f_size, {            \
+            rwtul_p(buf, env->segs[R_GS].base, is_read);                       \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, MsrGsSwap, f_size, {            \
+            rwtul_p(buf, env->kernelgsbase, is_read);                          \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, MsrStar, f_size, {              \
+            rwtul_p(buf, env->star, is_read);                                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, MsrLStar, f_size, {             \
+            rwtul_p(buf, env->lstar, is_read);                                 \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, MsrCStar, f_size, {             \
+            rwtul_p(buf, env->cstar, is_read);                                 \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, MsrSyscallMask, f_size, {       \
+            /* NOTE: Unimplemented in qemu: msr MSR_SFMASK */                  \
+        });                                                                    \
+        CASE_FIELD_X64(CPU_KSPECIAL_REGISTERS, Xcr0, f_size, {                 \
+            rwtul_p(buf, env->xcr0, is_read);                                  \
+        });                                                                    \
+        default:                                                               \
+            f_size = 1;                                                        \
+        }                                                                      \
+        offset += f_size;                                                      \
+        buf += f_size;                                                         \
+    }                                                                          \
+    return 0;                                                                  \
+}
+
 __attribute__ ((unused)) /* unused yet */
 GEN_WINDBG_CONTEXT_RW(windbg_read_context, false)
 
 __attribute__ ((unused)) /* unused yet */
 GEN_WINDBG_CONTEXT_RW(windbg_write_context, true)
 
+__attribute__ ((unused)) /* unused yet */
+GEN_WINDBG_KSPEC_REGS_RW(windbg_read_ks_regs, false)
+
+__attribute__ ((unused)) /* unused yet */
+GEN_WINDBG_KSPEC_REGS_RW(windbg_write_ks_regs, true)
+
 static bool find_KPCR(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
