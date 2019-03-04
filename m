Received: from eggs.gnu.org ([209.51.188.92]:44794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sB9-0000SH-TX
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sB7-00021H-V9
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:07 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sB6-0001Sp-17
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:05 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:18:06 -0500
Message-Id: <20190304181813.8075-67-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v7 66/73] riscv: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Soon we will call cpu_has_work without the BQL.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/riscv/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cc3ddc0ae4..a9a0a6728d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -257,6 +257,9 @@ static bool riscv_cpu_has_work(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+
+    g_assert(qemu_mutex_iothread_locked());
+
     /*
      * Definition of the WFI instruction requires it to ignore the privilege
      * mode and delegation registers, but respect individual enables
@@ -343,7 +346,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->reset = riscv_cpu_reset;
 
     cc->class_by_name = riscv_cpu_class_by_name;
-    cc->has_work = riscv_cpu_has_work;
+    cc->has_work_with_iothread_lock = riscv_cpu_has_work;
     cc->do_interrupt = riscv_cpu_do_interrupt;
     cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt;
     cc->dump_state = riscv_cpu_dump_state;
-- 
2.17.1
