Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC36C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B9722CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCt3fFC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B9722CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3422-0002J3-In
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GX-0003q1-Ol
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GT-0000Pk-B3
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:56 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33GS-0000MD-Ve
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:53 -0400
Received: by mail-pg1-x541.google.com with SMTP id n9so234218pgc.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V9/U0aGVS70AXEVxaqRPo6hkrItIElj/g3TdFJgyikI=;
 b=DCt3fFC1zB24iL711MRq//sJFwvzaQ78sQBi7RAy10nqUr8k7n266cugxIax5Q8NH+
 jJupcfEb3R26ePU3mEj5uMo9NO1+YCwxPyEH4RZJwIsf1hb/i0XDAGlPkGqLWI4EPeBj
 o2KRfsLHARBrhon8hpaYIkREmJdfuY8uyopoFtxqWmWBPhLdbDIK/YjROJxejYALnGt/
 CD/ZOA0jetMWXpGP6bklYZ9UOf+qJLbBvQknjSRn3sDiPRmuO55PuAPPld9OL1e5tJbv
 Bbn00L3ZlT8RgEuAkxi0zUleb/kcDTdYk/o27+1fzzqPsO5d+uliU+Uz93ndIQ1/OqjA
 IBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V9/U0aGVS70AXEVxaqRPo6hkrItIElj/g3TdFJgyikI=;
 b=NfyVYdpQ9b7WtG1Km2Cq3+3Y3IECg6SkU3GE11rcvfJ/mAYELpFIszb4Szp3ykTgWY
 s5h+68jWiH61BO8qjWgGMJbLyT1/DvzEbnnWjCsLwBIOw1P33HgCbdrsCxB3xdAxnY8a
 T6JDkArTIrM0VnIweCvc4720IfAB4/or9F32U9cKutqke+EAVREKLcPPAzv5H5ix7n+r
 wHUjWabU4KM3IKRxKaYF0Wc7bUh8iG1wc8j0TTh7eGTyN6H19ngxRzqjDRkFi1dXltOB
 QC3PDhF7UDpe3MQMhV6MjljS+CDfmCK/9Tw7bE4JRBG+Tj4b1WkJsJfBOmuSIy9MocFN
 0DbQ==
X-Gm-Message-State: APjAAAWDOIMWt5r4OsB+KmwSNqjoIqzdlkT2bhOgNeKGKBSY656NZzbK
 biqf1odAkDPO6oQHw3LZYqVqQ3VmrBw=
X-Google-Smtp-Source: APXvYqwhK8l4qVESERPZNoRPqhRIEjhaPJ/4fX61k9gpx6u5qf1tC0h/nFFbpBR0+XDevwloeuuWYA==
X-Received: by 2002:aa7:8c04:: with SMTP id c4mr6686545pfd.59.1567019147326;
 Wed, 28 Aug 2019 12:05:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:24 -0700
Message-Id: <20190828190456.30315-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 37/69] target/arm: Convert SETEND
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
 target/arm/translate.c       | 22 +++++++++++++---------
 target/arm/a32-uncond.decode |  4 ++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e8764a88ae..f81f369544 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10217,6 +10217,18 @@ static bool trans_SB(DisasContext *s, arg_SB *a)
     return true;
 }
 
+static bool trans_SETEND(DisasContext *s, arg_SETEND *a)
+{
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+    if (a->E != (s->be_data == MO_BE)) {
+        gen_helper_setend(cpu_env);
+        s->base.is_jmp = DISAS_UPDATE;
+    }
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10302,15 +10314,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             return; /* v7MP: Unallocated memory hint: must NOP */
         }
 
-        if ((insn & 0x0ffffdff) == 0x01010000) {
-            ARCH(6);
-            /* setend */
-            if (((insn >> 9) & 1) != !!(s->be_data == MO_BE)) {
-                gen_helper_setend(cpu_env);
-                s->base.is_jmp = DISAS_UPDATE;
-            }
-            return;
-        } else if ((insn & 0x0e000f00) == 0x0c000100) {
+        if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
                 if (extract32(s->c15_cpar, 1, 1)) {
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index de611e8aff..32253b4f9a 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -24,6 +24,7 @@
 
 &empty           !extern
 &i               !extern imm
+&setend          E
 
 # Branch with Link and Exchange
 
@@ -50,3 +51,6 @@ DSB              1111 0101 0111 1111 1111 0000 0100 ----
 DMB              1111 0101 0111 1111 1111 0000 0101 ----
 ISB              1111 0101 0111 1111 1111 0000 0110 ----
 SB               1111 0101 0111 1111 1111 0000 0111 0000
+
+# Set Endianness
+SETEND           1111 0001 0000 0001 0000 00 E:1 0 0000 0000  &setend
-- 
2.17.1


