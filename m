Received: from eggs.gnu.org ([2001:4830:134:3::10]:40373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f84jI-0000Lc-QD
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f84jE-0004F0-Qd
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:03:36 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f84jE-0004EN-Hz
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:03:32 -0400
Received: by mail-wr0-x243.google.com with SMTP id q6so14293413wrd.6
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 07:03:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 16 Apr 2018 15:03:22 +0100
Message-Id: <20180416140322.904-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] target/arm: support reading of CNTVCT_EL0
 from user-space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, takeharu.kato@linaro.org, renato.golin@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Since kernel commit a86bd139f2 (arm64: arch_timer: Enable CNTVCT_EL0
trap..) user-space has been able to read this system register. This
patch enables access to that register although currently it always
returns 0 as we don't yet have a mechanism for managing timers in
linux-user mode.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b14fdab140..8244badd63 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2121,11 +2121,25 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
 };
 
 #else
-/* In user-mode none of the generic timer registers are accessible,
- * and their implementation depends on QEMU_CLOCK_VIRTUAL and qdev gpio outputs,
- * so instead just don't register any of them.
+
+/* In user-mode most of the generic timer registers are inaccessible
+ * however modern kernels (4.12+) allow access to cntvct_el0
  */
+
+static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* Currently we have no support for QEMUTimer in linux-user so we
+     * can't call gt_get_countervalue(env).
+     */
+    return 0;
+}
+
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
+    { .name = "CNTVCT_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 2,
+      .access = PL0_R, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .readfn = gt_virt_cnt_read,
+    },
     REGINFO_SENTINEL
 };
 
-- 
2.17.0
