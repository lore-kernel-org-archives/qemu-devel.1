Received: from eggs.gnu.org ([2001:4830:134:3::10]:46015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5M-00013s-Pv
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5J-00075i-N3
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W5J-00073I-3w
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:33 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5H-0003iy-HC
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:52 +0100
Message-Id: <20181008140004.12612-22-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/33] target/arm: Define new EXCP type for v8M
 stack overflows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Define EXCP_STKOF, and arrange for it to cause us to take
a UsageFault with CFSR.STKOF set.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181002163556.10279-3-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 2 ++
 target/arm/helper.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fde96845034..3a2aff11928 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -56,6 +56,7 @@
 #define EXCP_SEMIHOST       16   /* semihosting call */
 #define EXCP_NOCP           17   /* v7M NOCP UsageFault */
 #define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
+#define EXCP_STKOF          19   /* v8M STKOF UsageFault */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
 #define ARMV7M_EXCP_RESET   1
@@ -1388,6 +1389,7 @@ FIELD(V7M_CFSR, UNDEFINSTR, 16 + 0, 1)
 FIELD(V7M_CFSR, INVSTATE, 16 + 1, 1)
 FIELD(V7M_CFSR, INVPC, 16 + 2, 1)
 FIELD(V7M_CFSR, NOCP, 16 + 3, 1)
+FIELD(V7M_CFSR, STKOF, 16 + 4, 1)
 FIELD(V7M_CFSR, UNALIGNED, 16 + 8, 1)
 FIELD(V7M_CFSR, DIVBYZERO, 16 + 9, 1)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0807173eac9..a9a2173cb2f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7539,6 +7539,7 @@ static void arm_log_exception(int idx)
             [EXCP_SEMIHOST] = "Semihosting call",
             [EXCP_NOCP] = "v7M NOCP UsageFault",
             [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
+            [EXCP_STKOF] = "v8M STKOF UsageFault",
         };
 
         if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
@@ -7694,6 +7695,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVSTATE_MASK;
         break;
+    case EXCP_STKOF:
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
+        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_STKOF_MASK;
+        break;
     case EXCP_SWI:
         /* The PC already points to the next instruction.  */
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SVC, env->v7m.secure);
-- 
2.19.0
