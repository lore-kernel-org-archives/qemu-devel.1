Received: from eggs.gnu.org ([2001:4830:134:3::10]:34505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rez-0004zU-Tx
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rev-0006bC-SY
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:53 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57142)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rev-0006aT-Jh
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:49 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:11:46 +0300
Message-ID: <150824590636.6816.17152155223503474492.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 31/43] windbg: implemented windbg_set_dr
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

Defined useful macros for breakpoints.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 target/i386/windbgstub.c |   50 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index d67ad8cf0c..7dff5e6c1b 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -12,6 +12,21 @@
 #include "qemu/osdep.h"
 #include "exec/windbgstub-utils.h"
 
+#define IS_LOCAL_BP_ENABLED(dr7, index) (((dr7) >> ((index) * 2)) & 1)
+
+#define IS_GLOBAL_BP_ENABLED(dr7, index) (((dr7) >> ((index) * 2)) & 2)
+
+#define IS_BP_ENABLED(dr7, index) \
+    (IS_LOCAL_BP_ENABLED(dr7, index) | IS_GLOBAL_BP_ENABLED(dr7, index))
+
+#define BP_TYPE(dr7, index) \
+    ((int) ((dr7) >> (DR7_TYPE_SHIFT + ((index) * 4))) & 3)
+
+#define BP_LEN(dr7, index) ({                                    \
+    int _len = (((dr7) >> (DR7_LEN_SHIFT + ((index) * 4))) & 3); \
+    (_len == 2) ? 8 : _len + 1;                                  \
+})
+
 #ifdef TARGET_X86_64
 # define OFFSET_SELF_PCR         0x18
 # define OFFSET_VERS             0x108
@@ -271,9 +286,42 @@ typedef struct _CPU_KPROCESSOR_STATE {
 
 #endif
 
-static void windbg_set_dr(CPUState *cpu, int index, target_ulong value)
+static int windbg_hw_breakpoint_insert(CPUState *cpu, int index)
+{
+    return 0;
+}
+
+static int windbg_hw_breakpoint_remove(CPUState *cpu, int index)
+{
+    return 0;
+}
+
+static void windbg_set_dr7(CPUState *cpu, target_ulong new_dr7)
 {}
 
+static void windbg_set_dr(CPUState *cpu, int index, target_ulong value)
+{
+    CPUArchState *env = cpu->env_ptr;
+
+    switch (index) {
+    case 0 ... 3:
+        if (IS_BP_ENABLED(env->dr[7], index) && env->dr[index] != value) {
+            windbg_hw_breakpoint_remove(cpu, index);
+            env->dr[index] = value;
+            windbg_hw_breakpoint_insert(cpu, index);
+        } else {
+            env->dr[index] = value;
+        }
+        return;
+    case 6:
+        env->dr[6] = value | DR6_FIXED_1;
+        return;
+    case 7:
+        windbg_set_dr7(cpu, value);
+        return;
+    }
+}
+
 static void windbg_set_sr(CPUState *cpu, int sr, uint16_t selector)
 {
     CPUArchState *env = cpu->env_ptr;
