Received: from eggs.gnu.org ([2001:4830:134:3::10]:59567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngo-0004ZU-2o
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngk-00015f-2d
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:10 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52040)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngj-00015V-RJ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:06 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:06:03 +0300
Message-ID: <150642396368.3900.10377280585440026381.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 21/43] windbg: implemented
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
 windbgstub-utils.c              |   10 ++++++++++
 windbgstub.c                    |   21 ++++++++++++++++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 25e8458b4e..ca21af7c91 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -102,6 +102,8 @@ typedef struct SizedBuf {
     buf.size = 0;           \
 } while (false)
 
+void kd_api_unsupported(CPUState *cpu, PacketData *pd);
+
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
 SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
 
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 7d93f62d16..e7b381f829 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -30,6 +30,16 @@ typedef struct KDData {
 
 static KDData *kd;
 
+void kd_api_unsupported(CPUState *cpu, PacketData *pd)
+{
+    WINDBG_ERROR("Catched unimplemented api %s",
+                 KD_API_NAME(pd->m64.ApiNumber));
+    pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    pd->extra_size = 0;
+
+    exit(1);
+}
+
 static void kd_breakpoint_remove_range(CPUState *cpu, target_ulong base,
                                        target_ulong limit)
 {}
diff --git a/windbgstub.c b/windbgstub.c
index b9993c90d4..50b4ef0dea 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -123,7 +123,26 @@ static void windbg_vm_stop(void)
 }
 
 static void windbg_process_manipulate_packet(ParsingContext *ctx)
-{}
+{
+    CPUState *cpu;
+
+    ctx->data.extra_size = ctx->packet.ByteCount - M64_SIZE;
+    ctx->data.m64.ReturnStatus = STATUS_SUCCESS;
+
+    cpu = qemu_get_cpu(ctx->data.m64.Processor);
+
+    switch (ctx->data.m64.ApiNumber) {
+
+    default:
+        kd_api_unsupported(cpu, &ctx->data);
+        break;
+    }
+
+    ctx->data.m64.ReturnStatus = ldl_p(&ctx->data.m64.ReturnStatus);
+
+    windbg_send_data_packet(ctx->data.buf, ctx->data.extra_size + M64_SIZE,
+                            ctx->packet.PacketType);
+}
 
 static void windbg_process_data_packet(ParsingContext *ctx)
 {
