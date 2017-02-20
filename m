Received: from eggs.gnu.org ([2001:4830:134:3::10]:56970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cfpLq-0001kZ-4C
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cfpLn-0006tA-KL
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:54:06 -0500
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cfpLn-0006t5-Ft
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:54:03 -0500
Received: by mail-yb0-x243.google.com with SMTP id d128so885866ybh.3
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 06:54:03 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 20 Feb 2017 09:53:35 -0500
Message-Id: <20170220145335.591-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] mttcg: Set jmp_env to handle exit from
 tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

tb_gen_code() can exit execution using cpu_exit_loop() when it cannot
allocate new tb's. To handle this, we need to properly set the jmp_env
pointer ahead of calling tb_gen_code().

CC:Alex Bennée <alex.bennee@linaro.org> 
CC: Richard Henderson <rth@twiddle.net>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 cpu-exec.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 97d79612d9..4b70988b24 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -236,23 +236,22 @@ static void cpu_exec_step(CPUState *cpu)
 
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
     tb_lock();
-    tb = tb_gen_code(cpu, pc, cs_base, flags,
-                     1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
-    tb->orig_tb = NULL;
-    tb_unlock();
-
-    cc->cpu_exec_enter(cpu);
-
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
+        tb = tb_gen_code(cpu, pc, cs_base, flags,
+                         1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
+        tb->orig_tb = NULL;
+        tb_unlock();
+
+        cc->cpu_exec_enter(cpu);
         /* execute the generated code */
         trace_exec_tb_nocache(tb, pc);
         cpu_tb_exec(cpu, tb);
-    }
+        cc->cpu_exec_exit(cpu);
 
-    cc->cpu_exec_exit(cpu);
-    tb_lock();
-    tb_phys_invalidate(tb, -1);
-    tb_free(tb);
+        tb_lock();
+        tb_phys_invalidate(tb, -1);
+        tb_free(tb);
+    }
     tb_unlock();
 }
 
-- 
2.11.0
