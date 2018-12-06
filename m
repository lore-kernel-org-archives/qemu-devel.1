Received: from eggs.gnu.org ([2001:4830:134:3::10]:42240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLz-0001Gx-0L
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLv-0006F7-0N
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:02 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60454)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLu-0006BB-OQ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:58 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:01:43 +0300
Message-ID: <154409770323.5432.2269923579000346342.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 33/39] windbg: implement
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
index 48855cc858..4289e537a9 100644
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
