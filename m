Received: from eggs.gnu.org ([2001:4830:134:3::10]:54016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSs-0000ol-IL
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSq-0007Fy-6y
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:22 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:40274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSq-0007Er-03
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:20 -0400
Received: by mail-pl0-x22e.google.com with SMTP id s17-v6so1975141plp.7
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:21:53 -0700
Message-Id: <20180809042206.15726-8-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/20] target/arm: Fix is_a64 for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

Saves about 8k code size in qemu-aarch64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index aedaf2631e..ed51a2f5aa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -918,7 +918,15 @@ void aarch64_sync_64_to_32(CPUARMState *env);
 
 static inline bool is_a64(CPUARMState *env)
 {
+#ifdef CONFIG_USER_ONLY
+# ifdef TARGET_AARCH64
+    return true;
+# else
+    return false;
+# endif
+#else
     return env->aarch64;
+#endif
 }
 
 /* you can call this signal handler from your SIGBUS and SIGSEGV
-- 
2.17.1
