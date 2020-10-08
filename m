Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABDFC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E282083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9thzgBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E282083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVWy-0006QQ-Cp
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTo-0003RM-3X
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:08 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:32951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTm-0001wa-8D
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:07 -0400
Received: by mail-ot1-x32e.google.com with SMTP id t15so5409329otk.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sng81+Lojn0PspAFm2XXXoAzolkJuyUQkxTQ83xLlw4=;
 b=g9thzgBkM+VsqEe7rcXKIAd4prDkT/DLsgbUnE2XwYTUVpcZOdxhMd4C/xkKdIbzgy
 iQezoWttsbp/NTBKJ+sHJd+rJFn816BwrJhI6xjA31dJwJJRe5Ao57ZanspYfWhgNSqv
 ZEpyFXTgVLWRYjr1hKBt9VD0OlXyI9v7r0NnDptzYI5uLusXHuh7OUuYawo/x9Pyvatv
 VEEAnbzYy9iwUMjFZthP5xxwxZrD4BKNYdKvGpNLWl7xBylpPV/CUrNwZx1KpX4n3eY2
 xQyXj994eARL9yGtIWfseB+qDlUABvHzEe02w2p7HdOI9K3WlIpkCVgCmXOR/ba5Y//4
 imKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sng81+Lojn0PspAFm2XXXoAzolkJuyUQkxTQ83xLlw4=;
 b=kVHjnQXFy7zWuGtqVqO/4cA9iAFOk7JWX1ruCe/ZhZkncTXZV+PmdQ78u7p9ZrAoY7
 94yuELeIAMC4/liQ/0vyondeUdCymWC9zv6w/m+/2IHmVQ3blXGxRWFJQDB0l+RH6dA6
 WxSAqXpXN8jTq4dkWEcnWmElgQDzGEjT/Vo+a70vepURj00hno9tUUDo1dKjUAe67xTK
 wcfzSxNwTRP0OWWTmjFWYydqVi2y2QVybueYTs4UYbJlDgmBkwTyTUuKPQm+HOJnGim+
 AL2lu6gYpN5FsTbe0lPgWLfpPCDLNVtNr8iY9sypAEeyVFc/RtPSujrzp+ATiCprD0R3
 WTIg==
X-Gm-Message-State: AOAM533KbN2Z+EprowZ3YNF9XPZZGi8940tN6LYkVeL24SByEss5CGan
 W1aGan+GkEGmbA5Adm79lHS6jMdnGsmzSa81
X-Google-Smtp-Source: ABdhPJzQWgVRmgBeRmytQBcdHgTk/stntxXJRIL86QefT5o3cn3KyyM8ZrEhiGD8gbT0VaIweTcYUA==
X-Received: by 2002:a9d:2047:: with SMTP id n65mr4884061ota.178.1602161824518; 
 Thu, 08 Oct 2020 05:57:04 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id w64sm4701933oig.31.2020.10.08.05.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 05:57:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] tcg: Adjust simd_desc size encoding
Date: Thu,  8 Oct 2020 07:56:49 -0500
Message-Id: <20201008125659.49857-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
References: <20201008125659.49857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Frank Chang <frank.chang@sifive.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With larger vector sizes, it turns out oprsz == maxsz, and we only
need to represent mismatch for oprsz <= 32.  We do, however, need
to represent larger oprsz and do so without reducing SIMD_DATA_BITS.

Reduce the size of the oprsz field and increase the maxsz field.
Steal the oprsz value of 24 to indicate equality with maxsz.

Tested-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-gvec-desc.h | 38 ++++++++++++++++++++++++-------------
 tcg/tcg-op-gvec.c           | 35 ++++++++++++++++++++++++++--------
 2 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
index 0224ac3e78..704bd86454 100644
--- a/include/tcg/tcg-gvec-desc.h
+++ b/include/tcg/tcg-gvec-desc.h
@@ -20,29 +20,41 @@
 #ifndef TCG_TCG_GVEC_DESC_H
 #define TCG_TCG_GVEC_DESC_H
 
