Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B599C41517
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A39121842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTiaH8qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A39121842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4V7-00059c-2F
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58513)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NJ-0004ht-ED
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NF-0000P8-P1
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:33288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NF-0000Fa-EK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:21 -0400
Received: by mail-pl1-x633.google.com with SMTP id c14so24959377plo.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VzkvUsUZh9EVbOcurylb0EvE0t9ji9eIajoY1fu0OlU=;
 b=JTiaH8qg13W5L7ZBXSUJXBfgCem9ARL1uiQFgjSz3GSsuW+K63GFGoVMb1eXI/kHqS
 j5hIjUWGgN1EPPkz2rr1n64pKilRQCsxioGELbw3wawI+4wddJNXnP1nhoWD8pNmyV+C
 mNdpGdJaP81pZoxCI7PxFV7p6yVbbTITfQIw2go7rFoCe9x7xUaeBIACssl/3OzYWVCu
 ZY+9QXhV0w6pPtg4I9FY8QkZLOQp4g2sbKK8TBKlGAtn5myrOZEnDGIg/POrKhl92QWA
 8lj0WeCyZz+FbWjo0mJ9pL4EKimeh8qPjin+JDCX8JxUhY/7WK2QK+16mujg8FbpX1GH
 n4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VzkvUsUZh9EVbOcurylb0EvE0t9ji9eIajoY1fu0OlU=;
 b=gxUILojchfA4QTkL5IoKzKIYUB9Z9AgrWExrmVNdHBgvTdHTGzZRW9UfcOHGtALPIy
 Jbbs7TyUmp8TtU9ogHOrIh0YPcWOlYCG5tlITIfIr6gM2j7pa44Jxrh1loxx3yh8gfkk
 LJ7Wv2fRLMb2dmwEKdEC4kEMleLblM92oPUDZFgDoa8b7wnNSsUkjGb4b2HM8OudE2hy
 JKy4/DS/0BD9GhBn2rqxOhGlPCzC9teFVWD4LplzVBstohx5xBDOUZEPuFinDLf7kUji
 6NzWp0LUF9VTB33ztJTu0p3Yhln1waqrtYVlwTkpIOdly2LEQWJ7RD2w12+rJXl36qQQ
 HeRQ==
X-Gm-Message-State: APjAAAUlzJkIcwHKfKOSAABC5Z88Fz7zHTdhpiU+QKsPB7Ez1IlcNsQZ
 F/YXys8mHQEGZ8AXrY7wtA2idnrn7w8=
X-Google-Smtp-Source: APXvYqxWWCMF/SkQ5z4AGVssYKZpV0IvQ5lNu0WWehVYQr1IZCsGOhBghnGhwiVr2MoONTwazEpk0g==
X-Received: by 2002:a17:902:aa83:: with SMTP id
 d3mr94715985plr.74.1564163473666; 
 Fri, 26 Jul 2019 10:51:13 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:58 -0700
Message-Id: <20190726175032.6769-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: [Qemu-devel] [PATCH 33/67] target/arm: Convert Clear-Exclusive,
 Barriers
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
 target/arm/translate.c       | 122 +++++++++++++++--------------------
 target/arm/a32-uncond.decode |  10 +++
 target/arm/t32.decode        |  10 +++
 3 files changed, 73 insertions(+), 69 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b43b344f96..797e8f7344 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10049,6 +10049,58 @@ static bool trans_SRS(DisasContext *s, arg_SRS *a)
     return true;
 }
 
+/*
+ * Clear-Exclusive, Barriers
+ */
+
+static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
+{
+    if (!ENABLE_ARCH_6K) {
+        return false;
+    }
+    gen_clrex(s);
+    return true;
+}
+
+static bool trans_DSB(DisasContext *s, arg_DSB *a)
+{
+    if (!s->thumb && !ENABLE_ARCH_7) {
+        return false;
+    }
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+    return true;
+}
+
+static bool trans_DMB(DisasContext *s, arg_DMB *a)
+{
+    return trans_DSB(s, NULL);
+}
+
+static bool trans_ISB(DisasContext *s, arg_ISB *a)
+{
+    /*
+     * We need to break the TB after this insn to execute
+     * self-modifying code correctly and also to take
+     * any pending interrupts immediately.
+     */
+    gen_goto_tb(s, 0, s->pc & ~1);
+    return true;
+}
+
+static bool trans_SB(DisasContext *s, arg_SB *a)
+{
+    if (!dc_isar_feature(aa32_sb, s)) {
+        return false;
+    }
+    /*
+     * TODO: There is no speculation barrier opcode
+     * for TCG; MB and end the TB instead.
+     */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+    gen_goto_tb(s, 0, s->pc & ~1);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10142,38 +10194,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 s->base.is_jmp = DISAS_UPDATE;
             }
             return;
