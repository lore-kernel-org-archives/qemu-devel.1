Received: from eggs.gnu.org ([2001:4830:134:3::10]:54154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W3o-0002Rw-W9
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W3k-0005Ew-CG
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:29 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e9W3k-0005Ea-2b
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:24 -0400
Received: by mail-wr0-x243.google.com with SMTP id z55so15871182wrz.1
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 05:54:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 31 Oct 2017 13:53:54 +0100
Message-Id: <20171031125358.23377-4-richard.henderson@linaro.org>
In-Reply-To: <20171031125358.23377-1-richard.henderson@linaro.org>
References: <20171031125358.23377-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/7] linux-user/hppa: Fix cpu_clone_regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

By failing to return from the syscall in the child, the child
issues another clone syscall and hilarity ensues.

Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.13.6
