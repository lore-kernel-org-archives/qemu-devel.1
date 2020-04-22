Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3616C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCACD206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcyL6Dwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCACD206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4CH-0003so-QM
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41O-0001gJ-2g
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41N-0001zK-9m
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:49 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:42611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41M-0001vh-PI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id f7so212102pfa.9
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DuJkDhPEOnaROoc/1JyNu5wUbGL/01Lw8KOKVY4KSao=;
 b=RcyL6DwgogtDh0tDQS1mF5ZYbfPbm7Z4xiv30qgO99gDnELvAxiqz9iC2CKMd6b9vn
 zHNjZPdT1mhcjKndU1B21AQb4WGx2KyooA9boeHd8VEuix5/LlFEp0vBZpBUro55FFug
 aN9PJF8GZGvurK+w9vgiL45JpmiITQ7pIp0oQT4qQ5cH59iZjzbFrmF1ZZKx+SSXir+1
 j+U3mgaVXctEKYPPX9XO/yKvYwXXVDL6+2XiAOoBqjyG6u0g/XRw6dDhoACMazsm2qWg
 //Y5+HJfjSKnLgQzJFOscWsHdhYubuz9dSxzIYN16kZauROIg1/bYtovAJfYVbpD+c7V
 3tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DuJkDhPEOnaROoc/1JyNu5wUbGL/01Lw8KOKVY4KSao=;
 b=pyqQQFhjG1243t8KItS4xIq5rit+PUN6clTpmMTdG66rtE17PUQvjNZyllIhGNX2oN
 2eUFFaQN2mYsW8gPmNZsx9nNMfQNljUJ8XSqytVw/tkHLqRIXRuBgEjUOibO+Wb+IG18
 M8Zer3LgEvAN+fwByhypAItHXuVd4aGgIqQ0KsR90OsyqRuKBA5758N583CO3bfYcHTT
 gx0j7LRrRze7Xn6E9/BrL8R8try0VDU0avjtvcHXucQt5vu8m2QxS7fcLmyX0VOR0vPO
 gQzpcmqso8d+OuDJnxxVts6SkqBjY/HpV9vQvGk9wrLMZc0tFkZ0lV9A2cdCpPOmY3+b
 8J7w==
X-Gm-Message-State: AGi0PuZRZA/ZxbCilxUkGTl5JWSJfhjIi6E8XDr/DO8TzWSuSlAmgu3Z
 NrLrNMY8Fkd7qpFXeuH44+5Bcm0far0=
X-Google-Smtp-Source: APiQypI+JELYpTYHu3zV+yY8sAJ8tVl8qlWcce0kv3uYBvid+3d+bbroi0IJXzeGdjKdUJnsxBv58A==
X-Received: by 2002:aa7:9e07:: with SMTP id y7mr18435551pfq.257.1587518266036; 
 Tue, 21 Apr 2020 18:17:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/36] tcg/optimize: Adjust TempOptInfo allocation
Date: Tue, 21 Apr 2020 18:17:03 -0700
Message-Id: <20200422011722.13287-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::434
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not allocate a large block for indexing.  Instead, allocate
for each temporary as they are seen.

In general, this will use less memory, if we consider that most
TBs do not touch every target register.  This also allows us to
allocate TempOptInfo for new temps created during optimization.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 60 ++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b86bf3d707..d36d7e1d7f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -89,35 +89,41 @@ static void reset_temp(TCGArg arg)
 }
 
 /* Initialize and activate a temporary.  */
-static void init_ts_info(TempOptInfo *infos,
-                         TCGTempSet *temps_used, TCGTemp *ts)
+static void init_ts_info(TCGTempSet *temps_used, TCGTemp *ts)
 {
     size_t idx = temp_idx(ts);
-    if (!test_bit(idx, temps_used->l)) {
-        TempOptInfo *ti = &infos[idx];
+    TempOptInfo *ti;
 
+    if (test_bit(idx, temps_used->l)) {
+        return;
+    }
+    set_bit(idx, temps_used->l);
+
+    ti = ts->state_ptr;
+    if (ti == NULL) {
+        ti = tcg_malloc(sizeof(TempOptInfo));
         ts->state_ptr = ti;
-        ti->next_copy = ts;
-        ti->prev_copy = ts;
-        if (ts->kind == TEMP_CONST) {
-            ti->is_const = true;
-            ti->val = ti->mask = ts->val;
-            if (TCG_TARGET_REG_BITS > 32 && ts->type == TCG_TYPE_I32) {
-                /* High bits of a 32-bit quantity are garbage.  */
-                ti->mask |= ~0xffffffffull;
-            }
-        } else {
-            ti->is_const = false;
-            ti->mask = -1;
+    }
+
+    ti->next_copy = ts;
+    ti->prev_copy = ts;
+    if (ts->kind == TEMP_CONST) {
+        ti->is_const = true;
+        ti->val = ts->val;
+        ti->mask = ts->val;
+        if (TCG_TARGET_REG_BITS > 32 && ts->type == TCG_TYPE_I32) {
+            /* High bits of a 32-bit quantity are garbage.  */
+            ti->mask |= ~0xffffffffull;
         }
-        set_bit(idx, temps_used->l);
+    } else {
+        ti->is_const = false;
+        ti->mask = -1;
     }
 }
 
-static void init_arg_info(TempOptInfo *infos,
-                          TCGTempSet *temps_used, TCGArg arg)
+static void init_arg_info(TCGTempSet *temps_used, TCGArg arg)
 {
-    init_ts_info(infos, temps_used, arg_temp(arg));
+    init_ts_info(temps_used, arg_temp(arg));
 }
 
 static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
@@ -603,9 +609,8 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
-    int nb_temps, nb_globals;
+    int nb_temps, nb_globals, i;
     TCGOp *op, *op_next, *prev_mb = NULL;
-    TempOptInfo *infos;
     TCGTempSet temps_used;
 
     /* Array VALS has an element for each temp.
@@ -615,12 +620,15 @@ void tcg_optimize(TCGContext *s)
 
     nb_temps = s->nb_temps;
     nb_globals = s->nb_globals;
+
     bitmap_zero(temps_used.l, nb_temps);
-    infos = tcg_malloc(sizeof(TempOptInfo) * nb_temps);
+    for (i = 0; i < nb_temps; ++i) {
+        s->temps[i].state_ptr = NULL;
+    }
 
     QTAILQ_FOREACH_SAFE(op, &s->ops, link, op_next) {
         tcg_target_ulong mask, partmask, affected;
-        int nb_oargs, nb_iargs, i;
+        int nb_oargs, nb_iargs;
         TCGArg tmp;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
@@ -633,14 +641,14 @@ void tcg_optimize(TCGContext *s)
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
                 TCGTemp *ts = arg_temp(op->args[i]);
                 if (ts) {
-                    init_ts_info(infos, &temps_used, ts);
+                    init_ts_info(&temps_used, ts);
                 }
             }
         } else {
             nb_oargs = def->nb_oargs;
             nb_iargs = def->nb_iargs;
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
-                init_arg_info(infos, &temps_used, op->args[i]);
+                init_arg_info(&temps_used, op->args[i]);
             }
         }
 
-- 
2.20.1


