Received: from eggs.gnu.org ([2001:4830:134:3::10]:59168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFl-0004pQ-1H
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFj-0003KK-A9
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:00 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFi-00032C-Rc
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:02 -0400
Message-Id: <20181019010625.25294-34-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 33/56] cris: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
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
index d2ec349191..e3fa19363f 100644
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
