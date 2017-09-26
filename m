Received: from eggs.gnu.org ([2001:4830:134:3::10]:60084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhz-0005jE-0C
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhv-0001a3-JO
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:22 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52306)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhv-0001ZY-6m
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:19 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:07:17 +0300
Message-ID: <150642403705.3900.11372246446054638606.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 34/43] windbg: implemented
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
 windbgstub-utils.c              |   77 ++++++++++++++++++++++++++++++++++++++-
 windbgstub.c                    |   11 ++++++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index e368b2e85d..3d062ab9bb 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -106,6 +106,8 @@ void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_get_context(CPUState *cpu, PacketData *pd);
 void kd_api_set_context(CPUState *cpu, PacketData *pd);
+void kd_api_write_breakpoint(CPUState *cpu, PacketData *pd);
+void kd_api_restore_breakpoint(CPUState *cpu, PacketData *pd);
 void kd_api_read_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 05caf98c0c..c5d24c5d8e 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -288,6 +288,8 @@ typedef struct _CPU_KPROCESSOR_STATE {
 typedef struct KDData {
     InitedAddr KPCR;
     InitedAddr version;
+
+    InitedAddr bps[KD_BREAKPOINT_MAX];
 } KDData;
 
 static KDData *kd;
@@ -971,6 +973,62 @@ void kd_api_set_context(CPUState *cpu, PacketData *pd)
     }
 }
 
+void kd_api_write_breakpoint(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_WRITE_BREAKPOINT64 *m64c = &pd->m64.u.WriteBreakPoint;
+    target_ulong addr = ldtul_p(&m64c->BreakPointAddress);
+    int i = 0, err = 0;
+
+    for (; i < KD_BREAKPOINT_MAX; ++i) {
+        if (!kd->bps[i].is_init) {
+            err = cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
+            if (!err) {
+                kd->bps[i].addr = addr;
+                kd->bps[i].is_init = true;
+                WINDBG_DEBUG("write_breakpoint: " FMT_ADDR, addr);
+                break;
+            } else {
+                WINDBG_ERROR("write_breakpoint: " FMT_ADDR ", " FMT_ERR,
+                             addr, err);
+                pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+                return;
+            }
+        } else if (addr == kd->bps[i].addr) {
+            break;
+        }
+    }
+
+    if (!err) {
+        m64c->BreakPointHandle = i + 1;
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
+    uint8_t index = ldtul_p(&m64c->BreakPointHandle) - 1;
+    int err = -1;
+
+    if (kd->bps[index].is_init) {
+        err = cpu_breakpoint_remove(cpu, kd->bps[index].addr, BP_GDB);
+        if (!err) {
+            WINDBG_DEBUG("restore_breakpoint: " FMT_ADDR ", index(%d)",
+                         kd->bps[index].addr, index);
+        } else {
+            WINDBG_ERROR("restore_breakpoint: " FMT_ADDR ", index(%d), "
+                         FMT_ERR, kd->bps[index].addr, index, err);
+        }
+        kd->bps[index].is_init = false;
+        pd->m64.ReturnStatus = STATUS_SUCCESS;
+    } else {
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+}
+
 void kd_api_read_control_space(CPUState *cpu, PacketData *pd)
 {
     DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
@@ -1052,7 +1110,24 @@ void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 
 static void kd_breakpoint_remove_range(CPUState *cpu, target_ulong base,
                                        target_ulong limit)
-{}
+{
+    int i = 0, err = 0;
+    for (; i < KD_BREAKPOINT_MAX; ++i) {
+        if (kd->bps[i].is_init && kd->bps[i].addr >= base &&
+            kd->bps[i].addr < limit) {
+            err = cpu_breakpoint_remove(cpu, kd->bps[i].addr, BP_GDB);
+            if (!err) {
+                WINDBG_DEBUG("breakpoint_remove_range: " FMT_ADDR
+                             ", index(%d)", kd->bps[i].addr, i);
+            } else {
+                WINDBG_ERROR("breakpoint_remove_range: " FMT_ADDR
+                             ", index(%d), " FMT_ERR,
+                             kd->bps[i].addr, i, err);
+            }
+            kd->bps[i].is_init = false;
+        }
+    }
+}
 
 static void kd_init_state_change(CPUState *cpu,
                                  DBGKD_ANY_WAIT_STATE_CHANGE *sc)
diff --git a/windbgstub.c b/windbgstub.c
index 24d0031167..f8e80c60ab 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -149,6 +149,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
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
@@ -157,6 +165,9 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_write_control_space(cpu, &ctx->data);
         break;
 
+    case DbgKdClearAllInternalBreakpointsApi:
+        return;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
