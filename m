Received: from eggs.gnu.org ([2001:4830:134:3::10]:34061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO3L-00020z-PM
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO3K-0002iG-RC
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:27 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43680)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO3K-0002ho-Jp
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:26 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:23:11 +0300
Message-ID: <151299859117.4808.9078976340520276677.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 20/46] windbg: implemented
 windbg_process_manipulate_packet
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
 windbgstub-utils.c              |    8 ++++++++
 windbgstub.c                    |   26 +++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index a7ec53555b..51977b46c7 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -74,6 +74,8 @@ typedef struct PacketData {
 InitedAddr *windbg_get_KPCR(void);
 InitedAddr *windbg_get_version(void);
 
+void kd_api_unsupported(CPUState *cpu, PacketData *pd);
+
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
 SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
 
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 347c61553a..04a7e1cc7b 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -23,3 +23,11 @@ InitedAddr *windbg_get_version(void)
 {
     return &version;
 }
+
+void kd_api_unsupported(CPUState *cpu, PacketData *pd)
+{
+    WINDBG_ERROR("Caught unimplemented api %s",
+                 KD_API_NAME(pd->m64.ApiNumber));
+    pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    pd->extra_size = 0;
+}
diff --git a/windbgstub.c b/windbgstub.c
index cd46649278..a798186930 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -126,7 +126,31 @@ static void windbg_vm_stop(void)
 }
 
 static void windbg_process_manipulate_packet(ParsingContext *ctx)
-{}
+{
+    CPUState *cpu;
+
+    ctx->data.extra_size = ctx->packet.ByteCount -
+                           sizeof(DBGKD_MANIPULATE_STATE64);
+    ctx->data.m64.ReturnStatus = STATUS_SUCCESS;
+
+    cpu = qemu_get_cpu(ctx->data.m64.Processor);
+    if (cpu == NULL) {
+        cpu = qemu_get_cpu(0);
+    }
+
+    switch (ctx->data.m64.ApiNumber) {
+
+    default:
+        kd_api_unsupported(cpu, &ctx->data);
+        break;
+    }
+
+    stl_p(&ctx->data.m64.ReturnStatus, ctx->data.m64.ReturnStatus);
+
+    windbg_send_data_packet(ctx->data.buf, ctx->data.extra_size +
+                            sizeof(DBGKD_MANIPULATE_STATE64),
+                            ctx->packet.PacketType);
+}
 
 static void windbg_process_data_packet(ParsingContext *ctx)
 {
