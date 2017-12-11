Received: from eggs.gnu.org ([2001:4830:134:3::10]:34741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO4z-0004AS-1d
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO4v-0003gq-Ui
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:09 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44096)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO4v-0003gN-MU
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:05 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:24:50 +0300
Message-ID: <151299869028.4808.12985241516617955667.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 37/46] windbg: implemented
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
index 131eb6418a..a40253f18a 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -85,6 +85,8 @@ void kd_api_read_control_space(CPUState *cpu, PacketData *pd);
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
index a88bfde072..9cf25bc6dd 100755
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
 
