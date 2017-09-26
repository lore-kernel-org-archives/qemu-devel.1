Received: from eggs.gnu.org ([2001:4830:134:3::10]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwniK-00060J-DR
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwniI-0001iN-GY
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:44 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52396)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwniI-0001hx-8w
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:42 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:07:40 +0300
Message-ID: <150642406010.3900.1199547239226671745.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 38/43] windbg: implemented
 kd_api_read_physical_memory and kd_api_write_physical_memory
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
 windbgstub-utils.c              |   28 ++++++++++++++++++++++++++++
 windbgstub.c                    |    8 ++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 07e11c0494..d390bc1dfe 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -113,6 +113,8 @@ void kd_api_read_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_read_io_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_io_space(CPUState *cpu, PacketData *pd);
+void kd_api_read_physical_memory(CPUState *cpu, PacketData *pd);
+void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 6bf9868e51..1fba54f9d9 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -1170,6 +1170,34 @@ void kd_api_write_io_space(CPUState *cpu, PacketData *pd)
     pd->m64.ReturnStatus = STATUS_SUCCESS;
 }
 
+void kd_api_read_physical_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
+    uint32_t len;
+    target_ulong addr;
+
+    len = MIN(ldl_p(&mem->TransferCount), PACKET_MAX_SIZE - M64_SIZE);
+    addr = ldtul_p(&mem->TargetBaseAddress);
+
+    cpu_physical_memory_rw(addr, pd->extra, len, 0);
+    pd->extra_size = len;
+    mem->ActualBytesRead = ldl_p(&len);
+}
+
+void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_WRITE_MEMORY64 *mem = &pd->m64.u.WriteMemory;
+    uint32_t len;
+    target_ulong addr;
+
+    len = MIN(ldl_p(&mem->TransferCount), pd->extra_size);
+    addr = ldtul_p(&mem->TargetBaseAddress);
+
+    cpu_physical_memory_rw(addr, pd->extra, len, 1);
+    pd->extra_size = 0;
+    mem->ActualBytesWritten = ldl_p(&len);
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Catched unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 0363d9a5c8..118e9dd697 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -182,6 +182,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_write_control_space(cpu, &ctx->data);
         break;
 
+    case DbgKdReadPhysicalMemoryApi:
+        kd_api_read_physical_memory(cpu, &ctx->data);
+        break;
+
+    case DbgKdWritePhysicalMemoryApi:
+        kd_api_write_physical_memory(cpu, &ctx->data);
+        break;
+
     case DbgKdClearAllInternalBreakpointsApi:
         return;
 
