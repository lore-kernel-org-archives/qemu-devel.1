Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEE4C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9223A20693
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+tqP9I2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9223A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQpx-00040I-Qv
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40371)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hjQhf-0002yf-Jy
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hjQhc-0001ze-K2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:36541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hjQhb-0000Mx-Ch
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id g67so3973719wme.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mM1Kb6A1N3/Dz5Nk0cJ9QkDDg49iumbs9t4kZbIKPkI=;
 b=B+tqP9I2K5+Tn0q1xTHuNqxtvalMjBwgpRBufaF3SfhdXrnTb/pgmhQfNXP9lh8WML
 gzqDf3amfLMEWDOVNb5FvaTjtUIrXZQ3n8dBzn0xeHzjZywuHImPLALClJckQ2+YE+bq
 LBC9f8G4Cj2Uq22ODM/ZuH3ZeT2S2bql1id06uLDZjbS3G8BsGcDZiPjiZjULUJHyxL5
 /HczLHViXPhnCv5gHEfNNhNW0v8H6sn8FjVA48ad0fLtq/MsYh5hsTe53RvKEPmkzPTR
 JVGKPCcWW79QVCNqO4nkkJWZfXkYUHTDJ3RJ7i3wgwSnP5Bpq7eYdHrHleiBkIvbCish
 a8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mM1Kb6A1N3/Dz5Nk0cJ9QkDDg49iumbs9t4kZbIKPkI=;
 b=h9dPruawaiaT9kIvyd5tSRC+5y+fhyjEkMLWvHKy3LFLx44xCLIlxp0uGY62/uzN6Z
 SqUS551QkhAG1oxLiXBfwWRZkd9GBhkHE9F7Hd+u78do1CJBxwt8ON7DO+qz+hlrr4r/
 MS8+hTnMGlX7enNy+4n8VnC2p/FkSpRYY3x8HjrY0kU9HhE+DkqOhKPPN82PYbaUbxTZ
 MoVnxyFCloJOSTVxfbEAq8mVA4RKuibcRZIFWdM6L9BlZRIkFQXlJb4Ls5A382gLcda0
 GqA5MXY025MCGhPmasf7Ot/mp9b6i5Q9MqZj6kvVWrUQF2s9iyMpEjdobThFUTQnD1PV
 SC+Q==
X-Gm-Message-State: APjAAAUpQv3Q/ciWL7CQrTEC2Mb4VHNWcz9FDNCqUS83fwHyeB70sg7E
 YCrT7xWtahyJPi2uziGYNmqSww==
X-Google-Smtp-Source: APXvYqx524yNaBBH5LNxbXNG8rKJ8ddDXHkfXVGbTXyapq5k1Y1aZ2LJ7ugdobxufcA070obXpbbQA==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr407119wmi.16.1562342662844;
 Fri, 05 Jul 2019 09:04:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d9sm13335593wrb.71.2019.07.05.09.04.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 09:04:22 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8C7421FF8C;
 Fri,  5 Jul 2019 17:04:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 17:04:17 +0100
Message-Id: <20190705160421.19015-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705160421.19015-1-alex.bennee@linaro.org>
References: <20190705160421.19015-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PATCH v1 1/5] target/arm/vfp_helper: Call
 set_fpscr_to_host before updating FPSCR reg
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In commit e9d652824b0 we extracted the vfp_set_fpscr_to_host()
function but failed at calling it in the correct place, we call
it after xregs[ARM_VFP_FPSCR] is modified.

Fix by calling this function before we update FPSCR.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-Id: <20190705124318.1075-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/vfp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 46041e3294..9710ef1c3e 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -197,6 +197,8 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         val &= 0xf7c0009f;
     }
 
+    vfp_set_fpscr_to_host(env, val);
+
     /*
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
@@ -217,8 +219,6 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
     env->vfp.qc[1] = 0;
     env->vfp.qc[2] = 0;
     env->vfp.qc[3] = 0;
-
-    vfp_set_fpscr_to_host(env, val);
 }
 
 void vfp_set_fpscr(CPUARMState *env, uint32_t val)
-- 
2.20.1


