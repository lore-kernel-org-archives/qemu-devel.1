Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A04C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F408206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hBSoX99L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F408206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVTO5-0005FD-9F
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 23:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1iVTNB-0004nS-OL
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1iVTN9-00073z-QW
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:38:16 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:8795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1iVTN9-00073L-IM
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1573792695; x=1605328695;
 h=from:to:cc:subject:date:message-id;
 bh=9+Jkk3VY3LZNC5jVKH37stQqdbHBJpkUG3gV+wIiEd4=;
 b=hBSoX99LfHHDoPSU6G/90xZSn3WBLvt19ziGhzXsL8qxCqH/PssvAVWo
 EG2h678oidZYonUcudyQiv54+keK5y5N6oQoPqx4UwcnaUzgV9pbtHS0c
 SiK9LwqTw1QFMNkI1cN8qkQnLiXjQrgICHIeiwEcaXjNW1t3s5BSaPWIV A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Nov 2019 20:38:13 -0800
IronPort-SDR: 2aRTAEhFhZNcDFKj20cyQVWk2LtRbHDCDzJVjEqdd7GC5cumXZ/3Yndex8dbRdnSv+MkZLq+96
 VqiR6cKXQYC6ofVf/DuYHbX5eyXBlhDXw=
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 14 Nov 2019 20:38:13 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id E8911ABD; Thu, 14 Nov 2019 22:38:12 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: alex.bennee@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH] Modify tests to work with clang
Date: Thu, 14 Nov 2019 22:38:11 -0600
Message-Id: <1573792691-398-1-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
 tests/tcg/multiarch/float_helpers.c | 13 ++++++++++++-
 tests/tcg/multiarch/linux-test.c    |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/float_helpers.c b/tests/tcg/multiarch/float_helpers.c
index 8ee7903..437247c 100644
--- a/tests/tcg/multiarch/float_helpers.c
+++ b/tests/tcg/multiarch/float_helpers.c
@@ -26,6 +26,17 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
+/*----------------------------------------------------------------------------
+| The macro QEMU_GNUC_PREREQ tests for minimum version of the GNU C compiler.
+| The code is a copy of SOFTFLOAT_GNUC_PREREQ, see softfloat-macros.h.
+*----------------------------------------------------------------------------*/
+#if defined(__GNUC__) && defined(__GNUC_MINOR__)
+# define QEMU_GNUC_PREREQ(maj, min) \
+         ((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
+#else
+# define QEMU_GNUC_PREREQ(maj, min) 0
+#endif
+
 /*
  * Half Precision Numbers
  *
@@ -79,7 +90,7 @@ char *fmt_16(uint16_t num)
 
 #ifndef SNANF
 /* Signaling NaN macros, if supported.  */
-# if __GNUC_PREREQ(3, 3)
+# if defined(__clang__) || QEMU_GNUC_PREREQ(3, 3)
 #  define SNANF (__builtin_nansf (""))
 #  define SNAN (__builtin_nans (""))
 #  define SNANL (__builtin_nansl (""))
diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 673d7c8..edfc02c 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -485,7 +485,7 @@ static void test_signal(void)
     act.sa_flags = SA_SIGINFO;
     chk_error(sigaction(SIGSEGV, &act, NULL));
     if (setjmp(jmp_env) == 0) {
-        *(uint8_t *)0 = 0;
+        *(volatile uint8_t *)0 = 0;
     }
 
     act.sa_handler = SIG_DFL;
-- 
2.7.4


