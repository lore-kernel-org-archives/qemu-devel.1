Received: from eggs.gnu.org ([2001:4830:134:3::10]:60199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwniD-0005tv-6c
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwni7-0001eZ-Bt
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:37 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52348)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwni7-0001eD-3r
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:31 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:07:28 +0300
Message-ID: <150642404847.3900.17671292421528132408.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 36/43] windbg: implemented kd_api_continue
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
 include/exec/windbgstub-utils.h |    1 +
 windbgstub-utils.c              |   15 +++++++++++++++
 windbgstub.c                    |    5 +++++
 3 files changed, 21 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 3d062ab9bb..f6a60292a2 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -108,6 +108,7 @@ void kd_api_get_context(CPUState *cpu, PacketData *pd);
 void kd_api_set_context(CPUState *cpu, PacketData *pd);
 void kd_api_write_breakpoint(CPUState *cpu, PacketData *pd);
 void kd_api_restore_breakpoint(CPUState *cpu, PacketData *pd);
+void kd_api_continue(CPUState *cpu, PacketData *pd);
 void kd_api_read_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index c5d24c5d8e..8d5136f310 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -10,6 +10,7 @@
  */
 
 #include "exec/windbgstub-utils.h"
+#include "sysemu/sysemu.h"
 
 #define IS_LOCAL_BP_ENABLED(dr7, index) (((dr7) >> ((index) * 2)) & 1)
 
@@ -1029,6 +1030,20 @@ void kd_api_restore_breakpoint(CPUState *cpu, PacketData *pd)
     }
 }
 
+void kd_api_continue(CPUState *cpu, PacketData *pd)
+{
+    uint32_t status = ldl_p(&pd->m64.u.Continue2.ContinueStatus);
+    uint32_t trace = ldl_p(&pd->m64.u.Continue2.ControlSet.TraceFlag);
+    int ssFlag = trace ? SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER : 0;
+
+    if (NT_SUCCESS(status)) {
+        cpu_single_step(cpu, ssFlag);
+        if (!runstate_needs_reset()) {
+            vm_start();
+        }
+    }
+}
+
 void kd_api_read_control_space(CPUState *cpu, PacketData *pd)
 {
     DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
diff --git a/windbgstub.c b/windbgstub.c
index 54564962a5..19a4f0184b 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -161,6 +161,11 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_restore_breakpoint(cpu, &ctx->data);
         break;
 
+    case DbgKdContinueApi:
+    case DbgKdContinueApi2:
+        kd_api_continue(cpu, &ctx->data);
+        return;
+
     case DbgKdReadControlSpaceApi:
         kd_api_read_control_space(cpu, &ctx->data);
         break;
