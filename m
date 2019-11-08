Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8A7FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3CC218AE
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlqgxq+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3CC218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3dH-0003NE-K3
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iT3bM-0001eR-A5
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iT3bK-0000Uu-A0
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:42:55 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iT3bJ-0000U6-BB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:42:54 -0500
Received: by mail-wr1-x443.google.com with SMTP id w9so103974wrr.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 04:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O+7oqTj35SxpOp+OUToP9NWOXc7v9VZvqQg34DnV5Ds=;
 b=Rlqgxq+M3G5kUDVU+FeUVLZznllzB9pffc+eViEeqPtm+9mu5sfblkggk1waBq03BT
 z/8CSPkONIGn0BqHooX5aUOBAR9YxqAsC4gagQlevPt2OtM2NFfpHKK0k/rmV45NDpp6
 GWkp2Fsn7WxT2Fb7aiPDkSLdBqMFb2lXkFVoQ8puDhdO03vp6xPkRnR5Fa7Vzf3upFIy
 ZR/rHuzIThuwZswcItF9qn38SukPs886cTIBn2qsmS1lTCaIwuwQZBtkpNB0+RGMf7Z+
 OoYu3y9u3r1oHN/KNFrBzHZWRojgNDOzmXX0r1blc7pNBTE1NqSknriMYzJFer7Ga+nt
 tVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O+7oqTj35SxpOp+OUToP9NWOXc7v9VZvqQg34DnV5Ds=;
 b=BWcFq3F/EHEOxruVrqhHxcm8UgIccabQ1fOV3gJEJlHX7GMzWxcdwZRw6Q0bTGwBQo
 Npmr13zMJX4JLsqkKN+ClvUDAQDBiFvOtU0mOllKW6zFBaFInPnuLBDSUm7L+kdcAiRO
 LUnNS5FXrS5I/hvF9fnngtAGKXcTAlBWF9T5hDh6t6SHawumZjk8RfJtfl6rIi5SOvWO
 uxcX2bCkP7eISWa6AzDcHElUiRH5BjJ6sca16H26VyVQWRIMTEUpj8ipZY3M1AxSNjzC
 GL2rb0zIGX8Pf+tEum0HAQLJ/70csLLYga6UQfiUzEknheUg4Of5WdaEPRCxGdl8jNRV
 zs6A==
X-Gm-Message-State: APjAAAVPG5HRDgsn+zT0dGlsbfJiAuLX1n6zWrf2StpnB3l58nlWnhCD
 jQcV1PJrw9zBVw/wH/f2aiYyFFN5RSA=
X-Google-Smtp-Source: APXvYqxzRllVgQgIHOmx0PAmgeo+eQVh4kC2FW0ZuCWYbghhdgXmdZL6+5xthcNuOPkmxwxyrzLJ/A==
X-Received: by 2002:a5d:4946:: with SMTP id r6mr7442094wrs.155.1573216972047; 
 Fri, 08 Nov 2019 04:42:52 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id m15sm5866397wrq.97.2019.11.08.04.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 04:42:51 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] target/microblaze: Plug temp leak around
 eval_cond_jmp()
Date: Fri,  8 Nov 2019 13:42:19 +0100
Message-Id: <20191108124219.31348-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108124219.31348-1-edgar.iglesias@gmail.com>
References: <20191108124219.31348-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7b4b66a622..bdc7d5326a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1681,7 +1681,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
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


