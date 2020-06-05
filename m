Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5134C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA18F2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA18F2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhHgZ-0007Vu-0b
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 15:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHcU-0002yg-EF
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:03:14 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:34118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHcT-0007JN-Hp
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:03:10 -0400
IronPort-SDR: OG6madOroSKM5PvwCaOwRNpHrvYOKnsLs4/jgPOBMgYVa7UUnlcOJKbYwFRBeIS2RM0+ulRTwj
 Y+ORKGXmgnFcQYMBhQR3hRgi/FrZvz2MC0ZkkbSXHqC4SJYjOP7omAoXxr6cEwYURyZeVa/6sx
 4HdJQj+VN1zup06HRQ/rkJzfSdTVrx1wL6GetuGiYhfpJ0DEYnegnSw5zhg6FH49Hz02LkIq1u
 u6Q3UUvhm6gtNNnDPKuARx59UJf+MDKbqZYWqw9TzKSY3OTV91Q/OyQx/LC2wrE80FGN+93wNd
 SkY=
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; d="scan'208";a="49633118"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 05 Jun 2020 11:02:47 -0800
IronPort-SDR: Dw0EzBKvMvk+mvfMqTcnCAOJIL/V/CQDQs3FoAcsEKE33C1FgWja2FdOwwmDr+YdPWa7rEUsXI
 EMnebsgTS9eAZeEMaFrq5i+1yGJo8yM3Z7R+6nGwexL+Xijd9ZixsS8+UMiBkYXoS0Pmkkkudv
 S0OGLHW9cOLKBc+2rs3wHE0TDk22MN68FX6s+CcW359WSgRHqq/7ar9+i1292KJ5PR7AUuVB8k
 5A/n1M+SyVqo2dCEm/d6NwkgWOoZc/CizGZ/zoPDrJIyh6izwH+HQXwtTlQxy0jyWsyKaQv8xR
 cbg=
Date: Fri, 5 Jun 2020 19:02:41 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <laurent@vivier.eu>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH 7/7] target/i386: reimplement fprem using floatx80 operations
In-Reply-To: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006051902140.13777@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 14:59:46
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The x87 fprem emulation is currently based around conversion to
double, which is inherently unsuitable for a good emulation of any
floatx80 operation.  Reimplement using the soft-float floatx80
remainder operations.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c | 58 +---------------------------------------
 1 file changed, 1 insertion(+), 57 deletions(-)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index bab35e00a0..d2fc2c1dde 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -989,63 +989,7 @@ void helper_fprem1(CPUX86State *env)
 
 void helper_fprem(CPUX86State *env)
 {
-    double st0, st1, dblq, fpsrcop, fptemp;
-    CPU_LDoubleU fpsrcop1, fptemp1;
-    int expdif;
-    signed long long int q;
-
-    st0 = floatx80_to_double(env, ST0);
-    st1 = floatx80_to_double(env, ST1);
-
-    if (isinf(st0) || isnan(st0) || isnan(st1) || (st1 == 0.0)) {
-        ST0 = double_to_floatx80(env, 0.0 / 0.0); /* NaN */
-        env->fpus &= ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
-        return;
-    }
-
-    fpsrcop = st0;
-    fptemp = st1;
-    fpsrcop1.d = ST0;
-    fptemp1.d = ST1;
-    expdif = EXPD(fpsrcop1) - EXPD(fptemp1);
-
-    if (expdif < 0) {
-        /* optimisation? taken from the AMD docs */
-        env->fpus &= ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
-        /* ST0 is unchanged */
-        return;
-    }
-
-    if (expdif < 53) {
-        dblq = fpsrcop / fptemp; /* ST0 / ST1 */
-        /* round dblq towards zero */
-        dblq = (dblq < 0.0) ? ceil(dblq) : floor(dblq);
-        st0 = fpsrcop - fptemp * dblq; /* fpsrcop is ST0 */
-
-        /* convert dblq to q by truncating towards zero */
-        if (dblq < 0.0) {
-            q = (signed long long int)(-dblq);
-        } else {
-            q = (signed long long int)dblq;
-        }
-
-        env->fpus &= ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
-        /* (C0,C3,C1) <-- (q2,q1,q0) */
-        env->fpus |= (q & 0x4) << (8 - 2);  /* (C0) <-- q2 */
-        env->fpus |= (q & 0x2) << (14 - 1); /* (C3) <-- q1 */
-        env->fpus |= (q & 0x1) << (9 - 0);  /* (C1) <-- q0 */
-    } else {
-        int N = 32 + (expdif % 32); /* as per AMD docs */
-
-        env->fpus |= 0x400;  /* C2 <-- 1 */
-        fptemp = pow(2.0, (double)(expdif - N));
-        fpsrcop = (st0 / st1) / fptemp;
-        /* fpsrcop = integer obtained by chopping */
-        fpsrcop = (fpsrcop < 0.0) ?
-                  -(floor(fabs(fpsrcop))) : floor(fpsrcop);
-        st0 -= (st1 * fpsrcop * fptemp);
-    }
-    ST0 = double_to_floatx80(env, st0);
+    helper_fprem_common(env, true);
 }
 
 void helper_fyl2xp1(CPUX86State *env)
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

