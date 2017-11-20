Received: from eggs.gnu.org ([2001:4830:134:3::10]:58123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVo-0004Ur-3u
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVn-0007iJ-DG
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:52 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:43426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVn-0007em-6P
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:51 -0500
Received: by mail-lf0-x242.google.com with SMTP id 73so11682380lfu.10
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:21:51 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:31 +0200
Message-Id: <fc37dcfe1a049090e72fd3f4810f0b221cc5399c.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 03/15] linux-user/hppa: Fix cpu_clone_regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

By failing to return from the syscall in the child, the child
issues another clone syscall and hilarity ensues.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/hppa/target_cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index 1a5cecad3c..e50522eae9 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -24,7 +24,11 @@ static inline void cpu_clone_regs(CPUHPPAState *env, target_ulong newsp)
     if (newsp) {
         env->gr[30] = newsp;
     }
+    /* Indicate child in return value.  */
     env->gr[28] = 0;
+    /* Return from the syscall.  */
+    env->iaoq_f = env->gr[31];
+    env->iaoq_b = env->gr[31] + 4;
 }
 
 static inline void cpu_set_tls(CPUHPPAState *env, target_ulong newtls)
-- 
2.14.2
