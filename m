Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07062CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C713620867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/8ICshc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C713620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuE5-0002p1-Ie
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtps-0004SI-G7
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpr-00077j-9p
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:34075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtpr-00077C-4E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id v3so3584262wmh.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RJkX+FSx41NmsCqdZkvH4L5KYPcUzyeYKNjS8EG2fRk=;
 b=F/8ICshcU4B0Z9LUtYMGqT3Oy3VVkbT+rM6vb0dNjwovvaiCp5brG6mdJimrGi6crz
 MhIfwHK1+aHfZy8mMM076a3mnhNSF6IBRZxJzhOy7/e7vTFfW3kTHjsNM7X64iGFFpU+
 SwDLt34T8VfKhoeTF/SPsZ6J9vNKDlSY2xl18ZQbTukOWau9p6+R24XFRLN22HZjD0Vm
 CrbxATYU2Gw0LGlTsjhxvWh9a8aTaEnVEL0CG3xkHy+7WP1tUbo4B5d3LC9/zskU++N0
 dSXAMvXWAxU9v1p9HLQJfi0on2haCKAXEB2MnpuqIVAgS4bYgY2+7l0/RUt3SxqhgJdb
 phJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RJkX+FSx41NmsCqdZkvH4L5KYPcUzyeYKNjS8EG2fRk=;
 b=DfUEC3wkvyZCIWOduQbcrkeSkz7qgyLiw/BWJtd4e5cvoishpcpf62lrsTaYKiEgzA
 Dx/hRvCTe5LQQ6sIaW7wJ3oapT9RD20D0Fl8qJzZESLSaQ04ieea772DZ4cOtVOpGgU0
 x7ihtiViQtquubtXkyv28da5Q6HZXiW+f/F4ZnbFZ/FckibPUVFji58QrGMVk1nbzyY/
 UHtOnLgSE4aThH4kcfbX4FQfIVtRBne9UY/RLJb2/N6joCRCy30JBLpZSdAvkTKYAUBz
 gunOm0z8JOe7+sdZz36nGkWQ4mn7TGo/bjAh80iEjGIXQHt631EyCfPD2iqMbtuFlO84
 TPbA==
X-Gm-Message-State: APjAAAWdXtuKtnvSGlw3VNx4IkOToaQNtzz9mih70Tde9Wt7Jj3DEuzz
 ZwH2iZvLupX66PDLkCGLUZRRUA==
X-Google-Smtp-Source: APXvYqw3tPOqbNUnvtCRtK3B4VifBNg48rBsTbbnj2e/hsaHg38Stki52M9kjbNMhxWfN6QBX/80Sg==
X-Received: by 2002:a1c:8189:: with SMTP id c131mr1959751wmd.151.1571987793906; 
 Fri, 25 Oct 2019 00:16:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b5sm1145818wmj.18.2019.10.25.00.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CEB9D1FFC3;
 Fri, 25 Oct 2019 07:37:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 43/73] target/i386: fetch code with translator_ld
Date: Fri, 25 Oct 2019 07:36:43 +0100
Message-Id: <20191025063713.23374-44-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 868b0acafe8..77e932d8276 100644
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


