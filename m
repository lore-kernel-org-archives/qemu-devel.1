Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572E1C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2060021726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYOf+kyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2060021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5buG-0006Tj-Kt
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0a-0005Hf-RU
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0Y-0002sx-Ti
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:00 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0Y-0002s8-M7
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:58 -0400
Received: by mail-pf1-x441.google.com with SMTP id r12so1752236pfh.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VzsNEJ79vBBXHa6di56eotbjbD089opoeS7FPmrAgFs=;
 b=hYOf+kyOC9AZ+E0vgO5tCaEmGZjWMRbuJk28WTnMTHv6EuLVa+7DBJc/eksBzZo3ei
 dfExrjpYNfdJRIuoi+MKnL2DXyOsStqRfz3w1yWlS2W+I/4h2uAtEtzo3RP3zhjJrGH9
 tjaLNGjFGa8dBAVjJA7RWZZ6zNVMn3r80s/0kk//6JQMKkD4MVpYese8MTXahI9d9Osj
 pmXmn+dWSymsAAgUGwNvqFVZtnGGkwwD6/XATdAsSCKijQZHauCbH8kS18D67WEyUqP2
 oH/NYHq1etyDOUttNqtOHaYJwQJbclcgrT+0dyhkXQoWHzyO2E0fyIX+ot7TW7vSgCA+
 5A5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VzsNEJ79vBBXHa6di56eotbjbD089opoeS7FPmrAgFs=;
 b=dJRrZAbBICfdO38G17a7kXcBrlGS1hvIIr+au48Tq8TSObIvz1ZnV3OwNoXx1gwhP8
 tUgBy9UZt6T56JlhvnXPpEKpogXqSStEEuccTlN7KmOzXReuKcuYWx9sVjW91aA8HB3c
 XPiHIy8LHkxPJzd//BP9l4gGPQE5O9cFp/Vur7G7Gnmt/7yWbGuwtWaZhJtEtzv4Oy6e
 LLqOGkt5rGaq9pqTF/pyM1DiXA5bXBAzGfDsoR0dEc+b10jVSajkBu9SFcsBfISYyagx
 XzJrdTAtEGR0Y6oZAnBOk2Gpce/u5anFdYXpsj2cJxWG4LuLmkUgXYZxkjsZnP4RwC6z
 plTw==
X-Gm-Message-State: APjAAAWhXWYv256b6oByvtzjFPiV+b/V/JzmCEbStnpGkopPjQWMXibt
 XWSMIcfo4YvbhngV7QyvNhaQYFepn20=
X-Google-Smtp-Source: APXvYqwpLVEfboqWbPqy3LvUl85SokwSibRFFd0zDN7B5Pk9L9tO6wYVBj0DmSJvMlHr83Gr1Jqk4w==
X-Received: by 2002:a63:755e:: with SMTP id f30mr36601200pgn.246.1567625517269; 
 Wed, 04 Sep 2019 12:31:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:34 -0700
Message-Id: <20190904193059.26202-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v4 44/69] target/arm: Simplify disas_arm_insn
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

Fold away all of the cases that now just goto illegal_op,
because all of their internal bits are now in decodetree.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 69 ++++++++++--------------------------------
 1 file changed, 16 insertions(+), 53 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f68e09ff1f..7f2a46100e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10364,7 +10364,7 @@ static bool trans_PLI(DisasContext *s, arg_PLD *a)
 
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
-    unsigned int cond, op1;
+    unsigned int cond = insn >> 28;
 
     /* M variants do not implement ARM mode; this must raise the INVSTATE
      * UsageFault exception.
@@ -10374,7 +10374,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                            default_exception_el(s));
         return;
     }
-    cond = insn >> 28;
 
     if (cond == 0xf) {
         /* In ARMv3 and v4 the NV condition is UNPREDICTABLE; we
@@ -10439,11 +10438,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 goto illegal_op;
             }
             return;
-        } else if ((insn & 0x0fe00000) == 0x0c400000) {
-            /* Coprocessor double register transfer.  */
-            ARCH(5TE);
-        } else if ((insn & 0x0f000010) == 0x0e000010) {
-            /* Additional coprocessor register transfer.  */
         }
         goto illegal_op;
     }
@@ -10458,55 +10452,24 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     }
     /* fall back to legacy decoder */
 
-    if ((insn & 0x0f900000) == 0x03000000) {
-        /* All done in decodetree.  Illegal ops reach here.  */
-        goto illegal_op;
-    } else if ((insn & 0x0f900000) == 0x01000000
-               && (insn & 0x00000090) != 0x00000090) {
-        /* miscellaneous instructions */
-        /* All done in decodetree.  Illegal ops reach here.  */
-        goto illegal_op;
-    } else if (((insn & 0x0e000000) == 0 &&
-                (insn & 0x00000090) != 0x90) ||
-               ((insn & 0x0e000000) == (1 << 25))) {
-        /* Data-processing (reg, reg-shift-reg, imm).  */
-        /* All done in decodetree.  Reach here for illegal ops.  */
-        goto illegal_op;
-    } else {
-        /* other instructions */
-        op1 = (insn >> 24) & 0xf;
-        switch(op1) {
-        case 0x0:
-        case 0x1:
-        case 0x4:
-        case 0x5:
-        case 0x6:
-        case 0x7:
-        case 0x08:
-        case 0x09:
-        case 0xa:
-        case 0xb:
-        case 0xf:
-            /* All done in decodetree.  Reach here for illegal ops.  */
-            goto illegal_op;
-        case 0xc:
-        case 0xd:
-        case 0xe:
-            if (((insn >> 8) & 0xe) == 10) {
-                /* VFP.  */
-                if (disas_vfp_insn(s, insn)) {
-                    goto illegal_op;
-                }
-            } else if (disas_coproc_insn(s, insn)) {
-                /* Coprocessor.  */
+    switch ((insn >> 24) & 0xf) {
+    case 0xc:
+    case 0xd:
+    case 0xe:
+        if (((insn >> 8) & 0xe) == 10) {
+            /* VFP.  */
+            if (disas_vfp_insn(s, insn)) {
                 goto illegal_op;
             }
-            break;
-        default:
-        illegal_op:
-            unallocated_encoding(s);
-            break;
+        } else if (disas_coproc_insn(s, insn)) {
+            /* Coprocessor.  */
+            goto illegal_op;
         }
+        break;
+    default:
+    illegal_op:
+        unallocated_encoding(s);
+        break;
     }
 }
 
-- 
2.17.1


