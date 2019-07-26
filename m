Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1045FC76190
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D65B622BE8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sebaT5Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65B622BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4YB-0008Ql-52
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4No-00072A-UA
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nl-0001C9-CI
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:55 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nl-000104-3L
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:53 -0400
Received: by mail-pg1-x544.google.com with SMTP id w10so25119004pgj.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4oQFd4eolp/sR05iPY07hrdPVedFpqTSb74q9tevE6Q=;
 b=sebaT5CasiTw2aM3248r1KuO5rtFcs1xBcJSCI0q1O9VXVe8TaJ5Jd4Xof3DPSkguy
 SdwPX+1iUc6OEXijV+TlXieOtSH9CiMnH1cGu8E6VElNAFU3DJEYnFwmcTj4gWP9mmUK
 /wPf2JdJDkvHEmeOaTfp+7hzDOgFzA/rI4rVIP6vSTsOnuaRjvABIpedUTv8GtfLknum
 oHRT/y2drBf5b/EDjQld8UII+U8bZ1Kbn/SQkkAPoe4cwsg5wFLzJpvvDBeONpw1ohv9
 85Klm4DDg8PXU7dbUnp8pnDjroZ3PAPrhHCZY9+1N0/7tnJA7b4VtDlNkYd9c+OuztrL
 Acag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4oQFd4eolp/sR05iPY07hrdPVedFpqTSb74q9tevE6Q=;
 b=DEs1nBHbmqVrESg3rs7bnP+O1Cyo757KEy+t7vVQPX/KFIO/25j4TvSt//NmnMjJ2B
 r9wPZH+uYwJGCqBoM+zN4GHoQEzSk6VhhT/tyG0M/bCLj7/6e9olFW+u2KvUDTik/6qo
 cuaTatRSBXJAmdFkz84o1URYOQlNWQkJuvL/MBHCdEAF7RYKynrir+veBLFqLxcSwVnz
 Xrk7YBQX4B9mVGgCjykw67cfgVDLuSXvB5w1qx76WwBEWkNpZMM58O/XMvlg36bVTgJi
 yOFDg6Beh4agwqIaVkCUlAaAI7MvAakWiYpVqYyQ8PzmyJf7PqVfvIW1TqPAPLAcsT0+
 UpUQ==
X-Gm-Message-State: APjAAAVMUbDH/56Sk5Ifcxd+DIKzv4yBpHq3v9fRlHjO8ypZ/96eQn53
 +yuoD98xxkgIlvG1F1XfCiJTY09mRgI=
X-Google-Smtp-Source: APXvYqxOzZpWyPNKSuBcQ16lQYpVyvhlX4GBRaXlcBtUC/QODCksPzzXlJgICUhsFOUPFUk30vFpbg==
X-Received: by 2002:a17:90a:d996:: with SMTP id
 d22mr99375160pjv.86.1564163498255; 
 Fri, 26 Jul 2019 10:51:38 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:18 -0700
Message-Id: <20190726175032.6769-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 53/67] target/arm: Convert T16 adjust sp
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 15 ++-------------
 target/arm/t16.decode  |  9 +++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 23f5f982f5..8dd88419fe 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10648,19 +10648,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         /* misc */
         op = (insn >> 8) & 0xf;
         switch (op) {
-        case 0:
-            /*
-             * 0b1011_0000_xxxx_xxxx
-             *  - ADD (SP plus immediate)
-             *  - SUB (SP minus immediate)
-             */
-            tmp = load_reg(s, 13);
-            val = (insn & 0x7f) * 4;
-            if (insn & (1 << 7))
-                val = -(int32_t)val;
-            tcg_gen_addi_i32(tmp, tmp, val);
-            store_sp_checked(s, tmp);
-            break;
+        case 0: /* add/sub (sp, immediate), in decodetree */
+            goto illegal_op;
 
         case 2: /* sign/zero extend.  */
             ARCH(6);
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 69d3894ba7..ddf12ada11 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -156,6 +156,15 @@ ADD_rrri        0100 0100 . .... ...            @addsub_2h s=0
 CMP_rrri        0100 0101 . .... ...            @addsub_2h s=1
 MOV_rrri        0100 0110 . .... ...            @addsub_2h s=0
 
+# Adjust SP (immediate)
+
+%imm7_0x4       0:7 !function=times_4
+@addsub_sp_i    .... .... . ....... \
+                &s_rri_rot s=0 rd=13 rn=13 rot=0 imm=%imm7_0x4
+
+ADD_rri         1011 0000 0 .......             @addsub_sp_i
+SUB_rri         1011 0000 1 .......             @addsub_sp_i
+
 # Branch and exchange
 
 @branchr        .... .... . rm:4 ...            &r
-- 
2.17.1


