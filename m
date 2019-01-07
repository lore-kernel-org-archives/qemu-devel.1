Received: from eggs.gnu.org ([209.51.188.92]:46176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoT-0004wm-Qy
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoR-0001vZ-Dx
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:41 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoO-0001mk-AO
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:38 -0500
Received: by mail-wm1-x32b.google.com with SMTP id a62so1454877wmh.4
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.32 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:50 +0000
Message-Id: <20190107163117.16269-11-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/37] gdbstub: add multiprocess support to
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

From: Luc Michel <luc.michel@greensocs.com>

Change the Xfer:features:read: packet handling to support the
multiprocess extension. This packet is used to request the XML
description of the CPU. In multiprocess mode, different descriptions can
be sent for different processes.

This function now takes the process to send the description for as a
parameter, and use a buffer in the process structure to store the
generated description.

It takes the first CPU of the process to generate the description.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20181207090135.7651-9-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index f70b5a326fe..1f2b155490d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -300,6 +300,8 @@ typedef struct GDBRegisterState {
 typedef struct GDBProcess {
     uint32_t pid;
     bool attached;
+
+    char target_xml[1024];
 } GDBProcess;
 
 enum RSState {
@@ -812,13 +814,14 @@ static CPUState *gdb_first_attached_cpu(const GDBState *s)
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
@@ -827,36 +830,37 @@ static const char *get_feature_xml(const char *p, const char **newp,
 
     name = NULL;
     if (strncmp(p, "target.xml", len) == 0) {
-        /* Generate the XML description for this CPU.  */
-        if (!target_xml[0]) {
-            GDBRegisterState *r;
-            CPUState *cpu = first_cpu;
+        char *buf = process->target_xml;
+        const size_t buf_sz = sizeof(process->target_xml);
 
-            pstrcat(target_xml, sizeof(target_xml),
+        /* Generate the XML description for this CPU.  */
+        if (!buf[0]) {
+            GDBRegisterState *r;
+
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
 
@@ -1266,6 +1270,7 @@ out:
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
+    GDBProcess *process;
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
@@ -1650,14 +1655,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
@@ -2070,6 +2076,7 @@ static void create_default_process(GDBState *s)
 
     process->pid = max_pid + 1;
     process->attached = false;
+    process->target_xml[0] = '\0';
 }
 
 #ifdef CONFIG_USER_ONLY
@@ -2345,6 +2352,7 @@ static int find_cpu_clusters(Object *child, void *opaque)
         assert(cluster->cluster_id != UINT32_MAX);
         process->pid = cluster->cluster_id + 1;
         process->attached = false;
+        process->target_xml[0] = '\0';
 
         return 0;
     }
-- 
2.19.2
