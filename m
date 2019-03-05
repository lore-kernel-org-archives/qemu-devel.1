Received: from eggs.gnu.org ([209.51.188.92]:54485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHO-0001VG-Te
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHO-0000fS-1Y
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:50:58 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHN-0000d8-Pl
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:50:57 -0500
Received: by mail-wm1-x330.google.com with SMTP id y15so3281726wma.0
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:50:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.50.55
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:50:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:31 +0000
Message-Id: <20190305165051.26860-3-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/22] target/arm: Split out arm_sctlr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Minimize the number of places that will need updating when
the virtual host extensions are added.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190301200501.16533-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 26 ++++++++++++++++----------
 target/arm/helper.c |  8 ++------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 36cd365efaf..67b06bfad09 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3042,11 +3042,20 @@ static inline bool arm_sctlr_b(CPUARMState *env)
         (env->cp15.sctlr_el[1] & SCTLR_B) != 0;
 }
 
+static inline uint64_t arm_sctlr(CPUARMState *env, int el)
+{
+    if (el == 0) {
+        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+        return env->cp15.sctlr_el[1];
+    } else {
+        return env->cp15.sctlr_el[el];
+    }
+}
+
+
 /* Return true if the processor is in big-endian mode. */
 static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 {
-    int cur_el;
-
     /* In 32bit endianness is determined by looking at CPSR's E bit */
     if (!is_a64(env)) {
         return
@@ -3065,15 +3074,12 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
             arm_sctlr_b(env) ||
 #endif
                 ((env->uncached_cpsr & CPSR_E) ? 1 : 0);
+    } else {
+        int cur_el = arm_current_el(env);
+        uint64_t sctlr = arm_sctlr(env, cur_el);
+
+        return (sctlr & (cur_el ? SCTLR_EE : SCTLR_E0E)) != 0;
     }
-
-    cur_el = arm_current_el(env);
-
-    if (cur_el == 0) {
-        return (env->cp15.sctlr_el[1] & SCTLR_E0E) != 0;
-    }
-
-    return (env->cp15.sctlr_el[cur_el] & SCTLR_EE) != 0;
 }
 
 #include "exec/cpu-all.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1fa282a7fc1..49ff79a146b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12854,12 +12854,8 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
         }
 
-        if (current_el == 0) {
-            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-            sctlr = env->cp15.sctlr_el[1];
-        } else {
-            sctlr = env->cp15.sctlr_el[current_el];
-        }
+        sctlr = arm_sctlr(env, current_el);
+
         if (cpu_isar_feature(aa64_pauth, cpu)) {
             /*
              * In order to save space in flags, we record only whether
-- 
2.20.1
