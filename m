Received: from eggs.gnu.org ([2001:4830:134:3::10]:34560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO4Z-0003lU-Mc
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO4T-0003PT-Rw
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:24:43 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43962)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO4T-0003P5-Jw
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:24:37 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:24:22 +0300
Message-ID: <151299866215.4808.6549177107050604222.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 32/46] windbg: implemented
 windbg_hw_breakpoint_insert and windbg_hw_breakpoint_remove
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
 target/i386/windbgstub.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 6e167a7473..5e094e81d7 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -290,11 +290,67 @@ typedef struct _CPU_KPROCESSOR_STATE {
 
 static int windbg_hw_breakpoint_insert(CPUState *cpu, int index)
 {
+    CPUArchState *env = cpu->env_ptr;
+
+    target_ulong addr = env->dr[index];
+    int type = BP_TYPE(env->dr[7], index);
+    int len = BP_LEN(env->dr[7], index);
+    int err = 0;
+
+    switch (type) {
+    case DR7_TYPE_DATA_WR:
+        err = cpu_watchpoint_insert(cpu, addr, len, BP_MEM_WRITE | BP_GDB,
+                                    &env->cpu_watchpoint[index]);
+        break;
+    case DR7_TYPE_DATA_RW:
+        err = cpu_watchpoint_insert(cpu, addr, len, BP_MEM_ACCESS | BP_GDB,
+                                    &env->cpu_watchpoint[index]);
+        break;
+    case DR7_TYPE_BP_INST:
+        err = cpu_breakpoint_insert(cpu, addr, BP_GDB,
+                                    &env->cpu_breakpoint[index]);
+        break;
+    case DR7_TYPE_IO_RW:
+        return HF_IOBPT_MASK;
+    default:
+        return 0;
+    }
+
+    if (!err) {
+        WINDBG_DEBUG("hw_breakpoint_insert: index(%d), " FMT_ADDR,
+                     index, addr);
+    } else {
+        env->cpu_breakpoint[index] = NULL;
+        WINDBG_ERROR("hw_breakpoint_insert: index(%d), " FMT_ADDR ", " FMT_ERR,
+                     index, addr, err);
+    }
     return 0;
 }
 
 static int windbg_hw_breakpoint_remove(CPUState *cpu, int index)
 {
+    CPUArchState *env = cpu->env_ptr;
+    int type = BP_TYPE(env->dr[7], index);
+
+    switch (type) {
+    case DR7_TYPE_BP_INST:
+        if (env->cpu_breakpoint[index]) {
+            cpu_breakpoint_remove_by_ref(cpu, env->cpu_breakpoint[index]);
+        }
+        break;
+    case DR7_TYPE_DATA_WR:
+    case DR7_TYPE_DATA_RW:
+        if (env->cpu_watchpoint[index]) {
+            cpu_watchpoint_remove_by_ref(cpu, env->cpu_watchpoint[index]);
+        }
+        break;
+    default:
+        return 0;
+    }
+
+    env->cpu_breakpoint[index] = NULL;
+    WINDBG_DEBUG("hw_breakpoint_remove: index(%d), " FMT_ADDR,
+                 index, env->dr[index]);
     return 0;
 }
 
