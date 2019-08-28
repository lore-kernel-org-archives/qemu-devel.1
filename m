Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795CCC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D71B20679
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwqrKVKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D71B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33Ij-0005Zz-8T
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fe-0002vo-FV
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fd-00084Q-Dp
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:02 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Fd-00083l-7E
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:01 -0400
Received: by mail-pg1-x541.google.com with SMTP id p3so210099pgb.9
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jAqvd/2BIuSZJ/quAHqjRlBcC779AH2rhSu4pCUKbkY=;
 b=cwqrKVKkM5ZDHJULoLzd1MCeKIvJCsqMAGtjwM1WNM7n+rhC4YXa/ccKWJkv8YEMmv
 JjWU2O2Bq3SUEmz01uGx2lSLb7aa9rdCDAQ2kIW1/M4VeXP4EYwSpzagpH8tz8sqM4Sh
 d7p7jC+crnZ1u4+rIfNMhw7u181jPTsCIhLo5nhE00FXC7B+oTl8tqR9VQEeqIQ9XS2Y
 1HeQggQK+WwyhcTUeswIOq8q7EONBd+EHc/3uIZuw53/DQMK5WOyMk+zErSrXcxA/s2S
 WBODvBSQZKLE397QAmOKFPtUFwzrmk1C4pjmsH3+PJji+XpTsrRGXqBlMwtQ2GsmuzwY
 AqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jAqvd/2BIuSZJ/quAHqjRlBcC779AH2rhSu4pCUKbkY=;
 b=WUb4YnYwtxQpQakR1j0Lx2HTKkU7j8Oyk+08bMHK0Fn6tjpnNKI/2CjElDMHJSsbfi
 UfsBnHsJjHCOPrpCzmPMmGgK6noPXTKXcdr9a+vX2jPqI3M3iaFsxtoyuhlSzEGrXzFd
 fG2KrYIxV9Ityd56YrY4bbsVLnFZYjmJ+CJSSHv1JAJHrTSazXT3QIqFLj4kYJbWVzgc
 RspENH/fsaTrVvuX47a7lamEpZokU/GOvT86nqUuYfWYX6xNg3uMJfD7Ve5IXg87u+O6
 /8Vo6vzReZqSbB9JS/n38hqkUd4GSMWE22wmVe9F5is9A6IgFkC7UB5c8uGQ8pyKPtjR
 2/8w==
X-Gm-Message-State: APjAAAUd4Zq2uV7cNjVxMzlxMK19wSxyHUlZKD7300iqoxhbvl8OB6g8
 7fTKlqnD809EGBz5Hu81aO+JhtiBCb8=
X-Google-Smtp-Source: APXvYqyXqw2otp/bOrb2PgK0HPRFqbBNvbB2HqaOa66IZlx7F+1wOcGEqFSOLuVRubqm5QXlCEZNew==
X-Received: by 2002:a62:e516:: with SMTP id n22mr6559250pff.105.1567019099849; 
 Wed, 28 Aug 2019 12:04:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:04:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:03:48 -0700
Message-Id: <20190828190456.30315-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 01/69] target/arm: Use store_reg_from_load
 in thumb2 code
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function already includes the test for an interworking write
to PC from a load.  Change the T32 LDM implementation to match the
A32 LDM implementation.

For LDM, the reordering of the tests does not change valid
behaviour because the only case that differs is has rn == 15,
which is UNPREDICTABLE.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index cbe19b7a62..35e59a8a16 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9707,13 +9707,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         /* Load.  */
                         tmp = tcg_temp_new_i32();
                         gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                        if (i == 15) {
-                            gen_bx_excret(s, tmp);
-                        } else if (i == rn) {
+                        if (i == rn) {
                             loaded_var = tmp;
                             loaded_base = 1;
                         } else {
-                            store_reg(s, i, tmp);
+                            store_reg_from_load(s, i, tmp);
                         }
                     } else {
                         /* Store.  */
@@ -10847,11 +10845,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 tcg_temp_free_i32(addr);
                 goto illegal_op;
             }
-            if (rs == 15) {
-                gen_bx_excret(s, tmp);
-            } else {
-                store_reg(s, rs, tmp);
-            }
+            store_reg_from_load(s, rs, tmp);
         } else {
             /* Store.  */
             tmp = load_reg(s, rs);
-- 
2.17.1


