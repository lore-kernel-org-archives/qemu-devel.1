Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B6C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296D8206DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJtSnyCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296D8206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpm8-0002ro-Ra
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMN-0002At-AK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMM-0006Pw-92
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:39 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMM-0006PR-49
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:38 -0400
Received: by mail-pf1-x444.google.com with SMTP id c81so1936604pfc.11
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PQ+LqO+lz8aRvDtiE1Qc+qi0l6DF2tSTKskus1LdpN4=;
 b=yJtSnyCnzFgS8dO+gi9fsUmsemw5RartDZNEsx/CN9M9gFxSZQ8iCboaDsqo9BgcP9
 VJ/8frTOBPA+8HbkZjVnWcEXc6NpkWmXIPMDDmZs08/YYHslBtRn0OTfk28/aWqrXgiE
 QYavLQyrS38/iX8xsNsvGxsHKUOpg3leK08WVsFof2PoET7tmmU1EpDSIBdfmUIjwydf
 sUGBw/ZDM+irk9IgZmsoZGKHan0CYmFzqmKs0YrQPsiNA5V16BrpX+yIDtCHcy6lC3MD
 rrzhXllmvOdl4vo44T41AMF88Rjs5K7ibHMVeKQmcHTNfSYt3YUTE6cPx+hYt7GZOSdl
 CPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PQ+LqO+lz8aRvDtiE1Qc+qi0l6DF2tSTKskus1LdpN4=;
 b=l/GFF4/aipSS3pJmJMFUt4qER80q/Y3upb5K5f0so0T+IMnQO+KbpWfP0rFps1JaeM
 iWACBi6JdqrjogYYSkwc9gRR70xn8La0miqY6nA2FEYVq/uDgS/a81GdDzIEAcwOFBlc
 BcON38jnUdNHTNDjMsGIoCWAKcUPvWb1RPPuxiioBxJxDyZ2suj5GYGls9N4T+sRRXeL
 sEqszov3mh48eaUNBhEEj8XIkdScOA7k6hnYobpgX9LWUcOEWqnJnCpTJxCWo6ItXroE
 UDrrPjiWsaSOaeTQ7d2YMRCHgeOXb640q0beFfj6i76+IYrXJL6eS4KMBeuJFJyPcN38
 INew==
X-Gm-Message-State: APjAAAVDto9q23ozBkmSfCWIAji4Nqrw5XmGKXskJSO24xEK3J+RXSlg
 4Cs137Jov3n/5umprHT2traPasoPob4=
X-Google-Smtp-Source: APXvYqwRJeYrQsnSE9U4nHrRpTKk0mLzwlMNxxtTHtzv6iOAvmq6/+VtKSbu9lsJyKIFSOeXz4hnDQ==
X-Received: by 2002:aa7:925a:: with SMTP id 26mr26490232pfp.198.1566250716944; 
 Mon, 19 Aug 2019 14:38:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:19 -0700
Message-Id: <20190819213755.26175-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 32/68] target/arm: Convert SVC
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
 target/arm/translate.c | 19 +++++++++++++------
 target/arm/a32.decode  |  4 ++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6b7b3df685..b6d8b7be8c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9968,6 +9968,18 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
     return true;
 }
 
+/*
+ * Supervisor call
+ */
+
+static bool trans_SVC(DisasContext *s, arg_SVC *a)
+{
+    gen_set_pc_im(s, s->base.pc_next);
+    s->svc_imm = a->imm;
+    s->base.is_jmp = DISAS_SWI;
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10235,6 +10247,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         case 0x09:
         case 0xa:
         case 0xb:
+        case 0xf:
             /* All done in decodetree.  Reach here for illegal ops.  */
             goto illegal_op;
         case 0xc:
@@ -10250,12 +10263,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 goto illegal_op;
             }
             break;
-        case 0xf:
-            /* swi */
-            gen_set_pc_im(s, s->base.pc_next);
-            s->svc_imm = extract32(insn, 0, 24);
-            s->base.is_jmp = DISAS_SWI;
-            break;
         default:
         illegal_op:
             unallocated_encoding(s);
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 62c6f8562e..0bd952c069 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -528,3 +528,7 @@ LDM_a32          ---- 100 b:1 i:1 u:1 w:1 1 rn:4 list:16   &ldst_block
 
 B                .... 1010 ........................           @branch
 BL               .... 1011 ........................           @branch
+
+# Supervisor call
+
+SVC              ---- 1111 imm:24                             &i
-- 
2.17.1


