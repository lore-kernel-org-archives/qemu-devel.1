Received: from eggs.gnu.org ([2001:4830:134:3::10]:51567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f6ymv-0004gH-CL
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f6yms-0005lb-9K
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:30:49 -0400
Received: from mail.ispras.ru ([83.149.199.45]:58818)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f6ymr-0005l4-W8
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:30:46 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Fri, 13 Apr 2018 16:30:41 +0300
Message-ID: <20180413133041.29509.59064.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] m68: fix exception stack frame for 68000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, laurent@vivier.eu, pavel.dovgaluk@ispras.ru

68000 CPUs do not save format in the exception stack frame.
This patch adds feature checking to prevent format saving for 68000.
m68k_ret() already includes this modification, this patch fixes
the exception processing function too.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v2:
 - moved switch under the condition (suggested by Laurent Vivier)
---
 target/m68k/op_helper.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 3a7f7f2..8d09ed9 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -287,22 +287,25 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
                                   uint16_t format, uint16_t sr,
                                   uint32_t addr, uint32_t retaddr)
 {
-    CPUState *cs = CPU(m68k_env_get_cpu(env));
-    switch (format) {
-    case 4:
-        *sp -= 4;
-        cpu_stl_kernel(env, *sp, env->pc);
-        *sp -= 4;
-        cpu_stl_kernel(env, *sp, addr);
-        break;
-    case 3:
-    case 2:
-        *sp -= 4;
-        cpu_stl_kernel(env, *sp, addr);
-        break;
+    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
+        /*  all except 68000 */
+        CPUState *cs = CPU(m68k_env_get_cpu(env));
+        switch (format) {
+        case 4:
+            *sp -= 4;
+            cpu_stl_kernel(env, *sp, env->pc);
+            *sp -= 4;
+            cpu_stl_kernel(env, *sp, addr);
+            break;
+        case 3:
+        case 2:
+            *sp -= 4;
+            cpu_stl_kernel(env, *sp, addr);
+            break;
+        }
+        *sp -= 2;
+        cpu_stw_kernel(env, *sp, (format << 12) + (cs->exception_index << 2));
     }
-    *sp -= 2;
-    cpu_stw_kernel(env, *sp, (format << 12) + (cs->exception_index << 2));
     *sp -= 4;
     cpu_stl_kernel(env, *sp, retaddr);
     *sp -= 2;
