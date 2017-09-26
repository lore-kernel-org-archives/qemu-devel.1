Received: from eggs.gnu.org ([2001:4830:134:3::10]:59682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnh4-0004mt-2s
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnh0-0001DJ-UT
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:26 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52094)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnh0-0001D4-Mm
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:22 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:06:20 +0300
Message-ID: <150642398052.3900.12516273863992631402.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 24/43] windbg: implemented kd_api_get_context
 and kd_api_set_context
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

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 ++
 windbgstub-utils.c              |   37 +++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 ++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index c1ff1cec57..0b683f95ac 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -104,6 +104,8 @@ typedef struct SizedBuf {
 
 void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd);
+void kd_api_get_context(CPUState *cpu, PacketData *pd);
+void kd_api_set_context(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 3c81ecefb8..b15d84c8d0 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -277,6 +277,18 @@ typedef struct KDData {
 
 static KDData *kd;
 
+static int windbg_read_context(CPUState *cpu, uint8_t *buf, int len,
+                               int offset)
+{
+    return 0;
+}
+
+static int windbg_write_context(CPUState *cpu, uint8_t *buf, int len,
+                                int offset)
+{
+    return 0;
+}
+
 void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd)
 {
     DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
@@ -324,6 +336,31 @@ void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd)
     }
 }
 
+void kd_api_get_context(CPUState *cpu, PacketData *pd)
+{
+    int err;
+
+    pd->extra_size = sizeof(CPU_CONTEXT);
+    err = windbg_read_context(cpu, pd->extra, pd->extra_size, 0);
+
+    if (err) {
+        pd->extra_size = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+}
+
+void kd_api_set_context(CPUState *cpu, PacketData *pd)
+{
+    int err;
+
+    err = windbg_write_context(cpu, pd->extra, pd->extra_size, 0);
+    pd->extra_size = 0;
+
+    if (err) {
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Catched unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 327fe83f70..23930d195e 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -141,6 +141,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_write_virtual_memory(cpu, &ctx->data);
         break;
 
+    case DbgKdGetContextApi:
+        kd_api_get_context(cpu, &ctx->data);
+        break;
+
+    case DbgKdSetContextApi:
+        kd_api_set_context(cpu, &ctx->data);
+        break;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
