Received: from eggs.gnu.org ([2001:4830:134:3::10]:35037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7Nf8-00078L-BL
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7Nf7-0005JO-IM
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:42 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  2 Oct 2018 17:35:56 +0100
Message-Id: <20181002163556.10279-14-peter.maydell@linaro.org>
In-Reply-To: <20181002163556.10279-1-peter.maydell@linaro.org>
References: <20181002163556.10279-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/13] target/arm: Add v8M stack checks for MSR
 to SP_NS
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

Updating the NS stack pointer via MSR to SP_NS should include
a check whether the new SP value is below the stack limit.
No other kinds of update to the various stack pointer and
limit registers via MSR should perform a check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 074f7616272..712828674fa 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10963,11 +10963,23 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
              * currently in handler mode or not, using the NS CONTROL.SPSEL.
              */
             bool spsel = env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SPSEL_MASK;
+            bool is_psp = !arm_v7m_is_handler_mode(env) && spsel;
+            uint32_t limit;
 
             if (!env->v7m.secure) {
                 return;
             }
-            if (!arm_v7m_is_handler_mode(env) && spsel) {
+
+            limit = is_psp ? env->v7m.psplim[false] : env->v7m.msplim[false];
+
+            if (val < limit) {
+                CPUState *cs = CPU(arm_env_get_cpu(env));
+
+                cpu_restore_state(cs, GETPC(), true);
+                raise_exception(env, EXCP_STKOF, 0, 1);
+            }
+
+            if (is_psp) {
                 env->v7m.other_ss_psp = val;
             } else {
                 env->v7m.other_ss_msp = val;
-- 
2.19.0
