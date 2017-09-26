Received: from eggs.gnu.org ([2001:4830:134:3::10]:59590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngr-0004c7-8C
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngp-00017s-Ta
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:13 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52056)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngp-00017X-Gu
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:11 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:06:09 +0300
Message-ID: <150642396922.3900.13282234011521338171.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 22/43] windbg: implemented
 kd_api_read_virtual_memory and kd_api_read_virtual_memory
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
 windbgstub-utils.c              |   47 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 +++++++
 3 files changed, 57 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index ca21af7c91..c1ff1cec57 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -102,6 +102,8 @@ typedef struct SizedBuf {
     buf.size = 0;           \
 } while (false)
 
+void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd);
+void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index e7b381f829..1bde60a1e9 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -30,6 +30,53 @@ typedef struct KDData {
 
 static KDData *kd;
 
+void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
+    uint32_t len;
+    target_ulong addr;
+    int err;
+
+    len = MIN(ldl_p(&mem->TransferCount), PACKET_MAX_SIZE - M64_SIZE);
+    addr = ldtul_p(&mem->TargetBaseAddress);
+    err = cpu_memory_rw_debug(cpu, addr, pd->extra, len, 0);
+
+    if (!err) {
+        pd->extra_size = len;
+        mem->ActualBytesRead = ldl_p(&len);
+    } else {
+        pd->extra_size = 0;
+        mem->ActualBytesRead = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+
+        WINDBG_DEBUG("read_virtual_memory: No physical page mapped: " FMT_ADDR,
+                     (target_ulong) mem->TargetBaseAddress);
+    }
+}
+
+void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_WRITE_MEMORY64 *mem = &pd->m64.u.WriteMemory;
+    uint32_t len;
+    target_ulong addr;
+    int err;
+
+    len = MIN(ldl_p(&mem->TransferCount), pd->extra_size);
+    addr = ldtul_p(&mem->TargetBaseAddress);
+    err = cpu_memory_rw_debug(cpu, addr, pd->extra, len, 1);
+
+    pd->extra_size = 0;
+    if (!err) {
+        mem->ActualBytesWritten = ldl_p(&len);
+    } else {
+        mem->ActualBytesWritten = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+
+        WINDBG_DEBUG("read_write_memory: No physical page mapped: " FMT_ADDR,
+                     (target_ulong) mem->TargetBaseAddress);
+    }
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Catched unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 50b4ef0dea..327fe83f70 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -133,6 +133,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
 
     switch (ctx->data.m64.ApiNumber) {
 
+    case DbgKdReadVirtualMemoryApi:
+        kd_api_read_virtual_memory(cpu, &ctx->data);
+        break;
+
+    case DbgKdWriteVirtualMemoryApi:
+        kd_api_write_virtual_memory(cpu, &ctx->data);
+        break;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
