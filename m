Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D672C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634B4206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634B4206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiHwm-0005ee-Ll
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 09:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jiHvu-00051e-7w; Mon, 08 Jun 2020 09:35:22 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jiHvs-0006FR-Ak; Mon, 08 Jun 2020 09:35:21 -0400
X-Originating-IP: 82.252.130.88
Received: from localhost.localdomain (lns-bzn-59-82-252-130-88.adsl.proxad.net
 [82.252.130.88]) (Authenticated sender: jcd@tribudubois.net)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C367320015;
 Mon,  8 Jun 2020 13:35:11 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-arm@nongnu.org
Subject: [PATCH v2] hw/misc/imx6ul_ccm: Implement non writable bits in CCM
 registers
Date: Mon,  8 Jun 2020 15:35:08 +0200
Message-Id: <20200608133508.550046-1-jcd@tribudubois.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=217.70.183.200; envelope-from=jcd@tribudubois.net;
 helo=relay7-d.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 09:35:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, peter.chubb@nicta.com.au, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some bits of the CCM registers are non writable.

This was left undone in the initial commit (all bits of registers were
writable).

This patch adds the required code to protect the non writable bits.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---

 v2: simplify code after feedback on the first patch.

 hw/misc/imx6ul_ccm.c | 76 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index a2fc1d0364a..5e0661dacf7 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -19,6 +19,62 @@
 
 #include "trace.h"
 
+static const uint32_t ccm_mask[CCM_MAX] = {
+    [CCM_CCR] = 0xf01fef80,
+    [CCM_CCDR] = 0xfffeffff,
+    [CCM_CSR] = 0xffffffff,
+    [CCM_CCSR] = 0xfffffef2,
+    [CCM_CACRR] = 0xfffffff8,
+    [CCM_CBCDR] = 0xc1f8e000,
+    [CCM_CBCMR] = 0xfc03cfff,
+    [CCM_CSCMR1] = 0x80700000,
+    [CCM_CSCMR2] = 0xe01ff003,
+    [CCM_CSCDR1] = 0xfe00c780,
+    [CCM_CS1CDR] = 0xfe00fe00,
+    [CCM_CS2CDR] = 0xf8007000,
+    [CCM_CDCDR] = 0xf00fffff,
+    [CCM_CHSCCDR] = 0xfffc01ff,
+    [CCM_CSCDR2] = 0xfe0001ff,
+    [CCM_CSCDR3] = 0xffffc1ff,
+    [CCM_CDHIPR] = 0xffffffff,
+    [CCM_CTOR] = 0x00000000,
+    [CCM_CLPCR] = 0xf39ff01c,
+    [CCM_CISR] = 0xfb85ffbe,
+    [CCM_CIMR] = 0xfb85ffbf,
+    [CCM_CCOSR] = 0xfe00fe00,
+    [CCM_CGPR] = 0xfffc3fea,
+    [CCM_CCGR0] = 0x00000000,
+    [CCM_CCGR1] = 0x00000000,
+    [CCM_CCGR2] = 0x00000000,
+    [CCM_CCGR3] = 0x00000000,
+    [CCM_CCGR4] = 0x00000000,
+    [CCM_CCGR5] = 0x00000000,
+    [CCM_CCGR6] = 0x00000000,
+    [CCM_CMEOR] = 0xafffff1f,
+};
+
+static const uint32_t analog_mask[CCM_ANALOG_MAX] = {
+    [CCM_ANALOG_PLL_ARM] = 0xfff60f80,
+    [CCM_ANALOG_PLL_USB1] = 0xfffe0fbc,
+    [CCM_ANALOG_PLL_USB2] = 0xfffe0fbc,
+    [CCM_ANALOG_PLL_SYS] = 0xfffa0ffe,
+    [CCM_ANALOG_PLL_SYS_SS] = 0x00000000,
+    [CCM_ANALOG_PLL_SYS_NUM] = 0xc0000000,
+    [CCM_ANALOG_PLL_SYS_DENOM] = 0xc0000000,
+    [CCM_ANALOG_PLL_AUDIO] = 0xffe20f80,
+    [CCM_ANALOG_PLL_AUDIO_NUM] = 0xc0000000,
+    [CCM_ANALOG_PLL_AUDIO_DENOM] = 0xc0000000,
+    [CCM_ANALOG_PLL_VIDEO] = 0xffe20f80,
+    [CCM_ANALOG_PLL_VIDEO_NUM] = 0xc0000000,
+    [CCM_ANALOG_PLL_VIDEO_DENOM] = 0xc0000000,
+    [CCM_ANALOG_PLL_ENET] = 0xffc20ff0,
+    [CCM_ANALOG_PFD_480] = 0x40404040,
+    [CCM_ANALOG_PFD_528] = 0x40404040,
+    [PMU_MISC0] = 0x01fe8306,
+    [PMU_MISC1] = 0x07fcede0,
+    [PMU_MISC2] = 0x005f5f5f,
+};
+
 static const char *imx6ul_ccm_reg_name(uint32_t reg)
 {
     static char unknown[20];
@@ -596,11 +652,8 @@ static void imx6ul_ccm_write(void *opaque, hwaddr offset, uint64_t value,
 
     trace_ccm_write_reg(imx6ul_ccm_reg_name(index), (uint32_t)value);
 
-    /*
-     * We will do a better implementation later. In particular some bits
-     * cannot be written to.
-     */
-    s->ccm[index] = (uint32_t)value;
+    s->ccm[index] = (s->ccm[index] & ccm_mask[index]) |
+                           ((uint32_t)value & ~ccm_mask[index]);
 }
 
 static uint64_t imx6ul_analog_read(void *opaque, hwaddr offset, unsigned size)
@@ -737,7 +790,7 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
          * the REG_NAME register. So we change the value of the
          * REG_NAME register, setting bits passed in the value.
          */
-        s->analog[index - 1] |= value;
+        s->analog[index - 1] |= (value & ~analog_mask[index - 1]);
         break;
     case CCM_ANALOG_PLL_ARM_CLR:
     case CCM_ANALOG_PLL_USB1_CLR:
@@ -762,7 +815,7 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
          * the REG_NAME register. So we change the value of the
          * REG_NAME register, unsetting bits passed in the value.
          */
-        s->analog[index - 2] &= ~value;
+        s->analog[index - 2] &= ~(value & ~analog_mask[index - 2]);
         break;
     case CCM_ANALOG_PLL_ARM_TOG:
     case CCM_ANALOG_PLL_USB1_TOG:
@@ -787,14 +840,11 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
          * the REG_NAME register. So we change the value of the
          * REG_NAME register, toggling bits passed in the value.
          */
-        s->analog[index - 3] ^= value;
+        s->analog[index - 3] ^= (value & ~analog_mask[index - 3]);
         break;
     default:
-        /*
-         * We will do a better implementation later. In particular some bits
-         * cannot be written to.
-         */
-        s->analog[index] = value;
+        s->analog[index] = (s->analog[index] & analog_mask[index]) |
+                           (value & ~analog_mask[index]);
         break;
     }
 }
-- 
2.25.1


