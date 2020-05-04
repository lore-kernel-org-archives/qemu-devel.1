Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC8C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28C1206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28C1206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkiR-0006R7-TE
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jVkfv-0003lm-IC
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:39:03 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:20501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jVkfn-000324-BC
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:39:03 -0400
IronPort-SDR: sU5Xav6K+YF3Ftch3aBOSo6n8UJFKcJ0uadN9LiwqlfG4Tnw5KDYTW+qwbvHFTSLPULjEYCHn+
 9bYvhvBkkBbMPTp3EreGopwhuiMT9qqyvns2mHDnWd3a2zEWzw2W6RHNIEH/QH0/IF6QztTEPW
 SNFhwC3cLCw0MHRnZg/HPysj7q7m4s2+tJ+FdqViMlPDEJSsJiDpIrPztAibITu4STQU3xhdnd
 bciXTrRNF/FAjEy2UYG9bBighCGitSf7w760wRevbhqUq8NxFuGaByGdVHc1l9MS0tayVc2p9o
 8v4=
X-IronPort-AV: E=Sophos;i="5.73,353,1583222400"; d="scan'208";a="50530968"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 04 May 2020 15:38:50 -0800
IronPort-SDR: r736D0AQBFRcBlWteS2D8ILqvW3m1g6/1TovYKeOEz914osYYhnptdI3hyS+qGpVbqxEeCLVyX
 dL3r/9CcHFhjqip9ZGikRritSx4vxDEvBqY0KKe2a8hH9b5TYR74/B+E8nxUGzii+vKuP81tWm
 HV/2MOXU46d6UVCv7qsQgAhjrbU4yKeot3d+SiaQONW7svcrgPtlBHSwMpiza7CBE1uPEOl+Hp
 BOdz3OFL/ewp5ZP01g+/IujqO1zqiIRBbhNFRpNxdbpRtE7ykBXx1Epud4nOzlmYAqwe+fs/CN
 94k=
Date: Mon, 4 May 2020 23:38:44 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <pbonzini@redhat.com>,
 <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH v2 2/4] softfloat: fix floatx80 pseudo-denormal addition /
 subtraction
In-Reply-To: <alpine.DEB.2.21.2005042332380.22972@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005042337570.22972@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005042332380.22972@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:38:51
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The softfloat function addFloatx80Sigs, used for addition of values
with the same sign and subtraction of values with opposite sign, fails
to handle the case where the two values both have biased exponent zero
and there is a carry resulting from adding the significands, which can
occur if one or both values are pseudo-denormals (biased exponent
zero, explicit integer bit 1).  Add a check for that case, so making
the results match those seen on x86 hardware for pseudo-denormals.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 fpu/softfloat.c                            |  6 ++++++
 tests/tcg/i386/test-i386-pseudo-denormal.c | 24 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tests/tcg/i386/test-i386-pseudo-denormal.c

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index ac116c70b8..6094d267b5 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5866,6 +5866,12 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
         zSig1 = 0;
         zSig0 = aSig + bSig;
         if ( aExp == 0 ) {
+            if ((aSig | bSig) & UINT64_C(0x8000000000000000) && zSig0 < aSig) {
+                /* At least one of the values is a pseudo-denormal,
+                 * and there is a carry out of the result.  */
+                zExp = 1;
+                goto shiftRight1;
+            }
             if (zSig0 == 0) {
                 return packFloatx80(zSign, 0, 0);
             }
diff --git a/tests/tcg/i386/test-i386-pseudo-denormal.c b/tests/tcg/i386/test-i386-pseudo-denormal.c
new file mode 100644
index 0000000000..cfa2a500b0
--- /dev/null
+++ b/tests/tcg/i386/test-i386-pseudo-denormal.c
@@ -0,0 +1,24 @@
+/* Test pseudo-denormal operations.  */
+
+#include <stdint.h>
+#include <stdio.h>
+
+union u {
+    struct { uint64_t sig; uint16_t sign_exp; } s;
+    long double ld;
+};
+
+volatile union u ld_pseudo_m16382 = { .s = { UINT64_C(1) << 63, 0 } };
+
+volatile long double ld_res;
+
+int main(void)
+{
+    int ret = 0;
+    ld_res = ld_pseudo_m16382.ld + ld_pseudo_m16382.ld;
+    if (ld_res != 0x1p-16381L) {
+        printf("FAIL: pseudo-denormal add\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

