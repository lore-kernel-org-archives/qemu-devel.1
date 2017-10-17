Received: from eggs.gnu.org ([2001:4830:134:3::10]:33958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4ReO-0004OR-CI
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4ReI-0005va-Jg
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:16 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56974)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4ReI-0005uz-Ai
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:10 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:11:07 +0300
Message-ID: <150824586699.6816.12521626029136655328.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 24/43] windbg: implemented
 kd_api_get_context and kd_api_set_context
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
 target/i386/windbgstub.c        |   39 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 ++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 552318ad05..39fbfc8d3a 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -95,6 +95,8 @@ InitedAddr *windbg_get_version(void);
 
 void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd);
+void kd_api_get_context(CPUState *cpu, PacketData *pd);
+void kd_api_set_context(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index dcbb8313b5..175fa09f24 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -271,6 +271,45 @@ typedef struct _CPU_KPROCESSOR_STATE {
 
 #endif
 
+static int windbg_read_context(CPUState *cpu, uint8_t *buf, int buf_size,
+                               int offset, int len)
+{
+    return 0;
+}
+
+static int windbg_write_context(CPUState *cpu, uint8_t *buf, int buf_size,
+                                int offset, int len)
+{
+    return 0;
+}
+
+void kd_api_get_context(CPUState *cpu, PacketData *pd)
+{
+    int err;
+
+    pd->extra_size = sizeof(CPU_CONTEXT);
+    err = windbg_read_context(cpu, pd->extra, pd->extra_size, 0,
+                              pd->extra_size);
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
+    err = windbg_write_context(cpu, pd->extra, pd->extra_size, 0,
+                               sizeof(CPU_CONTEXT));
+    pd->extra_size = 0;
+
+    if (err) {
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+}
+
 bool windbg_on_load(void)
 {
     CPUState *cpu = qemu_get_cpu(0);
diff --git a/windbgstub.c b/windbgstub.c
index 1725107722..ad8638b793 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -148,6 +148,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
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
