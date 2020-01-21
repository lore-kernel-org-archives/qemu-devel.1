Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71FEC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67AD217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhK0Xmzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67AD217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu3Aw-0003bY-Ge
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 18:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39J-0001f0-3p
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39G-0004rW-MT
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:32 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iu39F-0004ov-LJ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:29 -0500
Received: by mail-pl1-x644.google.com with SMTP id c23so2051384plz.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 15:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to:in-reply-to:references;
 bh=hY7S+SF926n6ouIjHpuwLDOoGx0oWtblsPQ8kOr7Bwo=;
 b=fhK0Xmzn8XReFmYk2KEsMa8tvwOu9EpbxMxOv8JtwtADiCDmvvTBppPp5EoScznAxo
 g19pnD82LFUyzEHiLx+hPfRfGlg5ANqR8SCgpeZkP7YRbhlGdgkg6Zffe4I5XhdYbw2e
 LQ6v7PWn0XXvUfDsuA4P8qKBSRcckgxxq3ZrmgkOUKLdznQz+Qzd0xPiMUrOveOAiBhZ
 KSlZLZbUfgbEJa39Ni1pUsNZ2YB3oQecyGnHwIy50lwmXuJvraoD7O5BI8WsxM8VxE8s
 +NlhDAn2+PXHEqV/4L4mVY88k+JIWMj4NHXe2NSKLcHRprQbK52ViynK1muhMk5Xvpq4
 4MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to:in-reply-to:references;
 bh=hY7S+SF926n6ouIjHpuwLDOoGx0oWtblsPQ8kOr7Bwo=;
 b=Kfm0mWDaDJKgmxDqkRRyQa8PjzrjGGGpUUqxNVGi7XTYKR3Ns/PevHenL0oy/rDiMd
 UQ3IwEJqHITBGAL5aGJXStj+Tn2eU62YRdyNii3czZfyGipAkv3Qgd59z0oLxeBigv2B
 ipDDzoMN7N5N5Iznp5bVKxh6cUQIgQPjmPRDcqC3q+Rp5Hz2+ZVjRhHcSNp1lcwl4hRx
 JgRiAqt+d5Qz/wXR/oZJSHJtQ9+ZHr0Q4/hakJPamfRYvziY5JU5hAfpwVj3i7kTdAcN
 hL1CrRRxaohJ292AsO695ID72PpPUwJ/HH1vxKoCMW/Nvnj/kxxf+Es0Z0aFmOzOrh7m
 NV4g==
X-Gm-Message-State: APjAAAWxaCTyPi0v9WzYE44CqSORbgdK/x8BQ9BnPBwGfp/kwLtcV4fg
 y0g7WO8w9xEtUc83JD0NoF7/YRZLOrM=
X-Google-Smtp-Source: APXvYqxfOFxbHY/6D+Cr+vLzePiUdC+VazBWttvxJj4NGdZfqmVF/HpKPEMOT9wSSxxHAc2AmbnFGw==
X-Received: by 2002:a17:902:a504:: with SMTP id
 s4mr8082628plq.333.1579650085715; 
 Tue, 21 Jan 2020 15:41:25 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id b19sm43513137pfo.56.2020.01.21.15.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 15:41:25 -0800 (PST)
Subject: [PULL 2/5] riscv: Set xPIE to 1 after xRET
Date: Tue, 21 Jan 2020 14:56:59 -0800
Message-Id: <20200121225703.148465-3-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org,       qemu-riscv@nongnu.org,
 Yiting Wang <yiting.wang@windriver.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <20200121225703.148465-1-palmerdabbelt@google.com>
References: <20200121225703.148465-1-palmerdabbelt@google.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

From: Yiting Wang <yiting.wang@windriver.com>

When executing an xRET instruction, supposing xPP holds the
value y, xIE is set to xPIE; the privilege mode is changed to y;
xPIE is set to 1. But QEMU sets xPIE to 0 incorrectly.

Signed-off-by: Yiting Wang <yiting.wang@windriver.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 331cc36232..e87c9115bc 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -93,7 +93,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_SIE : MSTATUS_UIE << prev_priv,
         get_field(mstatus, MSTATUS_SPIE));
-    mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
+    mstatus = set_field(mstatus, MSTATUS_SPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
     riscv_cpu_set_mode(env, prev_priv);
     env->mstatus = mstatus;
@@ -118,7 +118,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_MIE : MSTATUS_UIE << prev_priv,
         get_field(mstatus, MSTATUS_MPIE));
-    mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
+    mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
     riscv_cpu_set_mode(env, prev_priv);
     env->mstatus = mstatus;
-- 
2.25.0.341.g760bfbb309-goog


