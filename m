Received: from eggs.gnu.org ([209.51.188.92]:54162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gm3Xs-0004G8-5R
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gm3Xr-0001Kk-EE
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:25:20 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gm3Xr-0001Ik-2n
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:25:19 -0500
Received: by mail-lf1-x144.google.com with SMTP id v5so181lfe.7
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 13:25:18 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 22 Jan 2019 13:25:04 -0800
Message-Id: <20190122212504.6137-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: add qemu_cpu_kick to
 xtensa_runstall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

When xtensa_runstall is called to unstall a core it needs to kick it
after clearing runstall flag, otherwise the core doesn't start
immediately. There's also no point in clearing CPU_INTERRUPT_HALT, drop
it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 323c47a7fb54..bcf2f20d4858 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -252,7 +252,7 @@ void xtensa_runstall(CPUXtensaState *env, bool runstall)
     if (runstall) {
         cpu_interrupt(cpu, CPU_INTERRUPT_HALT);
     } else {
-        cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
+        qemu_cpu_kick(cpu);
     }
 }
 #endif
-- 
2.11.0
