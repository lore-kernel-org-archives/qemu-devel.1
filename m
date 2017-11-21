Received: from eggs.gnu.org ([2001:4830:134:3::10]:40147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Fh-00027r-MX
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Fd-000371-OE
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:17 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38426)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Fd-00036N-Gh
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:13 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:10:10 +0300
Message-ID: <151127341057.6888.4836291640056893717.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 31/45] windbg: implemented windbg_set_dr
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
index c59d1401ad..14ad195107 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -14,6 +14,21 @@
 #ifndef TARGET_X86_64
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
@@ -273,9 +288,42 @@ typedef struct _CPU_KPROCESSOR_STATE {
     CPU_KSPECIAL_REGISTERS SpecialRegisters;
 } CPU_KPROCESSOR_STATE, *PCPU_KPROCESSOR_STATE;
 
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
