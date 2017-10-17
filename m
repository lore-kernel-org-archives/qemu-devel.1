Received: from eggs.gnu.org ([2001:4830:134:3::10]:34897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rfj-0005eJ-IK
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rfe-0007MF-UL
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:12:39 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57408)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rfe-0007LA-MU
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:12:34 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:12:31 +0300
Message-ID: <150824595139.6816.4226767258774206043.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 39/43] windbg: implemented kd_api_get_version
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
index 8b0091c53b..0fcef14f20 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -106,6 +106,7 @@ void kd_api_read_io_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_io_space(CPUState *cpu, PacketData *pd);
 void kd_api_read_physical_memory(CPUState *cpu, PacketData *pd);
 void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd);
+void kd_api_get_version(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 319e70e01d..40f859009a 100755
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
index 72324ae53d..ddca290694 100755
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
 
