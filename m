Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7185BC35240
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A2D207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9Zg6e0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A2D207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iulpP-0001gY-C9
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 18:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuloT-0008VK-7p
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuloP-0007cl-Dj
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:23:01 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuloP-0007c8-3I
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:22:57 -0500
Received: by mail-pf1-x444.google.com with SMTP id w62so146943pfw.8
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 15:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IGNDPL2Meg2Sa+Ln4Vpxrll2sfttHqj9POtYPYv3Zr8=;
 b=m9Zg6e0rtq0C1kTfNzzdbPZl0R7T8eXy4HWrESozzJEgz7ZJpk1l6j0t16thu5Je0o
 qrNGAQS7gor1///rnM9KLdhdpwhPUwtYuB/iIaxh3tYPr6Tndm1eBQjFh5FrDTihpDmK
 3WyY+Tb52kkcHfirgWV0aECSfNbs9NlTCRVWhrRteqhpKXE0gIkbkh726EuIFj2mdfkB
 ya3ZoTiUtJzoj70pzgcDLndYIjBbN7J11L4s+WkwWtKeCpJz6nh2VA/JaB4HgIRYcfcI
 uiQPRJfSDqjEtWd99xk8sf7Tkne9DYBSw3xea6jGxdN9TvuVPtfKSgUiDs13VbeCR9yA
 ZDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IGNDPL2Meg2Sa+Ln4Vpxrll2sfttHqj9POtYPYv3Zr8=;
 b=XsjHwnMkwmhXaEnV1qhM8qliQzccYuHJapD4Y51GUfxUWjRifJjyQXH3IsHtsK7rp/
 xsjWkRt+Kvy/eeIYhen9idb+mDDFH7Tz+oaoBoQjTUYJBzL87o6UDZUYvL/6QFvtwWlI
 xbP1p6m8+CvZ2+MlqwiyQ0HjF/DVaq/lDDkTPBVgJftMmr0npTMnCCw8KiZ0zd9imwGU
 LF5ESOo4qMexGhW3JqwzbqneC5E1ebcbTNnX3YalfkWFEnUjYnqX5YmHrhQcM9iGaJxw
 MXFZa9ln0fD52m+4jfodcEFoNkh+aqIDBX8wjt/VXD9mNzlxcE/V7uRu4GV8QpBxCdDW
 5/UQ==
X-Gm-Message-State: APjAAAWVxO8RtCJ+y9MdFUdP7oxnLdWNJo6wR8lGDximA9IeN01ihqZk
 OaPLkpOKqYXLtbjYM08PAk9/fIpvvIg=
X-Google-Smtp-Source: APXvYqz6ftZMI3fN8+B+y0N1z4kXQ+cG6XRAILnIkBdBkaUvKaMaQApSnBR35M8LTnQ7K8mpqZ034A==
X-Received: by 2002:aa7:85d9:: with SMTP id z25mr593217pfn.223.1579821775206; 
 Thu, 23 Jan 2020 15:22:55 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id z5sm4136008pfq.3.2020.01.23.15.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 15:22:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] target/s390x: Remove DisasFields argument from callbacks
