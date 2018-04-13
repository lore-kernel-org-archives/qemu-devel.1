Received: from eggs.gnu.org ([2001:4830:134:3::10]:45416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f6wdU-0004VM-09
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f6wdP-0002BG-3R
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:12:55 -0400
Received: from mail.ispras.ru ([83.149.199.45]:48720)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f6wdO-0002A8-RZ
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:12:51 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Fri, 13 Apr 2018 14:12:45 +0300
Message-ID: <20180413111245.28627.3415.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] m68: fix exception stack frame for 68000
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
---
 target/m68k/op_helper.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 3a7f7f2..e367133 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -301,8 +301,11 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
         cpu_stl_kernel(env, *sp, addr);
         break;
     }
-    *sp -= 2;
-    cpu_stw_kernel(env, *sp, (format << 12) + (cs->exception_index << 2));
+    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
+        /*  all except 68000 */
+        *sp -= 2;
+        cpu_stw_kernel(env, *sp, (format << 12) + (cs->exception_index << 2));
+    }
     *sp -= 4;
     cpu_stl_kernel(env, *sp, retaddr);
     *sp -= 2;
