Received: from eggs.gnu.org ([2001:4830:134:3::10]:60492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cmXvm-0001e1-0C
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 22:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cmXvl-0004BZ-6k
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 22:42:58 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cmXvl-0004BM-2U
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 22:42:57 -0500
Received: by mail-qk0-x241.google.com with SMTP id n141so31281258qke.3
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 19:42:56 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sat, 11 Mar 2017 13:42:32 +1000
Message-Id: <20170311034232.14213-4-rth@twiddle.net>
In-Reply-To: <20170311034232.14213-1-rth@twiddle.net>
References: <20170311034232.14213-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 3/3] target/hppa: Fix cpu_clone_regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, riku.voipio@iki.fi, deller@gmx.de

By failing to return from the syscall in the child, the child
issues another clone syscall and hilarity ensues.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/hppa/target_cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index 1a5ceca..e50522e 100644
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
2.9.3
