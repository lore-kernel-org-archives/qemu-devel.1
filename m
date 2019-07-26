Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123DDC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53F2218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="biC6MyaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53F2218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4RR-0005tq-MR
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NP-000571-VT
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NM-0000ge-UY
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:29 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NF-0000Km-OS
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:28 -0400
Received: by mail-pl1-x641.google.com with SMTP id b7so25061209pls.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hWnZNwWI4tI65PwmLTIEUSuYbSd9btmA82x5Eaqyf6M=;
 b=biC6MyaVGYFUU+cB3fOZf2CH56rijwNd+mbIDwMD/XMxGqHlYgByj4Xxk0GTWLZGkk
 C8vjr7X8hcWBwDmMYCPejSm1uI3kVaitNj3XhzKz6bPydefsq9J7Ih54rvv3rubBE+QM
 86np2g8e+Dy3H1875Gs/DddVboAbbaL7FsPI5gM/2zqQPbXmsvr0ToaYymCxFjkPL1ag
 I6dNr4ipNEpDbDlVwa79TTrvB8gURN3C0DIbZiBWGcocBwO2Eie+I5Kklnoyg4X9p1pA
 NeOPc/Ya1lLfInbFUL37f1cZfALcblvODxlEGoIGuyOOjQdLxfa2c2VfelqdLBFp29Nf
 tofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hWnZNwWI4tI65PwmLTIEUSuYbSd9btmA82x5Eaqyf6M=;
 b=KUaOr1/Tb5kERN+F7454wPyTiYeeCx+rQKa5N24pWN6N3W1M1fHpaqtl0qx3CQtK4Y
 H7UkmTFyieFiWfujmsTxuLETlupysmDQm6I6+KVjKUUA4Ti2uidsRtaUxIdOyrkTlHUp
 jBhzeiVjaSmJmifvju2hDJ/tFcNy1cj008O3JLMuPMuzh7ciltIYYDUQLD9dJ0+jqr+Q
 BuGQ8ZF2dxioeXfiHNPsXBCbbUidkL/3sS/deYkg1X8kgNxBmGSMT84YI/sb5KdWtjLt
 INQj5renwrHSRlVKCJVP1jMDKkItpHA6BdgbU7jZAEWog2PJDyx9VD5E3v/Vh8RIlGm5
 rSQw==
X-Gm-Message-State: APjAAAVPXHE3U8ML1XUFPXz4Zt8VioJSqoW0ObrJALUwfMBbmQmwQECb
 c+WkfDTEB/a02BtW/LrBcFtr+pgW1Kc=
X-Google-Smtp-Source: APXvYqw8IAKElZE3Lyhhe9Co2Ud0b/NaCL0HySttIbbORMxzrCKhZz+6hKqM8IA6SbXHXqxKM+0NnQ==
X-Received: by 2002:a17:902:8207:: with SMTP id
 x7mr97754983pln.63.1564163478040; 
 Fri, 26 Jul 2019 10:51:18 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:02 -0700
Message-Id: <20190726175032.6769-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 37/67] target/arm: Convert Unallocated memory
 hint
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
 target/arm/translate.c       | 8 --------
 target/arm/a32-uncond.decode | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5366741d7b..87cbadc6cb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10227,14 +10227,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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


