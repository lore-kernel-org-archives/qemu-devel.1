Received: from eggs.gnu.org ([209.51.188.92]:59096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMF-0008IW-Gk
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMB-0003kl-Iv
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:59 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMB-0003cu-6X
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:55 -0500
Received: by mail-wr1-x42b.google.com with SMTP id x10so7663812wrs.8
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.41
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:43 +0000
Message-Id: <20190201160653.13829-38-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/47] target/arm: Enable API, APK bits in SCR,
 HCR
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

These bits become writable with the ARMv8.3-PAuth extension.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190129143511.12311-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e6f69180ba0..d070879894c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1859,6 +1859,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     if (cpu_isar_feature(aa64_lor, cpu)) {
         valid_mask |= SCR_TLOR;
     }
+    if (cpu_isar_feature(aa64_pauth, cpu)) {
+        valid_mask |= SCR_API | SCR_APK;
+    }
 
     /* Clear all-context RES0 bits.  */
     value &= valid_mask;
@@ -4558,6 +4561,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     if (cpu_isar_feature(aa64_lor, cpu)) {
         valid_mask |= HCR_TLOR;
     }
+    if (cpu_isar_feature(aa64_pauth, cpu)) {
+        valid_mask |= HCR_API | HCR_APK;
+    }
 
     /* Clear RES0 bits.  */
     value &= valid_mask;
-- 
2.20.1
