Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DE4C3A5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25C5214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJpOeVRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25C5214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VYW-0008HM-Ef
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URv-0001mM-2Q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URs-0008Vg-Iv
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:06 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c]:38378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URs-0008UA-Ay
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:04 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id j199so1343217ybg.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2P8XG/Ms0z5Bv/o+4iT7E2lxGG7rMaNpaALMij/pc5c=;
 b=BJpOeVRQ7v+ylzEZQLePtTdBgFOyHXZPVXJG1daDdapCx1d3LvnZpyu+GrS2aMlzhr
 v3Q6fPFJr+lz3S+5ajm2929Lu1y/MpaIWhCaEhULju6ArL05NBV5rgT3APM9Q/o9cgvo
 6nHQ1f72WhGJT9mG9ehDz/F3fi8jE8pEskya8+IsPzFKy9HTq2E2gFkDw9Mi+DhZz72T
 /SGRk2rf782Ua1dEyOVQQe0TdKgAazOS/Ll1QYuzLHMqejIig5xQRqblLvAvyeHEwSdN
 KFozQcHbbpJ9Py/5xqEMzgzfd9IBBipmxad4sok9g9X35xhsOhVOJbrMktp0FrLpgjfV
 CY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2P8XG/Ms0z5Bv/o+4iT7E2lxGG7rMaNpaALMij/pc5c=;
 b=hHH6Ed47ZAGX3u60UtE9O30bn3G0Sl64RfFW8Zo4nHpUBKZHnEFybfBWQIEPwWXfRY
 xssWMvzGg7b1iNdHr962fWaYIDzk6FWrIkKzCQIHKBwGemzvXo7NFLZKyD2YP+8ur497
 ooTbPd9X3LRjO/oln7nro7FnELKI+PDbkIFbuKBsjL8vVHrosQc7fisxdPxT92GJFFy+
 ctUvq6Y3bARxT/OC+bFxlBYYZ7t8tl7gCwrRhqmVj7hKPgHWFvqwI+Qb4FP6VfPnZq1q
 19nVw0VMhHlMHIHicKCho8oDJJAWiDa6Y2MFmBByWp5LIAlCY3gdtljckzWS+yoAqh72
 FhYg==
X-Gm-Message-State: APjAAAW4SIrruD1LQgT9B7KbcfvQnyRa7WektuIaVAysSAfhIkCSTibb
 4D7IyggttlEXGKjrE12fo0HAAkjF
X-Google-Smtp-Source: APXvYqzTSkyNc4NkJl/7nDJhl8bn5NLGhQ6nhMrK+qfasXBTFN5dFu41sq547IsqkgZlPn4JypgHIw==
X-Received: by 2002:a25:c2c4:: with SMTP id s187mr25662473ybf.21.1566408663299; 
 Wed, 21 Aug 2019 10:31:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:31:02 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:42 -0400
Message-Id: <20190821172951.15333-67-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b2c
Subject: [Qemu-devel] [RFC PATCH v4 66/75] target/i386: cleanup leftovers in
 ops_sse_header.h
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Get rid of unused macro definitions that have been left over after
removal of obsoleted helpers.
---
 target/i386/ops_sse_header.h | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index d8e33dff6b..afa0ad0938 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -48,27 +48,15 @@ DEF_HELPER_3(glue(psrldq, SUFFIX), void, env, Reg, Reg)
 DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
 #endif
 
-#define SSE_HELPER_B(name, F)\
-    DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
-
-#define SSE_HELPER_W(name, F)\
-    DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
-
-#define SSE_HELPER_L(name, F)\
-    DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
-
-#define SSE_HELPER_Q(name, F)\
-    DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
-
-SSE_HELPER_W(pmullw, FMULLW)
+DEF_HELPER_3(glue(pmullw, SUFFIX), void, env, Reg, Reg)
 #if SHIFT == 0
-SSE_HELPER_W(pmulhrw, FMULHRW)
+DEF_HELPER_3(glue(pmulhrw, SUFFIX), void, env, Reg, Reg)
 #endif
-SSE_HELPER_W(pmulhuw, FMULHUW)
-SSE_HELPER_W(pmulhw, FMULHW)
+DEF_HELPER_3(glue(pmulhuw, SUFFIX), void, env, Reg, Reg)
+DEF_HELPER_3(glue(pmulhw, SUFFIX), void, env, Reg, Reg)
 
-SSE_HELPER_B(pavgb, FAVG)
-SSE_HELPER_W(pavgw, FAVG)
+DEF_HELPER_3(glue(pavgb, SUFFIX), void, env, Reg, Reg)
+DEF_HELPER_3(glue(pavgw, SUFFIX), void, env, Reg, Reg)
 
 DEF_HELPER_3(glue(pmuludq, SUFFIX), void, env, Reg, Reg)
 DEF_HELPER_3(glue(pmaddwd, SUFFIX), void, env, Reg, Reg)
@@ -311,10 +299,6 @@ DEF_HELPER_4(glue(pclmulqdq, SUFFIX), void, env, Reg, Reg, i32)
 #undef Reg
 #undef SUFFIX
 
-#undef SSE_HELPER_B
-#undef SSE_HELPER_W
-#undef SSE_HELPER_L
-#undef SSE_HELPER_Q
 #undef SSE_HELPER_S
 #undef SSE_HELPER_CMP
 #undef UNPCK_OP
-- 
2.20.1