-/* ??? These bit widths are set for ARM SVE, maxing out at 256 byte vectors. */
-#define SIMD_OPRSZ_SHIFT   0
-#define SIMD_OPRSZ_BITS    5
+/*
+ * This configuration allows MAXSZ to represent 2048 bytes, and
+ * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.
+ *
+ * Encode this with:
+ *   0, 1, 3 -> 8, 16, 32
+ *   2       -> maxsz
+ *
+ * This steals the input that would otherwise map to 24 to match maxsz.
+ */
+#define SIMD_MAXSZ_SHIFT   0
+#define SIMD_MAXSZ_BITS    8
 
-#define SIMD_MAXSZ_SHIFT   (SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)
-#define SIMD_MAXSZ_BITS    5
+#define SIMD_OPRSZ_SHIFT   (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
+#define SIMD_OPRSZ_BITS    2
 
-#define SIMD_DATA_SHIFT    (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
+#define SIMD_DATA_SHIFT    (SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)
 #define SIMD_DATA_BITS     (32 - SIMD_DATA_SHIFT)
 
 /* Create a descriptor from components.  */
 uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data);
 
-/* Extract the operation size from a descriptor.  */
-static inline intptr_t simd_oprsz(uint32_t desc)
-{
-    return (extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS) + 1) * 8;
-}
-
 /* Extract the max vector size from a descriptor.  */
 static inline intptr_t simd_maxsz(uint32_t desc)
 {
-    return (extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) + 1) * 8;
+    return extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) * 8 + 8;
+}
+
+/* Extract the operation size from a descriptor.  */
+static inline intptr_t simd_oprsz(uint32_t desc)
+{
+    uint32_t f = extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS);
+    intptr_t o = f * 8 + 8;
+    intptr_t m = simd_maxsz(desc);
+    return f == 2 ? m : o;
 }
 
 /* Extract the operation-specific data from a descriptor.  */
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 7ebd9e8298..ddbe06b71a 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -37,11 +37,21 @@ static const TCGOpcode vecop_list_empty[1] = { 0 };
    of the operand offsets so that we can check them all at once.  */
 static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
 {
-    uint32_t opr_align = oprsz >= 16 ? 15 : 7;
-    uint32_t max_align = maxsz >= 16 || oprsz >= 16 ? 15 : 7;
-    tcg_debug_assert(oprsz > 0);
-    tcg_debug_assert(oprsz <= maxsz);
-    tcg_debug_assert((oprsz & opr_align) == 0);
+    uint32_t max_align;
+
+    switch (oprsz) {
+    case 8:
+    case 16:
+    case 32:
+        tcg_debug_assert(oprsz <= maxsz);
+        break;
+    default:
+        tcg_debug_assert(oprsz == maxsz);
+        break;
+    }
+    tcg_debug_assert(maxsz <= (8 << SIMD_MAXSZ_BITS));
+
+    max_align = maxsz >= 16 ? 15 : 7;
     tcg_debug_assert((maxsz & max_align) == 0);
     tcg_debug_assert((ofs & max_align) == 0);
 }
@@ -77,12 +87,21 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
 {
     uint32_t desc = 0;
 
-    assert(oprsz % 8 == 0 && oprsz <= (8 << SIMD_OPRSZ_BITS));
-    assert(maxsz % 8 == 0 && maxsz <= (8 << SIMD_MAXSZ_BITS));
-    assert(data == sextract32(data, 0, SIMD_DATA_BITS));
+    check_size_align(oprsz, maxsz, 0);
+    tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS));
 
     oprsz = (oprsz / 8) - 1;
     maxsz = (maxsz / 8) - 1;
+
+    /*
+     * We have just asserted in check_size_align that either
+     * oprsz is {8,16,32} or matches maxsz.  Encode the final
+     * case with '2', as that would otherwise map to 24.
+     */
+    if (oprsz == maxsz) {
+        oprsz = 2;
+    }
+
     desc = deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS, oprsz);
     desc = deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS, maxsz);
     desc = deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS, data);
-- 
2.25.1


