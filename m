Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265D8C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52D521D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMoqQHAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52D521D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vqr-0005Hy-20
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkE-0000zM-IQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkC-00048d-9d
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:10 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:40548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkB-000486-OT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:07 -0500
Received: by mail-pg1-x532.google.com with SMTP id t24so664629pgj.7
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=W+1KlNG52DiYYGJSqMpEfpl6AqeCVhBM24KS2I8GcZw=;
 b=GMoqQHAOC1NDTcD6JYVjEtcYkGg0tFmO0EF6MH0+sqs9d1esbvqtCp9ijDZWHo7ITN
 LM0OFkOA/EDueGto6MaZ4RAXoLx2NRiWpFYd93yrpgCQQxAdjGH6FPf/Z0LL2ptjWGzr
 2iKfzXCsHOenFmLqZYN5PdkQbpFc/MjP77kEF/SRWqtlkNEHHdttxrBgd9t7jXUht/sX
 04w0SPJg9IiGn2ial9aYf+f2I5sQ9pIBXanknbGzmgNL9+r1htSuDOk2CUNh1gilCdc6
 D7aNmcxI/XjS38+4uXvfkfzRQx9+s2GMjaYwdnIzSMxg2FiNlDRcouhPWnsYGeAVouer
 c8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=W+1KlNG52DiYYGJSqMpEfpl6AqeCVhBM24KS2I8GcZw=;
 b=Tqu0jJBGtFzoqWuntmUCyZD70fVzbnKK9D64VZXIyd8hI3RNKzPDWA8hV9bFu/rZA+
 EhIc6WwhFZ+SrOHWyVxO9sceOEVI0l/jP/2lpRI6aYj0+2Fll8qWtQqdHhqcNslFKgU3
 /CoP7u3g2crt9lOQASQVUoq3XzahwNJO8gbrJyFbfcVJwSiMOQQcoAuDNgKMi3kEoDdK
 42L2c+/j4DzdvPMtp+/0ir7A+njcWr3+ZFmwS+p3JU+3Cp9Co7sAfTbSwYkWdLRLu+8k
 0JIe+mkDqyLXwrG4n0gdM0Pt16qOIOgr5JIejmYCTCYwNXALIk5a8O3VnhpZVHZ0vd8K
 D0mw==
X-Gm-Message-State: ANhLgQ3tGI5dcS3Q5l2rcgHHucOqr8IF3dR0RS3FFfcLm4b9EUdE1fAf
 M/RMtUKM84b+3nb4jinpbRyBSQ==
X-Google-Smtp-Source: ADFU+vuOJVLecQNQ7O+yE8dXu9yMq71VUfFSoD0tghM8oWK6Ke7hKo/6QmkgKqBjuBbeElleE9WtIQ==
X-Received: by 2002:a62:e111:: with SMTP id q17mr1580696pfh.242.1583196546088; 
 Mon, 02 Mar 2020 16:49:06 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id y193sm6582499pfg.162.2020.03.02.16.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:05 -0800 (PST)
Subject: [PULL 05/38] target/riscv: Rename the H irqs to VS irqs
Date: Mon,  2 Mar 2020 16:48:15 -0800
Message-Id: <20200303004848.136788-6-palmerdabbelt@google.com>
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.c      |  6 +++---
 target/riscv/cpu_bits.h | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2f62f5ea19..f7a35c74c2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -80,14 +80,14 @@ const char * const riscv_excp_names[] = {
 const char * const riscv_intr_names[] = {
     "u_software",
     "s_software",
-    "h_software",
+    "vs_software",
     "m_software",
     "u_timer",
     "s_timer",
-    "h_timer",
+    "vs_timer",
     "m_timer",
     "u_external",
-    "s_external",
+    "vs_external",
     "h_external",
     "m_external",
     "reserved",
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 9ce73c36de..eeaa03c0f8 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -514,29 +514,29 @@
 /* Interrupt causes */
 #define IRQ_U_SOFT                         0
 #define IRQ_S_SOFT                         1
-#define IRQ_H_SOFT                         2  /* reserved */
+#define IRQ_VS_SOFT                        2
 #define IRQ_M_SOFT                         3
 #define IRQ_U_TIMER                        4
 #define IRQ_S_TIMER                        5
-#define IRQ_H_TIMER                        6  /* reserved */
+#define IRQ_VS_TIMER                       6
 #define IRQ_M_TIMER                        7
 #define IRQ_U_EXT                          8
 #define IRQ_S_EXT                          9
-#define IRQ_H_EXT                          10 /* reserved */
+#define IRQ_VS_EXT                         10
 #define IRQ_M_EXT                          11
 
 /* mip masks */
 #define MIP_USIP                           (1 << IRQ_U_SOFT)
 #define MIP_SSIP                           (1 << IRQ_S_SOFT)
-#define MIP_HSIP                           (1 << IRQ_H_SOFT)
+#define MIP_VSSIP                          (1 << IRQ_VS_SOFT)
 #define MIP_MSIP                           (1 << IRQ_M_SOFT)
 #define MIP_UTIP                           (1 << IRQ_U_TIMER)
 #define MIP_STIP                           (1 << IRQ_S_TIMER)
-#define MIP_HTIP                           (1 << IRQ_H_TIMER)
+#define MIP_VSTIP                          (1 << IRQ_VS_TIMER)
 #define MIP_MTIP                           (1 << IRQ_M_TIMER)
 #define MIP_UEIP                           (1 << IRQ_U_EXT)
 #define MIP_SEIP                           (1 << IRQ_S_EXT)
-#define MIP_HEIP                           (1 << IRQ_H_EXT)
+#define MIP_VSEIP                          (1 << IRQ_VS_EXT)
 #define MIP_MEIP                           (1 << IRQ_M_EXT)
 
 /* sip masks */
-- 
2.25.0.265.gbab2e86ba0-goog


