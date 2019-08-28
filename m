Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77497C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4123522CF8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtuNrN1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4123522CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33zm-0007uR-5Q
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gl-0003tu-4A
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gj-0000bT-1C
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gh-0000YI-SI
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:08 -0400
Received: by mail-pf1-x441.google.com with SMTP id q139so366510pfc.13
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wUg3Ac9PvzNEESjTwEzJ5fyzbN8R44LkSXDRtI42CUw=;
 b=XtuNrN1C2ND15RPwA7ok7e2aRBxivSQBLyXG+Op/axT6OLiqFd1Hugy2J3I9/PdbLi
 okIsW3uP9Gs+O9erAVPL/55US8ugU48CrH9mZahKdsz7zJI+DqiANzIvXHLG8XrEFfpB
 kIgmvYcKqL33LLwomZOJzp7cyr6TZRsvOKUp/gMGC/+wACQ0bQsj6/yoH6mTXuJhAtE8
 mlMcwiNf1Hb6+MXGr4vAH49eKOMZTKrixnjpOwIjM5m+8stEvKhnw/Uu2dHQhA8X/fcq
 anCOK5vvzUjK8DxOqFRviQP9UV3x1l4PkfmHvYvjYGbmkb0KqNwuvCWh47w8Hhl5imDk
 fC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wUg3Ac9PvzNEESjTwEzJ5fyzbN8R44LkSXDRtI42CUw=;
 b=VuC/8LT4YHblyQCs7cmgib9eso/2Jfb/fMnvbPcFOJnTl9wgSl+CNC7q1niv1m2gkj
 TjzmhPZsLmI221iRIGH3PwWyngFapcpaH0T6NdnECS/+HP0Qsnh9pcBmokzFSE6SogkH
 R1vHZOSPctSDWlBBvzaFdJYZ5N02fNu/V0Ymd6dyNFzAe3+3ld7gI/E7OmFyBHFU2tEK
 b/on2R53m1UABBRGB5VcYgnqkzyycVaRXRY7YSfERGpLkWz6BUJXBAEFCGBC2zVipb2H
 X/BCkYAva1V4XQiO33nEWQduEPKhSlK7o9N+XIjCceEb1ygjRjTKJfs8iMIAMbVzv/UP
 iLkw==
X-Gm-Message-State: APjAAAVb7/M9yinymQptOJ/AP4iNQ0MJOLg3qSUIMkF9iorl7Ghh4SBc
 JFIkFMf39jY3Whwedmdc6GJ73a1tRRs=
X-Google-Smtp-Source: APXvYqzGbMDp4wbRb2uy53Ntz1PB4zbK3fDSKRk4u4mWx4yfxjRNYxpg70vL8lYKru0BQMoM33TKtg==
X-Received: by 2002:a63:184b:: with SMTP id 11mr5028707pgy.112.1567019164939; 
 Wed, 28 Aug 2019 12:06:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:38 -0700
Message-Id: <20190828190456.30315-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 51/69] target/arm: Convert T16 add/sub (3
 low, 2 low and imm)
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 ++------------------------
 target/arm/t16.decode  | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b6ee123bf5..fa6892d6af 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10668,31 +10668,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
              * 0b0001_1xxx_xxxx_xxxx
              *  - Add, subtract (three low registers)
              *  - Add, subtract (two low registers and immediate)
+             * In decodetree.
              */
-            rn = (insn >> 3) & 7;
-            tmp = load_reg(s, rn);
-            if (insn & (1 << 10)) {
-                /* immediate */
-                tmp2 = tcg_temp_new_i32();
-                tcg_gen_movi_i32(tmp2, (insn >> 6) & 7);
-            } else {
-                /* reg */
-                rm = (insn >> 6) & 7;
-                tmp2 = load_reg(s, rm);
-            }
-            if (insn & (1 << 9)) {
-                if (s->condexec_mask)
-                    tcg_gen_sub_i32(tmp, tmp, tmp2);
-                else
-                    gen_sub_CC(tmp, tmp, tmp2);
-            } else {
-                if (s->condexec_mask)
-                    tcg_gen_add_i32(tmp, tmp, tmp2);
-                else
-                    gen_add_CC(tmp, tmp, tmp2);
-            }
-            tcg_temp_free_i32(tmp2);
-            store_reg(s, rd, tmp);
+            goto illegal_op;
         } else {
             /* shift immediate */
             rm = (insn >> 3) & 7;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index a7a437f930..2b5f368d31 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -117,3 +117,19 @@ ADD_rri         10101 rd:3 ........ \
 
 STM             11000 ... ........              @ldstm
 LDM_t16         11001 ... ........              @ldstm
+
+# Add/subtract (three low registers)
+
+@addsub_3       ....... rm:3 rn:3 rd:3 \
+                &s_rrr_shi %s shim=0 shty=0
+
+ADD_rrri        0001100 ... ... ...             @addsub_3
+SUB_rrri        0001101 ... ... ...             @addsub_3
+
+# Add/subtract (two low registers and immediate)
+
+@addsub_2i      ....... imm:3 rn:3 rd:3 \
+                &s_rri_rot %s rot=0
+
+ADD_rri         0001 110 ... ... ...            @addsub_2i
+SUB_rri         0001 111 ... ... ...            @addsub_2i
-- 
2.17.1


