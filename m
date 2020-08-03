Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D903C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 22:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD3E2076C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 22:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fPxfARKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD3E2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2jCS-0003ki-8d
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 18:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3PI8oXwMKCvssffjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--pcc.bounces.google.com>)
 id 1k2ivQ-0007ou-4E
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 18:27:20 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:46843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3PI8oXwMKCvssffjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--pcc.bounces.google.com>)
 id 1k2ivG-0000v5-G2
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 18:27:19 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id a14so40764530ybm.13
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=B4m3PxqDTvPw7tm6WU6OvMjg7gp8LiTODdOlcgxss48=;
 b=fPxfARKZV++9IqcKNXysaShvxSS1YSg6hH+9Nkfj5sFkvVJy+YAMMQQEO7SmaDpJrB
 arcF/nrHiRaXugSz2v9e4gMr7lwiEI8LTLmJviUpNyffE+xbgVyCuAuXw7uFvmZlhkP5
 OtlwjXvTjZ0Ejt1n4F5IN8NwzEK/D+4gCobmnzyr6ay9QxBDJ1eLqIQYMpWfnlZNTWvM
 8+A2WBgCp5AVDEdebSzwQfevN8BLwvLHw3PYTFR0lzS6TFDaxT5JO4X06YXOjmXPprV1
 isO2tbCA04ajWvKOgZi9jTy9e6Dvegxd8gxk/Y2nWP3M5uS8RItwCP5uhZimOYKD2DN1
 e2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=B4m3PxqDTvPw7tm6WU6OvMjg7gp8LiTODdOlcgxss48=;
 b=A6lYcGBw+d62+Mq8nU74/nuXw75ym1wgcXswKncXQQcvERMUl+wRMoUhJs1lQZkpNS
 Dr7c8wdikWwNQL14nj6AuVSQhWy9aE/Jy0d9p49PTg2CfU2MAO7mIPSm5nj+Ko1VUBey
 y5FtyrjXLtplKkAT5Ii9kGLN19ekuGFreSdMzMvIC213sEqsX+8LdoZudecfgGYu1tyQ
 exE1vnLDqAzn9FYpNul56Fj9Hc9pXPedpx+CERS1sbYMCB4HhZiv5a4PVaONusYf+xwN
 qOaBP4Txmwlryxcg/2nduuJdeK9FGFleJgy49HQ8Hvfhe97CWd6Ut6LpIrxEbsfmgWdM
 T/MQ==
X-Gm-Message-State: AOAM5311GV0SlcfolFxI3UafbM9YcALfILSYJKZiEi2kYLvnfhf5C/pf
 UwdUkxqsMXkE2epLiMsqv7noyHo=
X-Google-Smtp-Source: ABdhPJx7F6dx0AtGh6DpKMlliUMgwH4DAJJVRfhxHxbrP+t/aKPnf6qK01Hm+hQf+0e//nyfhpXtM/U=
X-Received: by 2002:a25:bfcc:: with SMTP id q12mr26869346ybm.166.1596493628017; 
 Mon, 03 Aug 2020 15:27:08 -0700 (PDT)
Date: Mon,  3 Aug 2020 15:26:56 -0700
Message-Id: <20200803222656.63936-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] target/arm: Fix decode of {LD,ST}RA[AB] instructions
From: Peter Collingbourne <pcc@google.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Cc: Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3PI8oXwMKCvssffjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--pcc.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 03 Aug 2020 18:44:06 -0400
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

These instructions use zero as the discriminator, not SP.

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 target/arm/translate-a64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8c0764957c..c996ca1393 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3429,9 +3429,11 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
 
     if (s->pauth_active) {
         if (use_key_a) {
-            gen_helper_autda(dirty_addr, cpu_env, dirty_addr, cpu_X[31]);
+            gen_helper_autda(dirty_addr, cpu_env, dirty_addr,
+                             new_tmp_a64_zero(s));
         } else {
-            gen_helper_autdb(dirty_addr, cpu_env, dirty_addr, cpu_X[31]);
+            gen_helper_autdb(dirty_addr, cpu_env, dirty_addr,
+                             new_tmp_a64_zero(s));
         }
     }
 
-- 
2.28.0.163.g6104cc2f0b6-goog


