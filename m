Received: from eggs.gnu.org ([2001:4830:134:3::10]:59300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFo-0004su-7u
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFk-0003Mh-HE
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFj-00034p-SC
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:00 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:13 -0400
Message-Id: <20181019010625.25294-45-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 44/56] unicore32: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/unicore32/cpu.c     | 2 +-
 target/unicore32/softmmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 2b49d1ca40..65c5334551 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -29,7 +29,7 @@ static void uc32_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool uc32_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request &
+    return cpu_interrupt_request(cs) &
         (CPU_INTERRUPT_HARD | CPU_INTERRUPT_EXITTB);
 }
 
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index 00c7e0d028..f58e2361e0 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -119,7 +119,7 @@ void uc32_cpu_do_interrupt(CPUState *cs)
     /* The PC already points to the proper instruction.  */
     env->regs[30] = env->regs[31];
     env->regs[31] = addr;
-    cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+    cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
 }
 
 static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
-- 
2.17.1
