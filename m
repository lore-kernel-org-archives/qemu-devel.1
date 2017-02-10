Received: from eggs.gnu.org ([2001:4830:134:3::10]:60281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ccGCM-0004Ak-J6
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ccGCI-0004ph-Ic
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:45:34 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:36104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1ccGCI-0004pO-E8
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:45:30 -0500
Received: by mail-yw0-x242.google.com with SMTP id q71so3159902ywg.3
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 10:45:30 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 10 Feb 2017 13:45:25 -0500
Message-Id: <20170210184525.10966-3-bobby.prani@gmail.com>
In-Reply-To: <20170210184525.10966-1-bobby.prani@gmail.com>
References: <20170210184525.10966-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/2] tcg: Set jmp_env for exceptions from
 atomic execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The current method of executing atomic code in a guest uses
cpu_exec_step_atomic() from the outermost loop. This causes an abort()
when single stepping over atomic code since debug exception longjmp
will point to the the setlongjmp in cpu_exec(). Properly set jmp_env
so that it jumps back here on an exception.

CC: Alex Bennée <alex.bennee@linaro.org>
CC: Richard Henderson <rth@twiddle.net>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 cpu-exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 9200c643c2..e61f5747c8 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -242,9 +242,12 @@ static void cpu_exec_step(CPUState *cpu)
     tb_unlock();
 
     cc->cpu_exec_enter(cpu);
-    /* execute the generated code */
-    trace_exec_tb_nocache(tb, pc);
-    cpu_tb_exec(cpu, tb);
+
+    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
+        /* execute the generated code */
+        trace_exec_tb_nocache(tb, pc);
+        cpu_tb_exec(cpu, tb);
+    }
 
     cc->cpu_exec_exit(cpu);
     tb_lock();
-- 
2.11.0
