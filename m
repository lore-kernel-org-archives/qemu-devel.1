Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F93C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C207820730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ML24+9fN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C207820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isB76-0001Mb-3z
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 14:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isB3W-000512-JX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isB3V-0007NA-47
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:43:50 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isB3U-0007MZ-V2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:43:49 -0500
Received: by mail-pj1-x1044.google.com with SMTP id d15so2036567pjw.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 11:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dVQPchFReqgJ20ne23FViP6RomyZ4oPHwhQNUV4fK+E=;
 b=ML24+9fN/mPfbJl4KFpjnO4mg2OiA/FfkJksOrTBE2dNmyi92coy9UOVwd3u9wcrZV
 wVjiPVCMTXtfYWhmfs2DNg5DqE8F9rZRayB0FrRFmdRMdxsaqVIiwt0jpAotjSOjoHlx
 vzKt3bC7L41RVkZF5UtR7rDy1zxE9IKySrsLwCZiXJD0mS4x4LyFWsHDXBrACXNUwpRu
 KCjAfPvht2+PQs8ZWtYkGObJF9w+w2Yjd56u3vLm4XyCtfqMo1SAGKAlLeqFIdeNc2Zh
 6ZVRMuK9htpMJmeKl9qt+mJCaIoQD4Oj9D7lhS7yQ01/VUPXbx2G4VIbAW2BS3ThoFxY
 kezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dVQPchFReqgJ20ne23FViP6RomyZ4oPHwhQNUV4fK+E=;
 b=nyJdmPdNnXSp9jstQRcDgLs+Jhe18NP8WZpxSTOVe5GBHRstce3T2xPjYLmYPQp/Oi
 J0wANb1DJ8uq6qQup4PbjKFu9aPPPWWboZ9YTupp65t/KShwUnykRSETwxO6SmijLfID
 BemvL8F99RJ5c8iUtioEKVSUxgOZ56rCS1Yk4wZqWyajT1zWLQUFN3Kpz9/SONVP023r
 95VvIfrys99eKjHD5XfBmuQITygbxqgJ59PqWAoM/Y6C0NnnEl+KxVrC2jSKkTX19MDw
 WB7D9TZyXML9ghwIHmMt+j8/KliEyKdUJCob2TUWmAZ1GqfTFNv2l7I4qPUlMTC8/Hre
 bV8g==
X-Gm-Message-State: APjAAAXNQjsOyumhTb1FKeU+hIST6FHO9XU7ZyWNgjY768HH6bu0OdNT
 wkAecH4QRHUbaQOwfqU9J6qThrPkEVA=
X-Google-Smtp-Source: APXvYqziYvnUGXcIGB5Hg5fLJjqx7KhOsgXGDzYJjQ3xf4dO9xZi+ufZfcQcg4FeYG3k6DWcEPp8JA==
X-Received: by 2002:a17:90a:d205:: with SMTP id
 o5mr1015731pju.46.1579203827602; 
 Thu, 16 Jan 2020 11:43:47 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id g2sm26411831pgn.59.2020.01.16.11.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 11:43:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] target/i386: Renumber EXCP_SYSCALL
Date: Thu, 16 Jan 2020 09:43:37 -1000
Message-Id: <20200116194341.402-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116194341.402-1-richard.henderson@linaro.org>
References: <20200116194341.402-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are not short of numbers for EXCP_*.  There is no need to confuse things
by having EXCP_VMEXIT and EXCP_SYSCALL overlap, even though the former is
only used for system mode and the latter is only used for user mode.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 594326a794..164d038d1f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -998,9 +998,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define EXCP11_ALGN	17
 #define EXCP12_MCHK	18
 
-#define EXCP_SYSCALL    0x100 /* only happens in user only emulation
-                                 for syscall instruction */
-#define EXCP_VMEXIT     0x100
+#define EXCP_VMEXIT     0x100 /* only for system emulation */
+#define EXCP_SYSCALL    0x101 /* only for user emulation */
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
-- 
2.20.1


