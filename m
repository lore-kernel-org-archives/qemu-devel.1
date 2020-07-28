Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC6EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD802075D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dlXP83ux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD802075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Kyy-0007OQ-4P
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1k0KwQ-0003nM-Rl
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:26:30 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1k0KwO-0000pQ-Iy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:26:30 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a9so11115940pjd.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Id9a5vUvad08zDtt5SVSxT+Ins5Rla6YBPDd7YbMPI=;
 b=dlXP83uxY7DEtkclZ1PCWYVObqy64Rt4JDiOI2yEN4I3yjsbNGkjJBuyKNspJ74DS3
 pIGD/oIcu5ltnX5zQZlVA0lnACL1qS7JOMlx3lfbdY42IgRclDDOfvBD4DlzVKfDcguo
 +5yTg8mEXhYtVi0JhEbytHXMAwVvI7t5N8oRDBGuPHy1N6FzXt5GR+CeJjILbwtDY4Cn
 SMGoXFSx4luxEJK01KEgcqFC1Q+X0ecd1fJCmoB6DwlJ+O7xwhTWUBpI5PmgFCXq2G2S
 noeTIVz4dcdZWwRp1HrUhcXff8ZVTNWft//3Da4w7CQEe2NRbuUJ7kKPKXo8JSmVWXzo
 4T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Id9a5vUvad08zDtt5SVSxT+Ins5Rla6YBPDd7YbMPI=;
 b=FDFTS7mBjAQVG2KpjKFvY2jcxpz0qDWFwmlRSzDCbmr/TI31uZqAANH98nK4K3RglZ
 teAVBzG4vvntM2W13EQuxudLja+vcCB/GuGTrDCXUw5kZfZM+fx24j74TcrGNrVqG2i+
 LmsdqUBw/Qyrb3WfS9/TeJl53uRmsjYW5v1OMr3F/D06w09tKrZlc7Awfi8/qAgo88HC
 irkUP7MKS4i7RV6FUmQBctlTP40F4Yyhch+4XrPETnBPMWs1cPK61PV6eVtMiNWoQcsx
 HjvHpROM6JhErDQTntV+/kTHgWJ8VD4cgCxHsf7+vwZeA96gKy6T+xfogSVJZpfcnoEE
 ugGA==
X-Gm-Message-State: AOAM531GqAeQ2UKLwwA6P/BgkyjCy62Hh79VZnoVFQFwf5YLJyyvGZw6
 +fBXOZZl35tm30az9vQNxG5f7w==
X-Google-Smtp-Source: ABdhPJzVKLyk540Lx9/iqpLpZCLhoVFn0qO/YE2NBK/VHbNutIx8Q7a3x7KUFbdIU7QZV3GOxBPhVQ==
X-Received: by 2002:a17:90b:8d7:: with SMTP id
 ds23mr3405209pjb.148.1595924787293; 
 Tue, 28 Jul 2020 01:26:27 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id h2sm17599747pfk.93.2020.07.28.01.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 01:26:26 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v6 2/4] target/riscv/pmp.c: Fix the index offset on RV64
Date: Tue, 28 Jul 2020 16:26:15 +0800
Message-Id: <efbd1fd27a166cc89228932bf498897c4b4744ef.1595924470.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595924470.git.zong.li@sifive.com>
References: <cover.1595924470.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=zong.li@sifive.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>, Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On RV64, the reg_index is 2 (pmpcfg2 CSR) after the seventh pmp
entry, it is not 1 (pmpcfg1 CSR) like RV32. In the original
implementation, the second parameter of pmp_write_cfg is
"reg_index * sizeof(target_ulong)", and we get the the result
which is started from 16 if reg_index is 2, but we expect that
it should be started from 8. Separate the implementation for
RV32 and RV64 respectively.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2a2b9f5363..aeba796484 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -318,6 +318,10 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
         return;
     }
 
+#if defined(TARGET_RISCV64)
+    reg_index >>= 1;
+#endif
+
     for (i = 0; i < sizeof(target_ulong); i++) {
         cfg_val = (val >> 8 * i)  & 0xff;
         pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
@@ -335,11 +339,16 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
     target_ulong cfg_val = 0;
     target_ulong val = 0;
 
+    trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
+
+#if defined(TARGET_RISCV64)
+    reg_index >>= 1;
+#endif
+
     for (i = 0; i < sizeof(target_ulong); i++) {
         val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
         cfg_val |= (val << (i * 8));
     }
-    trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
 
     return cfg_val;
 }
-- 
2.27.0


