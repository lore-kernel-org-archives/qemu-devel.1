Received: from eggs.gnu.org ([2001:4830:134:3::10]:35941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eBmCm-0002Ad-H2
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eBmCl-0000p5-Es
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:04 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eBmCl-0000ky-8L
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:03 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  6 Nov 2017 18:33:25 +0000
Message-Id: <1509993206-26637-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] linux-user/sparc: Put address for data
 faults where linux-user expects it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

In the user-mode-only version of sparc_cpu_handle_mmu_fault(),
we must save the fault address for a data fault into the CPU
state's mmu registers, because the code in linux-user/main.c
expects to find it there in order to populate the si_addr
field of the guest siginfo.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/mmu_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 126ea5e..d5b6c1e 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -30,10 +30,18 @@
 int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
                                int mmu_idx)
 {
+    SPARCCPU *cpu = SPARC_CPU(cs);
+    CPUSPARCState *env = &cpu->env;
+
     if (rw & 2) {
         cs->exception_index = TT_TFAULT;
     } else {
         cs->exception_index = TT_DFAULT;
+#ifdef TARGET_SPARC64
+        env->dmmu.mmuregs[4] = address;
+#else
+        env->mmuregs[4] = address;
+#endif
     }
     return 1;
 }
-- 
2.7.4
