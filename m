Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A2DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5182B2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GYNMcUZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5182B2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bZG-0001go-2a
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0S-000560-JW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0O-0002hT-Ev
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:52 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:43262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0O-0002gE-6s
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:48 -0400
Received: by mail-pf1-x42e.google.com with SMTP id d15so4399965pfo.10
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M4Erk2+6lG2j0nHNnlb8vKxLu6BsAo4xgf3Pb8Z6zRA=;
 b=GYNMcUZRLtjVXYbKNahv9TJRKOxR3l6UVXD+vWWBYBrbpZTY4Zdy2dgZN7/nsi9J8S
 DCQDc62T14yl0ZPdz9kNZVSnmd8BMgDsAvgR7x+aL6pjmTCT7O1aSuzUsBApn12F4Qgb
 H0AYl7Wy9Ptn9iCmWP18l4oY5sJYbXgnvOiJaRyN8vGdmYx7LtIsm4oT1BMEfhdNo3yV
 E3vj/eWlHhGodESkiPfVDio1qQRF9pmLjIxeb/fSnqJFl3/ud5Ffrd0MdEUCwTn1LAr2
 Vnzbzy26CqNtyfBJOw553cdOylsm6YgDGmq3jEYWn38jD/moYsx43vfc6YVCYV7DlZ+M
 U82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M4Erk2+6lG2j0nHNnlb8vKxLu6BsAo4xgf3Pb8Z6zRA=;
 b=G7aL7nD5kdx7Mq/PcAj12chGYiH4jr4CvEOK/yhzenrqcmfT9Usrb1tqeeAMjoe+CN
 /kwFBAq/5mkN6Y3VDhvP0CjJM0hFgNiyCO9An0hcZBz/DJfcm7lYvmj7FL50BwwoMYaW
 ofyINAX+bbmOYSt5Geg4ot8BOpCUK8eij+gtNGmUw4HOoEvsGXqWaX0YmAON0RlEhsdD
 J182pRc2CxpqROx+oiwYPE/ed3TyQwERXNR1X0SqmbGpdGHnbmcE3nlXlOo1UH9EXgsp
 DDbE6scbaUIP21FlheZJ0LovmW6CcsaxNcj6PKTBrTXQeo39puBUviddMi0bD5+DVDin
 J/rQ==
X-Gm-Message-State: APjAAAUeU6/62R5t+CMYXM6ibZpSgpkp0+MdNB21S3vDpazC3o5mYZP7
 hZD2NznHoEwwOGve9E2BRpsTu+kSmqQ=
X-Google-Smtp-Source: APXvYqw9kCH1+3cRIGWDunQC6vPbFxLf5Fprgh2OwIBTUgCwV283GFZrZofO8TAtpFlOZJHmhlyxRQ==
X-Received: by 2002:aa7:998f:: with SMTP id k15mr34497360pfh.203.1567625506689; 
 Wed, 04 Sep 2019 12:31:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:25 -0700
Message-Id: <20190904193059.26202-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
Subject: [Qemu-devel] [PATCH v4 35/69] target/arm: Convert Clear-Exclusive,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Check m-profile for all; fix missing isa check for ISB;
fix thumb isa check for CLREX and DSB.
---
 target/arm/translate.c       | 127 ++++++++++++++++-------------------
 target/arm/a32-uncond.decode |  10 +++
 target/arm/t32.decode        |  10 +++
 3 files changed, 78 insertions(+), 69 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ca4873e514..364b51c2a6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10145,6 +10145,63 @@ static bool trans_SRS(DisasContext *s, arg_SRS *a)
     return true;
 }
 
+/*
+ * Clear-Exclusive, Barriers
+ */
+
+static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
+{
+    if (s->thumb
+        ? !ENABLE_ARCH_7 && !arm_dc_feature(s, ARM_FEATURE_M)
+        : !ENABLE_ARCH_6K) {
+        return false;
+    }
+    gen_clrex(s);
+    return true;
+}
+
+static bool trans_DSB(DisasContext *s, arg_DSB *a)
+{
+    if (!ENABLE_ARCH_7 && !arm_dc_feature(s, ARM_FEATURE_M)) {
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
+    if (!ENABLE_ARCH_7 && !arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    /*
+     * We need to break the TB after this insn to execute
+     * self-modifying code correctly and also to take
+     * any pending interrupts immediately.
+     */
+    gen_goto_tb(s, 0, s->base.pc_next);
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
+    gen_goto_tb(s, 0, s->base.pc_next);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10238,38 +10295,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
-                gen_goto_tb(s, 0, s->base.pc_next);
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
-                gen_goto_tb(s, 0, s->base.pc_next);
-                return;
-            default:
-                goto illegal_op;
-            }
         } else if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
@@ -10730,43 +10755,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
-                            gen_goto_tb(s, 0, s->base.pc_next);
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
-                            gen_goto_tb(s, 0, s->base.pc_next);
-                            break;
-                        default:
-                            goto illegal_op;
-                        }
-                        break;
+                    case 3: /* Special control operations, in decodetree */
                     case 4: /* bxj, in decodetree */
                         goto illegal_op;
                     case 5: /* Exception return.  */
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index 64548a93e2..c7e9df8030 100644
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
 SRS              1111 100 pu:2 1 w:1 0 1101 0000 0101 000 mode:5  &srs
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
index c8a8aeceee..63bca82575 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -305,6 +305,16 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
       # of the space is "reserved hint, behaves as nop".
       NOP        1111 0011 1010 1111 1000 0000 ---- ----
     }
+
+    # Miscellaneous control
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


