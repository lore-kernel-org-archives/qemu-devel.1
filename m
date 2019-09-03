Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20D8C3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA9E2077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7c2bezU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA9E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5AtY-0004XD-Aq
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArJ-0002fy-JQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArI-0005rS-D8
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:53098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArI-0005qz-60
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id t17so18752788wmi.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iVd97GidBnX5EUA8NaXSsqaoChyZrHqE7AWsprcf0W4=;
 b=j7c2bezUysApzjxiKA1Fg7+q3USAOjs+uU7jDbWLIO1nkbGrmjw+e3NY9b9YWP3NPt
 p8tQLFHOnfsdBxoEnvopKY9JysQAg6567lwGFqFixxrQYQceSpDNxfPx0ISIp+XW2eso
 BC4x2r20vCfdHCYg5oTUAzxGEDI54cp05piDa0xVrcvvAjaHyOKEDJINMBIlPne7Q4my
 oRkui4Cel/5Bk2U/czKhnCp60/ZOlnTEy4TpQL/nuhi5Pta7CsCHzN/WrVGr8EO8Abqm
 PyyN/xozzV+qgd0v4rsSbCw+06FFSCA5IvkCxuGjYMppZZVJC7hgBlvEeNcL1shi0w4A
 9Wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iVd97GidBnX5EUA8NaXSsqaoChyZrHqE7AWsprcf0W4=;
 b=MXfmpe5U0e4IplgE1GmYwJ9K8OeXdUqzJzrhmvPMAck5baq5/Uhypsfbqpio/nmCV1
 +dSQWu9kmpWUunGwNb+fStJiw5xWPcOKVv+rLtX/p3/VzodLT/xmBm7v0mDT0vmO7FOW
 W0hIqvBbzTejVv24CMPN3sz0QEGWS5CdSFQjF6US6gRC4eSz4KFKy5fmpZ+5rMj3YG1D
 FZ0taZs8Z8DczujGAE6wkEH6iL6X8z3kq0kaGiPYeKDYGNhjEABGD6JaV4ckZilDmCfE
 8RGFts0saVZK2Qa3J3XQiRgF0uEnNqFu9SbZu0tikoVbGli+2PSazna1xpj+gbgRUIeN
 /20Q==
X-Gm-Message-State: APjAAAWEQ8ixD1GElhv393fEhI/sEmbQDUz/Jmi5d0AbF5MH3oSLla0/
 dG0vN0oXoN+kEhjzaTBrVO8BgtSuvaNODw==
X-Google-Smtp-Source: APXvYqy5wzA1bCrwY4kV6qFpW6BoItEQH4GJ9UEVqJnCuElphjJ75fTKXKo5UfS50+7vA5wqmStyJg==
X-Received: by 2002:a1c:d142:: with SMTP id i63mr814468wmg.53.1567524998687;
 Tue, 03 Sep 2019 08:36:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:14 +0100
Message-Id: <20190903153633.6651-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL 02/21] target/arm: Factor out
 unallocated_encoding for aarch32
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Make this a static function private to translate.c.
Thus we can use the same idiom between aarch64 and aarch32
without actually sharing function implementations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190826151536.6771-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c |  3 +--
 target/arm/translate.c         | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 5065d4524cd..3e8ea80493b 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -108,8 +108,7 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 
     if (!s->vfp_enabled && !ignore_vfp_enabled) {
         assert(!arm_dc_feature(s, ARM_FEATURE_M));
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                           default_exception_el(s));
+        unallocated_encoding(s);
         return false;
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2aac9aae681..66311580c05 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1231,6 +1231,13 @@ static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
+static void unallocated_encoding(DisasContext *s)
+{
+    /* Unallocated and reserved encodings are uncategorized */
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
+}
+
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
@@ -1261,8 +1268,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         return;
     }
 
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
@@ -7574,8 +7580,7 @@ static void gen_srs(DisasContext *s,
     }
 
     if (undef) {
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                           default_exception_el(s));
+        unallocated_encoding(s);
         return;
     }
 
@@ -9196,8 +9201,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         default:
         illegal_op:
-            gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                               default_exception_el(s));
+            unallocated_encoding(s);
             break;
         }
     }
@@ -10882,8 +10886,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     return;
 illegal_op:
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
@@ -11706,8 +11709,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     return;
 illegal_op:
 undef:
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
-- 
2.20.1


