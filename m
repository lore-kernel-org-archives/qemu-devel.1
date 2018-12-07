Received: from eggs.gnu.org ([2001:4830:134:3::10]:57462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gVC1O-00081t-BV
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gVC1J-0005Yl-Tq
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:05 -0500
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri,  7 Dec 2018 10:01:26 +0100
Message-Id: <20181207090135.7651-9-luc.michel@greensocs.com>
In-Reply-To: <20181207090135.7651-1-luc.michel@greensocs.com>
References: <20181207090135.7651-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 08/16] gdbstub: add multiprocess support to
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
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.burton@greensocs.com, Eduardo Habkost <ehabkost@redhat.com>

Change the Xfer:features:read: packet handling to support the
multiprocess extension. This packet is used to request the XML
description of the CPU. In multiprocess mode, different descriptions can
be sent for different processes.

This function now takes the process to send the description for as a
parameter, and use a buffer in the process structure to store the
generated description.

It takes the first CPU of the process to generate the description.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 gdbstub.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 770915446a..c66bf37b49 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -298,10 +298,12 @@ typedef struct GDBRegisterState {
 } GDBRegisterState;
=20
 typedef struct GDBProcess {
     uint32_t pid;
     bool attached;
+
+    char target_xml[1024];
 } GDBProcess;
=20
 enum RSState {
     RS_INACTIVE,
     RS_IDLE,
@@ -811,55 +813,57 @@ static CPUState *gdb_first_attached_cpu(const GDBSt=
ate *s)
     }
=20
     return cpu;
 }
=20
-static const char *get_feature_xml(const char *p, const char **newp,
-                                   CPUClass *cc)
+static const char *get_feature_xml(const GDBState *s, const char *p,
+                                   const char **newp, GDBProcess *proces=
s)
 {
     size_t len;
     int i;
     const char *name;
-    static char target_xml[1024];
+    CPUState *cpu =3D get_first_cpu_in_process(s, process);
+    CPUClass *cc =3D CPU_GET_CLASS(cpu);
=20
     len =3D 0;
     while (p[len] && p[len] !=3D ':')
         len++;
     *newp =3D p + len;
=20
     name =3D NULL;
     if (strncmp(p, "target.xml", len) =3D=3D 0) {
+        char *buf =3D process->target_xml;
+        const size_t buf_sz =3D sizeof(process->target_xml);
+
         /* Generate the XML description for this CPU.  */
-        if (!target_xml[0]) {
+        if (!buf[0]) {
             GDBRegisterState *r;
-            CPUState *cpu =3D first_cpu;
=20
-            pstrcat(target_xml, sizeof(target_xml),
+            pstrcat(buf, buf_sz,
                     "<?xml version=3D\"1.0\"?>"
                     "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
                     "<target>");
             if (cc->gdb_arch_name) {
                 gchar *arch =3D cc->gdb_arch_name(cpu);
-                pstrcat(target_xml, sizeof(target_xml), "<architecture>"=
);
-                pstrcat(target_xml, sizeof(target_xml), arch);
-                pstrcat(target_xml, sizeof(target_xml), "</architecture>=
");
+                pstrcat(buf, buf_sz, "<architecture>");
+                pstrcat(buf, buf_sz, arch);
+                pstrcat(buf, buf_sz, "</architecture>");
                 g_free(arch);
             }
-            pstrcat(target_xml, sizeof(target_xml), "<xi:include href=3D=
\"");
-            pstrcat(target_xml, sizeof(target_xml), cc->gdb_core_xml_fil=
e);
-            pstrcat(target_xml, sizeof(target_xml), "\"/>");
+            pstrcat(buf, buf_sz, "<xi:include href=3D\"");
+            pstrcat(buf, buf_sz, cc->gdb_core_xml_file);
+            pstrcat(buf, buf_sz, "\"/>");
             for (r =3D cpu->gdb_regs; r; r =3D r->next) {
-                pstrcat(target_xml, sizeof(target_xml), "<xi:include hre=
f=3D\"");
-                pstrcat(target_xml, sizeof(target_xml), r->xml);
-                pstrcat(target_xml, sizeof(target_xml), "\"/>");
+                pstrcat(buf, buf_sz, "<xi:include href=3D\"");
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
-        CPUState *cpu =3D first_cpu;
         char *xmlname =3D g_strndup(p, len);
         const char *xml =3D cc->gdb_get_dynamic_xml(cpu, xmlname);
=20
         g_free(xmlname);
         if (xml) {
@@ -1265,10 +1269,11 @@ out:
 }
=20
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
+    GDBProcess *process;
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
     int ch, reg_size, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
@@ -1648,18 +1653,19 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
         }
         if (strncmp(p, "Xfer:features:read:", 19) =3D=3D 0) {
             const char *xml;
             target_ulong total_len;
=20
-            cc =3D CPU_GET_CLASS(first_cpu);
+            process =3D gdb_get_cpu_process(s, s->g_cpu);
+            cc =3D CPU_GET_CLASS(s->g_cpu);
             if (cc->gdb_core_xml_file =3D=3D NULL) {
                 goto unknown_command;
             }
=20
             gdb_has_xml =3D true;
             p +=3D 19;
-            xml =3D get_feature_xml(p, &p, cc);
+            xml =3D get_feature_xml(s, p, &p, process);
             if (!xml) {
                 snprintf(buf, sizeof(buf), "E00");
                 put_packet(s, buf);
                 break;
             }
@@ -2068,10 +2074,11 @@ static void create_default_process(GDBState *s)
     /* We need an available PID slot for this process */
     assert(max_pid < UINT32_MAX);
=20
     process->pid =3D max_pid + 1;
     process->attached =3D false;
+    process->target_xml[0] =3D '\0';
 }
=20
 #ifdef CONFIG_USER_ONLY
 int
 gdb_handlesig(CPUState *cpu, int sig)
@@ -2342,10 +2349,11 @@ static int find_cpu_clusters(Object *child, void =
*opaque)
          * runtime, we enforce here that the machine does not use a clus=
ter ID
          * that would lead to PID 0. */
         assert(cluster->cluster_id !=3D UINT32_MAX);
         process->pid =3D cluster->cluster_id + 1;
         process->attached =3D false;
+        process->target_xml[0] =3D '\0';
=20
         return 0;
     }
=20
     return object_child_foreach(child, find_cpu_clusters, opaque);
--=20
2.19.2
