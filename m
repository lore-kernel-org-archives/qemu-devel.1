Received: from eggs.gnu.org ([2001:4830:134:3::10]:43580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f7eFI-0000jH-9k
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 05:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f7eFF-0007ON-5A
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 05:46:52 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:45551)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f7eFE-0007Mz-Qd
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 05:46:49 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 15 Apr 2018 11:46:38 +0200
Message-Id: <20180415094638.3278-2-laurent@vivier.eu>
In-Reply-To: <20180415094638.3278-1-laurent@vivier.eu>
References: <20180415094638.3278-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/1] m68k: fix exception stack frame for 68000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

68000 CPUs do not save format in the exception stack frame.
This patch adds feature checking to prevent format saving for 68000.
m68k_ret() already includes this modification, this patch fixes
the exception processing function too.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180413133041.29509.59064.stgit@pasha-VirtualBox>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/op_helper.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 3a7f7f2219..8d09ed91c4 100644
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
-- 
2.14.3
