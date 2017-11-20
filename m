Received: from eggs.gnu.org ([2001:4830:134:3::10]:58264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtW1-0004nM-Nx
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtW0-000827-Tn
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:05 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtW0-0007yn-Mk
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:04 -0500
Received: by mail-lf0-x244.google.com with SMTP id y2so10781007lfj.4
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:22:04 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:40 +0200
Message-Id: <15e692a6fc716f32976eea47946a4892e8ad7a3f.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 12/15] linux-user/ppc: Report correct fault
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
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

For faults on loads and stores, ppc_cpu_handle_mmu_fault() in
target/ppc/user_only_helper.c stores the offending address
in env->spr[SPR_DAR]. Report this correctly to the guest
in si_addr, rather than incorrectly using the address of the
instruction that caused the fault.

This fixes the test case in
https://bugs.launchpad.net/qemu/+bug/1077116
for ppc, ppc64 and ppc64le.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index b6dd9efd2d..6286661bd3 100644
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
2.14.2
