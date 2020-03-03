Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B920EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8783B21D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QyTHNCCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8783B21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vmy-0006cU-Lz
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkH-00015A-1p
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkF-0004B5-W2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:12 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:41879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkF-0004Ab-Q9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:11 -0500
Received: by mail-pg1-x532.google.com with SMTP id b1so662035pgm.8
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=ki3pTa3uJKP5VQhwlko+f1zWD5CRp2+R1vu8jGx8azs=;
 b=QyTHNCCKT05mcm6TzRR9XWYESyOBXRd2L+rD5+vkZ4q7hxzo/k0UrUJgZSPwx72yI2
 RKshVwU5eFdpUyoKXt/4Jj6CHFPRJUr6NHpt/uwfoxLDXzvp8f6O7gim5+utb3LoZ8IM
 Hp0VWj+p/GzArT73sK7YeJViLQEB7PjWK5N+f09uym13IFHlTez66eZ7wo8I7/GeKlOh
 jvChWJDBMuAanHPi8xQ87hYW+xcE2/jQmgC6N7/VBCPT2Lbs/5qk5x1o8IVCJOKweeGH
 Awt9ykQ9vLr1RqOfzTg4tiqFZpFBFQu/xDAkoy/bemQXBQpbz7hb1aNyG/Fwc6AlrpiK
 7iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=ki3pTa3uJKP5VQhwlko+f1zWD5CRp2+R1vu8jGx8azs=;
 b=tatzgEp30/cuVk1IeU987aRpeFSrr6HHaW1KJTYAjoTnLooYSPwRqh7NqYafbzhDSo
 3Ek/ujMnbFVBhm6WrCquGi4C4/RvxSzo9HwEEBJLbyTrg3K2sZZOYlfkD7skwo2IQ65p
 fVaUSNCimh80LQyaJNp/r1tUyPyAOEhVfaGGvx93/rY+bax460bu3YPvoc0HOhceKc4W
 opBiHF2eNM2N+lbNEUNXYKJIb5lF+1QOlqNNgyZsNk4+S5UGEE3OX9xdrD5mJkov4IcJ
 GkzHZ4iqMuVdfvJdmHI1Ek10C0LZ0jYTiQJxqXiMmC4t27QEHpAX6ldBLBvRFT4b04+b
 063A==
X-Gm-Message-State: ANhLgQ1opRTy1+5oOhHAf+9eOdrvPJ/F3k8998u+BUXcIgLSFSZhTXYI
 kfyTFLdA3UOySvXu09wabC/aEQd5OsmgIg==
X-Google-Smtp-Source: ADFU+vt9OamwOojLlilWmVCv1UfJZ0QjEEQR5Y18BXAFONXyRetjbKhjpBQv+K0AOpHVFwz1SmWz9w==
X-Received: by 2002:a62:8301:: with SMTP id h1mr1641003pfe.146.1583196550656; 
 Mon, 02 Mar 2020 16:49:10 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id 128sm8677325pfe.163.2020.03.02.16.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:10 -0800 (PST)
Subject: [PULL 08/38] target/riscv: Fix CSR perm checking for HS mode
Date: Mon,  2 Mar 2020 16:48:18 -0800
Message-Id: <20200303004848.136788-9-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::532
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Update the CSR permission checking to work correctly when we are in
HS-mode.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/csr.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ca27359c7e..c63b2f980c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -801,12 +801,22 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
     /* check privileges and return -1 if check fails */
 #if !defined(CONFIG_USER_ONLY)
-    int csr_priv = get_field(csrno, 0x300);
+    int effective_priv = env->priv;
     int read_only = get_field(csrno, 0xC00) == 3;
-    if ((!env->debugger) && (env->priv < csr_priv)) {
-        return -1;
+
+    if (riscv_has_ext(env, RVH) &&
+        env->priv == PRV_S &&
+        !riscv_cpu_virt_enabled(env)) {
+        /*
+         * We are in S mode without virtualisation, therefore we are in HS Mode.
+         * Add 1 to the effective privledge level to allow us to access the
+         * Hypervisor CSRs.
+         */
+        effective_priv++;
     }
-    if (write_mask && read_only) {
+
+    if ((write_mask && read_only) ||
+        (!env->debugger && (effective_priv < get_field(csrno, 0x300)))) {
         return -1;
     }
 #endif
-- 
2.25.0.265.gbab2e86ba0-goog


