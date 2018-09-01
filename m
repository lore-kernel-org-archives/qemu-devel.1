Received: from eggs.gnu.org ([2001:4830:134:3::10]:35490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JE-0004tP-Ab
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JC-0007oo-VW
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:24 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat,  1 Sep 2018 14:46:31 +0200
Message-Id: <20180901124639.19735-8-luc.michel@greensocs.com>
In-Reply-To: <20180901124639.19735-1-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 07/15] gdbstub: add multiprocess support to
 Xfer:features:read:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, mark.burton@greensocs.com

Change the Xfer:features:read: packet handling to support the
multiprocess extension. This packet is used to request the XML
description of the CPU. In multiprocess mode, different descriptions can
be sent for different processes.

This function now takes the process to send the description for as a
parameter, and use a buffer in the process structure to store the
generated description.

It takes the first CPU of the process to generate the description.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 43015f7792..761cb051c8 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -792,55 +792,57 @@ static CPUState *gdb_first_cpu(const GDBState *s)
     }
 
     return cpu;
 }
 
-static const char *get_feature_xml(const char *p, const char **newp,
-                                   CPUClass *cc)
+static const char *get_feature_xml(const GDBState *s, const char *p,
+                                   const char **newp, GDBProcess *process)
 {
     size_t len;
     int i;
     const char *name;
-    static char target_xml[1024];
+    CPUState *cpu = get_first_cpu_in_process(s, process);
+    CPUClass *cc = CPU_GET_CLASS(cpu);
 
     len = 0;
     while (p[len] && p[len] != ':')
         len++;
     *newp = p + len;
 
     name = NULL;
     if (strncmp(p, "target.xml", len) == 0) {
+        char *buf = process->target_xml;
+        const size_t buf_sz = sizeof(process->target_xml);
+
         /* Generate the XML description for this CPU.  */
-        if (!target_xml[0]) {
+        if (!buf[0]) {
             GDBRegisterState *r;
-            CPUState *cpu = first_cpu;
 
-            pstrcat(target_xml, sizeof(target_xml),
+            pstrcat(buf, buf_sz,
                     "<?xml version=\"1.0\"?>"
                     "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
                     "<target>");
             if (cc->gdb_arch_name) {
                 gchar *arch = cc->gdb_arch_name(cpu);
-                pstrcat(target_xml, sizeof(target_xml), "<architecture>");
-                pstrcat(target_xml, sizeof(target_xml), arch);
-                pstrcat(target_xml, sizeof(target_xml), "</architecture>");
+                pstrcat(buf, buf_sz, "<architecture>");
+                pstrcat(buf, buf_sz, arch);
+                pstrcat(buf, buf_sz, "</architecture>");
                 g_free(arch);
             }
-            pstrcat(target_xml, sizeof(target_xml), "<xi:include href=\"");
-            pstrcat(target_xml, sizeof(target_xml), cc->gdb_core_xml_file);
-            pstrcat(target_xml, sizeof(target_xml), "\"/>");
+            pstrcat(buf, buf_sz, "<xi:include href=\"");
+            pstrcat(buf, buf_sz, cc->gdb_core_xml_file);
+            pstrcat(buf, buf_sz, "\"/>");
             for (r = cpu->gdb_regs; r; r = r->next) {
-                pstrcat(target_xml, sizeof(target_xml), "<xi:include href=\"");
-                pstrcat(target_xml, sizeof(target_xml), r->xml);
-                pstrcat(target_xml, sizeof(target_xml), "\"/>");
+                pstrcat(buf, buf_sz, "<xi:include href=\"");
+                pstrcat(buf, buf_sz, r->xml);
+                pstrcat(buf, buf_sz, "\"/>");
             }
-            pstrcat(target_xml, sizeof(target_xml), "</target>");
+            pstrcat(buf, buf_sz, "</target>");
         }
-        return target_xml;
+        return buf;
     }
     if (cc->gdb_get_dynamic_xml) {
-        CPUState *cpu = first_cpu;
         char *xmlname = g_strndup(p, len);
         const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname);
 
         g_free(xmlname);
         if (xml) {
@@ -1247,10 +1249,11 @@ out:
 }
 
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
+    GDBProcess *process;
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
     int ch, reg_size, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
@@ -1621,18 +1624,19 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         if (strncmp(p, "Xfer:features:read:", 19) == 0) {
             const char *xml;
             target_ulong total_len;
 
-            cc = CPU_GET_CLASS(first_cpu);
+            process = gdb_get_cpu_process(s, s->g_cpu);
+            cc = CPU_GET_CLASS(s->g_cpu);
             if (cc->gdb_core_xml_file == NULL) {
                 goto unknown_command;
             }
 
             gdb_has_xml = true;
             p += 19;
-            xml = get_feature_xml(p, &p, cc);
+            xml = get_feature_xml(s, p, &p, process);
             if (!xml) {
                 snprintf(buf, sizeof(buf), "E00");
                 put_packet(s, buf);
                 break;
             }
-- 
2.18.0
