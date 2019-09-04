Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182B2C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D597F2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRb1/wXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D597F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bj4-0002zz-Cd
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0Y-0005De-38
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0V-0002p0-Fu
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0V-0002oD-6x
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:55 -0400
Received: by mail-pf1-x444.google.com with SMTP id y22so8278172pfr.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bRqYq2TLJ+WIjlJfH/2hIAtxOVh3ChiZfI3nAvVSmQE=;
 b=iRb1/wXKxZU+WH6cNoOPPE5ajNFKlx1uJ2+hVuPfjqFHjBEk0jz1T+w9rM4cyydPB5
 EgEVrmaGhx078DRYd78x9KDvO53i2785IeiT4DzWbP6t8gekmX2VPMGOY2/uK54d+WDg
 J7fUy/pmqBIlYfcuY3MH1HMHKSXYM9T1oHezV8zmvNZ/DCbBf+2DVe7zUYrjjlaNQuHG
 aooOtLGhp+zPkr4f3LsQVjKO2BOZlZ5K93OWB/seJNuKHBai4eZMTMZjRNIIwpegdwDI
 U/hNvDa+VSo1a2OtZIebBWTAfjZp9sq18l1iXQe03OFMyyjBqIpJFnYDVdPp8yO3nAcX
 jEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bRqYq2TLJ+WIjlJfH/2hIAtxOVh3ChiZfI3nAvVSmQE=;
 b=IXKT9TsvWbrE3SNIXrEJY3HBFTv++5aTblOhm+2tHAj9UwVg8P8YC1qA0r9jj8xFr2
 VzWJa4piM5FKRmDQ1QVTHa1cutjjb5XQcwFSgyBnkRf0LCZA9QoxO77snm5Uxmc7cLio
 /a2KbLW9j62US67avM+PmNkog2AwJyivQtM5cWjhbFvj82oHdUH8l6CI2Zvylq1eeDbi
 8C8WAZ7La3vHGbK00lA4/SAGhZaHTF+OD6AzzxZ9nlyQ9h6Y+VoRbbAbOVL6qSY/MtMq
 4PouwrPfipxiguBpPJpptXt/nTF0+9FPsf6wCIW63awhRw8ALjEN68gEsq0gtBFWORgb
 JUVQ==
X-Gm-Message-State: APjAAAXPdW7NSCjwIwlAWMmwUe6vf74u5VwkPgVpNhxGd/Fc5+jVFfE5
 D18opc3P76V86ZQ8Hd4TCB+Gw8RH/ng=
X-Google-Smtp-Source: APXvYqwdwCm/L5Pm9JDrtMYyHek472nzxNwi3rii63fpU0BfyfXqrf2U+9S773i2khK72IyEBc06jw==
X-Received: by 2002:a63:1b66:: with SMTP id b38mr36618239pgm.54.1567625513742; 
 Wed, 04 Sep 2019 12:31:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:31 -0700
Message-Id: <20190904193059.26202-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 41/69] target/arm: Convert SG
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 51 ++++++++++++++++++++++++------------------
 target/arm/t32.decode  |  5 ++++-
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 96149eabf4..af7eddca48 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8467,6 +8467,34 @@ static bool trans_SMC(DisasContext *s, arg_SMC *a)
     return true;
 }
 
+static bool trans_SG(DisasContext *s, arg_SG *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_M) ||
+        !arm_dc_feature(s, ARM_FEATURE_V8)) {
+        return false;
+    }
+    /*
+     * SG (v8M only)
+     * The bulk of the behaviour for this instruction is implemented
+     * in v7m_handle_execute_nsc(), which deals with the insn when
+     * it is executed by a CPU in non-secure state from memory
+     * which is Secure & NonSecure-Callable.
+     * Here we only need to handle the remaining cases:
+     *  * in NS memory (including the "security extension not
+     *    implemented" case) : NOP
+     *  * in S memory but CPU already secure (clear IT bits)
+     * We know that the attribute for the memory this insn is
+     * in must match the current CPU state, because otherwise
+     * get_phys_addr_pmsav8 would have generated an exception.
+     */
+    if (s->v8m_secure) {
+        /* Like the IT insn, we don't need to generate any code */
+        s->condexec_cond = 0;
+        s->condexec_mask = 0;
+    }
+    return true;
+}
+
 /*
  * Load/store register index
  */
@@ -10553,28 +10581,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
              * - load/store doubleword, load/store exclusive, ldacq/strel,
              *   table branch, TT.
              */
-            if (insn == 0xe97fe97f && arm_dc_feature(s, ARM_FEATURE_M) &&
-                arm_dc_feature(s, ARM_FEATURE_V8)) {
-                /* 0b1110_1001_0111_1111_1110_1001_0111_111
-                 *  - SG (v8M only)
-                 * The bulk of the behaviour for this instruction is implemented
-                 * in v7m_handle_execute_nsc(), which deals with the insn when
-                 * it is executed by a CPU in non-secure state from memory
-                 * which is Secure & NonSecure-Callable.
-                 * Here we only need to handle the remaining cases:
-                 *  * in NS memory (including the "security extension not
-                 *    implemented" case) : NOP
-                 *  * in S memory but CPU already secure (clear IT bits)
-                 * We know that the attribute for the memory this insn is
-                 * in must match the current CPU state, because otherwise
-                 * get_phys_addr_pmsav8 would have generated an exception.
-                 */
-                if (s->v8m_secure) {
-                    /* Like the IT insn, we don't need to generate any code */
-                    s->condexec_cond = 0;
-                    s->condexec_mask = 0;
-                }
-            } else if (insn & 0x01200000) {
+            if (insn & 0x01200000) {
                 /* load/store dual, in decodetree */
                 goto illegal_op;
             } else if ((insn & (1 << 23)) == 0) {
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index d05673ff3e..c956ddb254 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -487,7 +487,10 @@ STRD_ri_t32      1110 1001 .100 .... .... .... ........    @ldstd_ri8 w=0 p=1
 LDRD_ri_t32      1110 1001 .101 .... .... .... ........    @ldstd_ri8 w=0 p=1
 
 STRD_ri_t32      1110 1001 .110 .... .... .... ........    @ldstd_ri8 w=1 p=1
-LDRD_ri_t32      1110 1001 .111 .... .... .... ........    @ldstd_ri8 w=1 p=1
+{
+  SG             1110 1001 0111 1111 1110 1001 01111111
+  LDRD_ri_t32    1110 1001 .111 .... .... .... ........    @ldstd_ri8 w=1 p=1
+}
 
 # Load/Store Exclusive, Load-Acquire/Store-Release, and Table Branch
 
-- 
2.17.1


