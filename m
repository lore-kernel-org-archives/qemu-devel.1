Received: from eggs.gnu.org ([2001:4830:134:3::10]:53999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSp-0000lX-Av
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSo-0007D2-HH
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:19 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:44953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSo-0007CK-Aq
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:18 -0400
Received: by mail-pg1-x529.google.com with SMTP id r1-v6so2099238pgp.11
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:21:52 -0700
Message-Id: <20180809042206.15726-7-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/20] target/arm: Fix arm_current_el for
 user-only
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

Saves about 12k code size in qemu-aarch64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2d6d7d03aa..aedaf2631e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1958,6 +1958,9 @@ static inline bool arm_v7m_is_handler_mode(CPUARMState *env)
  */
 static inline int arm_current_el(CPUARMState *env)
 {
+#ifdef CONFIG_USER_ONLY
+    return 0;
+#else
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_v7m_is_handler_mode(env) ||
             !(env->v7m.control[env->v7m.secure] & 1);
@@ -1984,6 +1987,7 @@ static inline int arm_current_el(CPUARMState *env)
 
         return 1;
     }
+#endif
 }
 
 typedef struct ARMCPRegInfo ARMCPRegInfo;
-- 
2.17.1
