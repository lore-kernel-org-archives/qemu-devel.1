Received: from eggs.gnu.org ([209.51.188.92]:47872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1grQQZ-0007tH-Nl
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1grQQW-0001I1-8H
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:51:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45980
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1grQQP-0001Cy-DA
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:51:51 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x16GpGro126259
	for <qemu-devel@nongnu.org>; Wed, 6 Feb 2019 11:51:43 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qg387rwgm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 11:51:43 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Wed, 6 Feb 2019 16:51:42 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Wed,  6 Feb 2019 14:51:33 -0200
In-Reply-To: <20190206165133.12246-1-farosas@linux.ibm.com>
References: <20190206165133.12246-1-farosas@linux.ibm.com>
Message-Id: <20190206165133.12246-2-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v5 1/1] target/ppc: Enable reporting of SPRs to
 GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, groug@kaod.org

This allows reading and writing of SPRs via GDB:

(gdb) p/x $srr1
$1 = 0x8000000002803033

(gdb) p/x $pvr
$2 = 0x4b0201
(gdb) set $pvr=0x4b0000
(gdb) p/x $pvr
$3 = 0x4b0000

The `info` command can also be used:
(gdb) info registers spr

For this purpose, GDB needs to be provided with an XML description of
the registers (see the gdb-xml directory for examples) and a set of
callbacks for reading and writing the registers must be defined.

The XML file in this case is created dynamically, based on the SPRs
already defined in the machine. This way we avoid the need for several
XML files to suit each possible ppc machine.

The gdb_{get,set}_spr_reg callbacks take an index based on the order
the registers appear in the XML file. This index does not match the
actual location of the registers in the env->spr array so the
gdb_find_spr_idx function does that conversion.

Note: GDB currently needs to know the guest endianness in order to
properly print the registers values. This is done automatically by GDB
when provided with the ELF file or explicitly with the `set endian
<big|little>` command.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/cpu-qom.h            |  4 +++
 target/ppc/cpu.h                |  5 +++
 target/ppc/gdbstub.c            | 61 ++++++++++++++++++++++++++++++++
 target/ppc/translate_init.inc.c | 62 +++++++++++++++++++++++++++++++--
 4 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 4ea67692e2..3130802304 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -179,6 +179,10 @@ typedef struct PowerPCCPUClass {
     uint32_t flags;
     int bfd_mach;
     uint32_t l1_dcache_size, l1_icache_size;
+#ifndef CONFIG_USER_ONLY
+    unsigned int gdb_num_sprs;
+    const char *gdb_spr_xml;
+#endif
     const PPCHash64Options *hash64_opts;
     struct ppc_radix_page_info *radix_page_info;
     void (*init_proc)(CPUPPCState *env);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2c22292e7f..78af7e4608 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -230,6 +230,7 @@ struct ppc_spr_t {
     void (*oea_write)(DisasContext *ctx, int spr_num, int gpr_num);
     void (*hea_read)(DisasContext *ctx, int gpr_num, int spr_num);
     void (*hea_write)(DisasContext *ctx, int spr_num, int gpr_num);
+    unsigned int gdb_id;
 #endif
     const char *name;
     target_ulong default_value;
@@ -1263,6 +1264,10 @@ int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_read_register_apple(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
+#ifndef CONFIG_USER_ONLY
+void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu);
+const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
+#endif
 int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, void *opaque);
 int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 19565b584d..fbf3821f4b 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -319,3 +319,64 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
     }
     return r;
 }
