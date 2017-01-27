Received: from eggs.gnu.org ([2001:4830:134:3::10]:50386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX45A-00045I-0k
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX456-0005mu-Qb
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:48:40 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX456-0005mi-KS
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:48:36 -0500
Received: by mail-wm0-x229.google.com with SMTP id r126so111266695wmr.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:48:36 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:39:18 +0000
Message-Id: <20170127103922.19658-22-alex.bennee@linaro.org>
In-Reply-To: <20170127103922.19658-1-alex.bennee@linaro.org>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 21/25] target-arm: don't generate WFE/YIELD
 calls for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

The WFE and YIELD instructions are really only hints and in TCG's case
they were useful to move the scheduling on from one vCPU to the next. In
the parallel context (MTTCG) this just causes an unnecessary cpu_exit
and contention of the BQL.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/op_helper.c     |  7 +++++++
 target/arm/translate-a64.c |  8 ++++++--
 target/arm/translate.c     | 20 ++++++++++++++++----
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index e1a883c595..abfa7cdd39 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -436,6 +436,13 @@ void HELPER(yield)(CPUARMState *env)
     ARMCPU *cpu = arm_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
 
+    /* When running in MTTCG we don't generate jumps to the yield and
+     * WFE helpers as it won't affect the scheduling of other vCPUs.
+     * If we wanted to more completely model WFE/SEV so we don't busy
+     * spin unnecessarily we would need to do something more involved.
+     */
+    g_assert(!parallel_cpus);
+
     /* This is a non-trappable hint instruction that generally indicates
      * that the guest is currently busy-looping. Yield control back to the
      * top level loop so that a more deserving VCPU has a chance to run.
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 88a4df6959..05162f335e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1342,10 +1342,14 @@ static void handle_hint(DisasContext *s, uint32_t insn,
         s->is_jmp = DISAS_WFI;
         return;
     case 1: /* YIELD */
-        s->is_jmp = DISAS_YIELD;
+        if (!parallel_cpus) {
+            s->is_jmp = DISAS_YIELD;
+        }
         return;
     case 2: /* WFE */
-        s->is_jmp = DISAS_WFE;
+        if (!parallel_cpus) {
+            s->is_jmp = DISAS_WFE;
+        }
         return;
     case 4: /* SEV */
     case 5: /* SEVL */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index dc67887918..444a24c2b6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4343,20 +4343,32 @@ static void gen_exception_return(DisasContext *s, TCGv_i32 pc)
     gen_rfe(s, pc, load_cpu_field(spsr));
 }
 
+/*
+ * For WFI we will halt the vCPU until an IRQ. For WFE and YIELD we
+ * only call the helper when running single threaded TCG code to ensure
+ * the next round-robin scheduled vCPU gets a crack. In MTTCG mode we
+ * just skip this instruction. Currently the SEV/SEVL instructions
+ * which are *one* of many ways to wake the CPU from WFE are not
+ * implemented so we can't sleep like WFI does.
+ */
 static void gen_nop_hint(DisasContext *s, int val)
 {
     switch (val) {
     case 1: /* yield */
-        gen_set_pc_im(s, s->pc);
-        s->is_jmp = DISAS_YIELD;
+        if (!parallel_cpus) {
+            gen_set_pc_im(s, s->pc);
+            s->is_jmp = DISAS_YIELD;
+        }
         break;
     case 3: /* wfi */
         gen_set_pc_im(s, s->pc);
         s->is_jmp = DISAS_WFI;
         break;
     case 2: /* wfe */
-        gen_set_pc_im(s, s->pc);
-        s->is_jmp = DISAS_WFE;
+        if (!parallel_cpus) {
+            gen_set_pc_im(s, s->pc);
+            s->is_jmp = DISAS_WFE;
+        }
         break;
     case 4: /* sev */
     case 5: /* sevl */
-- 
2.11.0
