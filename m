Received: from eggs.gnu.org ([2001:4830:134:3::10]:59994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhn-0005UM-El
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhk-0001Vc-Ar
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:11 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52276)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhk-0001VT-2y
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:08 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:07:06 +0300
Message-ID: <150642402591.3900.544237580736904991.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 32/43] windbg: implemented windbg_set_dr7
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
 windbgstub-utils.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 58c4c98f04..e33789725e 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -303,7 +303,32 @@ static int windbg_hw_breakpoint_remove(CPUState *cpu, int index)
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
