Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A8C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B19217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBhPjM/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B19217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu3Cs-0006Zi-Kq
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 18:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39J-0001f3-3e
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39H-0004rt-7L
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:32 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iu39F-0004pi-Mh
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:30 -0500
Received: by mail-pj1-x1042.google.com with SMTP id l35so2418776pje.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 15:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to:in-reply-to:references;
 bh=UcbAsElOHsZ2fudjqh0fovhZKSCABUkGsAOTf1+yuLM=;
 b=KBhPjM/L6CReskcfc+Pldb+g2v31FCSgZk060EoYc+7tS+zUUn5qWSfO+Olrelu3/l
 321yNSPWRi4jm2/GNd1/rfLLPJszDIhgejtk4k3M2di9us9/9OiRUo/8DLVpwc2OS2+n
 Mk3bZIVSWli0x1gVPxFyVMfXhnQk5l4Fk0cddgjsWcZxLG/K+DYz1kiS/V4HTJG6QACJ
 ceWBwkD8upOMqlEQZJz1SeSBPRQ37pMnOMOQH1CFeOCWtOUN78Wnov0yXX2Wit5x6DPi
 USRFOQBeqIr5i+/hf+JxfZzFp5xwvqk+so2ZKiR714/eo/KR+Cwh4JzdLc5L0lO33GKG
 lppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to:in-reply-to:references;
 bh=UcbAsElOHsZ2fudjqh0fovhZKSCABUkGsAOTf1+yuLM=;
 b=Z892+cx6kiun6d7us1nry29fKN94/i3ybv8yNtrTlLotWP3w9m01Q+wWPxRwtgeceK
 xJgMZ1+yuh45hhhrATOnAi5zTomuBCwWaFq6jAKi/E7DZovzjVRBb9FDLq89uyl56lMQ
 fFL2qcKhaLX/LgN2C6B9FjSwpIc4uyiJOkWdIhAdzq068YOjOP/YVC8KArM8BA1ZvKCQ
 zQM7tEvhc5SzDDtDhu9ROove85X7DrkHuKaduFZa1wCJIGL+CXJVFN2HkjrDVYB6qVfM
 XMPgIXwYY2KcwXQe7GcQP8YtPTcDhFFf3EGUHFP3vlSpY0MtMOXCySa+ZVe+7NlRrVen
 L0mg==
X-Gm-Message-State: APjAAAWsQTpNEqDh5YhNJ0hUk416i46bxzqw+hcMlL3vFaPqLp0jmO9Z
 kF6IpZlzMtn8ezSSB29BHHGhSP3igqY=
X-Google-Smtp-Source: APXvYqwOUrQFTqzU94rWmMk7cbz6wahj/b9tmTxm5sncjQk1WPLfB7H4Xh//vRUC/9cUFF420oq7CQ==
X-Received: by 2002:a17:902:34a:: with SMTP id
 68mr7665022pld.250.1579650086876; 
 Tue, 21 Jan 2020 15:41:26 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id x21sm44075185pfn.164.2020.01.21.15.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 15:41:26 -0800 (PST)
Subject: [PULL 3/5] target/riscv: Fix tb->flags FS status
Date: Tue, 21 Jan 2020 14:57:00 -0800
Message-Id: <20200121225703.148465-4-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org,       qemu-riscv@nongnu.org,
 ShihPo Hung <shihpo.hung@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <20200121225703.148465-1-palmerdabbelt@google.com>
References: <20200121225703.148465-1-palmerdabbelt@google.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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

From: ShihPo Hung <shihpo.hung@sifive.com>

It was found that running libquantum on riscv-linux qemu produced an
incorrect result. After investigation, FP registers are not saved
during context switch due to incorrect mstatus.FS.

In current implementation tb->flags merges all non-disabled state to
dirty. This means the code in mark_fs_dirty in translate.c that
handles initial and clean states is unreachable.

This patch fixes it and is successfully tested with:
  libquantum

Thanks to Richard for pointing out the actual bug.

v3: remove the redundant condition
v2: root cause FS problem

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e59343e13c..de0a8d893a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -293,10 +293,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 #ifdef CONFIG_USER_ONLY
     *flags = TB_FLAGS_MSTATUS_FS;
 #else
-    *flags = cpu_mmu_index(env, 0);
-    if (riscv_cpu_fp_enabled(env)) {
-        *flags |= TB_FLAGS_MSTATUS_FS;
-    }
+    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
 #endif
 }
 
-- 
2.25.0.341.g760bfbb309-goog


