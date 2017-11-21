Received: from eggs.gnu.org ([2001:4830:134:3::10]:39759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Eq-0001OB-Bj
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Ep-0002rf-6g
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:24 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38150)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Eo-0002rV-QM
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:23 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:09:20 +0300
Message-ID: <151127335992.6888.10847608262485289638.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 22/45] windbg: implemented
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

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 ++
 windbgstub-utils.c              |   47 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 +++++++
 3 files changed, 57 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 28fd53039a..827aabb6d3 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -86,6 +86,8 @@ typedef struct SizedBuf {
 InitedAddr *windbg_get_KPCR(void);
 InitedAddr *windbg_get_version(void);
 
+void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd);
+void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 04a7e1cc7b..1e81c37501 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -24,6 +24,53 @@ InitedAddr *windbg_get_version(void)
     return &version;
 }
 
+void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
+    uint32_t len;
+    target_ulong addr;
+    int err;
+
+    len = MIN(ldl_p(&mem->TransferCount),
+                    PACKET_MAX_SIZE - sizeof(DBGKD_MANIPULATE_STATE64));
+    addr = ldtul_p(&mem->TargetBaseAddress);
+    err = cpu_memory_rw_debug(cpu, addr, pd->extra, len, 0);
+
+    if (err) {
+        len = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+
+        WINDBG_DEBUG("read_virtual_memory: No physical page mapped: " FMT_ADDR,
+                     (target_ulong) mem->TargetBaseAddress);
+    }
+
+    pd->extra_size = len;
+    stl_p(&mem->ActualBytesRead, len);
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
+    if (err) {
+        len = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+
+        WINDBG_DEBUG("read_write_memory: No physical page mapped: " FMT_ADDR,
+                     (target_ulong) mem->TargetBaseAddress);
+    }
+
+    pd->extra_size = 0;
+    stl_p(&mem->ActualBytesWritten, len);
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 2467d2d247..1725107722 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -140,6 +140,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
 
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
