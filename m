Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8796AC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5021622CF6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Flk5TmVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5021622CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpsu-0005R8-3P
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMS-0002Jb-4L
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMR-0006TS-1c
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:43 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMQ-0006T0-T5
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id n9so1938493pgc.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nUlERtxnsk9pzgBS89kY7GryxKus7N1Qg8iHW/AeABc=;
 b=Flk5TmVR1JR2yQH7xN27Vi9JZjxy+LJgxgCSEYXWQVAj19fwhgst81Tfv2YFVnKcvo
 xVe5/aFgDprkbAp4dJuGCGSaefy62x9K5rN2ZQXL8Ydb4SO39zwlgPcoauM9AJHPOoAw
 QLB9nDlu2vmfofN12U+LT8RDbxP5ZV+SSJqNeeUomH6/O+Coq3sZSgbkIEz66IDgdqYE
 e6Mqlt/p7YSm/ZyId8VYxYcbuv56ewVEZxMmZIwpY2xKjd2BerbBLwAu+WSTCqf26td8
 Q4PvBqnixtWTXiTrX8ZjagG1dIrj8wI7MDOk+vfUYOTC7dYAahdN8bC+1nhBoBcKNu1R
 c9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nUlERtxnsk9pzgBS89kY7GryxKus7N1Qg8iHW/AeABc=;
 b=jRhZNekurO0x2MxDDNMchpqsxhP3yM2zcXBMxVYm5HY2pE0NLMJvEn8Jobn3+My8qe
 IMUFuvsQTMe8f3Jp5Pl247yXgXDGq0aWxfqoYaQCoowJdurDW4vwA9dP2NS22MsENbhp
 X57S8kAhUBSqRvGuIGD3PAYoXfveOZCNK/MCKg4XSUGKmWDSHkq9FeLqAr8mhWusWNvu
 tPEelZR7toDK7I380AxSZNcOLkRn50OpgG4i2Kyi560nZtsdaPxrgLNJkAfRDWoKUNPu
 yLv+o86eIFcK7ycNVRPVKfppcY2pE05FcYDGzDnLzmRr4S0lYiU73ccqo2jPStvY/H4k
 97iA==
X-Gm-Message-State: APjAAAUUSXBzaie4sv8uQuovIOAjPsF/xI7qx1ZQU/o+iJVlhqgGk5v1
 25/9oWHdHDY7AJlk69yLv4uF4pa38y8=
X-Google-Smtp-Source: APXvYqxkcXHspZhhiZ/KLz8beCaNw0aJhqoMyskxswBSHYVj87ACPBznHPtQ/L0eGTIz/HC4DuCFxA==
X-Received: by 2002:aa7:80d7:: with SMTP id a23mr15956894pfn.208.1566250721714; 
 Mon, 19 Aug 2019 14:38:41 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:23 -0700
Message-Id: <20190819213755.26175-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 36/68] target/arm: Convert SETEND
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
 target/arm/translate.c       | 22 +++++++++++++---------
 target/arm/a32-uncond.decode |  4 ++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 928205d993..46e88d1d17 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10124,6 +10124,18 @@ static bool trans_SB(DisasContext *s, arg_SB *a)
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
@@ -10209,15 +10221,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
index eb1c55b330..d5ed48f0fd 100644
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


