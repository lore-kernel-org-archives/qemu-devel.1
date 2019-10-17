Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BCDECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB65020854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xS0FBr6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB65020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6WF-0008HA-Un
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mX-0002Kb-0o
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mR-0001Gl-Tr
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mR-0001GK-Nn
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id n14so2340110wrw.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bu4rKDpgnn8IvteRUio5V7sQbtET4I/Wc2TO4RaQ0LI=;
 b=xS0FBr6WVWAXfKPrZTybwn6uwFc1uQOgEnOCcU5ItblD3IOLAPKxgR6W/0qDov2+ri
 E+KJlCX273ZyMeVG47PpLFIJpJfK6lNodhuNIGUMHKyQQZ34JJBqHyUFOmR+DQa/AI9/
 syWkjPqRL45V4/JrxE1sXYje0JPF4yOT9HOpp758En8JTVV0Ts7+5MwCAO45cDLBsG3s
 MDt3vnij7mhQHRif8ZgRH8ktWO5qYjbrEvkRINKqJepgGPZZ2QOOgjoixPOKcJRoKhfD
 Z1qWHO/8i1qzJV6ABatwGDN8jc07gHwLeUURT+lKCyzojt8Zi/rMEnKW5KpsHsTd1zry
 JCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bu4rKDpgnn8IvteRUio5V7sQbtET4I/Wc2TO4RaQ0LI=;
 b=jPqCMUkRy1ZVxYlBATGY/c2ibblNwrNpR68owvP+1ZLVSs4FdrBZMSyD6Zp4YAo0YQ
 2I7XSQ23uRC3fDG1qXPGdbJZVU129d40cQsfwl4muHWOgJr2FB8YrY/tcb3mzDaJKPfp
 2gPjwu46ifZGGdHtt6DeiFrjkPeUKu742h4CWnbZllhV2o9UzfHjofDZ0uzPE1lUP8Wu
 o1Mk9kAS1wqNDdfXFoYAWC5Q5xGAXo4ZV8wfeigvPpBsgCnymzIkPzww00kHd8ZYPJMe
 jzEZi3ZIhbGWWgaWRYk7PrUE0+4i+2WfV7/jLUSnI3/yC558uEk8y6vNZ1RP8hWFODZc
 S8zQ==
X-Gm-Message-State: APjAAAW8g6WwAosY9rG7zNs5rAnTJFdjSh6u14LSIWYTyrIcBnQBLR4d
 OGQ+ebLhbeGVkA+Vc08Xb9l5/w==
X-Google-Smtp-Source: APXvYqw0s3QwZeOFr8osfdzdaFX5ISZlhcnJB6UxOwbYzSkVJzk1ubKkkOHmE7lWa99/ul51RcSKXA==
X-Received: by 2002:adf:a48c:: with SMTP id g12mr2887150wrb.212.1571318726654; 
 Thu, 17 Oct 2019 06:25:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y19sm2096038wmi.13.2019.10.17.06.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5E1D31FFAF;
 Thu, 17 Oct 2019 14:16:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 26/54] target/i386: fetch code with translator_ld
Date: Thu, 17 Oct 2019 14:15:47 +0100
Message-Id: <20191017131615.19660-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/i386/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 868b0acafe..77e932d827 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -1925,28 +1925,28 @@ static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
 
 static inline uint8_t x86_ldub_code(CPUX86State *env, DisasContext *s)
 {
-    return cpu_ldub_code(env, advance_pc(env, s, 1));
+    return translator_ldub(env, advance_pc(env, s, 1));
 }
 
 static inline int16_t x86_ldsw_code(CPUX86State *env, DisasContext *s)
 {
-    return cpu_ldsw_code(env, advance_pc(env, s, 2));
+    return translator_ldsw(env, advance_pc(env, s, 2));
 }
 
 static inline uint16_t x86_lduw_code(CPUX86State *env, DisasContext *s)
 {
-    return cpu_lduw_code(env, advance_pc(env, s, 2));
+    return translator_lduw(env, advance_pc(env, s, 2));
 }
 
 static inline uint32_t x86_ldl_code(CPUX86State *env, DisasContext *s)
 {
-    return cpu_ldl_code(env, advance_pc(env, s, 4));
+    return translator_ldl(env, advance_pc(env, s, 4));
 }
 
 #ifdef TARGET_X86_64
 static inline uint64_t x86_ldq_code(CPUX86State *env, DisasContext *s)
 {
-    return cpu_ldq_code(env, advance_pc(env, s, 8));
+    return translator_ldq(env, advance_pc(env, s, 8));
 }
 #endif
 
-- 
2.20.1


