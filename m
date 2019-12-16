Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2B9C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C5521835
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eq452F6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C5521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyrc-0000zL-QE
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybO-0005Jz-BQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybN-0007Mt-9v
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:30 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybN-0007MW-4s
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:29 -0500
Received: by mail-pf1-x441.google.com with SMTP id 4so6369388pfz.9
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s8SYA9/Rwv4ZxWRA0n9zn8WOO8ULkXoz56NCsZvZKnc=;
 b=Eq452F6QFJcMlAB8xMCNBHfJaYeilcHziFExSzehhnynRgmkLcQRSFmhq8/fDo6+QH
 xV7VFwuAkFDHegz+H3sNvosTQnDoMZVZ67uJL4AUR7NoI+3c6rJvs2BoPN36hIk8HZnq
 oANRhG7AqyApNppDuVmXWA+dcFu4u3WkAkLZIqvjZudE4eMd19AqhUvaqOSoltx34k2w
 2JrKf5dF++dVddWOLrZjwc3SA28/uTLLbYmj9WIehpmkr+Aug3kkCeu7eUyThh4AEZOf
 qCqwDos91MJ66tgwHnW6XP18DJ1pb5ayuclPavrqHGFIwgJl9gEYqlJeYaPyr/YhP4Yh
 n04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s8SYA9/Rwv4ZxWRA0n9zn8WOO8ULkXoz56NCsZvZKnc=;
 b=jUS/1LYex/oud6S8YWjfjjQ8BsVAVfJ2vDGUGMjbAYJn72+ziJ14wETLFnIvPkh5HY
 giyvi9OMcxg49Knr8wQlNXiUtaCTNMBw7rVXIb1tSaOTCSsdQrn7osqUJLqoYiSZvYqY
 mFc4n2xFtuykfoSV9SV7Gu3/jLqbkpa5YTCY4+ta4P2uw7XaTxv2dHHAEjHjB1sV/2C1
 PxwaH3aLkJ0wTQhXNuGCpQFLGd9zrumt5h6H4Z012QrKVTCU0/5eHFcjRCwLwBgqnZ7j
 c8Z3ewFq2wg4O6hqkWc80c12ob0lmatpSQQFBG0NiiofuhR2uUz1A9UI7jGdsDi76Gop
 Hcng==
X-Gm-Message-State: APjAAAWoOqeVnGhTw2hFF0iyXPJStSN8iFF33kwWqBOfXhK3hXFUTm/4
 nfEjBKaipi3THHJujfdGi6JfqYm9rGE=
X-Google-Smtp-Source: APXvYqxkpxCgMyFFqKqMps/rmdnL5J9fvp2WMFfLwllQwKQtze+1AU0XqUTEkBSzzr6m+fX+ieBVzA==
X-Received: by 2002:a63:f814:: with SMTP id n20mr20921854pgh.318.1576534347942; 
 Mon, 16 Dec 2019 14:12:27 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/28] target/cris: Remove MMU_MODE{0,1}_SUFFIX
Date: Mon, 16 Dec 2019 12:11:47 -1000
Message-Id: <20191216221158.29572-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index aba0a66474..bc43bc23a1 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -252,8 +252,6 @@ enum {
 #define cpu_signal_handler cpu_cris_signal_handler
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
 {
-- 
2.20.1


