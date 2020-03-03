Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186E8C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9E72467B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dt9vrbrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9E72467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vuB-0004gC-0u
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkn-0002P4-50
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkm-0004RZ-4I
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:45 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:38468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkl-0004RD-Ue
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:44 -0500
Received: by mail-pf1-x433.google.com with SMTP id q9so560097pfs.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=p/aHvK4Ow3ycdFh8n3Jb7MsDbfRWgHzYPLH7LzUr5BY=;
 b=dt9vrbrLfbbL/2xf5fuMrXyA192F+47JRTaFVyaK9Ncr4NeeVU8cl2E8pwib0KXQG/
 /jnS17zYQsH//CG4tUbWbPFaJiJgafbDAMtnLj6oMAnRpXYB4Rr467xRG0vY90uMoje4
 anV61bQAQsvVSmmq5z4T8k1IVnwcb/v8+xP6THZMiMbLI+h9nJI4xUzRBK9Z1k95QWa9
 +NgITLtrJ6GRqNTGdPhvDlQ3k/fPqwKn3Hnq8+9kHxXlfE/QNyW3X6ezIM7FoY7PxjNa
 /QkFZH4IMm5sceC/ZTww5jOpu7fEGPTaeSdF4fU4c+jmx+MNp3UrO/+cWOt0rybcICIJ
 r+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=p/aHvK4Ow3ycdFh8n3Jb7MsDbfRWgHzYPLH7LzUr5BY=;
 b=WoUokPZvdsqSQrcUibl2bfGwg+rIcWm8B03PezPbeo96ol/+vVxbaiU38EUNM4kdGW
 x9kkiv9Zqvr0aU/6yYKZUp6IFX9YoScU3G310EhoKwtnPcPKZnxTm/dcXc6ENUzNey4i
 ntgUyIHq//RUy6sc2mHBmY12ugI/bdGFbjhhBR6n5n5mN+KPzFlGS4He/J/WI/QMpVsJ
 /Iz7ZWKBuxSCwGHBUObxIZiD1I6RR5jhFLcBs2DkjjECaAwePMgBo5Sb2dxsRHsNam94
 T89JSQz9SVC+BLuUXzqwClZHBt9R1bDiqDhsAlrZQydwaqYN5R5vlKN3M9AInwiPuRUD
 je8w==
X-Gm-Message-State: ANhLgQ1mPY48i1hwsobBjarAt/B4IrVZ63ESij2ETWkLJp2lLiXakDKO
 3wdoRKUFrfBo86xdhRVTqtq1KQ==
X-Google-Smtp-Source: ADFU+vv96l6UZqK/+eeM++pmgQdQxUmvygEPEeNsj0eHzkhc8DX9fqavMgAFP/ekSt6eiJSIvg3xbA==
X-Received: by 2002:aa7:8687:: with SMTP id d7mr1622724pfo.164.1583196582854; 
 Mon, 02 Mar 2020 16:49:42 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id v8sm289539pjr.10.2020.03.02.16.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:42 -0800 (PST)
Subject: [PULL 25/38] target/riscv: Only set TB flags with FP status if enabled
Date: Mon,  2 Mar 2020 16:48:35 -0800
Message-Id: <20200303004848.136788-26-palmerdabbelt@google.com>
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
X-Received-From: 2607:f8b0:4864:20::433
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
 target/riscv/cpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5b889a0065..aa04e5cca7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -332,7 +332,10 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 #ifdef CONFIG_USER_ONLY
     *flags = TB_FLAGS_MSTATUS_FS;
 #else
-    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
+    *flags = cpu_mmu_index(env, 0);
+    if (riscv_cpu_fp_enabled(env)) {
+        *flags |= env->mstatus & MSTATUS_FS;
+    }
 #endif
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog


