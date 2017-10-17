Received: from eggs.gnu.org ([2001:4830:134:3::10]:34589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rf5-00055k-8O
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rf1-0006hO-DQ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:59 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57192)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rf1-0006ge-5r
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:55 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:11:52 +0300
Message-ID: <150824591192.6816.2324759466048015841.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 32/43] windbg: implemented windbg_set_dr7
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
index 7dff5e6c1b..570e68a735 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -297,7 +297,32 @@ static int windbg_hw_breakpoint_remove(CPUState *cpu, int index)
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
