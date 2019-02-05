Received: from eggs.gnu.org ([209.51.188.92]:35968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AT-0001uZ-Gi
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AR-0000ZU-US
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:53 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AR-0000RM-KG
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:51 -0500
Received: by mail-wr1-x444.google.com with SMTP id s12so4473467wrt.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.34
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:05:03 +0000
Message-Id: <20190205170510.21984-16-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/22] target/arm: Enable TBI for user-only
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

This has been enabled in the linux kernel since v3.11
(commit d50240a5f6cea, 2013-09-03,
"arm64: mm: permit use of tagged pointers at EL0").

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190204132126.3255-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3874dc98754..edf6e0e1f1c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -200,6 +200,12 @@ static void arm_cpu_reset(CPUState *s)
         env->vfp.zcr_el[1] = cpu->sve_max_vq - 1;
         env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
         env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
+        /*
+         * Enable TBI0 and TBI1.  While the real kernel only enables TBI0,
+         * turning on both here will produce smaller code and otherwise
+         * make no difference to the user-level emulation.
+         */
+        env->cp15.tcr_el[1].raw_tcr = (3ULL << 37);
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.20.1
