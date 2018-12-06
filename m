Received: from eggs.gnu.org ([2001:4830:134:3::10]:42149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLl-00015y-5I
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLg-00069C-C7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:48 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60418)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsLf-00060g-VH
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:01:44 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:01:32 +0300
Message-ID: <154409769211.5432.7012271191124338625.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 31/39] windbg: implement kd_api_continue
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
 include/exec/windbgstub-utils.h |    1 +
 windbgstub-utils.c              |   15 +++++++++++++++
 windbgstub.c                    |    5 +++++
 3 files changed, 21 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 85b7322b82..2843ad055e 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -73,6 +73,7 @@ void kd_api_get_context(CPUState *cs, PacketData *pd);
 void kd_api_set_context(CPUState *cs, PacketData *pd);
 void kd_api_write_breakpoint(CPUState *cs, PacketData *pd);
 void kd_api_restore_breakpoint(CPUState *cs, PacketData *pd);
+void kd_api_continue(CPUState *cs, PacketData *pd);
 void kd_api_read_control_space(CPUState *cs, PacketData *pd);
 void kd_api_write_control_space(CPUState *cs, PacketData *pd);
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index e4b7c4e6d0..9432aad762 100644
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -10,6 +10,7 @@
  */
 
 #include "exec/windbgstub-utils.h"
+#include "sysemu/sysemu.h"
 
 static const char *kd_api_names[] = {
     "DbgKdReadVirtualMemoryApi",
@@ -311,6 +312,20 @@ void kd_api_restore_breakpoint(CPUState *cs, PacketData *pd)
     }
 }
 
+void kd_api_continue(CPUState *cs, PacketData *pd)
+{
+    uint32_t status = ldl_p(&pd->m64.u.Continue2.ContinueStatus);
+    uint32_t trace = ldl_p(&pd->m64.u.Continue2.ControlSet.TraceFlag);
+    int ssFlag = trace ? SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER : 0;
+
+    if (NT_SUCCESS(status)) {
+        cpu_single_step(cs, ssFlag);
+        if (!runstate_needs_reset()) {
+            vm_start();
+        }
+    }
+}
+
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd)
 {
 }
diff --git a/windbgstub.c b/windbgstub.c
index 0e4ad6d009..d64bbc3f34 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -183,6 +183,11 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_restore_breakpoint(cs, data);
         break;
 
+    case DbgKdContinueApi:
+    case DbgKdContinueApi2:
+        kd_api_continue(cs, data);
+        return;
+
     case DbgKdReadControlSpaceApi:
         kd_api_read_control_space(cs, data);
         break;
