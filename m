Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0942FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76172467B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8UER3hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76172467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vsg-0000jD-UW
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkg-00025l-QO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkf-0004Pj-L5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:38 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:38736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkf-0004Ng-Fq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:37 -0500
Received: by mail-pl1-x62f.google.com with SMTP id p7so509836pli.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=Tr17usVQSO7by1Colq4RjWz3ztnvP9K6FlBtEfIKK0k=;
 b=q8UER3hqYHBX0mglrgEAtg6e9MqXG5OKb45xseEZiXOeYxdMprvLV3++34mVm5Q7P6
 1QfbGtHrDNtUDlP+nwMWFiBoR5xlyWg2CCFvIr6kgrm6ZGKjx0MypilVqW0pOHe/UiI3
 MfXXwJLuAi8YB0fLVni/0EwWoEYix+o4KFrwpslWDYOGxmky87+65v6RchClrtxTN2bv
 xnbSnkqzYyChvHHP5mQrwoedSA+eaz1crfP4Pwy6sfqLMy/xvFlaIRuuAztGCfg/Z4+Q
 4jJ5OFhx9nH0KbAk59V7F7Cnv53Mtz0wOOQJhNCKQJ+MK1yq/j1wn6bMcyyPzdAnW56Z
 9k3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Tr17usVQSO7by1Colq4RjWz3ztnvP9K6FlBtEfIKK0k=;
 b=D0/rLomJnssItSVz3EldzCH26MiIssKPZ9vz0nzZEvwRn2f404R4Pb0d79nZ1VVJdu
 nZtEUTD0UYYwFselILujpiEoxPekD/0qLH05KX3A2951yPmW3yOdZhLpmv3E4nHhInHX
 dall35x0hpNWCCs8DMBPDK6RoN45JYzpZ4VYwCM6rOmPhyj447XzWOCDBEgDsB6VHFne
 bpdn3Nt/2rzrf3rMccGVm/Jzj90TcvzWhvdkydtHuztYIs+ESlntSxTeFBmdztqQlZmq
 oU9ursvldAOqVJs7silFd/QUGaq6HouyfB1jeb310CNiI7SQJP2DTK8ldlMlm63qA8xb
 bjBg==
X-Gm-Message-State: ANhLgQ26EcHLuce462DuACVuCwIp/PJI2Fb8frODGbvjGiJFNDwjWakK
 eMnrGmkFYgJfa4hGGp6OVIxsVw==
X-Google-Smtp-Source: ADFU+vtL84bneNPUB27mETr4VOj6US5HTpXs5Ck1a0WdPyAN93YyReqsKs05gimKM0qBB3ZCAfumxw==
X-Received: by 2002:a17:90a:7d07:: with SMTP id
 g7mr1170535pjl.17.1583196574518; 
 Mon, 02 Mar 2020 16:49:34 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id 12sm335795pjm.33.2020.03.02.16.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:34 -0800 (PST)
Subject: [PULL 22/38] target/riscv: Add Hypervisor trap return support
Date: Mon,  2 Mar 2020 16:48:32 -0800
Message-Id: <20200303004848.136788-23-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62f
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
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/op_helper.c | 62 +++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 455eb28907..804936e9d5 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -73,6 +73,8 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
 
 target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
 {
+    target_ulong prev_priv, prev_virt, mstatus;
+
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
@@ -87,16 +89,46 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    target_ulong mstatus = env->mstatus;
-    target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
-    mstatus = set_field(mstatus,
-        env->priv_ver >= PRIV_VERSION_1_10_0 ?
-        MSTATUS_SIE : MSTATUS_UIE << prev_priv,
-        get_field(mstatus, MSTATUS_SPIE));
-    mstatus = set_field(mstatus, MSTATUS_SPIE, 1);
-    mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
+    mstatus = env->mstatus;
+
+    if (riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
+        /* We support Hypervisor extensions and virtulisation is disabled */
+        target_ulong hstatus = env->hstatus;
+
+        prev_priv = get_field(mstatus, MSTATUS_SPP);
+        prev_virt = get_field(hstatus, HSTATUS_SPV);
+
+        hstatus = set_field(hstatus, HSTATUS_SPV,
+                                 get_field(hstatus, HSTATUS_SP2V));
+        mstatus = set_field(mstatus, MSTATUS_SPP,
+                            get_field(hstatus, HSTATUS_SP2P));
+        hstatus = set_field(hstatus, HSTATUS_SP2V, 0);
+        hstatus = set_field(hstatus, HSTATUS_SP2P, 0);
+        mstatus = set_field(mstatus, SSTATUS_SIE,
+                            get_field(mstatus, SSTATUS_SPIE));
+        mstatus = set_field(mstatus, SSTATUS_SPIE, 1);
+
+        env->mstatus = mstatus;
+        env->hstatus = hstatus;
+
+        if (prev_virt) {
+            riscv_cpu_swap_hypervisor_regs(env);
+        }
+
+        riscv_cpu_set_virt_enabled(env, prev_virt);
+    } else {
+        prev_priv = get_field(mstatus, MSTATUS_SPP);
+
+        mstatus = set_field(mstatus,
+            env->priv_ver >= PRIV_VERSION_1_10_0 ?
+            MSTATUS_SIE : MSTATUS_UIE << prev_priv,
+            get_field(mstatus, MSTATUS_SPIE));
+        mstatus = set_field(mstatus, MSTATUS_SPIE, 1);
+        mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
+        env->mstatus = mstatus;
+    }
+
     riscv_cpu_set_mode(env, prev_priv);
-    env->mstatus = mstatus;
 
     return retpc;
 }
@@ -114,14 +146,24 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
 
     target_ulong mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
+    target_ulong prev_virt = get_field(mstatus, MSTATUS_MPV);
     mstatus = set_field(mstatus,
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_MIE : MSTATUS_UIE << prev_priv,
         get_field(mstatus, MSTATUS_MPIE));
     mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
-    riscv_cpu_set_mode(env, prev_priv);
+    mstatus = set_field(mstatus, MSTATUS_MPV, 0);
     env->mstatus = mstatus;
+    riscv_cpu_set_mode(env, prev_priv);
+
+    if (riscv_has_ext(env, RVH)) {
+        if (prev_virt) {
+            riscv_cpu_swap_hypervisor_regs(env);
+        }
+
+        riscv_cpu_set_virt_enabled(env, prev_virt);
+    }
 
     return retpc;
 }
-- 
2.25.0.265.gbab2e86ba0-goog


