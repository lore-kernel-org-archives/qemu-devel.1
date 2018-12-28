Received: from eggs.gnu.org ([208.118.235.92]:48595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gd0Tt-0005Iz-VB
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 17:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gd0LS-0001Op-Ty
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 17:11:10 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1gd0LS-0001Ny-Kh
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 17:11:06 -0500
Received: by mail-pl1-x641.google.com with SMTP id t13so10478604ply.13
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 14:11:06 -0800 (PST)
From: Jim Wilson <jimw@sifive.com>
Date: Fri, 28 Dec 2018 14:11:02 -0800
Message-Id: <20181228221102.5080-1-jimw@sifive.com>
In-Reply-To: <CAFyWVaai=5K7j8w+Abpk9jxGyKuo4v9w2BgmDbY=_29+Q++Jyw@mail.gmail.com>
References: <CAFyWVaai=5K7j8w+Abpk9jxGyKuo4v9w2BgmDbY=_29+Q++Jyw@mail.gmail.com>
Subject: [Qemu-devel] [PATCH 5/5 v2] RISC-V: Add hooks to use the gdb xml
 files.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Jim Wilson <jimw@sifive.com>

Signed-off-by: Jim Wilson <jimw@sifive.com>
---
 target/riscv/cpu.c     |  9 ++++++-
 target/riscv/gdbstub.c | 73 ++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a025a0a..b248e3e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -305,6 +305,8 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    riscv_cpu_register_gdb_regs_for_features(cs);
+
     qemu_init_vcpu(cs);
     cpu_reset(cs);
 
@@ -345,7 +347,12 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->synchronize_from_tb = riscv_cpu_synchronize_from_tb;
     cc->gdb_read_register = riscv_cpu_gdb_read_register;
     cc->gdb_write_register = riscv_cpu_gdb_write_register;
-    cc->gdb_num_core_regs = 65;
+    cc->gdb_num_core_regs = 33;
+#if defined(TARGET_RISCV32)
+    cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
+#elif defined(TARGET_RISCV64)
+    cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
+#endif
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = riscv_cpu_disas_set_info;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index b06f0fa..9558d80 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -31,10 +31,6 @@ int riscv_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         return gdb_get_regl(mem_buf, env->gpr[n]);
     } else if (n == 32) {
         return gdb_get_regl(mem_buf, env->pc);
-    } else if (n < 65) {
-        return gdb_get_reg64(mem_buf, env->fpr[n - 33]);
-    } else if (n < 4096 + 65) {
-        return gdb_get_regl(mem_buf, csr_read_helper(env, n - 65, true));
     }
     return 0;
 }
@@ -53,11 +49,72 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else if (n == 32) {
         env->pc = ldtul_p(mem_buf);
         return sizeof(target_ulong);
-    } else if (n < 65) {
-        env->fpr[n - 33] = ldq_p(mem_buf); /* always 64-bit */
+    }
+    return 0;
+}
+
+static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
+{
+    if (n < 32) {
+        return gdb_get_reg64(mem_buf, env->fpr[n]);
+    } else if (n < 35) {
+        /*
+         * CSR_FFLAGS is 0x001, and gdb says it is FP register 32, so we
+         * subtract 31 to map the gdb FP register number to the CSR number.
+         * This also works for CSR_FRM and CSR_FCSR.
+         */
+        return gdb_get_regl(mem_buf, csr_read_helper(env, n - 31, true));
+    }
+    return 0;
+}
+
+static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
+{
+    if (n < 32) {
+        env->fpr[n] = ldq_p(mem_buf); /* always 64-bit */
         return sizeof(uint64_t);
-    } else if (n < 4096 + 65) {
-        csr_write_helper(env, ldtul_p(mem_buf), n - 65, true);
+    } else if (n < 35) {
+        /*
+         * CSR_FFLAGS is 0x001, and gdb says it is FP register 32, so we
+         * subtract 31 to map the gdb FP register number to the CSR number.
+         * This also works for CSR_FRM and CSR_FCSR.
+         */
+        csr_write_helper(env, ldtul_p(mem_buf), n - 31, true);
     }
     return 0;
 }
+
+static int riscv_gdb_get_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
+{
+    if (n < ARRAY_SIZE(csr_register_map)) {
+        return gdb_get_regl(mem_buf, csr_read_helper(env, csr_register_map[n],
+                                                     true));
+    }
+    return 0;
+}
+
+static int riscv_gdb_set_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
+{
+    if (n < ARRAY_SIZE(csr_register_map)) {
+        csr_write_helper(env, ldtul_p(mem_buf), csr_register_map[n], true);
+    }
+    return 0;
+}
+
+void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
+{
+    /* ??? Assume all targets have FPU regs for now.  */
+#if defined(TARGET_RISCV32)
+    gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
+                             35, "riscv-32bit-fpu.xml", 0);
+
+    gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
+                             4096, "riscv-32bit-csr.xml", 0);
+#elif defined(TARGET_RISCV64)
+    gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
+                             35, "riscv-64bit-fpu.xml", 0);
+
+    gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
+                             4096, "riscv-64bit-csr.xml", 0);
+#endif
+}
-- 
2.7.4
