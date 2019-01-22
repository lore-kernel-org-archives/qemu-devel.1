Received: from eggs.gnu.org ([209.51.188.92]:38721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gm0wF-0005FA-IM
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gm0w5-00005g-AL
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gm0w4-0008LJ-OS
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:09 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0MGwsFY070774
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:01:23 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q65xtc26u-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:01:22 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Tue, 22 Jan 2019 17:01:21 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Tue, 22 Jan 2019 15:01:10 -0200
In-Reply-To: <20190122170112.8706-1-farosas@linux.ibm.com>
References: <20190122170112.8706-1-farosas@linux.ibm.com>
Message-Id: <20190122170112.8706-2-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v4 1/3] target/ppc: Add SPRs XML generation
 code for gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org

A following patch will add support for handling the Special Purpose
Registers (SPR) in GDB via gdbstub. For that purpose, GDB needs to be
provided with an XML description of the registers (see gdb-xml
directory).

This patch adds the code that generates the XML dynamically based on
the SPRs already defined in the machine. This eliminates the need for
several XML files to match each possible ppc machine.

A "group" is defined so that the GDB command `info registers spr` can
be used.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/cpu-qom.h            |  4 +++
 target/ppc/cpu.h                |  5 +++
 target/ppc/gdbstub.c            | 60 +++++++++++++++++++++++++++++++++
 target/ppc/translate_init.inc.c |  4 +++
 4 files changed, 73 insertions(+)

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
index a62ff60414..850c5ba278 100644
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
@@ -1268,6 +1269,10 @@ int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
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
index 19565b584d..b2bb765506 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -319,3 +319,63 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
     }
     return r;
 }
+
+#ifndef CONFIG_USER_ONLY
+void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
+{
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    CPUPPCState *env = &cpu->env;
+    GString *s;
+    unsigned int num_regs;
+    int i;
+
+    if (pcc->gdb_spr_xml) {
+        return;
+    }
+
+    s = g_string_new(NULL);
+    g_string_printf(s, "<?xml version=\"1.0\"?>");
+    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
+    g_string_append_printf(s, "<feature name=\"org.qemu.power.spr\">");
+
+    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
+        ppc_spr_t *spr = &env->spr_cb[i];
+
+        if (!spr->name) {
+            continue;
+        }
+
+        g_string_append_printf(s, "<reg name=\"%s\"",
+                               g_ascii_strdown(spr->name, -1));
+        g_string_append_printf(s, " bitsize=\"%d\"", TARGET_LONG_BITS);
+        g_string_append_printf(s, " group=\"spr\"/>");
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
+    g_string_append_printf(s, "</feature>");
+
+    pcc->gdb_num_sprs = num_regs;
+    pcc->gdb_spr_xml = g_string_free(s, false);
+}
+
+const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+
+    if (strcmp(xml_name, "power-spr.xml") == 0) {
+        return pcc->gdb_spr_xml;
+    }
+    return NULL;
+}
+#endif
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index ade06cc773..710064a25d 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8987,6 +8987,10 @@ static void init_ppc_proc(PowerPCCPU *cpu)
     /* PowerPC implementation specific initialisations (SPRs, timers, ...) */
     (*pcc->init_proc)(env);
 
+#if !defined(CONFIG_USER_ONLY)
+    ppc_gdb_gen_spr_xml(cpu);
+#endif
+
     /* MSR bits & flags consistency checks */
     if (env->msr_mask & (1 << 25)) {
         switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
-- 
2.17.1
