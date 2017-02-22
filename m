Received: from eggs.gnu.org ([2001:4830:134:3::10]:35504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgaTl-0006cy-3A
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgaTk-0000UN-8J
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:13:25 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgaTk-0000U1-2c
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:13:24 -0500
Received: by mail-wr0-x236.google.com with SMTP id s27so6628444wrb.2
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 09:13:24 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 22 Feb 2017 17:13:06 +0000
Message-Id: <20170222171327.26624-4-alex.bennee@linaro.org>
In-Reply-To: <20170222171327.26624-1-alex.bennee@linaro.org>
References: <20170222171327.26624-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v13 03/24] mttcg: Add missing tb_lock/unlock()
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
