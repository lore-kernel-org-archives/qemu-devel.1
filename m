Received: from eggs.gnu.org ([2001:4830:134:3::10]:48940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cO7aL-0001GK-V9
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 13:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cO7aI-0005uC-Tg
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 13:43:54 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:36001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cO7aI-0005sf-PR
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 13:43:50 -0500
Received: by mail-yw0-x244.google.com with SMTP id r204so36288055ywb.3
	for <qemu-devel@nongnu.org>; Mon, 02 Jan 2017 10:43:49 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon,  2 Jan 2017 13:42:58 -0500
Message-Id: <20170102184258.2442-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] mttcg: Add missing tb_lock/unlock() in
 cpu_exec_step()
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

The recent patch enabling lock assertions uncovered the missing lock
acquisition in cpu_exec_step(). This patch adds them.

CC: Richard Henderson <rth@twiddle.net>
CC: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 cpu-exec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cpu-exec.c b/cpu-exec.c
index aa8318d864..ef328087be 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -234,14 +234,18 @@ static void cpu_exec_step(CPUState *cpu)
     uint32_t flags;
 
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
+    tb_lock();
     tb = tb_gen_code(cpu, pc, cs_base, flags,
                      1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
     tb->orig_tb = NULL;
+    tb_unlock();
     /* execute the generated code */
     trace_exec_tb_nocache(tb, pc);
     cpu_tb_exec(cpu, tb);
+    tb_lock();
     tb_phys_invalidate(tb, -1);
     tb_free(tb);
+    tb_unlock();
 }
 
 void cpu_exec_step_atomic(CPUState *cpu)
-- 
2.11.0
