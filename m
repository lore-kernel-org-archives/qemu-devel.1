Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB78BECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D72C206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avE1GDIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D72C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyjl-00070n-IJ
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyC9-00081q-0d
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyC7-0007ey-Kd
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJyC7-0007e7-EW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id r5so19157227wrm.12
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bu4rKDpgnn8IvteRUio5V7sQbtET4I/Wc2TO4RaQ0LI=;
 b=avE1GDIV7mgZMHRqjx8TRvmCzXoYOPxowBAhMsi/coT2yH8fv4kcjbr9/m6rDsmJyM
 P12Nhb/XHGZW8xtlkwppeR2te1SxaImvLiRYFOY+n5RNLWUytPpd0XPdG21eJ647fZcm
 iLAGHn6yT3mlc6BRv23KSGufccBIkOPUhwD7QKeyD1QaeC+P/Lh/+gBUTrg8Pn9+LWp8
 M4LUobp4U67ZYQ8nZ04ryizEgdWzOTA/vyi7qgNnAsRz+xVpfKkF7fNjsZf59RRVpDYY
 pGVhoRQ1DVCgqqz6ef7E2nlNyw1e1i2gyaNxTbgpMj2wbxw26L2IoIPWLUYRyh55sv+E
 CGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bu4rKDpgnn8IvteRUio5V7sQbtET4I/Wc2TO4RaQ0LI=;
 b=aRRwptvxoPuu6P7iuFGJn3N/QMqCGb3a4Nzh0B1RI0eg/w1xILUPhBlCtB094VfqfY
 bldV5pzvYERCo0UDUwc/Giwr0mpbd/ZXIzPrv3Ao6wIwLAH0MfuNbGMtTgyfhuwQAGTR
 vCILg60Lg+kaAKTuOXf36UkNsIC0jeKezOZqte8DTkWCufipC+nWicqXeJDKo7seO6zo
 ec3oJ70KaeZKZNiH8gCRAEPDUmR7SnHWALHKDS8y1+cOTNVg+83O+NheXmWJUGScZAvF
 jpTFy9Wj5ZjvHuMDicVId9IcOZzThygaqo38zsXPVMourP6vkni4fQfBo+P+yPj0RxSN
 2ZQA==
X-Gm-Message-State: APjAAAVOJah+G62espgM8ZvKwB8JZ10FANtre68f/wQ0Lo9UExuXbhhJ
 B4x8rbrSWFLs2ZpuzA2WC7YIXg==
X-Google-Smtp-Source: APXvYqxjfVSVy32Sy6y2arI2jOP8Br4ueZ8dXBAIppYj/Bxw5swmG8KKVfpJhMopN72KnMIZV9DWZg==
X-Received: by 2002:adf:f50f:: with SMTP id q15mr25759756wro.293.1571051238484; 
 Mon, 14 Oct 2019 04:07:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q22sm15585249wmj.5.2019.10.14.04.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 04:07:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7788A1FFB3;
 Mon, 14 Oct 2019 11:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 27/55] target/i386: fetch code with translator_ld
Date: Mon, 14 Oct 2019 11:49:20 +0100
Message-Id: <20191014104948.4291-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
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


