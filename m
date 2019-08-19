Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182B0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D496D206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFuZtKWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D496D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59763 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpys-0004jF-Hi
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMX-0002Nl-Bc
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMU-0006VU-G0
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:49 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMT-0006Ub-QG
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:46 -0400
Received: by mail-pg1-x542.google.com with SMTP id d1so1933526pgp.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AfObyYVf+TtUvkYatWrX5oVYyhEhA7Z+ZbkDEmf7ZT8=;
 b=RFuZtKWFqnZO0ojoGmbmoV+jl/jaVkvAC9l8GHZG0Sy3J5rXnNMMp8S3ITVP1X95tU
 GM+1qmUS7we6nFCdoBPGu+vSpi73vT67ty7s7RmJXOE9kNxl14bpsAz1V+tPE/oCOX3w
 ltPuhuBXHYVCG5EkKZ+Av8L7KahVXtIMSUll+5nRwd8CqtVYalAUuq1kVLL67GiK9iFY
 G/7xRKkwHdLBK01/ABYGcJ/HJ7IzVlnyJiks/wszSXiP8BLnzehWwNZcHhDlp8hEsynd
 AWuznA/tpXZ0I14XRkzsfpBDPYMElty8M0gwagZBpFwRnpDR2dLee8r+UBoXOJGBiclm
 l6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AfObyYVf+TtUvkYatWrX5oVYyhEhA7Z+ZbkDEmf7ZT8=;
 b=N8/ZFVlTr7USlEXB9v0SG3oRghuCH1ZNkUSpS63n8gjqzyfvPtgw+ofXExzsMJxPfl
 bbLQIqzA+Ostrg8mgMZOYJHphxhrfs1fCmmNwqn9kbXGQHrrk5nGiWLoywGOIa946X3v
 WjbBEMPICl95yASFX9PiYXokeqzHHhBQa4Yy3I9216xMjbyntDlmQmm8pE4lX7o4nctK
 WdiKwQxpYXb7c0daEVjKqpynk6mcQT2NHQ66OFOle9HzVqlJYouprsxpFSU36Q7KFc4x
 IvIY4Ml0j6YqDFt6amRkIkSvL3PxgaW8x6YZs6y6XTaRZDUQMN8Nr4gAFhLHwQFcvtb0
 KOJw==
X-Gm-Message-State: APjAAAWCT6WJ2BfC2OHncYScdw/LIyfKdlMxVkz/f4EFnOC7IXsAenCF
 HY35GZ3lK6uPz2bD/3AkA03+i82bDkY=
X-Google-Smtp-Source: APXvYqzcthnbyj0e9K9F/2YDSHWCQnAiyPIRkUbZjESB4/XwtrOMfs90if1GYAuCsI4IoeEXrdepxA==
X-Received: by 2002:a62:8745:: with SMTP id i66mr26021455pfe.259.1566250724045; 
 Mon, 19 Aug 2019 14:38:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:25 -0700
Message-Id: <20190819213755.26175-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v2 38/68] target/arm: Convert Unallocated
 memory hint
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
 target/arm/translate.c       | 8 --------
 target/arm/a32-uncond.decode | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a30a9bb4e0..9ec6b25c03 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10216,14 +10216,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             return;
         }
-        if (((insn & 0x0f700000) == 0x04100000) ||
-            ((insn & 0x0f700010) == 0x06100000)) {
-            if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
-                goto illegal_op;
-            }
-            return; /* v7MP: Unallocated memory hint: must NOP */
-        }
-
         if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index aed381cb8e..afa95bf7aa 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -64,3 +64,11 @@ PLI              1111 0100 -101 ---- 1111 ---- ---- ----    # (imm, lit) 7
 PLD              1111 0111 -101 ---- 1111 ----- -- 0 ----   # (register) 5te
 PLDW             1111 0111 -001 ---- 1111 ----- -- 0 ----   # (register) 7mp
 PLI              1111 0110 -101 ---- 1111 ----- -- 0 ----   # (register) 7
+
+# Unallocated memory hints
+#
+# Since these are v7MP nops, and PLDW is v7MP and implemented as nop,
+# (ab)use the PLDW helper.
+
+PLDW             1111 0100 -001 ---- ---- ---- ---- ----
+PLDW             1111 0110 -001 ---- ---- ---- ---0 ----
-- 
2.17.1


