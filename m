Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E59C3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3655214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fzr8/0vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3655214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpmi-0003ua-KD
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMb-0002Px-9w
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMX-0006Yu-F3
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:53 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMX-0006W0-7m
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:49 -0400
Received: by mail-pf1-x443.google.com with SMTP id q139so1933662pfc.13
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wLniY7IH5XOVstT1ZURU/Pqp4JvYW6tk9V3WWoNomaw=;
 b=Fzr8/0vmfS6tSszW7ZllixzfRjddneCkY3yTW+m9YASnALE0+/I7xJV/rXV2NlepPR
 l7fvYZFPWDJL4lkV5FoRQLS2oyKNOCjBasxe7Hy6SFdbHARbFNwLcaGGdqyyz0tPi3a8
 cG5BPLHtvUaf9yk6KZgXd7IWYlPTbyuXchEl0ZaMsxJpDU6rjB1cKu79L0ZCv49UG5dt
 MhasRf1cTv4f3KH2ZUvuF6HuvbZHRgrKqfTxu9533K1jNkvSMtnqF7jO6Ky2mWlkh8o/
 eTdvgsbPzhgo2hX1QvhOE5VDz0vzv/HbIczzBC90C4q1HZyhPqLphzwnEqY82AgH015a
 rTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wLniY7IH5XOVstT1ZURU/Pqp4JvYW6tk9V3WWoNomaw=;
 b=LZxl+3tunOJvda6koIuZWd33iR/h48GSAIgf+o/ej5Wgd2G2o6JDLyaevqIacBeoad
 SJI2y7aZi4IceKzI8tSfNAjhoZwraMglHLm2+KqjFcOgJbC0D+3IeXds7OycB4a1Maqo
 vkK7LfQfyAgl6q21mJtFALF790D1WHQoT7T0tQqqQjIkmBk5vHfbEe9qtobVLT2RzESx
 0kh0DDnhLavXul7m8f2LiX9rur8motXcax7/DavOmCYTiFZrKJlH6QOHEjuQhY4e6Y3W
 DkfPUX9sBDtCIFG3b+ORx/hz3fxvqM0NggsYhASNQCB4/GUsC9rbSlTs7BXq6TjlJ+gu
 cGpQ==
X-Gm-Message-State: APjAAAUz0Ips9zw0Ecjh+HYzRPQMS/eYKmXZdlJFhEeQTwZHkTtQ9Y3N
 4yZ9dd5OqfbnsGz+1hEBxUWxlKMDbOc=
X-Google-Smtp-Source: APXvYqx8KCW+nrN2cD+a0gmjz2UlXqpJ5QkZDzVHodaw9BoHuge5eQPGsicGc4GCCsuoXHw1Og74nQ==
X-Received: by 2002:a62:2603:: with SMTP id m3mr27356125pfm.163.1566250726092; 
 Mon, 19 Aug 2019 14:38:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:27 -0700
Message-Id: <20190819213755.26175-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 40/68] target/arm: Convert SG
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
 target/arm/translate.c | 51 ++++++++++++++++++++++++------------------
 target/arm/t32.decode  |  5 ++++-
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7c05e7006e..9a8864e8ff 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8426,6 +8426,34 @@ static bool trans_SMC(DisasContext *s, arg_SMC *a)
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
@@ -10437,28 +10465,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
index 0cc0808c05..ce46650446 100644
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


