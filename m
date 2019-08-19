Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578C6C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2094D20578
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grW2OU+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2094D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq2J-0002Vu-5I
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMi-0002VV-S8
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMh-0006h7-Ch
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:36931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMf-0006em-9r
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:59 -0400
Received: by mail-pf1-x42f.google.com with SMTP id 129so1947313pfa.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fWWvdDru9knlRm6IuiK5xbgxCPFGSOj1TibiqgY2wt8=;
 b=grW2OU+wjg/5blRzRrGgbm6QX4+AxMXafojAUOXf/h/bJW41xxALJFqKvkV9qG5ix8
 +IVCedUWBAVE+xyVpar6Xcw/VcYj3Jf+sSFlvgr654a/rGMqjAM4eY17yJat4Jw8lUve
 QNQZLPHKWSgT4asBLpPLIwiezLISqCO5o2n2mHQKmU83ivFwZcVw7UAkTgXA2YBHHklg
 NNURNx8hYC9IlelKGc/iknMcOjBPiOBqHhf3jrKlHgeXDe1ByyNmElFnhJGCNsubmCe0
 fKaIVulbcK0mvnet4b4+gzg5Jcg1/kEP5fwZTV3k1ckIGv8jGTgn9N25QcGOhctWD8na
 lu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fWWvdDru9knlRm6IuiK5xbgxCPFGSOj1TibiqgY2wt8=;
 b=UqMW/8anZtrrvwHNiX2Cpxx/Bm+s6tV4sDiQVMa5/neZYWPowaZMcw35D0zRLlutf1
 1emUGbPzBzPNL0ibVamgBxiJIW10YMjvClOJSHeWxaIKoLTJYS1kAEvGLbBeUTNdq5qw
 lkc/FsWoTcjOckrlzuJUtddS9gZxjjqJHs02s91mLTvoC4/psU3PPrVBtANHA1lp0wEX
 FA7R4CIyYJOKZPIA7TRtSu7t9iXgqdA6o5e3w3M7sYGmFIvBAuJLt2kN/Ka14gxK9O8a
 MKgtfgeDoKPMMX7MASiNp6Haani37K/LPjjHOyms5qbcOkWxN4SWLkJR5OAF7x8561Ma
 t2vg==
X-Gm-Message-State: APjAAAUJT0kwobb+pCKvIpcSmKSfgGrmaZZyAI8e8wUoQ8VCS9MeeY6D
 NVGF8MVFGINzntKRTHSy7Y9qMCSnijc=
X-Google-Smtp-Source: APXvYqw3kP0fBOMR2QxGwg4rTdOZzZjotyZ60YLKajzAjZQ3nrk7zY8fOTmDpHBTtxyZ55s9jgrbbg==
X-Received: by 2002:aa7:8c57:: with SMTP id e23mr15883178pfd.48.1566250735751; 
 Mon, 19 Aug 2019 14:38:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:35 -0700
Message-Id: <20190819213755.26175-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
Subject: [Qemu-devel] [PATCH v2 48/68] target/arm: Convert T16 add pc/sp
 (immediate)
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 12 +-----------
 target/arm/t16.decode  |  7 +++++++
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 24537fc107..2640f50fcf 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10749,19 +10749,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 7: /* load/store byte immediate offset, in decodetree */
     case 8: /* load/store halfword immediate offset, in decodetree */
     case 9: /* load/store from stack, in decodetree */
+    case 10: /* add PC/SP (immediate), in decodetree */
         goto illegal_op;
 
-    case 10:
-        /*
-         * 0b1010_xxxx_xxxx_xxxx
-         *  - Add PC/SP (immediate)
-         */
-        rd = (insn >> 8) & 7;
-        val = (insn & 0xff) * 4;
-        tmp = add_reg_for_lit(s, insn & (1 << 11) ? 13 : 15, val);
-        store_reg(s, rd, tmp);
-        break;
-
     case 11:
         /* misc */
         op = (insn >> 8) & 0xf;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 1cf79789ac..71b3e8f02e 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -23,6 +23,7 @@
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
+&ri              !extern rd imm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
 
@@ -102,3 +103,9 @@ LDRH_ri         10001 ..... ... ...             @ldst_ri_2
 
 STR_ri          10010 ... ........              @ldst_spec_i rn=13
 LDR_ri          10011 ... ........              @ldst_spec_i rn=13
+
+# Add PC/SP (immediate)
+
+ADR             10100 rd:3 ........             imm=%imm8_0x4
+ADD_rri         10101 rd:3 ........ \
+                &s_rri_rot rn=13 s=0 rot=0 imm=%imm8_0x4  # SP
-- 
2.17.1


