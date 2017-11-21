Received: from eggs.gnu.org ([2001:4830:134:3::10]:40247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Fv-0002N4-F8
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Fp-0003Dz-1W
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:30 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38478)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Fo-0003Ds-PO
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:24 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:10:22 +0300
Message-ID: <151127342187.6888.10071306547141532589.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 33/45] windbg: implemented
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
index deb0e728e0..43e6d45df9 100755
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
 
