Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62263C2BA80
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1FC2072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sr4j9s1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1FC2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqYQ-0000Eu-B5
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVe-0003TC-7A
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVd-0004LX-4b
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLqVc-0004Kw-Uw
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id a25so4514848wrd.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=knuvWGJJjL2l+VM/Pu56sYdaHUVTSyIKJQEQhEZXCg8=;
 b=sr4j9s1YKOZfp2w+RIR3IaPWFx9+8+LQBxRZ4/zmJR/U78j8z/xVZYAgcrc1reyWZ7
 v1MHYYmNnJoPzIjwV5PQjh0dvFj+uL0XOxoeY8h/3aYyzVmKpMZJvn4UbRLiEkTPlOws
 LitRB9IrJpeM2a8yHRhlreW0lWvrBWSLbsI//ZF5qL2Md6a/SqGJW4pkM1W1ch386eB+
 P7XwxF4cy4jwZEmCe4RAJDrr+GV8VKRjsXkxAALsbQ7bbvMjOt/XfhsylbEdCHsbbGgY
 pLCmFPDaeRBNIlIwTzpbCw+7OXKSlkEKZBwjqPdAeHn2t06DQD2jwjjUuvrrsGahhDAF
 kCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=knuvWGJJjL2l+VM/Pu56sYdaHUVTSyIKJQEQhEZXCg8=;
 b=JardRk4uvRaV8Nxic45LDUpwMZsw3BlDP66QWkfT3VBKc7XRIzagi0kEy+s/GvZsnZ
 9vexZqw7fRr5G/qK/RzNqBvgOjm9uDWunrD1Ys1gvYd8PYuVv5ep2TAW2jdk4rmYBhVO
 vXbYKZMTAFG7U5w5snjKxzx4ZTEIFHdN6OeqwKXSexmgwOutY2/5Qy0JCMZY1yINs5Oz
 gA2O6wXHlSWR3i7+ONYNQTeNgVppDWDH4mf14Fln877L4Mx4flt/xTus4p5uu6BSLnt8
 p4vfCp8LSgV3c3p7fXctVNhJBWk2NX2FoEJQOhr/7TpW0sPsVoymJAoNCIYUcnXIkKVx
 tYiQ==
X-Gm-Message-State: AGi0PuZ0xoDpdznT47ZEuShaVEAHZApDik46OAMDD07oGz9B6QQVwn7K
 BZKw5sxQKf+m2SgLN2LSijZsXA==
X-Google-Smtp-Source: APiQypJ0dbYs8SRX5m98jhtJDdUHK/lSjLgYoREG6PYnmwu675h5dohOA+/se7BhebKWJF8Dnbhj2A==
X-Received: by 2002:adf:c3d0:: with SMTP id d16mr3664143wrg.180.1586274688050; 
 Tue, 07 Apr 2020 08:51:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m19sm2755823wml.21.2020.04.07.08.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 08:51:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B392E1FF91;
 Tue,  7 Apr 2020 16:51:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 05/13] linux-user: more debug for init_guest_space
Date: Tue,  7 Apr 2020 16:51:10 +0100
Message-Id: <20200407155118.20139-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407155118.20139-1-alex.bennee@linaro.org>
References: <20200407155118.20139-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Searching for memory space can cause problems so lets extend the
CPU_LOG_PAGE output so you can watch init_guest_space fail to
allocate memory. A more involved fix is actually required to make this
function play nicely with the large guard pages the sanitiser likes to
use.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200403191150.863-5-alex.bennee@linaro.org>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8198be04460..619c054cc48 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2172,6 +2172,8 @@ unsigned long init_guest_space(unsigned long host_start,
 
         /* Check to see if the address is valid.  */
         if (host_start && real_start != current_start) {
+            qemu_log_mask(CPU_LOG_PAGE, "invalid %lx && %lx != %lx\n",
+                          host_start, real_start, current_start);
             goto try_again;
         }
 
@@ -2240,7 +2242,11 @@ unsigned long init_guest_space(unsigned long host_start,
          * probably a bad strategy if not, which means we got here
          * because of trouble with ARM commpage setup.
          */
-        munmap((void *)real_start, real_size);
+        if (munmap((void *)real_start, real_size) != 0) {
+            error_report("%s: failed to unmap %lx:%lx (%s)", __func__,
+                         real_start, real_size, strerror(errno));
+            abort();
+        }
         current_start += align;
         if (host_start == current_start) {
             /* Theoretically possible if host doesn't have any suitably
-- 
2.20.1


