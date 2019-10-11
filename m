Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AEFECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB3F206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B49Z/cTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB3F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxgO-0007Jq-5R
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxH0-0002iD-4N
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGy-0007pM-TG
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:09 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:36925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGy-0007os-Pa
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:08 -0400
Received: by mail-yw1-xc44.google.com with SMTP id m7so3648756ywe.4
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cl2cwLMmZGvzhfN3CV68TLR9Wvkj57GFOp1995kUBYY=;
 b=B49Z/cTCHUm2tttXa2Kqx7xjEb91HMFOUpd2mgGzAjop/aq5kUs/1WoYQR2ENO0+ux
 E9zyUvimlJzur/K08AvVyeE3riN3VpaFRsnv7qviOVK1OMyf4IRc8kcPi7G6oQQJS/iM
 6NiqlhZi1DNxr5vrSlsL6tov8J4s31/1XqoRhA56SnJ5IkZzhmX4+hnlJYFCdsp5cmB+
 HThBU1QgUJA8GXqzm2QzpiJu3jumYabNEM5m70386s/g7XjeLkGMfSzgS97sORNCR955
 eAd12by+4L4IkGbpGJVI6HdOrDHLQHFOwyNBhTmDyj1lxZj/999QAuvMsCMbZPv9SKh8
 mX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cl2cwLMmZGvzhfN3CV68TLR9Wvkj57GFOp1995kUBYY=;
 b=PfDxf8qZKGzGqOjqVcIn8o/lC3hoTyQR1WppvFwiVMKrpswWaHNqjTI8ejAP95NYPD
 FAYN4a2nIskoxv6C2LY2QciU5AwuijP+rbCk7nZYHNJ29gQLFC3RMq8tgL5saXk+VOOX
 zegynCznfW0wXE9OeW784Ys8RZv674mjFEN5cgIY4m26TJLiwXUtVndA2XuwR/Bdswg3
 LaRzTxZydutS1XZxrvCz7o9h7kRzO5g38RDs7QCb14e32vnFidLgK5D/tZL051yY4IHY
 ofLPBo/qkD8wTaMoB+nzPcXEw51qvuacZf4jhJmQJ1cd+qqGUNQ6gVUuuU8Bs+SDxpAU
 BF0w==
X-Gm-Message-State: APjAAAXHmtLFbBXsg6o1lQ7agLY2SZdSqf2Pw1W86a59mB+6UQArKY8g
 sxh3x2AlBeIIuEZkMf//fenkfOAS2eI=
X-Google-Smtp-Source: APXvYqxjEiQp0d2g2BdkGJA+7WZkCvkXbF8R8hwoTRrm9N1Z7Q3Sy+QPF8/v91zzj6hzIJKxCiTONw==
X-Received: by 2002:a0d:d956:: with SMTP id b83mr3097689ywe.68.1570809367858; 
 Fri, 11 Oct 2019 08:56:07 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:56:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 17/20] target/arm: Rebuild hflags at MSR writes
Date: Fri, 11 Oct 2019 11:55:43 -0400
Message-Id: <20191011155546.14342-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 13 +++++++++++--
 target/arm/translate.c     | 28 +++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2d6cd09634..d4bebbe629 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1789,8 +1789,17 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
     if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) */
         s->base.is_jmp = DISAS_UPDATE;
-    } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
-        /* We default to ending the TB on a coprocessor register write,
+    }
+    if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
+        /*
+         * A write to any coprocessor regiser that ends a TB
+         * must rebuild the hflags for the next TB.
+         */
+        TCGv_i32 tcg_el = tcg_const_i32(s->current_el);
+        gen_helper_rebuild_hflags_a64(cpu_env, tcg_el);
+        tcg_temp_free_i32(tcg_el);
+        /*
+         * We default to ending the TB on a coprocessor register write,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 698c594e8c..cb47cd9744 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6890,6 +6890,8 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
     ri = get_arm_cp_reginfo(s->cp_regs,
             ENCODE_CP_REG(cpnum, is64, s->ns, crn, crm, opc1, opc2));
     if (ri) {
+        bool need_exit_tb;
+
         /* Check access permissions */
         if (!cp_access_ok(s->current_el, ri, isread)) {
             return 1;
@@ -7068,14 +7070,30 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             }
         }
 
-        if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
-            /* I/O operations must end the TB here (whether read or write) */
-            gen_lookup_tb(s);
-        } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
-            /* We default to ending the TB on a coprocessor register write,
+        /* I/O operations must end the TB here (whether read or write) */
+        need_exit_tb = ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) &&
+                        (ri->type & ARM_CP_IO));
+
+        if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
+            /*
+             * A write to any coprocessor regiser that ends a TB
+             * must rebuild the hflags for the next TB.
+             */
+            TCGv_i32 tcg_el = tcg_const_i32(s->current_el);
+            if (arm_dc_feature(s, ARM_FEATURE_M)) {
+                gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
+            } else {
+                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
+            }
+            tcg_temp_free_i32(tcg_el);
+            /*
+             * We default to ending the TB on a coprocessor register write,
              * but allow this to be suppressed by the register definition
              * (usually only necessary to work around guest bugs).
              */
+            need_exit_tb = true;
+        }
+        if (need_exit_tb) {
             gen_lookup_tb(s);
         }
 
-- 
2.17.1


