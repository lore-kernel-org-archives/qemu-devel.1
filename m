Received: from eggs.gnu.org ([2001:4830:134:3::10]:34515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO4Q-0003eN-PW
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO4O-0003Lf-5q
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:24:34 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43944)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO4N-0003L6-Tn
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:24:32 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:24:16 +0300
Message-ID: <151299865610.4808.8820750653179638903.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 31/46] windbg: implemented windbg_set_dr7
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
 target/i386/windbgstub.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index cae827df50..6e167a7473 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -299,7 +299,32 @@ static int windbg_hw_breakpoint_remove(CPUState *cpu, int index)
 }
 
 static void windbg_set_dr7(CPUState *cpu, target_ulong new_dr7)
-{}
+{
+    CPUArchState *env = cpu->env_ptr;
+    target_ulong old_dr7 = env->dr[7];
+    int iobpt = 0;
+    int i;
+
+    new_dr7 |= DR7_FIXED_1;
+    if (new_dr7 == old_dr7) {
+        return;
+    }
+
+    for (i = 0; i < DR7_MAX_BP; i++) {
+        if (IS_BP_ENABLED(old_dr7, i) && !IS_BP_ENABLED(new_dr7, i)) {
+            windbg_hw_breakpoint_remove(cpu, i);
+        }
+    }
+
+    env->dr[7] = new_dr7;
+    for (i = 0; i < DR7_MAX_BP; i++) {
+        if (IS_BP_ENABLED(env->dr[7], i)) {
+            iobpt |= windbg_hw_breakpoint_insert(cpu, i);
+        }
+    }
+
+    env->hflags = (env->hflags & ~HF_IOBPT_MASK) | iobpt;
+}
 
 static void windbg_set_dr(CPUState *cpu, int index, target_ulong value)
 {
