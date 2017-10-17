Received: from eggs.gnu.org ([2001:4830:134:3::10]:34804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RfS-0005Ld-Te
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RfO-00074g-8k
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:12:22 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57330)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RfO-00074E-0K
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:12:18 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:12:14 +0300
Message-ID: <150824593465.6816.16332217244673633518.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 36/43] windbg: implemented kd_api_continue
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
index 8cea2afdf1..49b05226b3 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -99,6 +99,7 @@ void kd_api_get_context(CPUState *cpu, PacketData *pd);
 void kd_api_set_context(CPUState *cpu, PacketData *pd);
 void kd_api_write_breakpoint(CPUState *cpu, PacketData *pd);
 void kd_api_restore_breakpoint(CPUState *cpu, PacketData *pd);
+void kd_api_continue(CPUState *cpu, PacketData *pd);
 void kd_api_read_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 0f23f3c865..dce2b4ccde 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -10,6 +10,7 @@
  */
 
 #include "exec/windbgstub-utils.h"
+#include "sysemu/sysemu.h"
 
 static InitedAddr KPCR;
 static InitedAddr version;
@@ -133,6 +134,20 @@ void kd_api_restore_breakpoint(CPUState *cpu, PacketData *pd)
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
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index b33f412659..a04698b003 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -168,6 +168,11 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
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
