Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0767EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 06:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CDB206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 06:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CDB206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5NTc-0001Wo-0E
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 02:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1k5NSz-00010d-KU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 02:08:57 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1k5NSw-0002ni-Mm
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 02:08:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06837587|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.565985-0.000114229-0.433901;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07440; MF=zhiwei_liu@c-sky.com; NM=1; PH=DU;
 RN=5; RT=5; SR=0; TI=SMTPD_---.IFpw2zh_1597126109; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.IFpw2zh_1597126109)
 by smtp.aliyun-inc.com(10.147.44.118);
 Tue, 11 Aug 2020 14:08:35 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH 1/1] target/arm: adjust CPTR_EL2 according to HCR_EL2.E2H
Date: Tue, 11 Aug 2020 14:07:48 +0800
Message-Id: <20200811060749.159-1-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:08:38
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From DDI0487Fc_armv8_arm.pdf, the CPTR_EL2 has two kinds
of layouts according to HCR_EL2.E2H.

When HCR_EL2.E2H is 1, fp_exception_el should refer to
HCR_EL2.FPEN and sve_exception_el should refer to HCR_EL2.ZEN.

Change-Id: If1c8f88db9fb505c36211ceafbf25e838ed96ec0
Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/arm/helper.c | 53 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8ef0fb478f..19b74b25e4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6116,11 +6116,29 @@ int sve_exception_el(CPUARMState *env, int el)
      * they will be zero when EL2 is not present.
      */
     if (el <= 2 && !arm_is_secure_below_el3(env)) {
-        if (env->cp15.cptr_el[2] & CPTR_TZ) {
-            return 2;
-        }
-        if (env->cp15.cptr_el[2] & CPTR_TFP) {
-            return 0;
+        if ((arm_hcr_el2_eff(env) & HCR_E2H) == HCR_E2H) {
+            int zen = extract32(env->cp15.cptr_el[2], 16, 2);
+            switch (zen) {
+            case 0:
+            case 2:
+                return 2;
+            case 1:
+                if ((arm_hcr_el2_eff(env) & HCR_TGE) == HCR_TGE) {
+                    if (el == 0) {
+                        return 2;
+                    }
+                }
+                break;
+            case 3:
+                break;
+            }
+        } else {
+            if (env->cp15.cptr_el[2] & CPTR_TZ) {
+                return 2;
+            }
+            if (env->cp15.cptr_el[2] & CPTR_TFP) {
+                return 0;
+            }
         }
     }
 
@@ -12492,10 +12510,29 @@ int fp_exception_el(CPUARMState *env, int cur_el)
      */
 
     /* CPTR_EL2 : present in v7VE or v8 */
-    if (cur_el <= 2 && extract32(env->cp15.cptr_el[2], 10, 1)
-        && !arm_is_secure_below_el3(env)) {
+    if ((cur_el <= 2) && !arm_is_secure_below_el3(env)) {
         /* Trap FP ops at EL2, NS-EL1 or NS-EL0 to EL2 */
-        return 2;
+        if ((arm_hcr_el2_eff(env) & HCR_E2H) == HCR_E2H) {
+            int fpen = extract32(env->cp15.cptr_el[2], 20, 2);
+            switch (fpen) {
+            case 0:
+            case 2:
+                return 2;
+            case 1:
+                if ((arm_hcr_el2_eff(env) & HCR_TGE) == HCR_TGE) {
+                    if (cur_el == 0) {
+                        return 2;
+                    }
+                }
+                break;
+            case 3:
+                break;
+            }
+        } else {
+            if (extract32(env->cp15.cptr_el[2], 10, 1)) {
+                return 2;
+            }
+        }
     }
 
     /* CPTR_EL3 : present in v8 */
-- 
2.23.0


