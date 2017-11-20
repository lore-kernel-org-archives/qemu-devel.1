Received: from eggs.gnu.org ([2001:4830:134:3::10]:58280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtW4-0004vR-WA
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtW2-00082s-Ex
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:08 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtW2-00082H-6o
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:06 -0500
Received: by mail-lf0-x244.google.com with SMTP id k66so11727387lfg.3
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:22:06 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:41 +0200
Message-Id: <8d8cb956e0a679fcf0a8e24f1b2f34e038cdd48e.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/15] linux-user/sparc: Put address for data
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
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

In the user-mode-only version of sparc_cpu_handle_mmu_fault(),
we must save the fault address for a data fault into the CPU
state's mmu registers, because the code in linux-user/main.c
expects to find it there in order to populate the si_addr
field of the guest siginfo.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 target/sparc/mmu_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 126ea5e3ee..d5b6c1e48c 100644
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
2.14.2
