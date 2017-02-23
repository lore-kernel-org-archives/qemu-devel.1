Received: from eggs.gnu.org ([2001:4830:134:3::10]:44207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgy91-0004Ex-Sr
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgy8z-0006Mx-TZ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:35 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgy8z-0006M5-Mx
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:33 -0500
Received: by mail-wm0-x22c.google.com with SMTP id v77so6987026wmv.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:29:33 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 23 Feb 2017 18:29:06 +0000
Message-Id: <20170223182927.7166-4-alex.bennee@linaro.org>
In-Reply-To: <20170223182927.7166-1-alex.bennee@linaro.org>
References: <20170223182927.7166-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 03/24] mttcg: Add missing tb_lock/unlock()
 in cpu_exec_step()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

From: Pranith Kumar <bobby.prani@gmail.com>

The recent patch enabling lock assertions uncovered the missing lock
acquisition in cpu_exec_step(). This patch adds them.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 cpu-exec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cpu-exec.c b/cpu-exec.c
index 142a5862fc..ec84fdb3d7 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -233,14 +233,18 @@ static void cpu_exec_step(CPUState *cpu)
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
