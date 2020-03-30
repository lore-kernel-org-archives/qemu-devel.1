Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25488C2D0E5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E826320771
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2dn1tQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E826320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIuew-0001ya-4J
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub5-0004Rw-9e
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub4-0001DW-8D
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:59 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIub4-0001CZ-1f
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:58 -0400
Received: by mail-wr1-x443.google.com with SMTP id h15so21634619wrx.9
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rpCKxKnHkUDXLH/ndhCEOHbuUN0g52+ytampKGXhXJ8=;
 b=z2dn1tQv8XYK97w5RFrs6g3FJVaZv+/emuEh1L2FrwZj4kJjIU67exGbemYF+q2NEc
 4Uv70IsP5VtiDDvpE1tA2o30GWu9ruriRshNmXfDPDc/J9RgxFbhw5GKuZQ2pxmnmyeX
 EAH1VTy5Qp0mBZCyv0vMcv88Vdb0ofenUVJ1usRjt7eV+Pf5qwSbulCrZByOogqJ+l30
 rKzTsqMCUt8tAyDj4uCah+OfvnR1uS+mmjQg8FCPuEy7TKiucn3rBZrj8MZiC4QJhjEm
 13f+V5S97a3AW+9szQVuS9sjU8r8GO+sHszCN1Ex3Usbh0anE34ipVaZkQ189llBEPRW
 UFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rpCKxKnHkUDXLH/ndhCEOHbuUN0g52+ytampKGXhXJ8=;
 b=k8cc1wJlYWoLl0mHe0biaFNCOVmIRlzWgLVq5NTkEeCYB8Z8Fkj/M9HrWuCHFJwz7H
 EYiaUbE9zjORHVjIqXd68mciackQZuqsBX1lxSdKJ1qRSVFmwJbZl3giPFrcQbODAobt
 PKY/sPnHkgvoVXvgH9V+CEt/Y4yhpSJKxGzkV5ONVVjFpvH4aafReHgcjXzMr7w8jTL8
 asExYCNvzlBO0ncW8cyWiVEFd3/+VRITPCqohKlvjZi/earY5P7iJBlQVWG6saW76+ea
 /eZpM5cLPmNas8CZ8QyC2mhI2JhuvtN2xGBUC4oq7ecL1bFFYOjj51aUrbLRKeTxy2bm
 h7bw==
X-Gm-Message-State: ANhLgQ2gdNH+4MG1BN6uJvifwU3RRLYcjCp6qgF4AQaNY9q+VHBNBa/a
 BrazcuksysyWwO0g4APKahioVoVOu9ZWjA==
X-Google-Smtp-Source: ADFU+vuK295ww31BQw1m+e9H1PyWjfLIQN1npMXZZxW6r/OfltSiyIniL9m3WZf78lwfPu8/rxDCOQ==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr14643626wrv.256.1585575416770; 
 Mon, 30 Mar 2020 06:36:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o14sm20756504wmh.22.2020.03.30.06.36.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:36:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] target/arm: fix incorrect current EL bug in aarch32
 exception emulation
Date: Mon, 30 Mar 2020 14:36:48 +0100
Message-Id: <20200330133648.22297-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330133648.22297-1-peter.maydell@linaro.org>
References: <20200330133648.22297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

From: Changbin Du <changbin.du@gmail.com>

The arm_current_el() should be invoked after mode switching. Otherwise, we
get a wrong current EL value, since current EL is also determined by
current mode.

Fixes: 4a2696c0d4 ("target/arm: Set PAN bit as required on exception entry")
Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200328140232.17278-1-changbin.du@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b7b6887241d..163c91a1ccd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9172,7 +9172,6 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
 
     /* Change the CPU state so as to actually take the exception. */
     switch_mode(env, new_mode);
-    new_el = arm_current_el(env);
 
     /*
      * For exceptions taken to AArch32 we must clear the SS bit in both
@@ -9184,6 +9183,10 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     env->condexec_bits = 0;
     /* Switch to the new mode, and to the correct instruction set.  */
     env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
+
+    /* This must be after mode switching. */
+    new_el = arm_current_el(env);
+
     /* Set new mode endianness */
     env->uncached_cpsr &= ~CPSR_E;
     if (env->cp15.sctlr_el[new_el] & SCTLR_EE) {
-- 
2.20.1


