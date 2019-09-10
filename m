Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E281BC49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE88721479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpfoOZur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE88721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hZc-0001Uc-3D
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNv-0005e6-Nf
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNu-00057E-Je
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7hNu-00056k-EE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id u16so20875157wrr.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YNt4rzxDLZvJ3mLelApZg/g3aGU83zBv6U6suQNcbas=;
 b=FpfoOZur9SeiO5+ovdwDYbHq6hgY6rbpK/dv9x8sQf3BJy2GaAu7MQuZ1a2E3E0XDT
 YVs0B5uMpkF9uag6dPn7MlYSKCo0zmuLggIJJVhvKllv10u96rc05E5vWgsdlLN4VaHZ
 sI15QxR7jvaDBR6COKIkQSCcPXZ6QSB2ssG4UvWxNzTLBT5x7GQ+mnRZLv2s0V5YQ3xI
 hpEvXUl3qo4W5YzjIBteUUC1YjXlUtpNrzrg3lzLyc6htpvPMs4D1YfpiL4sFYc9H4Hz
 +LUox7B3Sdu084rI+Z7jZqdkeE97Uj6xVJaObKt0+NwX34vUCz+rgQb5NlRVDXbyN38b
 W2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YNt4rzxDLZvJ3mLelApZg/g3aGU83zBv6U6suQNcbas=;
 b=D6bEWIWeM1BtUe1giOFQTMZ00geRL16d/GW7jCeA/OdzNtI2E7OS8mRnWYM59RA2wi
 5LpyjfxLd6nfLAeR7Dzfq0+NAXei69DSAwPNjGdJBSiVOgDCbIZsXgzGandkge5iUPCk
 DKadir44vyYqkD4KWX45MY39L8hthH8PFr4romXW3SSphoB7ZqUjogqwpVHu96xbULXZ
 9zPjPv1IHHQK1zBdSY829iAe64be0Q4QBiBnfHvfpPqJz6SKnQrNJM3eviA1cdJYFpwO
 dGWo7UBy8AQ/F8WrvZbsr+E6Ge7LPSciCPKtpH020ZkP8AWBs0uycElPxqc67RjtHCMO
 M/bg==
X-Gm-Message-State: APjAAAUbuAd4RwGYZVdRquUqvqLg0g4AZin9esjP2yYc62P2PAD5D9pJ
 Ek0PvBPLMVa6gFr4Mr5Uibzw8Q==
X-Google-Smtp-Source: APXvYqwx169BXXSViKCvBrdjzswbjoKZruNrZlvFksLoy7E9pkzfI/C8dUbG9BwTNzoNOA/Qd5jcmg==
X-Received: by 2002:a05:6000:1189:: with SMTP id
 g9mr28272944wrx.117.1568126685607; 
 Tue, 10 Sep 2019 07:44:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a192sm5703814wma.1.2019.09.10.07.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:44:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 15:44:28 +0100
Message-Id: <20190910144428.32597-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910144428.32597-1-peter.maydell@linaro.org>
References: <20190910144428.32597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 13/13] target/arm/arm-semi: Implement
 SH_EXT_EXIT_EXTENDED extension
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

SH_EXT_EXIT_EXTENDED is a v2.0 semihosting extension: it
indicates that the implementation supports the SYS_EXIT_EXTENDED
function. This function allows both A64 and A32/T32 guests to
exit with a specified exit status, unlike the older SYS_EXIT
function which only allowed this for A64 guests. Implement
this extension.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 0df8d4d69d6..3900bd4e1e6 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -66,6 +66,7 @@ typedef void TaskState;
 #define TARGET_SYS_HEAPINFO    0x16
 #define TARGET_SYS_EXIT        0x18
 #define TARGET_SYS_SYNCCACHE   0x19
+#define TARGET_SYS_EXIT_EXTENDED 0x20
 
 /* ADP_Stopped_ApplicationExit is used for exit(0),
  * anything else is implemented as exit(1) */
@@ -485,7 +486,7 @@ static const uint8_t featurefile_data[] = {
     SHFB_MAGIC_1,
     SHFB_MAGIC_2,
     SHFB_MAGIC_3,
-    SH_EXT_STDOUT_STDERR, /* Feature byte 0 */
+    SH_EXT_EXIT_EXTENDED | SH_EXT_STDOUT_STDERR, /* Feature byte 0 */
 };
 
 static void init_featurefile_guestfd(int guestfd)
@@ -1026,11 +1027,14 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return 0;
         }
     case TARGET_SYS_EXIT:
-        if (is_a64(env)) {
+    case TARGET_SYS_EXIT_EXTENDED:
+        if (nr == TARGET_SYS_EXIT_EXTENDED || is_a64(env)) {
             /*
-             * The A64 version of this call takes a parameter block,
+             * The A64 version of SYS_EXIT takes a parameter block,
              * so the application-exit type can return a subcode which
              * is the exit status code from the application.
+             * SYS_EXIT_EXTENDED is an a new-in-v2.0 optional function
+             * which allows A32/T32 guests to also provide a status code.
              */
             GET_ARG(0);
             GET_ARG(1);
@@ -1042,8 +1046,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             }
         } else {
             /*
-             * ARM specifies only Stopped_ApplicationExit as normal
-             * exit, everything else is considered an error
+             * The A32/T32 version of SYS_EXIT specifies only
+             * Stopped_ApplicationExit as normal exit, but does not
+             * allow the guest to specify the exit status code.
+             * Everything else is considered an error.
              */
             ret = (args == ADP_Stopped_ApplicationExit) ? 0 : 1;
         }
-- 
2.20.1


