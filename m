Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58623C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9B820736
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9B820736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWUfL-0001Rk-7r
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 20:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUeG-0000eM-1c
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:44:24 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:44374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUeE-00065U-VJ
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:44:23 -0400
IronPort-SDR: +mKhWHNq9RFbJyYDicD0xNHK8O+DTOrGMdcG8mXh5ys7cARXSkp3sWr3tCkcw9epRevLZQ8pnj
 2hHBmFH7wB6Xeh36eJHZGic+3IbeseC553k3VkX/WTRnNoSZyiOzDC4gh0bLLcPoapoJCTAWH2
 mzfmvUR5e1TBE3E1rxyQVMfrPv2nSGyUMLvHfdxpLgyLG2Uv0Q7Rg32MTxkMnNSGyJ6wiTqUko
 srABvelF+ii6KvxcChNYetW8renudZbCBi3wG6tGOLyWjYe9eyYTNYwALXJC5OxNQXMYJ4NM4V
 m/s=
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; d="scan'208";a="48663331"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 06 May 2020 16:44:20 -0800
IronPort-SDR: lknkSjlD/BveaarnrUP4Uc3ICE5+0fdhlZNN4ox0vishQtQb0A7HSxOuOhuFhKz8XZ/SkC1C0f
 qyOezBlSN+uwfCYuYFw+/Gp/98P6B6+Ia2ExNlbEEHVEf6l/Cv1G+zZbfAkdUUzcSb2bnljp2B
 jtnUjvy8F9L+qbWy4tVHSRnt8uaO0T6j2eNnRiMzrFLT8bFaaH0MWsYKO7RwFw+6/SGFrllgNt
 Aj64hyaFos1nSyV4R3Klr0h8jSe0DIexWNKeEoWZpLr70G0qorC975yFgw8eqbuqnoHsut8sWg
 6bY=
Date: Thu, 7 May 2020 00:44:14 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 2/5] target/i386: fix fscale handling of signaling NaN
In-Reply-To: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005070043330.18350@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 20:44:20
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The implementation of the fscale instruction returns a NaN exponent
unchanged.  Fix it to return a quiet NaN when the provided exponent is
a signaling NaN.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c          |  4 ++++
 tests/tcg/i386/test-i386-fscale.c | 37 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 tests/tcg/i386/test-i386-fscale.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 71a696a863..60012c405c 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -970,6 +970,10 @@ void helper_fscale(CPUX86State *env)
 {
     if (floatx80_is_any_nan(ST1)) {
         ST0 = ST1;
+        if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+            float_raise(float_flag_invalid, &env->fp_status);
+            ST0 = floatx80_silence_nan(ST0, &env->fp_status);
+        }
     } else {
         int n = floatx80_to_int32_round_to_zero(ST1, &env->fp_status);
         ST0 = floatx80_scalbn(ST0, n, &env->fp_status);
diff --git a/tests/tcg/i386/test-i386-fscale.c b/tests/tcg/i386/test-i386-fscale.c
new file mode 100644
index 0000000000..aecac5125f
--- /dev/null
+++ b/tests/tcg/i386/test-i386-fscale.c
@@ -0,0 +1,37 @@
+/* Test fscale instruction.  */
+
+#include <stdint.h>
+#include <stdio.h>
+
+union u {
+    struct { uint64_t sig; uint16_t sign_exp; } s;
+    long double ld;
+};
+
+volatile long double ld_res;
+
+int isnan_ld(long double x)
+{
+  union u tmp = { .ld = x };
+  return ((tmp.s.sign_exp & 0x7fff) == 0x7fff &&
+          (tmp.s.sig >> 63) != 0 &&
+          (tmp.s.sig << 1) != 0);
+}
+
+int issignaling_ld(long double x)
+{
+    union u tmp = { .ld = x };
+    return isnan_ld(x) && (tmp.s.sig & UINT64_C(0x4000000000000000)) == 0;
+}
+
+int main(void)
+{
+    int ret = 0;
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (2.5L), "u" (__builtin_nansl("")));
+    if (!isnan_ld(ld_res) || issignaling_ld(ld_res)) {
+        printf("FAIL: fscale snan\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

