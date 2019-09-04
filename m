Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9588C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEB220449
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVsmspge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEB220449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bea-0007bH-Ke
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0W-0005B6-9n
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0T-0002mV-2q
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:55 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0S-0002lQ-On
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:52 -0400
Received: by mail-pg1-x544.google.com with SMTP id n190so11795990pgn.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O4gGKTm/ojsMEGeGW6yunfSWJTb8afl4fLManLOK4Wg=;
 b=LVsmspgeMt2rLJPKUlsfm/Y52JzVPCRKttgmM7YSTSsgJPmkj7X42e3ck+w0f8t400
 /tdv3onZKJHBOXqLAc7scRdPXNfJu5H57q/wlgE/sCfRMmvhWifcRgZBOSnR7sDDOagL
 kqGH4i5gnl88GzpEhYpXnp3x1XhEatKCt/ihxfutVRTORAZr8pepxJv5qjkbpSChZIvP
 sVy+ZpYPyu/ulXv0uZVzhlUQBVfQtpO1MFDUpi+pXSZ2rIQH3OlvvCuj3+vy6Pc8wnBO
 kqDb83ZP2wVKT7U1TSiJv2rzWJdD3wZZbdBJ1GIvB4FQ9ll9KU36P9xyicNYkRl+SZG9
 +IMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O4gGKTm/ojsMEGeGW6yunfSWJTb8afl4fLManLOK4Wg=;
 b=YecmQSjrlqZa5/oVoODo+YbZ4xIcsel6UTRhzllWMCO+5REAQ3oOZLRv2Ay27YbOKK
 t1CJz/qWcPGYIZ37ZIaS/oMeGfGp8VhDNrVlzd2T2BXII5sFOQYi4TwMUMhtmU8CDzww
 tlWaUd1O7EEIWkePMJOIVnvl0ODoO/hDCVVm7GUnNLAmVky1jb5zk2TvMx/J1Ew4EBCE
 31/6CYua5LJ/UchJpaLKhFnE+XyGZ4RaT+2rpuyUQ7ZEiHsMSAHfpjtoZNVLYf446eH5
 T2X0rKOZgH64ngyr3DLqv0+Kid5jwBnEmspOmQYcqC08tidsU2jwXVelGPS/4qLzhr8s
 luJw==
X-Gm-Message-State: APjAAAU9YV96zOCYWMCmEUJjKzUMVogDke5fpenAhHHwBV954T8Y5rSC
 Mihp1pjnlRzoG87lFswCuDzpH57qlW4=
X-Google-Smtp-Source: APXvYqx/gMrIkuCyVg9WbmiVMN64s/0kRmltz0xAYrDu3J8mqGFF36v0mqhD/ROBlGJT19Kmz1cCbg==
X-Received: by 2002:a17:90a:da04:: with SMTP id
 e4mr6944783pjv.116.1567625511403; 
 Wed, 04 Sep 2019 12:31:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:29 -0700
Message-Id: <20190904193059.26202-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v4 39/69] target/arm: Convert Unallocated
 memory hint
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 8 --------
 target/arm/a32-uncond.decode | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3f02532d12..7023ee78f1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10332,14 +10332,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             return;
         }
-        if (((insn & 0x0f700000) == 0x04100000) ||
-            ((insn & 0x0f700010) == 0x06100000)) {
-            if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
-                goto illegal_op;
-            }
-            return; /* v7MP: Unallocated memory hint: must NOP */
-        }
-
         if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index ddc5edfa5e..60ccfc598d 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -64,3 +64,11 @@ PLI              1111 0100 -101 ---- 1111 ---- ---- ----    # (imm, lit) 7
 PLD              1111 0111 -101 ---- 1111 ----- -- 0 ----   # (register) 5te
 PLDW             1111 0111 -001 ---- 1111 ----- -- 0 ----   # (register) 7mp
 PLI              1111 0110 -101 ---- 1111 ----- -- 0 ----   # (register) 7
+
+# Unallocated memory hints
+#
+# Since these are v7MP nops, and PLDW is v7MP and implemented as nop,
+# (ab)use the PLDW helper.
+
+PLDW             1111 0100 -001 ---- ---- ---- ---- ----
+PLDW             1111 0110 -001 ---- ---- ---- ---0 ----
-- 
2.17.1