-        } else if ((insn & 0x0fffff00) == 0x057ff000) {
-            switch ((insn >> 4) & 0xf) {
-            case 1: /* clrex */
-                ARCH(6K);
-                gen_clrex(s);
-                return;
-            case 4: /* dsb */
-            case 5: /* dmb */
-                ARCH(7);
-                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                return;
-            case 6: /* isb */
-                /* We need to break the TB after this insn to execute
-                 * self-modifying code correctly and also to take
-                 * any pending interrupts immediately.
-                 */
-                gen_goto_tb(s, 0, s->pc & ~1);
-                return;
-            case 7: /* sb */
-                if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
-                    goto illegal_op;
-                }
-                /*
-                 * TODO: There is no speculation barrier opcode
-                 * for TCG; MB and end the TB instead.
-                 */
-                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                gen_goto_tb(s, 0, s->pc & ~1);
-                return;
-            default:
-                goto illegal_op;
-            }
         } else if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
@@ -10636,43 +10656,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                             gen_set_psr_im(s, offset, 0, imm);
                         }
                         break;
-                    case 3: /* Special control operations.  */
-                        if (!arm_dc_feature(s, ARM_FEATURE_V7) &&
-                            !arm_dc_feature(s, ARM_FEATURE_M)) {
-                            goto illegal_op;
-                        }
-                        op = (insn >> 4) & 0xf;
-                        switch (op) {
-                        case 2: /* clrex */
-                            gen_clrex(s);
-                            break;
-                        case 4: /* dsb */
-                        case 5: /* dmb */
-                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                            break;
-                        case 6: /* isb */
-                            /* We need to break the TB after this insn
-                             * to execute self-modifying code correctly
-                             * and also to take any pending interrupts
-                             * immediately.
-                             */
-                            gen_goto_tb(s, 0, s->pc & ~1);
-                            break;
-                        case 7: /* sb */
-                            if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
-                                goto illegal_op;
-                            }
-                            /*
-                             * TODO: There is no speculation barrier opcode
-                             * for TCG; MB and end the TB instead.
-                             */
-                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                            gen_goto_tb(s, 0, s->pc & ~1);
-                            break;
-                        default:
-                            goto illegal_op;
-                        }
-                        break;
+                    case 3: /* Special control operations, in decodetree */
                     case 4: /* bxj, in decodetree */
                     case 5: /* eret, in decodetree */
                     case 6: /* MRS, in decodetree */
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index 3b961233e5..b077958cec 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -22,6 +22,7 @@
 # All of those that have a COND field in insn[31:28] are in a32.decode
 #
 
+&empty           !extern
 &i               !extern imm
 
 # Branch with Link and Exchange
@@ -37,3 +38,12 @@ BLX_i            1111 101 . ........................          &i imm=%imm24h
 
 RFE              1111 100 pu:2 0 w:1 1 rn:4 0000 1010 0000 0000   &rfe
 SRS              1111 110 pu:2 1 w:1 0 1101 0000 0101 000 mode:5  &srs
+
+# Clear-Exclusive, Barriers
+
+# QEMU does not require the option field for the barriers.
+CLREX            1111 0101 0111 1111 1111 0000 0001 1111
+DSB              1111 0101 0111 1111 1111 0000 0100 ----
+DMB              1111 0101 0111 1111 1111 0000 0101 ----
+ISB              1111 0101 0111 1111 1111 0000 0110 ----
+SB               1111 0101 0111 1111 1111 0000 0111 0000
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 26b51c3bb2..9fe1500fe0 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -306,6 +306,16 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
       # of the space is "reserved hint, behaves as nop".
       NOP        1111 0011 1010 1111 1000 0000 ---- ----
     }
+
+    # Miscelaneous control
+    {
+      CLREX      1111 0011 1011 1111 1000 1111 0010 1111
+      DSB        1111 0011 1011 1111 1000 1111 0100 ----
+      DMB        1111 0011 1011 1111 1000 1111 0101 ----
+      ISB        1111 0011 1011 1111 1000 1111 0110 ----
+      SB         1111 0011 1011 1111 1000 1111 0111 0000
+    }
+
     # Note that the v7m insn overlaps both the normal and banked insn.
     {
       MRS_bank   1111 0011 111 r:1 .... 1000 rd:4   001. 0000  \
-- 
2.17.1


