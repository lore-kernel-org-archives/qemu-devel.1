Received: from eggs.gnu.org ([209.51.188.92]:49784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goUqh-0006Aw-MB
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goUUD-0008C4-TI
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:35:47 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goUU7-00088A-SO
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:35:37 -0500
Received: by mail-oi1-x244.google.com with SMTP id c206so16334541oib.0
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 06:35:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 29 Jan 2019 06:35:11 -0800
Message-Id: <20190129143511.12311-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Enable API, APK bits in SCR, HCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

These bits become writable with the ARMv8.3-PAuth extension.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 70277222da..a1a2ac7d06 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1747,6 +1747,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     if (cpu_isar_feature(aa64_lor, cpu)) {
         valid_mask |= SCR_TLOR;
     }
+    if (cpu_isar_feature(aa64_pauth, cpu)) {
+        valid_mask |= SCR_API | SCR_APK;
+    }
 
     /* Clear all-context RES0 bits.  */
     value &= valid_mask;
@@ -4444,6 +4447,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     if (cpu_isar_feature(aa64_lor, cpu)) {
         valid_mask |= HCR_TLOR;
     }
+    if (cpu_isar_feature(aa64_pauth, cpu)) {
+        valid_mask |= HCR_API | HCR_APK;
+    }
 
     /* Clear RES0 bits.  */
     value &= valid_mask;
-- 
2.17.2
