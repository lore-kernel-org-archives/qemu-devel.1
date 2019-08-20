Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7D8C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E11206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnC4h8aE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E11206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Bh3-0003bu-EU
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BM1-0000Je-5o
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLz-0000AZ-CF
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:45 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BLz-00008A-0S
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:43 -0400
Received: by mail-pl1-x641.google.com with SMTP id m12so92443plt.5
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bdJW10ZyVTM5Zc/CPE9B8BqW0sLbaJccOlvi6TIDC8k=;
 b=rnC4h8aEmYQxndmLKvZxqqh0jLXDwHQja/q6YbWGpszBe2d/evuhQa6WFKat0TVKi8
 X4xpnm72b3eCdNe8zQa+RQAttemLmDjJqvXcXIZJ9V/ZKeL6nhugFiE7vbMJQIOX3xYu
 KA+hAvXSnwJe3fq1pB0g9zfiN2NDYZpkh/l6DJ3WGYUJIuaxkvmauPH9i3FjPC7OgMBG
 cQbvHqzoURlLu0u9O6Mki/w9+I+cku5dztq8i6q45zRxRubqhNrsnYRWMEJ/IOSC3GxQ
 Y02lIokDSN4CzP6SQypX0WlpwxpB54pTHWSRTHU+1cKmVxn1tTAWXq1WhLooAFN6VB/i
 T9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bdJW10ZyVTM5Zc/CPE9B8BqW0sLbaJccOlvi6TIDC8k=;
 b=qEOBmmNuJqLlWiprpZpeXbgVZkPHZnh1u341Vw54sI/UZKtVmZN4Utd7udCZi3Fs5Z
 c4bpB/0gATlDJASsxxhnrU3Kx+5OHcLMPnrkYwRcd+0ngYNzbj+uZEi3Whj7JXIcsIl7
 4IWLB/YUgmtxsOe7sb0l2EB+ENUrBjuJizgRKAAa6bD7Van32FhR++L7wcuUVO09N53X
 uohZullvmLYkZWoNukecJve0YH/Qe6A9nRNrhRkxRZ9yV2b9sZ5QA8LmnxUrYGvxeJEm
 0elekE3bEeJ10eH0w8732n7AhIEvlkXZ9t/9rO3kGQiGlRIM4kAlTSIPaImTh6HWCaQx
 NHsg==
X-Gm-Message-State: APjAAAXdOb96HDt7Ro1JKqI0bWx+Ijo6Daku25oU8rxPJOgBLKCrjTDe
 742EITON1mGNIa/uliSH2UwlBLfG90w=
X-Google-Smtp-Source: APXvYqyLtz5cj4Y6XzB4WvMBnzpR7lKG/++MLuNOTPj/hTK8PvP4NSNWmv/rMCW7udmv1kG/LSvbQw==
X-Received: by 2002:a17:902:b905:: with SMTP id
 bf5mr28175471plb.342.1566335261331; 
 Tue, 20 Aug 2019 14:07:41 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:17 -0700
Message-Id: <20190820210720.18976-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v5 14/17] target/arm: Hoist store to cs_base in
 cpu_get_tb_cpu_state
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

By performing this store early, we avoid having to save and restore
the register holding the address around any function calls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19bdb9b9d6..7a94495788 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11187,6 +11187,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 {
     uint32_t flags, pstate_for_ss;
 
+    *cs_base = 0;
     flags = rebuild_hflags_internal(env);
 
     if (is_a64(env)) {
@@ -11260,7 +11261,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     }
 
     *pflags = flags;
-    *cs_base = 0;
 }
 
 #ifdef TARGET_AARCH64
-- 
2.17.1


