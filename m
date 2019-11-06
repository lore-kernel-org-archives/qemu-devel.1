Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C34DC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011612173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZb5bGDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011612173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSM8U-0001Ev-1F
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iSM57-0006Dh-Ud
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:14:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iSM57-0001kr-1B
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:14:45 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iSM56-0001hh-RK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:14:44 -0500
Received: by mail-wm1-x32d.google.com with SMTP id t26so3528666wmi.4
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ppajx2TsUCnTlh9u4c0p57YVNOfV7vxJaOxn+KJ6Rg8=;
 b=EZb5bGDgfWY0MD1PeF7OBDaYA5L8zkY/poZFBtPF4hGlbBYpn3BrOPmHSYIRpDZY3B
 rqCnZIjIJ3yfbjLa+cXh5imH3OiQoRXuwSHJ3/z8Pov35QViGBkiidoMa5Am1qP6IFOi
 ACvAjzV45fq45uZtf/Gb5rAlPN4BTQG7fw7axKKu9rp+70nvzwomrjnf5YO1gNdnNw6C
 8LrUC64RphaYmjCXyjQbzmSnHh+ccJj2afytNmf3nZpRvSj2ywXRoGxZ1kpW1iSzaQFc
 ZUmKGLIRmquLcNxAmttHdwi2TRT6Czy9WHLjN3y50XHHKcE2CkHePrf5Te/5cUGR7Z8Q
 9LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ppajx2TsUCnTlh9u4c0p57YVNOfV7vxJaOxn+KJ6Rg8=;
 b=CPxdnovZV/lV8BbKFwf3ZZZabCjVzsO3p8Stwe9j/rPOUmRnIpE8EojCSU+GCJqVo1
 rM3Go3sNYvCm3efrexV2lV8w64hHuX9AMe8ZsTVDaXhIoi2sbOB1qKSmEsx1hGOknfxl
 ny94LI5PLfUOJGWqU4XNtDK6IC0FB9AOB5glsRd4vgnz2DBP0rnmSQrFwSOPqIyW7tEE
 JguVjyhISb5H2mQ4Ku1HYjWnKO1vPFu0d5OhBxGfBmKvpRJrKIVy1J9WaaEdtK7+D3Md
 bhuLHtbkUz3on+K0THBkubTY5DQUsTyxJjevZFm6fU4dfe9g1BkROVARbrewEpLKm9uL
 LlsA==
X-Gm-Message-State: APjAAAVhXnRmDh0GGApQQijrXbZMCUyu4RZd4d/aa84B/U5aGwG47Jc8
 D42XAppaTzBa4CTuADpFdotIr/w8uiA=
X-Google-Smtp-Source: APXvYqwF06MiAv8XtLviYlZqEhH/LU0GJRUG7iI3CXjVBdjZnyjr2Sck5xSAgy23AqCFhKT1zT+xAQ==
X-Received: by 2002:a7b:c3d6:: with SMTP id t22mr2820176wmj.13.1573049683552; 
 Wed, 06 Nov 2019 06:14:43 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id y2sm3376243wmy.2.2019.11.06.06.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 06:14:42 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/3] target/microblaze: Plug temp leak around
 eval_cond_jmp()
Date: Wed,  6 Nov 2019 15:14:24 +0100
Message-Id: <20191106141424.27244-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106141424.27244-1-edgar.iglesias@gmail.com>
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Plug temp leak around eval_cond_jmp().

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index e9ff9e650d..93e22a89ac 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1705,7 +1705,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                 dc->tb_flags &= ~D_FLAG;
                 /* If it is a direct jump, try direct chaining.  */
                 if (dc->jmp == JMP_INDIRECT) {
-                    eval_cond_jmp(dc, env_btarget, tcg_const_i64(dc->pc));
+                    TCGv_i64 tmp_pc = tcg_const_i64(dc->pc);
+                    eval_cond_jmp(dc, env_btarget, tmp_pc);
+                    tcg_temp_free_i64(tmp_pc);
+
                     dc->is_jmp = DISAS_JUMP;
                 } else if (dc->jmp == JMP_DIRECT) {
                     t_sync_flags(dc);
-- 
2.20.1