Date: Thu, 23 Jan 2020 13:22:45 -1000
Message-Id: <20200123232248.1800-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123232248.1800-1-richard.henderson@linaro.org>
References: <20200123232248.1800-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: thuth@redhat.com, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The DisasFields data is available from DisasContext.
We do not need to pass a separate argument.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate.c | 417 ++++++++++++++++++++-------------------
 1 file changed, 210 insertions(+), 207 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 7ef228843a..7d3dcc4fab 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1223,15 +1223,15 @@ struct DisasInsn {
     const char *name;
 
     /* Pre-process arguments before HELP_OP.  */
-    void (*help_in1)(DisasContext *, DisasFields *, DisasOps *);
-    void (*help_in2)(DisasContext *, DisasFields *, DisasOps *);
-    void (*help_prep)(DisasContext *, DisasFields *, DisasOps *);
+    void (*help_in1)(DisasContext *, DisasOps *);
+    void (*help_in2)(DisasContext *, DisasOps *);
+    void (*help_prep)(DisasContext *, DisasOps *);
 
     /*
      * Post-process output after HELP_OP.
      * Note that these are not called if HELP_OP returns DISAS_NORETURN.
      */
-    void (*help_wout)(DisasContext *, DisasFields *, DisasOps *);
+    void (*help_wout)(DisasContext *, DisasOps *);
     void (*help_cout)(DisasContext *, DisasOps *);
 
     /* Implement the operation itself.  */
@@ -1243,11 +1243,10 @@ struct DisasInsn {
 /* ====================================================================== */
 /* Miscellaneous helpers, used by several operations.  */
 
-static void help_l2_shift(DisasContext *s, DisasFields *f,
-                          DisasOps *o, int mask)
+static void help_l2_shift(DisasContext *s, DisasOps *o, int mask)
 {
-    int b2 = get_field(f, b2);
-    int d2 = get_field(f, d2);
+    int b2 = get_field(s->fields, b2);
+    int d2 = get_field(s->fields, d2);
 
     if (b2 == 0) {
         o->in2 = tcg_const_i64(d2 & mask);
@@ -5290,29 +5289,29 @@ static void cout_tm64(DisasContext *s, DisasOps *o)
    the "wout" generators, in some cases we need a new temporary, and in
    some cases we can write to a TCG global.  */
 
-static void prep_new(DisasContext *s, DisasFields *f, DisasOps *o)
+static void prep_new(DisasContext *s, DisasOps *o)
 {
     o->out = tcg_temp_new_i64();
 }
 #define SPEC_prep_new 0
 
-static void prep_new_P(DisasContext *s, DisasFields *f, DisasOps *o)
+static void prep_new_P(DisasContext *s, DisasOps *o)
 {
     o->out = tcg_temp_new_i64();
     o->out2 = tcg_temp_new_i64();
 }
 #define SPEC_prep_new_P 0
 
-static void prep_r1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void prep_r1(DisasContext *s, DisasOps *o)
 {
-    o->out = regs[get_field(f, r1)];
+    o->out = regs[get_field(s->fields, r1)];
     o->g_out = true;
 }
 #define SPEC_prep_r1 0
 
-static void prep_r1_P(DisasContext *s, DisasFields *f, DisasOps *o)
+static void prep_r1_P(DisasContext *s, DisasOps *o)
 {
-    int r1 = get_field(f, r1);
+    int r1 = get_field(s->fields, r1);
     o->out = regs[r1];
     o->out2 = regs[r1 + 1];
     o->g_out = o->g_out2 = true;
@@ -5320,10 +5319,10 @@ static void prep_r1_P(DisasContext *s, DisasFields *f, DisasOps *o)
 #define SPEC_prep_r1_P SPEC_r1_even
 
 /* Whenever we need x1 in addition to other inputs, we'll load it to out/out2 */
-static void prep_x1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void prep_x1(DisasContext *s, DisasOps *o)
 {
-    o->out = load_freg(get_field(f, r1));
-    o->out2 = load_freg(get_field(f, r1) + 2);
+    o->out = load_freg(get_field(s->fields, r1));
+    o->out2 = load_freg(get_field(s->fields, r1) + 2);
 }
 #define SPEC_prep_x1 SPEC_r1_f128
 
@@ -5333,84 +5332,84 @@ static void prep_x1(DisasContext *s, DisasFields *f, DisasOps *o)
    generally handled by having a "prep" generator install the TCG global
    as the destination of the operation.  */
 
-static void wout_r1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_r1(DisasContext *s, DisasOps *o)
 {
-    store_reg(get_field(f, r1), o->out);
+    store_reg(get_field(s->fields, r1), o->out);
 }
 #define SPEC_wout_r1 0
 
-static void wout_r1_8(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_r1_8(DisasContext *s, DisasOps *o)
 {
-    int r1 = get_field(f, r1);
+    int r1 = get_field(s->fields, r1);
     tcg_gen_deposit_i64(regs[r1], regs[r1], o->out, 0, 8);
 }
 #define SPEC_wout_r1_8 0
 
-static void wout_r1_16(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_r1_16(DisasContext *s, DisasOps *o)
 {
-    int r1 = get_field(f, r1);
+    int r1 = get_field(s->fields, r1);
     tcg_gen_deposit_i64(regs[r1], regs[r1], o->out, 0, 16);
 }
 #define SPEC_wout_r1_16 0
 
-static void wout_r1_32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_r1_32(DisasContext *s, DisasOps *o)
 {
-    store_reg32_i64(get_field(f, r1), o->out);
+    store_reg32_i64(get_field(s->fields, r1), o->out);
 }
 #define SPEC_wout_r1_32 0
 
-static void wout_r1_32h(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_r1_32h(DisasContext *s, DisasOps *o)
 {
-    store_reg32h_i64(get_field(f, r1), o->out);
+    store_reg32h_i64(get_field(s->fields, r1), o->out);
 }
 #define SPEC_wout_r1_32h 0
 
-static void wout_r1_P32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_r1_P32(DisasContext *s, DisasOps *o)
 {
-    int r1 = get_field(f, r1);
+    int r1 = get_field(s->fields, r1);
     store_reg32_i64(r1, o->out);
     store_reg32_i64(r1 + 1, o->out2);
 }
 #define SPEC_wout_r1_P32 SPEC_r1_even
 
-static void wout_r1_D32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_r1_D32(DisasContext *s, DisasOps *o)
 {
-    int r1 = get_field(f, r1);
+    int r1 = get_field(s->fields, r1);
     store_reg32_i64(r1 + 1, o->out);
     tcg_gen_shri_i64(o->out, o->out, 32);
     store_reg32_i64(r1, o->out);
 }
 #define SPEC_wout_r1_D32 SPEC_r1_even
 
-static void wout_r3_P32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_r3_P32(DisasContext *s, DisasOps *o)
 {
-    int r3 = get_field(f, r3);
+    int r3 = get_field(s->fields, r3);
     store_reg32_i64(r3, o->out);
     store_reg32_i64(r3 + 1, o->out2);
 }
 #define SPEC_wout_r3_P32 SPEC_r3_even
 
-static void wout_r3_P64(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_r3_P64(DisasContext *s, DisasOps *o)
 {
-    int r3 = get_field(f, r3);
+    int r3 = get_field(s->fields, r3);
     store_reg(r3, o->out);
     store_reg(r3 + 1, o->out2);
 }
 #define SPEC_wout_r3_P64 SPEC_r3_even
 
-static void wout_e1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_e1(DisasContext *s, DisasOps *o)
 {
-    store_freg32_i64(get_field(f, r1), o->out);
+    store_freg32_i64(get_field(s->fields, r1), o->out);
 }
 #define SPEC_wout_e1 0
 
-static void wout_f1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_f1(DisasContext *s, DisasOps *o)
 {
-    store_freg(get_field(f, r1), o->out);
+    store_freg(get_field(s->fields, r1), o->out);
 }
 #define SPEC_wout_f1 0
 
-static void wout_x1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_x1(DisasContext *s, DisasOps *o)
 {
     int f1 = get_field(s->fields, r1);
     store_freg(f1, o->out);
@@ -5418,282 +5417,284 @@ static void wout_x1(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_wout_x1 SPEC_r1_f128
 
-static void wout_cond_r1r2_32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_cond_r1r2_32(DisasContext *s, DisasOps *o)
 {
-    if (get_field(f, r1) != get_field(f, r2)) {
-        store_reg32_i64(get_field(f, r1), o->out);
+    if (get_field(s->fields, r1) != get_field(s->fields, r2)) {
+        store_reg32_i64(get_field(s->fields, r1), o->out);
     }
 }
 #define SPEC_wout_cond_r1r2_32 0
 
-static void wout_cond_e1e2(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_cond_e1e2(DisasContext *s, DisasOps *o)
 {
-    if (get_field(f, r1) != get_field(f, r2)) {
-        store_freg32_i64(get_field(f, r1), o->out);
+    if (get_field(s->fields, r1) != get_field(s->fields, r2)) {
+        store_freg32_i64(get_field(s->fields, r1), o->out);
     }
 }
 #define SPEC_wout_cond_e1e2 0
 
-static void wout_m1_8(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_m1_8(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st8(o->out, o->addr1, get_mem_index(s));
 }
 #define SPEC_wout_m1_8 0
 
-static void wout_m1_16(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_m1_16(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st16(o->out, o->addr1, get_mem_index(s));
 }
 #define SPEC_wout_m1_16 0
 
 #ifndef CONFIG_USER_ONLY
-static void wout_m1_16a(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_m1_16a(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUW | MO_ALIGN);
 }
 #define SPEC_wout_m1_16a 0
 #endif
 
-static void wout_m1_32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_m1_32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st32(o->out, o->addr1, get_mem_index(s));
 }
 #define SPEC_wout_m1_32 0
 
 #ifndef CONFIG_USER_ONLY
-static void wout_m1_32a(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_m1_32a(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUL | MO_ALIGN);
 }
 #define SPEC_wout_m1_32a 0
 #endif
 
-static void wout_m1_64(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_m1_64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st64(o->out, o->addr1, get_mem_index(s));
 }
 #define SPEC_wout_m1_64 0
 
 #ifndef CONFIG_USER_ONLY
-static void wout_m1_64a(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_m1_64a(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
 }
 #define SPEC_wout_m1_64a 0
 #endif
 
-static void wout_m2_32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_m2_32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st32(o->out, o->in2, get_mem_index(s));
 }
 #define SPEC_wout_m2_32 0
 
-static void wout_in2_r1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_in2_r1(DisasContext *s, DisasOps *o)
 {
-    store_reg(get_field(f, r1), o->in2);
+    store_reg(get_field(s->fields, r1), o->in2);
 }
 #define SPEC_wout_in2_r1 0
 
-static void wout_in2_r1_32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void wout_in2_r1_32(DisasContext *s, DisasOps *o)
 {
-    store_reg32_i64(get_field(f, r1), o->in2);
+    store_reg32_i64(get_field(s->fields, r1), o->in2);
 }
 #define SPEC_wout_in2_r1_32 0
 
 /* ====================================================================== */
 /* The "INput 1" generators.  These load the first operand to an insn.  */
 
-static void in1_r1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r1(DisasContext *s, DisasOps *o)
 {
-    o->in1 = load_reg(get_field(f, r1));
+    o->in1 = load_reg(get_field(s->fields, r1));
 }
 #define SPEC_in1_r1 0
 
-static void in1_r1_o(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r1_o(DisasContext *s, DisasOps *o)
 {
-    o->in1 = regs[get_field(f, r1)];
+    o->in1 = regs[get_field(s->fields, r1)];
     o->g_in1 = true;
 }
 #define SPEC_in1_r1_o 0
 
-static void in1_r1_32s(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r1_32s(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_ext32s_i64(o->in1, regs[get_field(f, r1)]);
+    tcg_gen_ext32s_i64(o->in1, regs[get_field(s->fields, r1)]);
 }
 #define SPEC_in1_r1_32s 0
 
-static void in1_r1_32u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r1_32u(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in1, regs[get_field(f, r1)]);
+    tcg_gen_ext32u_i64(o->in1, regs[get_field(s->fields, r1)]);
 }
 #define SPEC_in1_r1_32u 0
 
-static void in1_r1_sr32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r1_sr32(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_shri_i64(o->in1, regs[get_field(f, r1)], 32);
+    tcg_gen_shri_i64(o->in1, regs[get_field(s->fields, r1)], 32);
 }
 #define SPEC_in1_r1_sr32 0
 
-static void in1_r1p1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r1p1(DisasContext *s, DisasOps *o)
 {
-    o->in1 = load_reg(get_field(f, r1) + 1);
+    o->in1 = load_reg(get_field(s->fields, r1) + 1);
 }
 #define SPEC_in1_r1p1 SPEC_r1_even
 
-static void in1_r1p1_32s(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r1p1_32s(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_ext32s_i64(o->in1, regs[get_field(f, r1) + 1]);
+    tcg_gen_ext32s_i64(o->in1, regs[get_field(s->fields, r1) + 1]);
 }
 #define SPEC_in1_r1p1_32s SPEC_r1_even
 
-static void in1_r1p1_32u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r1p1_32u(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in1, regs[get_field(f, r1) + 1]);
+    tcg_gen_ext32u_i64(o->in1, regs[get_field(s->fields, r1) + 1]);
 }
 #define SPEC_in1_r1p1_32u SPEC_r1_even
 
-static void in1_r1_D32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r1_D32(DisasContext *s, DisasOps *o)
 {
-    int r1 = get_field(f, r1);
+    int r1 = get_field(s->fields, r1);
     o->in1 = tcg_temp_new_i64();
     tcg_gen_concat32_i64(o->in1, regs[r1 + 1], regs[r1]);
 }
 #define SPEC_in1_r1_D32 SPEC_r1_even
 
-static void in1_r2(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r2(DisasContext *s, DisasOps *o)
 {
-    o->in1 = load_reg(get_field(f, r2));
+    o->in1 = load_reg(get_field(s->fields, r2));
 }
 #define SPEC_in1_r2 0
 
-static void in1_r2_sr32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r2_sr32(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_shri_i64(o->in1, regs[get_field(f, r2)], 32);
+    tcg_gen_shri_i64(o->in1, regs[get_field(s->fields, r2)], 32);
 }
 #define SPEC_in1_r2_sr32 0
 
-static void in1_r3(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r3(DisasContext *s, DisasOps *o)
 {
-    o->in1 = load_reg(get_field(f, r3));
+    o->in1 = load_reg(get_field(s->fields, r3));
 }
 #define SPEC_in1_r3 0
 
-static void in1_r3_o(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r3_o(DisasContext *s, DisasOps *o)
 {
-    o->in1 = regs[get_field(f, r3)];
+    o->in1 = regs[get_field(s->fields, r3)];
     o->g_in1 = true;
 }
 #define SPEC_in1_r3_o 0
 
-static void in1_r3_32s(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r3_32s(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_ext32s_i64(o->in1, regs[get_field(f, r3)]);
+    tcg_gen_ext32s_i64(o->in1, regs[get_field(s->fields, r3)]);
 }
 #define SPEC_in1_r3_32s 0
 
-static void in1_r3_32u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r3_32u(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in1, regs[get_field(f, r3)]);
+    tcg_gen_ext32u_i64(o->in1, regs[get_field(s->fields, r3)]);
 }
 #define SPEC_in1_r3_32u 0
 
-static void in1_r3_D32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_r3_D32(DisasContext *s, DisasOps *o)
 {
-    int r3 = get_field(f, r3);
+    int r3 = get_field(s->fields, r3);
     o->in1 = tcg_temp_new_i64();
     tcg_gen_concat32_i64(o->in1, regs[r3 + 1], regs[r3]);
 }
 #define SPEC_in1_r3_D32 SPEC_r3_even
 
-static void in1_e1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_e1(DisasContext *s, DisasOps *o)
 {
-    o->in1 = load_freg32_i64(get_field(f, r1));
+    o->in1 = load_freg32_i64(get_field(s->fields, r1));
 }
 #define SPEC_in1_e1 0
 
-static void in1_f1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_f1(DisasContext *s, DisasOps *o)
 {
-    o->in1 = load_freg(get_field(f, r1));
+    o->in1 = load_freg(get_field(s->fields, r1));
 }
 #define SPEC_in1_f1 0
 
 /* Load the high double word of an extended (128-bit) format FP number */
-static void in1_x2h(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_x2h(DisasContext *s, DisasOps *o)
 {
-    o->in1 = load_freg(get_field(f, r2));
+    o->in1 = load_freg(get_field(s->fields, r2));
 }
 #define SPEC_in1_x2h SPEC_r2_f128
 
-static void in1_f3(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_f3(DisasContext *s, DisasOps *o)
 {
-    o->in1 = load_freg(get_field(f, r3));
+    o->in1 = load_freg(get_field(s->fields, r3));
 }
 #define SPEC_in1_f3 0
 
-static void in1_la1(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_la1(DisasContext *s, DisasOps *o)
 {
-    o->addr1 = get_address(s, 0, get_field(f, b1), get_field(f, d1));
+    o->addr1 = get_address(s, 0, get_field(s->fields, b1),
+                           get_field(s->fields, d1));
 }
 #define SPEC_in1_la1 0
 
-static void in1_la2(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_la2(DisasContext *s, DisasOps *o)
 {
-    int x2 = have_field(f, x2) ? get_field(f, x2) : 0;
-    o->addr1 = get_address(s, x2, get_field(f, b2), get_field(f, d2));
+    int x2 = have_field(s->fields, x2) ? get_field(s->fields, x2) : 0;
+    o->addr1 = get_address(s, x2, get_field(s->fields, b2),
+                           get_field(s->fields, d2));
 }
 #define SPEC_in1_la2 0
 
-static void in1_m1_8u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_m1_8u(DisasContext *s, DisasOps *o)
 {
-    in1_la1(s, f, o);
+    in1_la1(s, o);
     o->in1 = tcg_temp_new_i64();
     tcg_gen_qemu_ld8u(o->in1, o->addr1, get_mem_index(s));
 }
 #define SPEC_in1_m1_8u 0
 
-static void in1_m1_16s(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_m1_16s(DisasContext *s, DisasOps *o)
 {
-    in1_la1(s, f, o);
+    in1_la1(s, o);
     o->in1 = tcg_temp_new_i64();
     tcg_gen_qemu_ld16s(o->in1, o->addr1, get_mem_index(s));
 }
 #define SPEC_in1_m1_16s 0
 
-static void in1_m1_16u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_m1_16u(DisasContext *s, DisasOps *o)
 {
-    in1_la1(s, f, o);
+    in1_la1(s, o);
     o->in1 = tcg_temp_new_i64();
     tcg_gen_qemu_ld16u(o->in1, o->addr1, get_mem_index(s));
 }
 #define SPEC_in1_m1_16u 0
 
-static void in1_m1_32s(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_m1_32s(DisasContext *s, DisasOps *o)
 {
-    in1_la1(s, f, o);
+    in1_la1(s, o);
     o->in1 = tcg_temp_new_i64();
     tcg_gen_qemu_ld32s(o->in1, o->addr1, get_mem_index(s));
 }
 #define SPEC_in1_m1_32s 0
 
-static void in1_m1_32u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_m1_32u(DisasContext *s, DisasOps *o)
 {
-    in1_la1(s, f, o);
+    in1_la1(s, o);
     o->in1 = tcg_temp_new_i64();
     tcg_gen_qemu_ld32u(o->in1, o->addr1, get_mem_index(s));
 }
 #define SPEC_in1_m1_32u 0
 
-static void in1_m1_64(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_m1_64(DisasContext *s, DisasOps *o)
 {
-    in1_la1(s, f, o);
+    in1_la1(s, o);
     o->in1 = tcg_temp_new_i64();
     tcg_gen_qemu_ld64(o->in1, o->addr1, get_mem_index(s));
 }
@@ -5702,304 +5703,306 @@ static void in1_m1_64(DisasContext *s, DisasFields *f, DisasOps *o)
 /* ====================================================================== */
 /* The "INput 2" generators.  These load the second operand to an insn.  */
 
-static void in2_r1_o(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r1_o(DisasContext *s, DisasOps *o)
 {
-    o->in2 = regs[get_field(f, r1)];
+    o->in2 = regs[get_field(s->fields, r1)];
     o->g_in2 = true;
 }
 #define SPEC_in2_r1_o 0
 
-static void in2_r1_16u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r1_16u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_ext16u_i64(o->in2, regs[get_field(f, r1)]);
+    tcg_gen_ext16u_i64(o->in2, regs[get_field(s->fields, r1)]);
 }
 #define SPEC_in2_r1_16u 0
 
-static void in2_r1_32u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r1_32u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in2, regs[get_field(f, r1)]);
+    tcg_gen_ext32u_i64(o->in2, regs[get_field(s->fields, r1)]);
 }
 #define SPEC_in2_r1_32u 0
 
-static void in2_r1_D32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r1_D32(DisasContext *s, DisasOps *o)
 {
-    int r1 = get_field(f, r1);
+    int r1 = get_field(s->fields, r1);
     o->in2 = tcg_temp_new_i64();
     tcg_gen_concat32_i64(o->in2, regs[r1 + 1], regs[r1]);
 }
 #define SPEC_in2_r1_D32 SPEC_r1_even
 
-static void in2_r2(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r2(DisasContext *s, DisasOps *o)
 {
-    o->in2 = load_reg(get_field(f, r2));
+    o->in2 = load_reg(get_field(s->fields, r2));
 }
 #define SPEC_in2_r2 0
 
-static void in2_r2_o(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r2_o(DisasContext *s, DisasOps *o)
 {
-    o->in2 = regs[get_field(f, r2)];
+    o->in2 = regs[get_field(s->fields, r2)];
     o->g_in2 = true;
 }
 #define SPEC_in2_r2_o 0
 
-static void in2_r2_nz(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r2_nz(DisasContext *s, DisasOps *o)
 {
-    int r2 = get_field(f, r2);
+    int r2 = get_field(s->fields, r2);
     if (r2 != 0) {
         o->in2 = load_reg(r2);
     }
 }
 #define SPEC_in2_r2_nz 0
 
-static void in2_r2_8s(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r2_8s(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_ext8s_i64(o->in2, regs[get_field(f, r2)]);
+    tcg_gen_ext8s_i64(o->in2, regs[get_field(s->fields, r2)]);
 }
 #define SPEC_in2_r2_8s 0
 
-static void in2_r2_8u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r2_8u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_ext8u_i64(o->in2, regs[get_field(f, r2)]);
+    tcg_gen_ext8u_i64(o->in2, regs[get_field(s->fields, r2)]);
 }
 #define SPEC_in2_r2_8u 0
 
-static void in2_r2_16s(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r2_16s(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_ext16s_i64(o->in2, regs[get_field(f, r2)]);
+    tcg_gen_ext16s_i64(o->in2, regs[get_field(s->fields, r2)]);
 }
 #define SPEC_in2_r2_16s 0
 
-static void in2_r2_16u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r2_16u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_ext16u_i64(o->in2, regs[get_field(f, r2)]);
+    tcg_gen_ext16u_i64(o->in2, regs[get_field(s->fields, r2)]);
 }
 #define SPEC_in2_r2_16u 0
 
-static void in2_r3(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r3(DisasContext *s, DisasOps *o)
 {
-    o->in2 = load_reg(get_field(f, r3));
+    o->in2 = load_reg(get_field(s->fields, r3));
 }
 #define SPEC_in2_r3 0
 
-static void in2_r3_sr32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r3_sr32(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_shri_i64(o->in2, regs[get_field(f, r3)], 32);
+    tcg_gen_shri_i64(o->in2, regs[get_field(s->fields, r3)], 32);
 }
 #define SPEC_in2_r3_sr32 0
 
-static void in2_r3_32u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r3_32u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in2, regs[get_field(f, r3)]);
+    tcg_gen_ext32u_i64(o->in2, regs[get_field(s->fields, r3)]);
 }
 #define SPEC_in2_r3_32u 0
 
-static void in2_r2_32s(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r2_32s(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_ext32s_i64(o->in2, regs[get_field(f, r2)]);
+    tcg_gen_ext32s_i64(o->in2, regs[get_field(s->fields, r2)]);
 }
 #define SPEC_in2_r2_32s 0
 
-static void in2_r2_32u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r2_32u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in2, regs[get_field(f, r2)]);
+    tcg_gen_ext32u_i64(o->in2, regs[get_field(s->fields, r2)]);
 }
 #define SPEC_in2_r2_32u 0
 
-static void in2_r2_sr32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_r2_sr32(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_shri_i64(o->in2, regs[get_field(f, r2)], 32);
+    tcg_gen_shri_i64(o->in2, regs[get_field(s->fields, r2)], 32);
 }
 #define SPEC_in2_r2_sr32 0
 
-static void in2_e2(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_e2(DisasContext *s, DisasOps *o)
 {
-    o->in2 = load_freg32_i64(get_field(f, r2));
+    o->in2 = load_freg32_i64(get_field(s->fields, r2));
 }
 #define SPEC_in2_e2 0
 
-static void in2_f2(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_f2(DisasContext *s, DisasOps *o)
 {
-    o->in2 = load_freg(get_field(f, r2));
+    o->in2 = load_freg(get_field(s->fields, r2));
 }
 #define SPEC_in2_f2 0
 
 /* Load the low double word of an extended (128-bit) format FP number */
-static void in2_x2l(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_x2l(DisasContext *s, DisasOps *o)
 {
-    o->in2 = load_freg(get_field(f, r2) + 2);
+    o->in2 = load_freg(get_field(s->fields, r2) + 2);
 }
 #define SPEC_in2_x2l SPEC_r2_f128
 
-static void in2_ra2(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_ra2(DisasContext *s, DisasOps *o)
 {
-    o->in2 = get_address(s, 0, get_field(f, r2), 0);
+    o->in2 = get_address(s, 0, get_field(s->fields, r2), 0);
 }
 #define SPEC_in2_ra2 0
 
-static void in2_a2(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_a2(DisasContext *s, DisasOps *o)
 {
-    int x2 = have_field(f, x2) ? get_field(f, x2) : 0;
-    o->in2 = get_address(s, x2, get_field(f, b2), get_field(f, d2));
+    int x2 = have_field(s->fields, x2) ? get_field(s->fields, x2) : 0;
+    o->in2 = get_address(s, x2, get_field(s->fields, b2),
+                         get_field(s->fields, d2));
 }
 #define SPEC_in2_a2 0
 
-static void in2_ri2(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_ri2(DisasContext *s, DisasOps *o)
 {
-    o->in2 = tcg_const_i64(s->base.pc_next + (int64_t)get_field(f, i2) * 2);
+    o->in2 = tcg_const_i64(s->base.pc_next +
+                           (int64_t)get_field(s->fields, i2) * 2);
 }
 #define SPEC_in2_ri2 0
 
-static void in2_sh32(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_sh32(DisasContext *s, DisasOps *o)
 {
-    help_l2_shift(s, f, o, 31);
+    help_l2_shift(s, o, 31);
 }
 #define SPEC_in2_sh32 0
 
-static void in2_sh64(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_sh64(DisasContext *s, DisasOps *o)
 {
-    help_l2_shift(s, f, o, 63);
+    help_l2_shift(s, o, 63);
 }
 #define SPEC_in2_sh64 0
 
-static void in2_m2_8u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_m2_8u(DisasContext *s, DisasOps *o)
 {
-    in2_a2(s, f, o);
+    in2_a2(s, o);
     tcg_gen_qemu_ld8u(o->in2, o->in2, get_mem_index(s));
 }
 #define SPEC_in2_m2_8u 0
 
-static void in2_m2_16s(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_m2_16s(DisasContext *s, DisasOps *o)
 {
-    in2_a2(s, f, o);
+    in2_a2(s, o);
     tcg_gen_qemu_ld16s(o->in2, o->in2, get_mem_index(s));
 }
 #define SPEC_in2_m2_16s 0
 
-static void in2_m2_16u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_m2_16u(DisasContext *s, DisasOps *o)
 {
-    in2_a2(s, f, o);
+    in2_a2(s, o);
     tcg_gen_qemu_ld16u(o->in2, o->in2, get_mem_index(s));
 }
 #define SPEC_in2_m2_16u 0
 
-static void in2_m2_32s(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_m2_32s(DisasContext *s, DisasOps *o)
 {
-    in2_a2(s, f, o);
+    in2_a2(s, o);
     tcg_gen_qemu_ld32s(o->in2, o->in2, get_mem_index(s));
 }
 #define SPEC_in2_m2_32s 0
 
-static void in2_m2_32u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_m2_32u(DisasContext *s, DisasOps *o)
 {
-    in2_a2(s, f, o);
+    in2_a2(s, o);
     tcg_gen_qemu_ld32u(o->in2, o->in2, get_mem_index(s));
 }
 #define SPEC_in2_m2_32u 0
 
 #ifndef CONFIG_USER_ONLY
-static void in2_m2_32ua(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_m2_32ua(DisasContext *s, DisasOps *o)
 {
-    in2_a2(s, f, o);
+    in2_a2(s, o);
     tcg_gen_qemu_ld_tl(o->in2, o->in2, get_mem_index(s), MO_TEUL | MO_ALIGN);
 }
 #define SPEC_in2_m2_32ua 0
 #endif
 
-static void in2_m2_64(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_m2_64(DisasContext *s, DisasOps *o)
 {
-    in2_a2(s, f, o);
+    in2_a2(s, o);
     tcg_gen_qemu_ld64(o->in2, o->in2, get_mem_index(s));
 }
 #define SPEC_in2_m2_64 0
 
 #ifndef CONFIG_USER_ONLY
-static void in2_m2_64a(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_m2_64a(DisasContext *s, DisasOps *o)
 {
-    in2_a2(s, f, o);
+    in2_a2(s, o);
     tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEQ | MO_ALIGN);
 }
 #define SPEC_in2_m2_64a 0
 #endif
 
-static void in2_mri2_16u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_mri2_16u(DisasContext *s, DisasOps *o)
 {
-    in2_ri2(s, f, o);
+    in2_ri2(s, o);
     tcg_gen_qemu_ld16u(o->in2, o->in2, get_mem_index(s));
 }
 #define SPEC_in2_mri2_16u 0
 
-static void in2_mri2_32s(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_mri2_32s(DisasContext *s, DisasOps *o)
 {
-    in2_ri2(s, f, o);
+    in2_ri2(s, o);
     tcg_gen_qemu_ld32s(o->in2, o->in2, get_mem_index(s));
 }
 #define SPEC_in2_mri2_32s 0
 
-static void in2_mri2_32u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_mri2_32u(DisasContext *s, DisasOps *o)
 {
-    in2_ri2(s, f, o);
+    in2_ri2(s, o);
     tcg_gen_qemu_ld32u(o->in2, o->in2, get_mem_index(s));
 }
 #define SPEC_in2_mri2_32u 0
 
-static void in2_mri2_64(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_mri2_64(DisasContext *s, DisasOps *o)
 {
-    in2_ri2(s, f, o);
+    in2_ri2(s, o);
     tcg_gen_qemu_ld64(o->in2, o->in2, get_mem_index(s));
 }
 #define SPEC_in2_mri2_64 0
 
-static void in2_i2(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_i2(DisasContext *s, DisasOps *o)
 {
-    o->in2 = tcg_const_i64(get_field(f, i2));
+    o->in2 = tcg_const_i64(get_field(s->fields, i2));
 }
 #define SPEC_in2_i2 0
 
-static void in2_i2_8u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_i2_8u(DisasContext *s, DisasOps *o)
 {
-    o->in2 = tcg_const_i64((uint8_t)get_field(f, i2));
+    o->in2 = tcg_const_i64((uint8_t)get_field(s->fields, i2));
 }
 #define SPEC_in2_i2_8u 0
 
-static void in2_i2_16u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_i2_16u(DisasContext *s, DisasOps *o)
 {
-    o->in2 = tcg_const_i64((uint16_t)get_field(f, i2));
+    o->in2 = tcg_const_i64((uint16_t)get_field(s->fields, i2));
 }
 #define SPEC_in2_i2_16u 0
 
-static void in2_i2_32u(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_i2_32u(DisasContext *s, DisasOps *o)
 {
-    o->in2 = tcg_const_i64((uint32_t)get_field(f, i2));
+    o->in2 = tcg_const_i64((uint32_t)get_field(s->fields, i2));
 }
 #define SPEC_in2_i2_32u 0
 
-static void in2_i2_16u_shl(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_i2_16u_shl(DisasContext *s, DisasOps *o)
 {
-    uint64_t i2 = (uint16_t)get_field(f, i2);
+    uint64_t i2 = (uint16_t)get_field(s->fields, i2);
     o->in2 = tcg_const_i64(i2 << s->insn->data);
 }
 #define SPEC_in2_i2_16u_shl 0
 
-static void in2_i2_32u_shl(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_i2_32u_shl(DisasContext *s, DisasOps *o)
 {
-    uint64_t i2 = (uint32_t)get_field(f, i2);
+    uint64_t i2 = (uint32_t)get_field(s->fields, i2);
     o->in2 = tcg_const_i64(i2 << s->insn->data);
 }
 #define SPEC_in2_i2_32u_shl 0
 
 #ifndef CONFIG_USER_ONLY
-static void in2_insn(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_insn(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_const_i64(s->fields->raw_insn);
 }
@@ -6388,20 +6391,20 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
     /* Implement the instruction.  */
     if (insn->help_in1) {
-        insn->help_in1(s, &f, &o);
+        insn->help_in1(s, &o);
     }
     if (insn->help_in2) {
-        insn->help_in2(s, &f, &o);
+        insn->help_in2(s, &o);
     }
     if (insn->help_prep) {
-        insn->help_prep(s, &f, &o);
+        insn->help_prep(s, &o);
     }
     if (insn->help_op) {
         ret = insn->help_op(s, &o);
     }
     if (ret != DISAS_NORETURN) {
         if (insn->help_wout) {
-            insn->help_wout(s, &f, &o);
+            insn->help_wout(s, &o);
         }
         if (insn->help_cout) {
             insn->help_cout(s, &o);
-- 
2.20.1


