Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445D6C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11649214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVWboJtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11649214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpui-0007Rw-Ve
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMp-0002ie-FY
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMo-0006oa-5V
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:07 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMn-0006nf-WA
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:06 -0400
Received: by mail-pf1-x444.google.com with SMTP id q139so1934188pfc.13
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IoEU+NRa2JWhajyfKqrmJYRYOBCu04dzJDGI4c2fGqA=;
 b=fVWboJtDgcblSVQ9v2jozNz5T7a1y+Km5gqHeD/FUzAxk/yHqNmBGlH/rew6l8AQkP
 QepSMzHhSmyQAUrW6clwCom0I4ZH7a4AbKrpKv3rQN9Fu392Y15uTTreWqENMsUUwzwr
 W+YsaCvFpLRS6ZSBB+jv4jA4f3kC0R8N5qRm5M3XH5LHJP/n4VV0vvNTziAWElLdv1gj
 oBdayyKMQXSYA7OOA9MLEj6CIF+DYCYJ/M7Ws2ByNvT/yMGgqlmPdS0Ciiobqe980ckv
 yGWtjiiezJW3l746Kj4Yi1uHQepYKgdb2GXyXCZ/8DAYrifELFAwCYPuqcyCJ5BI4dSV
 23yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IoEU+NRa2JWhajyfKqrmJYRYOBCu04dzJDGI4c2fGqA=;
 b=HGc0HouJIJ5Von44Plm15isphvh6RtAkuV5z1dmDT7zk/OwDYbkJkGFgIB0bXlCJ5k
 RV6dEUpS3k0wDOd510QohbW9hpTmlMjDXpzSc8Dc++ef8/kCdg9gXINlPQM8PcCYImQ3
 2NUvukefWPh4XsbYiTdXpAxxfXI/n7eDoCOSiMV/Q+NAi4hXGs0uGXFfYGyssh+A9ydc
 vUJj+q1Oqa3eq6mgrYIbrrmlTjz88F6Zgs/7zCZS0A8YnGADaMDP9HxbXgqerKgPmkVm
 nC7NjwDcIpfFA5EpdtAFirOZkkE4tDPkM+c22Vkv5jtfoqlZ+Cr/+UhsiAv3wXHJS6MY
 4Wow==
X-Gm-Message-State: APjAAAX+6u+dFMFaHbOAysjls1HvqylqYibh/6qD6UlqCFgJryLWU7zV
 XyI2/VZRj+prgiQCsO8gqAZPGXCR9hE=
X-Google-Smtp-Source: APXvYqzxNdVMXkLKBS8HlzmOZ7mE+8It6kEQtK9tFoZi6/nPr64v6B6BJdejA1q7H/ZlY2Lt+agNVw==
X-Received: by 2002:aa7:925a:: with SMTP id 26mr26491760pfp.198.1566250744805; 
 Mon, 19 Aug 2019 14:39:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:42 -0700
Message-Id: <20190819213755.26175-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 55/68] target/arm: Convert T16, extract
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
 target/arm/translate.c | 14 +-------------
 target/arm/t16.decode  | 10 ++++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index cac3893386..414c562fb3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10641,21 +10641,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         op = (insn >> 8) & 0xf;
         switch (op) {
         case 0: /* add/sub (sp, immediate), in decodetree */
+        case 2: /* sign/zero extend, in decodetree */
             goto illegal_op;
 
-        case 2: /* sign/zero extend.  */
-            ARCH(6);
-            rd = insn & 7;
-            rm = (insn >> 3) & 7;
-            tmp = load_reg(s, rm);
-            switch ((insn >> 6) & 3) {
-            case 0: gen_sxth(tmp); break;
-            case 1: gen_sxtb(tmp); break;
-            case 2: gen_uxth(tmp); break;
-            case 3: gen_uxtb(tmp); break;
-            }
-            store_reg(s, rd, tmp);
-            break;
         case 4: case 5: case 0xc: case 0xd:
             /*
              * 0b1011_x10x_xxxx_xxxx
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index b425b86795..b5b5086e8a 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -23,6 +23,7 @@
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
+&rrr_rot         !extern rd rn rm rot
 &ri              !extern rd imm
 &r               !extern rm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
@@ -173,3 +174,12 @@ BX              0100 0111 0 .... 000            @branchr
 BLX_r           0100 0111 1 .... 000            @branchr
 BXNS            0100 0111 0 .... 100            @branchr
 BLXNS           0100 0111 1 .... 100            @branchr
+
+# Extend
+
+@extend         .... .... .. rm:3 rd:3          &rrr_rot rn=15 rot=0
+
+SXTAH           1011 0010 00 ... ...            @extend
+SXTAB           1011 0010 01 ... ...            @extend
+UXTAH           1011 0010 10 ... ...            @extend
+UXTAB           1011 0010 11 ... ...            @extend
-- 
2.17.1


