Received: from eggs.gnu.org ([2001:4830:134:3::10]:60277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ccGCM-0004Aj-FD
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ccGCH-0004p3-Ot
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:45:34 -0500
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:34005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1ccGCH-0004oj-JV
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:45:29 -0500
Received: by mail-yw0-x241.google.com with SMTP id v73so3180370ywg.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 10:45:29 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 10 Feb 2017 13:45:24 -0500
Message-Id: <20170210184525.10966-2-bobby.prani@gmail.com>
In-Reply-To: <20170210184525.10966-1-bobby.prani@gmail.com>
References: <20170210184525.10966-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/2] tcg: Save cpu flags in atomic execution
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

The current mechanism discards the flags which were set in atomic
execution. Properly save them.

CC: Alex Bennée <alex.bennee@linaro.org>
CC: Richard Henderson <rth@twiddle.net>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 cpu-exec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/cpu-exec.c b/cpu-exec.c
index b0ddada8c1..9200c643c2 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -228,6 +228,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 
 static void cpu_exec_step(CPUState *cpu)
 {
+    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = (CPUArchState *)cpu->env_ptr;
     TranslationBlock *tb;
     target_ulong cs_base, pc;
@@ -239,9 +240,13 @@ static void cpu_exec_step(CPUState *cpu)
                      1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
     tb->orig_tb = NULL;
     tb_unlock();
+
+    cc->cpu_exec_enter(cpu);
     /* execute the generated code */
     trace_exec_tb_nocache(tb, pc);
     cpu_tb_exec(cpu, tb);
+
+    cc->cpu_exec_exit(cpu);
     tb_lock();
     tb_phys_invalidate(tb, -1);
     tb_free(tb);
-- 
2.11.0
