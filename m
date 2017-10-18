Received: from eggs.gnu.org ([2001:4830:134:3::10]:42564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e4x1o-0003ld-Ul
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e4x1n-0001Zd-8I
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:41:32 -0400
Date: Wed, 18 Oct 2017 15:41:23 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1710181539580.27209@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PATCH] don't hardcode EL1 in
 extended_addresses_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, sstabellini@kernel.org, julien.grall@linaro.org

extended_addresses_enabled calls arm_el_is_aa64, hardcoding exception
level 1. Instead, retrieve the current el calling arm_current_el.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1f6efef..63507d9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -187,7 +187,7 @@ static inline unsigned int arm_pamax(ARMCPU *cpu)
 static inline bool extended_addresses_enabled(CPUARMState *env)
 {
     TCR *tcr = &env->cp15.tcr_el[arm_is_secure(env) ? 3 : 1];
-    return arm_el_is_aa64(env, 1) ||
+    return arm_el_is_aa64(env, arm_current_el(env)) ||
            (arm_feature(env, ARM_FEATURE_LPAE) && (tcr->raw_tcr & TTBCR_EAE));
 }
 
