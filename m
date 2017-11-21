Received: from eggs.gnu.org ([2001:4830:134:3::10]:40408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9GL-0002hz-Fe
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9GH-0003M9-CT
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:57 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38616)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9GH-0003M3-4l
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:53 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:10:50 +0300
Message-ID: <151127345022.6888.7353172210861790809.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 38/45] windbg: implemented
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
 windbgstub-utils.c              |   29 +++++++++++++++++++++++++++++
 windbgstub.c                    |    8 ++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 7f52acbae3..be48f69f40 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -97,6 +97,8 @@ void kd_api_read_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_read_io_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_io_space(CPUState *cpu, PacketData *pd);
+void kd_api_read_physical_memory(CPUState *cpu, PacketData *pd);
+void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 3f8ce1f8be..6708e62798 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -210,6 +210,35 @@ void kd_api_write_io_space(CPUState *cpu, PacketData *pd)
     pd->m64.ReturnStatus = STATUS_SUCCESS;
 }
 
+void kd_api_read_physical_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
+    uint32_t len;
+    target_ulong addr;
+
+    len = MIN(ldl_p(&mem->TransferCount),
+              PACKET_MAX_SIZE - sizeof(DBGKD_MANIPULATE_STATE64));
+    addr = ldtul_p(&mem->TargetBaseAddress);
+
+    cpu_physical_memory_rw(addr, pd->extra, len, 0);
+    pd->extra_size = len;
+    stl_p(&mem->ActualBytesRead, len);
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
+    stl_p(&mem->ActualBytesWritten, len);
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 397dedd9d1..72324ae53d 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -189,6 +189,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
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
 
