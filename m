Received: from eggs.gnu.org ([2001:4830:134:3::10]:55285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeM-0007y4-9H
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeL-0002uK-IV
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 15:42:27 +0100
Message-Id: <20181012144235.19646-3-peter.maydell@linaro.org>
In-Reply-To: <20181012144235.19646-1-peter.maydell@linaro.org>
References: <20181012144235.19646-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/10] target/arm: Make switch_mode() file-local
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The switch_mode() function is defined in target/arm/helper.c and used
only in that file and nowhere else, so we can make it file-local
rather than global.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 1 -
 target/arm/helper.c    | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index abe4d73b59c..d4b1973efa1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -145,7 +145,6 @@ static inline int bank_number(int mode)
     g_assert_not_reached();
 }
 
-void switch_mode(CPUARMState *, int);
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0fa5ac0450f..0253a971099 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -56,6 +56,8 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
                                 V8M_SAttributes *sattrs);
 #endif
 
+static void switch_mode(CPUARMState *env, int mode);
+
 static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
 {
     int nregs;
@@ -6313,7 +6315,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     return 0;
 }
 
-void switch_mode(CPUARMState *env, int mode)
+static void switch_mode(CPUARMState *env, int mode)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
 
@@ -6335,7 +6337,7 @@ void aarch64_sync_64_to_32(CPUARMState *env)
 
 #else
 
-void switch_mode(CPUARMState *env, int mode)
+static void switch_mode(CPUARMState *env, int mode)
 {
     int old_mode;
     int i;
-- 
2.19.0
