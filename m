Received: from eggs.gnu.org ([2001:4830:134:3::10]:35957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eBmCn-0002B4-4O
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eBmCm-0000pv-BQ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:05 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eBmCm-0000ky-5f
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:04 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  6 Nov 2017 18:33:24 +0000
Message-Id: <1509993206-26637-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] linux-user/ppc: Report correct fault
 address for data faults
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

For faults on loads and stores, ppc_cpu_handle_mmu_fault() in
target/ppc/user_only_helper.c stores the offending address
in env->spr[SPR_DAR]. Report this correctly to the guest
in si_addr, rather than incorrectly using the address of the
instruction that caused the fault.

This fixes the test case in
https://bugs.launchpad.net/qemu/+bug/1077116
for ppc, ppc64 and ppc64le.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index b6dd9ef..6286661 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1420,7 +1420,7 @@ void cpu_loop(CPUPPCState *env)
                 info.si_code = TARGET_SEGV_MAPERR;
                 break;
             }
-            info._sifields._sigfault._addr = env->nip;
+            info._sifields._sigfault._addr = env->spr[SPR_DAR];
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case POWERPC_EXCP_ISI:      /* Instruction storage exception         */
-- 
2.7.4
