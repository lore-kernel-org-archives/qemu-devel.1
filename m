Received: from eggs.gnu.org ([2001:4830:134:3::10]:34936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWiB-00044U-B8
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWi7-0007hv-KY
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:55:31 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50804)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWi2-0007FA-Qm
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:55:23 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:55:08 +0300
Message-ID: <154401450778.8440.8213559779814326805.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 33/39] windbg: implement
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

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 ++
 windbgstub-utils.c              |   29 +++++++++++++++++++++++++++++
 windbgstub.c                    |    8 ++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index f0a786cdef..fa67a7048d 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -78,6 +78,8 @@ void kd_api_read_control_space(CPUState *cs, PacketData *pd);
 void kd_api_write_control_space(CPUState *cs, PacketData *pd);
 void kd_api_read_io_space(CPUState *cs, PacketData *pd);
 void kd_api_write_io_space(CPUState *cs, PacketData *pd);
+void kd_api_read_physical_memory(CPUState *cs, PacketData *pd);
+void kd_api_write_physical_memory(CPUState *cs, PacketData *pd);
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd);
 void kd_api_get_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_set_context_ex(CPUState *cs, PacketData *pd);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index b3c2504be2..602dcf0be8 100644
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -388,6 +388,35 @@ void kd_api_write_io_space(CPUState *cs, PacketData *pd)
     pd->m64.ReturnStatus = STATUS_SUCCESS;
 }
 
+void kd_api_read_physical_memory(CPUState *cs, PacketData *pd)
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
+void kd_api_write_physical_memory(CPUState *cs, PacketData *pd)
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
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd)
 {
 }
diff --git a/windbgstub.c b/windbgstub.c
index 78f96a6621..25331f218f 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -204,6 +204,14 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_write_io_space(cs, data);
         break;
 
+    case DbgKdReadPhysicalMemoryApi:
+        kd_api_read_physical_memory(cs, data);
+        break;
+
+    case DbgKdWritePhysicalMemoryApi:
+        kd_api_write_physical_memory(cs, data);
+        break;
+
     case DbgKdClearAllInternalBreakpointsApi:
         kd_api_clear_all_internal_breakpoints(cs, data);
         return;
