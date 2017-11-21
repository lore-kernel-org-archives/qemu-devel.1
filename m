Received: from eggs.gnu.org ([2001:4830:134:3::10]:40265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9G0-0002Ri-UO
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Fv-0003Fd-1B
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:36 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38510)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Fu-0003FJ-EC
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:30 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:10:27 +0300
Message-ID: <151127342748.6888.16000796755963632674.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 34/45] windbg: implemented
 kd_api_write_breakpoint and kd_api_restore_breakpoint
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

Added supporting of windbg breakpoints.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 +
 windbgstub-utils.c              |   62 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |   11 +++++++
 3 files changed, 75 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 5e5893bac8..0d9ccf9801 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -90,6 +90,8 @@ void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_get_context(CPUState *cpu, PacketData *pd);
 void kd_api_set_context(CPUState *cpu, PacketData *pd);
+void kd_api_write_breakpoint(CPUState *cpu, PacketData *pd);
+void kd_api_restore_breakpoint(CPUState *cpu, PacketData *pd);
 void kd_api_read_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 1e81c37501..f00dab2a9d 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -14,6 +14,8 @@
 static InitedAddr KPCR;
 static InitedAddr version;
 
+static InitedAddr bps[KD_BREAKPOINT_MAX];
+
 InitedAddr *windbg_get_KPCR(void)
 {
     return &KPCR;
@@ -71,6 +73,66 @@ void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd)
     stl_p(&mem->ActualBytesWritten, len);
 }
 
+void kd_api_write_breakpoint(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_WRITE_BREAKPOINT64 *m64c = &pd->m64.u.WriteBreakPoint;
+    target_ulong addr;
+    int i, err = 0;
+
+    addr = ldtul_p(&m64c->BreakPointAddress);
+
+    for (i = 0; i < KD_BREAKPOINT_MAX; ++i) {
+        if (!bps[i].is_init) {
+            err = cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
+            if (!err) {
+                bps[i].addr = addr;
+                bps[i].is_init = true;
+                WINDBG_DEBUG("write_breakpoint: " FMT_ADDR, addr);
+                break;
+            } else {
+                WINDBG_ERROR("write_breakpoint: " FMT_ADDR ", " FMT_ERR,
+                             addr, err);
+                pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+                return;
+            }
+        } else if (addr == bps[i].addr) {
+            break;
+        }
+    }
+
+    if (!err) {
+        stl_p(&m64c->BreakPointHandle, i + 1);
+        pd->m64.ReturnStatus = STATUS_SUCCESS;
+    } else {
+        WINDBG_ERROR("write_breakpoint: All breakpoints occupied");
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+}
+
+void kd_api_restore_breakpoint(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_RESTORE_BREAKPOINT *m64c = &pd->m64.u.RestoreBreakPoint;
+    uint8_t index;
+    int err = -1;
+
+    index = ldtul_p(&m64c->BreakPointHandle) - 1;
+
+    if (bps[index].is_init) {
+        err = cpu_breakpoint_remove(cpu, bps[index].addr, BP_GDB);
+        if (!err) {
+            WINDBG_DEBUG("restore_breakpoint: " FMT_ADDR ", index(%d)",
+                         bps[index].addr, index);
+        } else {
+            WINDBG_ERROR("restore_breakpoint: " FMT_ADDR ", index(%d), "
+                         FMT_ERR, bps[index].addr, index, err);
+        }
+        bps[index].is_init = false;
+        pd->m64.ReturnStatus = STATUS_SUCCESS;
+    } else {
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 5b0a15ea4e..489abe6d6c 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -156,6 +156,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_set_context(cpu, &ctx->data);
         break;
 
+    case DbgKdWriteBreakPointApi:
+        kd_api_write_breakpoint(cpu, &ctx->data);
+        break;
+
+    case DbgKdRestoreBreakPointApi:
+        kd_api_restore_breakpoint(cpu, &ctx->data);
+        break;
+
     case DbgKdReadControlSpaceApi:
         kd_api_read_control_space(cpu, &ctx->data);
         break;
@@ -164,6 +172,9 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_write_control_space(cpu, &ctx->data);
         break;
 
+    case DbgKdClearAllInternalBreakpointsApi:
+        return;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
