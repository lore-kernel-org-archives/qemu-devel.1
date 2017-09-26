Received: from eggs.gnu.org ([2001:4830:134:3::10]:60335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwniS-00069a-US
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwniO-0001lE-WD
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:52 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52416)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwniO-0001kx-OQ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:48 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:07:45 +0300
Message-ID: <150642406568.3900.18393117019157434726.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 39/43] windbg: implemented kd_api_get_version
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
 windbgstub-utils.c              |   23 +++++++++++++++++++++++
 windbgstub.c                    |    4 ++++
 3 files changed, 28 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index d390bc1dfe..e76bf1ad6f 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -115,6 +115,7 @@ void kd_api_read_io_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_io_space(CPUState *cpu, PacketData *pd);
 void kd_api_read_physical_memory(CPUState *cpu, PacketData *pd);
 void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd);
+void kd_api_get_version(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 1fba54f9d9..171097eba2 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -1198,6 +1198,29 @@ void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd)
     mem->ActualBytesWritten = ldl_p(&len);
 }
 
+void kd_api_get_version(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_GET_VERSION64 *version;
+    int err = cpu_memory_rw_debug(cpu, kd->version.addr,
+                                  PTR(pd->m64) + 0x10,
+                                  M64_SIZE - 0x10, 0);
+    if (!err) {
+        version = (DBGKD_GET_VERSION64 *) (PTR(pd->m64) + 0x10);
+
+        version->MajorVersion = lduw_p(&version->MajorVersion);
+        version->MinorVersion = lduw_p(&version->MinorVersion);
+        version->Flags = lduw_p(&version->Flags);
+        version->MachineType = lduw_p(&version->MachineType);
+        version->Unused[0] = lduw_p(version->Unused);
+        version->KernBase = ldq_p(&version->KernBase);
+        version->PsLoadedModuleList = ldq_p(&version->PsLoadedModuleList);
+        version->DebuggerDataList = ldq_p(&version->DebuggerDataList);
+    } else {
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+        WINDBG_ERROR("get_version: " FMT_ERR, err);
+    }
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Catched unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 118e9dd697..b37393d93c 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -190,6 +190,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_write_physical_memory(cpu, &ctx->data);
         break;
 
+    case DbgKdGetVersionApi:
+        kd_api_get_version(cpu, &ctx->data);
+        break;
+
     case DbgKdClearAllInternalBreakpointsApi:
         return;
 
