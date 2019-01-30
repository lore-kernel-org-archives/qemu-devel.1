Received: from eggs.gnu.org ([209.51.188.92]:35682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3y-00007t-Lg
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3v-0001Ht-DE
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:08 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3s-00012N-R5
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:04 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:44 -0500
Message-Id: <20190130004811.27372-47-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 46/73] cris: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/cris/cpu.c    | 2 +-
 target/cris/helper.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index a23aba2688..3cdba581e6 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -37,7 +37,7 @@ static void cris_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool cris_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
 /* CPUClass::reset() */
diff --git a/target/cris/helper.c b/target/cris/helper.c
index b2dbb2075c..5c453d5221 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -116,7 +116,7 @@ int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     if (r > 0) {
         qemu_log_mask(CPU_LOG_MMU,
                 "%s returns %d irqreq=%x addr=%" VADDR_PRIx " phy=%x vec=%x"
-                " pc=%x\n", __func__, r, cs->interrupt_request, address,
+                " pc=%x\n", __func__, r, cpu_interrupt_request(cs), address,
                 res.phy, res.bf_vec, env->pc);
     }
     return r;
@@ -130,7 +130,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
 
     D_LOG("exception index=%d interrupt_req=%d\n",
           cs->exception_index,
-          cs->interrupt_request);
+          cpu_interrupt_request(cs));
 
     if (env->dslot) {
         /* CRISv10 never takes interrupts while in a delay-slot.  */
@@ -192,7 +192,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
 
     D_LOG("exception index=%d interrupt_req=%d\n",
           cs->exception_index,
-          cs->interrupt_request);
+          cpu_interrupt_request(cs));
 
     switch (cs->exception_index) {
     case EXCP_BREAK:
-- 
2.17.1
