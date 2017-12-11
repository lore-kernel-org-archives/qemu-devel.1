Received: from eggs.gnu.org ([2001:4830:134:3::10]:34791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO57-0004H9-Mv
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO51-0003kH-O3
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:17 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44126)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO51-0003k2-GY
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:11 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:24:56 +0300
Message-ID: <151299869611.4808.7456605968626650768.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 38/46] windbg: implemented kd_api_get_version
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
 include/exec/windbgstub-utils.h |    1 +
 windbgstub-utils.c              |   22 ++++++++++++++++++++++
 windbgstub.c                    |    4 ++++
 3 files changed, 27 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index a40253f18a..8cdb275555 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -87,6 +87,7 @@ void kd_api_read_io_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_io_space(CPUState *cpu, PacketData *pd);
 void kd_api_read_physical_memory(CPUState *cpu, PacketData *pd);
 void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd);
+void kd_api_get_version(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 6708e62798..7ef301bac7 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -239,6 +239,28 @@ void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd)
     stl_p(&mem->ActualBytesWritten, len);
 }
 
+void kd_api_get_version(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_GET_VERSION64 *kdver;
+    int err = cpu_memory_rw_debug(cpu, version.addr, PTR(pd->m64) + 0x10,
+                                  sizeof(DBGKD_MANIPULATE_STATE64) - 0x10, 0);
+    if (!err) {
+        kdver = (DBGKD_GET_VERSION64 *) (PTR(pd->m64) + 0x10);
+
+        stw_p(&kdver->MajorVersion, kdver->MajorVersion);
+        stw_p(&kdver->MinorVersion, kdver->MinorVersion);
+        stw_p(&kdver->Flags, kdver->Flags);
+        stw_p(&kdver->MachineType, kdver->MachineType);
+        stw_p(&kdver->Unused[0], kdver->Unused[0]);
+        sttul_p(&kdver->KernBase, kdver->KernBase);
+        sttul_p(&kdver->PsLoadedModuleList, kdver->PsLoadedModuleList);
+        sttul_p(&kdver->DebuggerDataList, kdver->DebuggerDataList);
+    } else {
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+        WINDBG_ERROR("get_version: " FMT_ERR, err);
+    }
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 9cf25bc6dd..06e99199b6 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -197,6 +197,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_write_physical_memory(cpu, &ctx->data);
         break;
 
+    case DbgKdGetVersionApi:
+        kd_api_get_version(cpu, &ctx->data);
+        break;
+
     case DbgKdClearAllInternalBreakpointsApi:
         return;
 
