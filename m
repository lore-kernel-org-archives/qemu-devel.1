Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED6C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B2221842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khOm4Ns3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B2221842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4VE-0005lV-Tc
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58630)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NL-0004ql-EV
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NI-0000WJ-1W
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:26 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NH-0000Mz-QC
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:23 -0400
Received: by mail-pg1-x542.google.com with SMTP id i70so14371649pgd.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Nxa/cuCHMs3HeU9P7ofD/RBscm9ah4Tq+3WaXVFVTi8=;
 b=khOm4Ns3aOhzviXJxUgm0+U2fW4iOx0h/eq74+vKDGl0DyGQuc4eDWoSE4OzDkBOhs
 xvQkkAtF7ajTyt1lFY9jhcACRUSCCCDesn7Z8XZRKDVbT9u2Bu0vxFscV8ZP9pW5KEMG
 l9h6BJYyqh2qF5Ja1rZSe2610pr8qQ9XFeIevU4Uct4VWbPIGWM9sz0+H7EjRqxpUf9D
 9KGs23yt1JJ0Rh6hbhxoJtd06zf8yR6wBM0l8NwGyQFAbDARrKuJ+FgNXa8QOy0ShCPb
 2DX392DuNA0ktSa9h9kw5BboG6n04lCwB5hg6IH0q5eXUe3Ku8N2fwgGZMd+N3pVhJiP
 IlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Nxa/cuCHMs3HeU9P7ofD/RBscm9ah4Tq+3WaXVFVTi8=;
 b=jgAX7rLjK0xh8v+wxTcppyt+50tGpkufECZnDqAen+kViOG96fyDD/GOsDx5UnaKSu
 +LRRopIPhORlaHQBCVBWl/zJXn517HpwGyr0l+gij6zPU0MnxguxVwn188mMpzHHvH+4
 xL5uGUhmBSNCqbKfQcSljbnYLjkE+qAISJEK5dhXqQu1IJMIC+VUkUh20Kc3udpb7Jv2
 ZHEqvbj5YDuLJRTcy/SWZ8Lc6MP75D4ktW2rjPAuwhTZ0rRnIeEoY0NtsiBPl31Rinc4
 RQ5n4SmGyVXx+qDmpD/TQyVU1dsxVIy8pHIK6u8ZLCK6tlXY69zrxKA7yxFyTi6EhC8D
 ZNBA==
X-Gm-Message-State: APjAAAUdnXAv+6EHy6YJZyV3qudmWMy4sx6qVQN9eSh2EyOgLLBIkJ2n
 zZ5+Q3xsMyyAq8mLBkTBt7X4Ovxo9m0=
X-Google-Smtp-Source: APXvYqxmpZEOEVxwMHsB/etbw9ZUfDwVt4F+lzPC5QwCv/B4ZUmGVqr0wgHFFcg1lidqt/3aTunSCQ==
X-Received: by 2002:a17:90a:ac11:: with SMTP id
 o17mr100549798pjq.134.1564163480128; 
 Fri, 26 Jul 2019 10:51:20 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:04 -0700
Message-Id: <20190726175032.6769-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 39/67] target/arm: Convert SG
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
 target/arm/translate.c | 51 ++++++++++++++++++++++++------------------
 target/arm/t32.decode  |  5 ++++-
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9c6623fb6b..df515e9341 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8497,6 +8497,34 @@ static bool trans_SMC(DisasContext *s, arg_SMC *a)
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
@@ -10445,28 +10473,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
index 17e6dae688..c0b962479b 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -485,7 +485,10 @@ STRD_ri_t32      1110 1001 .100 .... .... .... ........    @ldstd_ri8 w=0 p=1
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


