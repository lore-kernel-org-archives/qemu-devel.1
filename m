Received: from eggs.gnu.org ([2001:4830:134:3::10]:46406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5w-0001Wr-I3
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5v-0007Ou-Hm
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W5n-0006iu-AO
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:07 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5S-0003lk-GA
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:42 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 15:00:03 +0100
Message-Id: <20181008140004.12612-33-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/33] target/arm: Add v8M stack checks for MSR
 to SP_NS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Updating the NS stack pointer via MSR to SP_NS should include
a check whether the new SP value is below the stack limit.
No other kinds of update to the various stack pointer and
limit registers via MSR should perform a check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181002163556.10279-14-peter.maydell@linaro.org
---
 target/arm/helper.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 33c7e2f48e3..c83f7c1109c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10994,11 +10994,23 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
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
