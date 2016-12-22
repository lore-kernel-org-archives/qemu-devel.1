Received: from eggs.gnu.org ([2001:4830:134:3::10]:37900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DT-0007vA-43
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DO-0007DP-VZ
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DO-0007Cy-Mf
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:30 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:53 +0100
Message-Id: <20161222152300.32395-19-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/25] x86: Fix x86_64 'g' packet response to
 gdb from 32-bit mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Doug Evans <dje@google.com>

From: Doug Evans <dje@google.com>

The remote protocol can't handle flipping back and forth
between 32-bit and 64-bit regs. To compensate, pretend "as if"
on 64-bit cpu when in 32-bit mode.

Signed-off-by: Doug Evans <dje@google.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <001a113dca8274572005406e03c3@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/gdbstub.c | 52 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index c494535..9b94ab8 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -44,10 +44,22 @@ int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
+    /* N.B. GDB can't deal with changes in registers or sizes in the middle
+       of a session. So if we're in 32-bit mode on a 64-bit cpu, still act
+       as if we're on a 64-bit cpu. */
+
     if (n < CPU_NB_REGS) {
-        if (TARGET_LONG_BITS == 64 && env->hflags & HF_CS64_MASK) {
-            return gdb_get_reg64(mem_buf, env->regs[gpr_map[n]]);
-        } else if (n < CPU_NB_REGS32) {
+        if (TARGET_LONG_BITS == 64) {
+            if (env->hflags & HF_CS64_MASK) {
+                return gdb_get_reg64(mem_buf, env->regs[gpr_map[n]]);
+            } else if (n < CPU_NB_REGS32) {
+                return gdb_get_reg64(mem_buf,
+                                     env->regs[gpr_map[n]] & 0xffffffffUL);
+            } else {
+                memset(mem_buf, 0, sizeof(target_ulong));
+                return sizeof(target_ulong);
+            }
+        } else {
             return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
         }
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
@@ -60,8 +72,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         return 10;
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
-        if (n < CPU_NB_REGS32 ||
-            (TARGET_LONG_BITS == 64 && env->hflags & HF_CS64_MASK)) {
+        if (n < CPU_NB_REGS32 || TARGET_LONG_BITS == 64) {
             stq_p(mem_buf, env->xmm_regs[n].ZMM_Q(0));
             stq_p(mem_buf + 8, env->xmm_regs[n].ZMM_Q(1));
             return 16;
@@ -69,8 +80,12 @@ int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else {
         switch (n) {
         case IDX_IP_REG:
-            if (TARGET_LONG_BITS == 64 && env->hflags & HF_CS64_MASK) {
-                return gdb_get_reg64(mem_buf, env->eip);
+            if (TARGET_LONG_BITS == 64) {
+                if (env->hflags & HF_CS64_MASK) {
+                    return gdb_get_reg64(mem_buf, env->eip);
+                } else {
+                    return gdb_get_reg64(mem_buf, env->eip & 0xffffffffUL);
+                }
             } else {
                 return gdb_get_reg32(mem_buf, env->eip);
             }
@@ -151,9 +166,17 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUX86State *env = &cpu->env;
     uint32_t tmp;
 
+    /* N.B. GDB can't deal with changes in registers or sizes in the middle
+       of a session. So if we're in 32-bit mode on a 64-bit cpu, still act
+       as if we're on a 64-bit cpu. */
+
     if (n < CPU_NB_REGS) {
-        if (TARGET_LONG_BITS == 64 && env->hflags & HF_CS64_MASK) {
-            env->regs[gpr_map[n]] = ldtul_p(mem_buf);
+        if (TARGET_LONG_BITS == 64) {
+            if (env->hflags & HF_CS64_MASK) {
+                env->regs[gpr_map[n]] = ldtul_p(mem_buf);
+            } else if (n < CPU_NB_REGS32) {
+                env->regs[gpr_map[n]] = ldtul_p(mem_buf) & 0xffffffffUL;
+            }
             return sizeof(target_ulong);
         } else if (n < CPU_NB_REGS32) {
             n = gpr_map32[n];
@@ -169,8 +192,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         return 10;
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
-        if (n < CPU_NB_REGS32 ||
-            (TARGET_LONG_BITS == 64 && env->hflags & HF_CS64_MASK)) {
+        if (n < CPU_NB_REGS32 || TARGET_LONG_BITS == 64) {
             env->xmm_regs[n].ZMM_Q(0) = ldq_p(mem_buf);
             env->xmm_regs[n].ZMM_Q(1) = ldq_p(mem_buf + 8);
             return 16;
@@ -178,8 +200,12 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else {
         switch (n) {
         case IDX_IP_REG:
-            if (TARGET_LONG_BITS == 64 && env->hflags & HF_CS64_MASK) {
-                env->eip = ldq_p(mem_buf);
+            if (TARGET_LONG_BITS == 64) {
+                if (env->hflags & HF_CS64_MASK) {
+                    env->eip = ldq_p(mem_buf);
+                } else {
+                    env->eip = ldq_p(mem_buf) & 0xffffffffUL;
+                }
                 return 8;
             } else {
                 env->eip &= ~0xffffffffUL;
-- 
2.9.3
