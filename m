Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A80BC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B01721842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBcpfWh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B01721842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4bJ-00031X-Gb
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59725)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nv-0007Vx-G1
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nt-0001Ow-Vy
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:03 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nt-00010K-LP
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:01 -0400
Received: by mail-pg1-x543.google.com with SMTP id s1so18806513pgr.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zTUDYR2hU4ZALOUVF4vngOslrJ4X/C4rxl23t5JZO3Q=;
 b=IBcpfWh5F6SICO8ZNgo7HTWDEj65hPbOmjwpHDMPOSCTbQdQto+AG5lDVWE1kScYkY
 rEsUNeJv4bBFCbT66tWGHDNt+d0xjQ/OB9MQdoTN+F/1CPHGwOBZ3boZbOttYIDTYNsh
 PTmM0DBzE0+7rqSNGOfyl8V5z6oueULbw4QzVAOk+njVXlGr6WsSRMS16e8bi46V+NgY
 od0S5QvWjed+z6Qr/bSITXm52QCaEWcF4h1c92XYLvDWqCm8zaDNUmo+kP4TJvAyWXTL
 wZL411752OUL9vsnDENcfUJhWQ4PLhmiKZxUrZYiGTzCycnozF00YUPxnAXEFN0wttuH
 9Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zTUDYR2hU4ZALOUVF4vngOslrJ4X/C4rxl23t5JZO3Q=;
 b=qWuKciOTBgUp44THfd2OYFQsPHpBsEvPJdNDve0gj3t80YqWIVIGIJ7mqpAKx/YlmV
 N1WofbG0o7d0sV5oOQGVx0iH8imL1ZafV136cMVeB4Va1jjGLMfp3r1lDkmGlVZ+3Pxp
 iC51jM60sjgQDtxcEEAROzrusNHjtQ0nnVPuRgz4S7Vp2PlkDzDC9rsDqct8Hgx9bFtE
 0Aq1V/yCdc0VeeBWxlUwitp62MiMzhNlEHhTSwEgCgPo3i3pQKf8UjVKz396ZlTMlTlZ
 ZDB/n5PGlr8yleQhX4fEdXBgeZxD6GZ6j0QWwVuboKPurB0iJEib9i4w7kUj/nNLcIo8
 RNug==
X-Gm-Message-State: APjAAAXXJzBYU/Uevl0MLP9dK9aiHweyBqpXuysX2gjH66oFmCp5MaOb
 PJUr4LhaJQkEKszDyVMzcX0FBkmr8kU=
X-Google-Smtp-Source: APXvYqxGhPvm+WZGEC1hSI13KU6gkOPJ8HlBJZ3M4shCforb+njAXOXRIP8u16W8+u2xKiUypO1cmw==
X-Received: by 2002:a63:5c7:: with SMTP id 190mr90711195pgf.67.1564163499284; 
 Fri, 26 Jul 2019 10:51:39 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:19 -0700
Message-Id: <20190726175032.6769-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 54/67] target/arm: Convert T16, extract
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 14 +-------------
 target/arm/t16.decode  | 10 ++++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8dd88419fe..9c8e11bd3a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10649,21 +10649,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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
index ddf12ada11..1b47e804bf 100644
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


