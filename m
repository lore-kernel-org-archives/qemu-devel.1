Received: from eggs.gnu.org ([208.118.235.92]:56721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gfVak-0000jh-0Q
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gfVaf-0000cH-Sx
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:57:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36634
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gfVad-0000Yq-PK
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:57:07 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x04JstZU116661
	for <qemu-devel@nongnu.org>; Fri, 4 Jan 2019 14:57:06 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ptcfn4c99-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 14:57:06 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 4 Jan 2019 19:57:05 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Fri,  4 Jan 2019 17:56:52 -0200
In-Reply-To: <20190104195654.19976-1-farosas@linux.ibm.com>
References: <20190104195654.19976-1-farosas@linux.ibm.com>
Message-Id: <20190104195654.19976-2-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 1/3] target/ppc: Add SPRs XML generation code
 for gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

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
 target/ppc/cpu.h     |  7 +++++++
 target/ppc/gdbstub.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d5f99f1fc7..365bca2248 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1052,6 +1052,9 @@ struct CPUPPCState {
     /* Special purpose registers */
     target_ulong spr[1024];
     ppc_spr_t spr_cb[1024];
+#if !defined(CONFIG_USER_ONLY)
+    const char *gdb_spr_xml;
+#endif
     /* Altivec registers */
     ppc_avr_t avr[32];
     uint32_t vscr;
@@ -1264,6 +1267,10 @@ int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_read_register_apple(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
+#ifndef CONFIG_USER_ONLY
+int ppc_gdb_gen_spr_xml(CPUState *cpu);
+const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
+#endif
 int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, void *opaque);
 int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index b6f6693583..82db500457 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -319,3 +319,48 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
     }
     return r;
 }
+
+#ifndef CONFIG_USER_ONLY
+int ppc_gdb_gen_spr_xml(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    GString *s = g_string_new(NULL);
+    int num_regs = 0;
+    int i;
+
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
+        num_regs++;
+    }
+
+    g_string_append_printf(s, "</feature>");
+    env->gdb_spr_xml = g_string_free(s, false);
+    return num_regs;
+}
+
+const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
+    if (strcmp(xml_name, "power-spr.xml") == 0) {
+        return env->gdb_spr_xml;
+    }
+    return NULL;
+}
+#endif
--
2.17.1
