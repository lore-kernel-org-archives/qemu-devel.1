Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F4BC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10872077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXT+tIT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10872077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bat-0003Um-IR
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0O-0004zw-H4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0L-0002er-PE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:48 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:47066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0L-0002e3-EQ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:45 -0400
Received: by mail-pg1-x534.google.com with SMTP id m3so11750369pgv.13
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jCLx5wbUWyoQFBTJtKxHJZzHzglyCub6PkVD7Xy998w=;
 b=XXT+tIT+OLPZofonDRatHFWp9c7dSQdPlo3AJsyJSzP5Kl/f/7+p8eHm/rSBpy4mZ5
 DNAsUCgfcE8B0vhr3//i+Jp6rvUIvNX1h7lo/X5TGHcS67MYWNIH/Z+rz6vWC6fGdaqA
 H49fHr+ExAH+fmPuwiP8NwsTjNGeHb6qwGzKrp16TEzpbdVcCMId/m5gF6FDi54VmGSD
 pbbaUUiMNdK2ZJC/3fY8Ew5yMnKhEe/2kCIdVJc6BT8zmkjVXzVUUqaXy2Bk3sARuJxq
 tmHssq9btZMFfYq6wXGfwOHeg6gsyr0/t7GzO7XhyRtRBjZ2nbenmrwscxx16ojAy7UI
 mlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jCLx5wbUWyoQFBTJtKxHJZzHzglyCub6PkVD7Xy998w=;
 b=tV9/bP5iVHf6Nxq2Bxye+7+3/2lrjDYSpJrFe/f65AgbauI2XESH7eI/+fJzUQKQka
 9HbTToqmcy0GVjey0Qna3SfBec9OnlfXRMG+iZhdUM9G/sbUao6sthvS6rSte8QxZx7g
 m7VVwNyfXRsZvFN0m8pARckSBELqOGwQy02lltBU76yW1U99BHlwjkEKTi80OaKqFsTR
 Tdzk9+FY17eJPZCEjd2I1ZuWzYHUjC+fAcPil59dvlzzJCp/HiHJ2rqL6xlpjqlcghMP
 lHrGPWEOsFH5bKpkmGcQG6IP1u9uZQxK+1AloFLDofZY3AXSv5qBwR+qimFvnsylQz4r
 YpSQ==
X-Gm-Message-State: APjAAAWbg2wQclqsYGI2P1EjaWw2skiBMohPbYgEz7V1aoZRQmU99Xwq
 RGTMKUzoDISoBE5XmpuNepFFdcWJqjM=
X-Google-Smtp-Source: APXvYqxVwJ4mzTA9KVtYkrvhWJgfsdEJGaITXTT66NkgYg6e+bMDsIRPtFsQ39k6766vlriGpKz4vA==
X-Received: by 2002:a62:d143:: with SMTP id t3mr44321762pfl.213.1567625504065; 
 Wed, 04 Sep 2019 12:31:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:23 -0700
Message-Id: <20190904193059.26202-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
Subject: [Qemu-devel] [PATCH v4 33/69] target/arm: Convert SVC
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
 target/arm/translate.c | 19 +++++++++++++------
 target/arm/a32.decode  |  4 ++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 72e4708e61..208021181f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10081,6 +10081,18 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
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
@@ -10348,6 +10360,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         case 0x09:
         case 0xa:
         case 0xb:
+        case 0xf:
             /* All done in decodetree.  Reach here for illegal ops.  */
             goto illegal_op;
         case 0xc:
@@ -10363,12 +10376,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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