+
+#ifndef CONFIG_USER_ONLY
+void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
+{
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    CPUPPCState *env = &cpu->env;
+    GString *xml;
+    char *spr_name;
+    unsigned int num_regs = 0;
+    int i;
+
+    if (pcc->gdb_spr_xml) {
+        return;
+    }
+
+    xml = g_string_new("<?xml version=\"1.0\"?>");
+    g_string_append(xml, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
+    g_string_append(xml, "<feature name=\"org.qemu.power.spr\">");
+
+    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
+        ppc_spr_t *spr = &env->spr_cb[i];
+
+        if (!spr->name) {
+            continue;
+        }
+
+        spr_name = g_ascii_strdown(spr->name, -1);
+        g_string_append_printf(xml, "<reg name=\"%s\"", spr_name);
+        g_free(spr_name);
+
+        g_string_append_printf(xml, " bitsize=\"%d\"", TARGET_LONG_BITS);
+        g_string_append(xml, " group=\"spr\"/>");
+
+        /*
+         * GDB identifies registers based on the order they are
+         * presented in the XML. These ids will not match QEMU's
+         * representation (which follows the PowerISA).
+         *
+         * Store the position of the current register description so
+         * we can make the correspondence later.
+         */
+        spr->gdb_id = num_regs;
+        num_regs++;
+    }
+
+    g_string_append(xml, "</feature>");
+
+    pcc->gdb_num_sprs = num_regs;
+    pcc->gdb_spr_xml = g_string_free(xml, false);
+}
+
+const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name)
+{
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
+
+    if (strcmp(xml_name, "power-spr.xml") == 0) {
+        return pcc->gdb_spr_xml;
+    }
+    return NULL;
+}
+#endif
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 59e0b86762..9295f78d5f 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8979,6 +8979,10 @@ static void init_ppc_proc(PowerPCCPU *cpu)
     /* PowerPC implementation specific initialisations (SPRs, timers, ...) */
     (*pcc->init_proc)(env);
 
+#if !defined(CONFIG_USER_ONLY)
+    ppc_gdb_gen_spr_xml(cpu);
+#endif
+
     /* MSR bits & flags consistency checks */
     if (env->msr_mask & (1 << 25)) {
         switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
@@ -9475,6 +9479,55 @@ static bool avr_need_swap(CPUPPCState *env)
 #endif
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static int gdb_find_spr_idx(CPUPPCState *env, int n)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
+        ppc_spr_t *spr = &env->spr_cb[i];
+
+        if (spr->name && spr->gdb_id == n) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+{
+    int reg;
+    int len;
+
+    reg = gdb_find_spr_idx(env, n);
+    if (reg < 0) {
+        return 0;
+    }
+
+    len = TARGET_LONG_SIZE;
+    stn_p(mem_buf, len, env->spr[reg]);
+    ppc_maybe_bswap_register(env, mem_buf, len);
+    return len;
+}
+
+static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+{
+    int reg;
+    int len;
+
+    reg = gdb_find_spr_idx(env, n);
+    if (reg < 0) {
+        return 0;
+    }
+
+    len = TARGET_LONG_SIZE;
+    ppc_maybe_bswap_register(env, mem_buf, len);
+    env->spr[reg] = ldn_p(mem_buf, len);
+
+    return len;
+}
+#endif
+
 static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
 {
     if (n < 32) {
@@ -9704,7 +9757,10 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
         gdb_register_coprocessor(cs, gdb_get_vsx_reg, gdb_set_vsx_reg,
                                  32, "power-vsx.xml", 0);
     }
-
+#ifndef CONFIG_USER_ONLY
+    gdb_register_coprocessor(cs, gdb_get_spr_reg, gdb_set_spr_reg,
+                             pcc->gdb_num_sprs, "power-spr.xml", 0);
+#endif
     qemu_init_vcpu(cs);
 
     pcc->parent_realize(dev, errp);
@@ -10467,7 +10523,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #endif
 
     cc->gdb_num_core_regs = 71;
-
+#ifndef CONFIG_USER_ONLY
+    cc->gdb_get_dynamic_xml = ppc_gdb_get_dynamic_xml;
+#endif
 #ifdef USE_APPLE_GDB
     cc->gdb_read_register = ppc_cpu_gdb_read_register_apple;
     cc->gdb_write_register = ppc_cpu_gdb_write_register_apple;
-- 
2.17.1
