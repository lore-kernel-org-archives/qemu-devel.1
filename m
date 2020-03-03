Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E022C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2216524673
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdVKJ7RY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2216524673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vlF-0002ba-6f
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vk5-0000w2-RR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vk4-00045j-S1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:01 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:40048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vk4-00045V-Mm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:00 -0500
Received: by mail-pl1-x634.google.com with SMTP id y1so503447plp.7
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=11a7NIMhd3gpRKr3KvBv9bMb/iOBc4dnUF9RcuuDB/U=;
 b=sdVKJ7RYKhbzocdUPeMdVkhOGAgNPqFTRxSayEleVtT77FgOH/bl2KLRBVT/FlXMxI
 9KxQQzB3WSjL9gZUD6pVma+Daow8iv7Ptuc5EEpvxNz6fQl8VV2cmoBHJO5RJYehVy15
 U4+T2UuFkgxOSR1hsXhrihSG/6eUxDUw5V4sE2Iwwhwku8sP8MtsivW/rXtEn5OEKH97
 eJj14a09z6ngBQl0RS7CDiLveI1JvlNIFxw+Eg2Pys3jB1dqGktDOzMFz8fRNPt4vqDs
 vqg1HXSpZ7a8QG/DRFGPo2bw+axLHVLP7JtA2TD2nRdged5o4Bs8hhK42A2X/KfMpq3N
 2AbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=11a7NIMhd3gpRKr3KvBv9bMb/iOBc4dnUF9RcuuDB/U=;
 b=UhD3sw7f2b4Z2ZHWmhScJSQ/kTVDnsppVfbSrlQ8RfF4j/5FyS4xfwmm5vVYHK+/Mj
 Ns5EztPDReHc0Moe1HaBc+T9GKkC0vS7OI+WnxvfsYGo24hqQoEzyPv5KgrAFLNANIFq
 cyycU12SYmiRQOgzh/nkJ91zOk0LaOZeUn3FBgw+DkiQv5pZuqKKF96JnrOUztmSMeep
 DEe3nSEsRy45mjlteSV8Yl+QrHh86J2byV+QlDfAWaXjmxXj9VKDqe3NtdZdapqujrgJ
 TI5rOTTvf6KUx3d9NL3JsAiWa4T4t5rqatXY2TYC1I9ayMPkyb/fxzWOXNtpkmrW+Dzz
 3oSg==
X-Gm-Message-State: ANhLgQ33dQ1zGRNxwzLTHvnGgolWKxqElGh2AaQyyg78sJR1+HdLoUCj
 b0gwWHOS3HBW8t5AMjH+Ke4o5Q==
X-Google-Smtp-Source: ADFU+vveOm9WETVG6en/Um/PkNxRnF2iSsSH3++tZKX7ih4UuINneoUMaS1ULThCICkRSVNXjkqcZQ==
X-Received: by 2002:a17:902:302:: with SMTP id 2mr1772352pld.58.1583196539571; 
 Mon, 02 Mar 2020 16:48:59 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id 72sm12534071pgd.86.2020.03.02.16.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:48:59 -0800 (PST)
Subject: [PULL 01/38] target/riscv: Convert MIP CSR to target_ulong
Date: Mon,  2 Mar 2020 16:48:11 -0800
Message-Id: <20200303004848.136788-2-palmerdabbelt@google.com>
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
X-Received-From: 2607:f8b0:4864:20::634
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

The MIP CSR is a xlen CSR, it was only 32-bits to allow atomic access.
Now that we don't use atomics for MIP we can change this back to a xlen
CSR.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.c | 2 +-
 target/riscv/cpu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8c86ebc109..efbd676edb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -224,7 +224,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
-    qemu_fprintf(f, " %s 0x%x\n", "mip     ", env->mip);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ", env->mip);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de0a8d893a..95de9e58a2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -121,7 +121,7 @@ struct CPURISCVState {
     target_ulong mhartid;
     target_ulong mstatus;
 
-    uint32_t mip;
+    target_ulong mip;
     uint32_t miclaim;
 
     target_ulong mie;
-- 
2.25.0.265.gbab2e86ba0-goog


