Received: from eggs.gnu.org ([2001:4830:134:3::10]:42138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLl-00015w-59
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLf-00068Z-QH
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:47 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60372)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLd-0005uC-Fr
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:43 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:01:21 +0300
Message-ID: <154409768093.5432.14349304881922492190.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 29/39] windbg: implement
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

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |    3 ++
 windbgstub-utils.c              |   68 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |   12 +++++++
 3 files changed, 83 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 2781a54044..85b7322b82 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -71,8 +71,11 @@ void kd_api_read_virtual_memory(CPUState *cs, PacketData *pd);
 void kd_api_write_virtual_memory(CPUState *cs, PacketData *pd);
 void kd_api_get_context(CPUState *cs, PacketData *pd);
 void kd_api_set_context(CPUState *cs, PacketData *pd);
+void kd_api_write_breakpoint(CPUState *cs, PacketData *pd);
+void kd_api_restore_breakpoint(CPUState *cs, PacketData *pd);
 void kd_api_read_control_space(CPUState *cs, PacketData *pd);
 void kd_api_write_control_space(CPUState *cs, PacketData *pd);
+void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd);
 void kd_api_get_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_set_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_unsupported(CPUState *cs, PacketData *pd);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index e7da2d5dd8..e4b7c4e6d0 100644
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -80,6 +80,8 @@ static const char *kd_packet_type_names[] = {
     "PACKET_TYPE_MAX",
 };
 
+static InitedAddr bps[KD_BREAKPOINT_MAX];
+
 static void prep_bmbc(const uint8_t *pattern, int pLen, int bmBc[])
 {
     int i;
@@ -247,6 +249,72 @@ void kd_api_write_virtual_memory(CPUState *cs, PacketData *pd)
     stl_p(&mem->ActualBytesWritten, len);
 }
 
+void kd_api_write_breakpoint(CPUState *cs, PacketData *pd)
+{
+    DBGKD_WRITE_BREAKPOINT64 *m64c = &pd->m64.u.WriteBreakPoint;
+    target_ulong addr;
+    int i, err = 0;
+
+    addr = ldtul_p(&m64c->BreakPointAddress);
+
+    for (i = 0; i < KD_BREAKPOINT_MAX; ++i) {
+        if (!bps[i].is_init) {
+            err = cpu_breakpoint_insert(cs, addr, BP_GDB, NULL);
+            if (!err) {
+                bps[i].addr = addr;
+                bps[i].is_init = true;
+                DPRINTF("write_breakpoint: " FMT_ADDR ", index(%d)\n",
+                        addr, i);
+                break;
+            } else {
+                WINDBG_ERROR("write_breakpoint: " FMT_ADDR ", " FMT_ERR, addr,
+                             err);
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
+void kd_api_restore_breakpoint(CPUState *cs, PacketData *pd)
+{
+    DBGKD_RESTORE_BREAKPOINT *m64c = &pd->m64.u.RestoreBreakPoint;
+    uint8_t index;
+    int err = -1;
+
+    index = ldtul_p(&m64c->BreakPointHandle) - 1;
+
+    if (bps[index].is_init) {
+        err = cpu_breakpoint_remove(cs, bps[index].addr, BP_GDB);
+        if (!err) {
+            DPRINTF("restore_breakpoint: " FMT_ADDR ", index(%d)\n",
+                    bps[index].addr, index);
+        } else {
+            WINDBG_ERROR("restore_breakpoint: " FMT_ADDR
+                         ", index(%d), " FMT_ERR,
+                         bps[index].addr, index, err);
+        }
+        bps[index].is_init = false;
+        pd->m64.ReturnStatus = STATUS_SUCCESS;
+    } else {
+        pd->m64.ReturnStatus = STATUS_SUCCESS;
+    }
+}
+
+void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd)
+{
+}
+
 void kd_api_unsupported(CPUState *cs, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s", kd_api_name(pd->m64.ApiNumber));
diff --git a/windbgstub.c b/windbgstub.c
index 328a04735f..a1c013cd8c 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -165,6 +165,14 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_set_context(cs, data);
         break;
 
+    case DbgKdWriteBreakPointApi:
+        kd_api_write_breakpoint(cs, data);
+        break;
+
+    case DbgKdRestoreBreakPointApi:
+        kd_api_restore_breakpoint(cs, data);
+        break;
+
     case DbgKdReadControlSpaceApi:
         kd_api_read_control_space(cs, data);
         break;
@@ -173,6 +181,10 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_write_control_space(cs, data);
         break;
 
+    case DbgKdClearAllInternalBreakpointsApi:
+        kd_api_clear_all_internal_breakpoints(cs, data);
+        return;
+
     case DbgKdGetContextExApi:
         kd_api_get_context_ex(cs, data);
         break;
