Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A6CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A6B221E9
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXLS/Bgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A6B221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPpr6-0008GJ-Ee
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 11:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPppy-0006wY-JR
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPppx-0002iM-9h
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:56:58 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPppx-0002ha-4F
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:56:57 -0400
Received: by mail-pg1-x542.google.com with SMTP id o185so2200194pgo.3
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5wIqJJlAXSxMp0Ef0rZrs4CyiYgBlKFC7q0dmEQ2am4=;
 b=QXLS/Bgmn5Sly7dRplMVrYtHFnTlszesYi/raOKNsl3+LKH7NueONtFOO1nCowo4i8
 wMD/oir0F2VxcmdPZMe6XB4mGTKmXVmgQw2TPYVdWFvmqKiMWKlCO3ExDCJWTUBZ3neM
 h/9CgcKXavaFk80tvky3FI7I/BUgk9BJiXXk0//+chVTvki3kHP+liMTyYNtM5c3dIH8
 YuTJAgHrp3DuzIFRuFFH+x+DqRjel1w6M0W0d5t2Gzykiw7eNod34kSLw8qNtMm0ZRce
 Ge7tO/HJEf2MAvkpt4mi2XL9Gsmjt1WxRqtHe1ZVbUOJ2bdbDdpL/23s1czj0TyRKcsr
 fH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5wIqJJlAXSxMp0Ef0rZrs4CyiYgBlKFC7q0dmEQ2am4=;
 b=sCR6UJNW3qmMCa5Upt8BfjZJWXgGOXqGxXDvPJGDf5s31FSj0AckMquG+7Z0zbsutD
 oHNz/M86a8AXvwiZawir94YsTlfiV+f4wOGMuQ4fSS1hhE0ctqyxicxILjJjja30FENb
 B9pD/VT3CLtAKiYMUGdeSGz2bzlEzIZORiYtX5i/Qy4ziWAq9nVsw8RF5xlzyws52dsW
 y3eajFkujfQlL3ED9QaKokKgheDElY0qzltpkp4Wpur/HbtMLFHq2fAk1UBm27PhJN0u
 2HTdwOBsMqbkL7MhcVAzDH2wcbYYA/vzYE7fdWwRne8aWCayWylpbvnAqVpJCgTQWkcu
 DSuw==
X-Gm-Message-State: AGi0PuYY0AiNHlZgBt0Ay5zBNMEDtTK4P6yjGFlupN9/ZvmA6LB5RVx1
 rI3d+fRCPKU7514x8WhHAIOIiABW8fM=
X-Google-Smtp-Source: APiQypKFj+8RW/B1CfE67L7JkddqVNNSkLQ83S8XRPC3soXdf3k/KKk5wo+il1gd6Tbi4gC+yHe6VQ==
X-Received: by 2002:a63:cd08:: with SMTP id i8mr8301816pgg.55.1587225415562;
 Sat, 18 Apr 2020 08:56:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m189sm13928532pfm.60.2020.04.18.08.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 08:56:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] tcg: Improve vector tail clearing
Date: Sat, 18 Apr 2020 08:56:49 -0700
Message-Id: <20200418155651.3901-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418155651.3901-1-richard.henderson@linaro.org>
References: <20200418155651.3901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Better handling of non-power-of-2 tails as seen with Arm 8-byte
vector operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 82 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 19 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 5a6cc19812..43cac1a0bf 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -326,11 +326,34 @@ void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
    in units of LNSZ.  This limits the expansion of inline code.  */
 static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
 {
-    if (oprsz % lnsz == 0) {
-        uint32_t lnct = oprsz / lnsz;
-        return lnct >= 1 && lnct <= MAX_UNROLL;
+    uint32_t q, r;
+
+    if (oprsz < lnsz) {
+        return false;
     }
-    return false;
+
+    q = oprsz / lnsz;
+    r = oprsz % lnsz;
+    tcg_debug_assert((r & 7) == 0);
+
+    if (lnsz < 16) {
+        /* For sizes below 16, accept no remainder. */
+        if (r != 0) {
+            return false;
+        }
+    } else {
+        /*
+         * Recall that ARM SVE allows vector sizes that are not a
+         * power of 2, but always a multiple of 16.  The intent is
+         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+         * In addition, expand_clr needs to handle a multiple of 8.
+         * Thus we can handle the tail with one more operation per
+         * diminishing power of 2.
+         */
+        q += ctpop32(r);
+    }
+
+    return q <= MAX_UNROLL;
 }
 
 static void expand_clr(uint32_t dofs, uint32_t maxsz);
@@ -402,22 +425,31 @@ static void gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
 static TCGType choose_vector_type(const TCGOpcode *list, unsigned vece,
                                   uint32_t size, bool prefer_i64)
 {
-    if (TCG_TARGET_HAS_v256 && check_size_impl(size, 32)) {
-        /*
-         * Recall that ARM SVE allows vector sizes that are not a
-         * power of 2, but always a multiple of 16.  The intent is
-         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
-         * It is hard to imagine a case in which v256 is supported
-         * but v128 is not, but check anyway.
-         */
-        if (tcg_can_emit_vecop_list(list, TCG_TYPE_V256, vece)
-            && (size % 32 == 0
-                || tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece))) {
-            return TCG_TYPE_V256;
-        }
+    /*
+     * Recall that ARM SVE allows vector sizes that are not a
+     * power of 2, but always a multiple of 16.  The intent is
+     * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+     * It is hard to imagine a case in which v256 is supported
+     * but v128 is not, but check anyway.
+     * In addition, expand_clr needs to handle a multiple of 8.
+     */
+    if (TCG_TARGET_HAS_v256 &&
+        check_size_impl(size, 32) &&
+        tcg_can_emit_vecop_list(list, TCG_TYPE_V256, vece) &&
+        (!(size & 16) ||
+         (TCG_TARGET_HAS_v128 &&
+          tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece))) &&
+        (!(size & 8) ||
+         (TCG_TARGET_HAS_v64 &&
+          tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)))) {
+        return TCG_TYPE_V256;
     }
-    if (TCG_TARGET_HAS_v128 && check_size_impl(size, 16)
-        && tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece)) {
+    if (TCG_TARGET_HAS_v128 &&
+        check_size_impl(size, 16) &&
+        tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece) &&
+        (!(size & 8) ||
+         (TCG_TARGET_HAS_v64 &&
+          tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)))) {
         return TCG_TYPE_V128;
     }
     if (TCG_TARGET_HAS_v64 && !prefer_i64 && check_size_impl(size, 8)
@@ -432,6 +464,18 @@ static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
 {
     uint32_t i = 0;
 
+    tcg_debug_assert(oprsz >= 8);
+
+    /*
+     * This may be expand_clr for the tail of an operation, e.g.
+     * oprsz == 8 && maxsz == 64.  The first 8 bytes of this store
+     * are misaligned wrt the maximum vector size, so do that first.
+     */
+    if (dofs & 8) {
+        tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);
+        i += 8;
+    }
+
     switch (type) {
     case TCG_TYPE_V256:
         /*
-- 
2.20.1


