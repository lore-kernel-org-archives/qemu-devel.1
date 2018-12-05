Received: from eggs.gnu.org ([2001:4830:134:3::10]:34128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWgm-0002QV-AW
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWgl-0006MP-HG
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:04 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50460)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWgl-0006Kj-7i
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:03 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:54:01 +0300
Message-ID: <154401444081.8440.12026768872502273785.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 21/39] windbg: implement
 kd_api_read_virtual_memory and kd_api_write_virtual_memory
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
 windbgstub-utils.c              |   47 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 +++++++
 3 files changed, 57 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 1c577ddd49..638b2b9a6f 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -67,6 +67,8 @@ typedef struct PacketData {
 const char *kd_api_name(int id);
 const char *kd_pkt_type_name(int id);
 
+void kd_api_read_virtual_memory(CPUState *cs, PacketData *pd);
+void kd_api_write_virtual_memory(CPUState *cs, PacketData *pd);
 void kd_api_unsupported(CPUState *cs, PacketData *pd);
 
 DBGKD_ANY_WAIT_STATE_CHANGE *kd_state_change_exc(CPUState *cs);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 6da6eea08f..61f74dd22e 100644
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -200,6 +200,53 @@ InitedAddr windbg_search_vmaddr(CPUState *cs, target_ulong start,
     return ret;
 }
 
+void kd_api_read_virtual_memory(CPUState *cs, PacketData *pd)
+{
+    DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
+    uint32_t len;
+    target_ulong addr;
+    int err;
+
+    len = MIN(ldl_p(&mem->TransferCount),
+              PACKET_MAX_SIZE - sizeof(DBGKD_MANIPULATE_STATE64));
+    addr = ldtul_p(&mem->TargetBaseAddress);
+    err = cpu_memory_rw_debug(cs, addr, pd->extra, len, 0);
+
+    if (err) {
+        len = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+
+        DPRINTF("read_virtual_memory: No physical page mapped: " FMT_ADDR "\n",
+                addr);
+    }
+
+    pd->extra_size = len;
+    stl_p(&mem->ActualBytesRead, len);
+}
+
+void kd_api_write_virtual_memory(CPUState *cs, PacketData *pd)
+{
+    DBGKD_WRITE_MEMORY64 *mem = &pd->m64.u.WriteMemory;
+    uint32_t len;
+    target_ulong addr;
+    int err;
+
+    len = MIN(ldl_p(&mem->TransferCount), pd->extra_size);
+    addr = ldtul_p(&mem->TargetBaseAddress);
+    err = cpu_memory_rw_debug(cs, addr, pd->extra, len, 1);
+
+    if (err) {
+        len = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+
+        DPRINTF("read_write_memory: No physical page mapped: " FMT_ADDR "\n",
+                addr);
+    }
+
+    pd->extra_size = 0;
+    stl_p(&mem->ActualBytesWritten, len);
+}
+
 void kd_api_unsupported(CPUState *cs, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s", kd_api_name(pd->m64.ApiNumber));
diff --git a/windbgstub.c b/windbgstub.c
index 6ed93b8ce9..46400d9bad 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -149,6 +149,14 @@ static void windbg_process_manipulate_packet(WindbgState *state)
     }
 
     switch (data->m64.ApiNumber) {
+    case DbgKdReadVirtualMemoryApi:
+        kd_api_read_virtual_memory(cs, data);
+        break;
+
+    case DbgKdWriteVirtualMemoryApi:
+        kd_api_write_virtual_memory(cs, data);
+        break;
+
     default:
         kd_api_unsupported(cs, data);
         break;
