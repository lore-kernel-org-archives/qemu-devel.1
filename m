Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D574C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 23:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55C420729
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 23:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hNs8oD5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55C420729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWTmI-0003u4-VD
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 18:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1iWTkf-0002Qj-S0
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1iWTke-0005Is-8T
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:14:41 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:45041)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1iWTkd-0005Hk-UH
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 18:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574032479; x=1605568479;
 h=from:to:cc:subject:date:message-id;
 bh=CCcz3lwT2Jw/rmh/2nariZEL4qmLojSeowjro3iQfk4=;
 b=hNs8oD5+/ZBSnWjqMlXYt5NaRxyvJp4sXUqjn3RPXa6mUz0D8gC8cHCu
 U3FZYfjC0h79c3xMkgCDXiOrhcZlFY21nKPyoz5AiL8JRGD168EqyCQG6
 PN3jSeU3zuS6B9HrBuTScbJL2jMjhfC57WUbvROGIs321Yc+kCV0XDWXY w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Nov 2019 15:14:36 -0800
IronPort-SDR: 80NMW66ZcbRe4Zb7L36lNoO42XOpShmNNYq4ngk9a3io+5jMV5dZt217jDc7igg/DFzMIzhP/q
 d6qaWk9dg3s3gL3Y6pHja8Th0D519krNCbBqeEZTIXR8dWD60JTB199Dyc9V/6XPZELCan83h6
 b0qp+HdR8RU57SiDKtFlsILrb7zF4w1yJILz0M+sYJCF1HIeRskPxxL0mW79ma88eBnhX8CqQA
 cO1EKaeaVv11rLTN+BRHisBZxCQINEHY6kPm0LPXzAFaz2Vd7W8UtmxzxffOYyPZkBQZ+KPj6o
 ETeW6esz5yCtGfZUoKi4xmDf
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg02-sd.qualcomm.com with ESMTP; 17 Nov 2019 15:14:35 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 96D5E3DD; Sun, 17 Nov 2019 17:14:35 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: alex.bennee@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH] Modify tests to work with clang
Date: Sun, 17 Nov 2019 17:14:25 -0600
Message-Id: <1574032465-12186-1-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: Taylor Simpson <tsimpson@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
---
 tests/tcg/multiarch/float_helpers.c | 2 --
 tests/tcg/multiarch/linux-test.c    | 6 +++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/multiarch/float_helpers.c b/tests/tcg/multiarch/float_helpers.c
index 8ee7903..bc530e5 100644
--- a/tests/tcg/multiarch/float_helpers.c
+++ b/tests/tcg/multiarch/float_helpers.c
@@ -79,11 +79,9 @@ char *fmt_16(uint16_t num)
 
 #ifndef SNANF
 /* Signaling NaN macros, if supported.  */
-# if __GNUC_PREREQ(3, 3)
 #  define SNANF (__builtin_nansf (""))
 #  define SNAN (__builtin_nans (""))
 #  define SNANL (__builtin_nansl (""))
-# endif
 #endif
 
 static float f32_numbers[] = {
diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 673d7c8..8a7c15c 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -485,7 +485,11 @@ static void test_signal(void)
     act.sa_flags = SA_SIGINFO;
     chk_error(sigaction(SIGSEGV, &act, NULL));
     if (setjmp(jmp_env) == 0) {
-        *(uint8_t *)0 = 0;
+        /*
+         * clang requires volatile or it will turn this into a
+         * call to abort() instead of forcing a SIGSEGV.
+         */
+        *(volatile uint8_t *)0 = 0;
     }
 
     act.sa_handler = SIG_DFL;
-- 
2.7.4


