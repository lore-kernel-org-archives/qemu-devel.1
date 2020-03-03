Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5AEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6CCF21D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nT/GxoRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CCF21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vsr-0001DV-UD
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkY-0001lK-UE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkX-0004Kx-Qp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:30 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:40182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkX-0004Kg-LD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:29 -0500
Received: by mail-pj1-x1032.google.com with SMTP id 12so536209pjb.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=dPJ9PIVmXWg5PPkPFCD2Z/Ek444prHrmA3NLPOaiVyc=;
 b=nT/GxoRvW0mVjcPi8nNIMMS6rvMQF57vXDS1/vt6ITFUUpwiQPAyBy4JLA8TJKNPkX
 KzukUrwyLzpgB8d1Se03t7rPJYSVhgwnKTD4N8kKfLch4RW2sCRmM3CLAfHNsaQCsD+T
 g6fPqnnTKGLuaYCtE9RHoz54nJoa8jLhvdyOcDzmim21HKfgS/yxis3MqpP5iJAfz5dB
 VWJFczhC1yJAePMWoWEhJ4QC2J4AySb/xgU8MP3hFJNwalagNsHKqD5rcsWJ6IL2CRrE
 Icp9+uKu6tBp8SPkiXcgCefiWoyaktZhuTn6OCTPS2K5a0iUII4pAPuVi/gTpbvB7pwa
 hDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=dPJ9PIVmXWg5PPkPFCD2Z/Ek444prHrmA3NLPOaiVyc=;
 b=bFJ+rWjYLZmjh22NE8gX/eAlmfgPoffCkwLPPqwYlcqNDfAq1P8BZZ5l/wfXIhhqzf
 4ZFsdVz8y2THMXQJOPynZxFEYWFLLF0JuZcxAubobPWQ0oEjh0mvO2nNTyocpkDewsFO
 6dxTDD6pcXJfv2CoOF2eJXb0dJntCYcJaVX3lsQQe0i+i/3XuF6yQdq0FFOQ6TaZ4P3h
 rlN/e3UpKSGQ8o5PlJmM5oUJPxZAdRxW+YzCRoLUXN2aNfFWFutk5ACFY9TbxS4YPQWb
 iG3Q3wTJkS9Hfn7770x/g0EqSuSSQ5p+3PVFJRrWrDf78kHqsLcEpWuy/tVrHNxVmDpm
 8jfg==
X-Gm-Message-State: ANhLgQ1oJFLZJ0SYFvnMTc0nKFl2srh0fCoBzuYK4owNs9SQiQzrTvmX
 9McO6B7NUL07Jz7qd5LPQ9N1IyQalhboCQ==
X-Google-Smtp-Source: ADFU+vsmG70ZPllkr7PucjKutAoAb3BKaC7mz4QLoDpdvrQIVvTNMMlECLHUD14e3I2PPHiid4Wsdw==
X-Received: by 2002:a17:902:ed14:: with SMTP id
 b20mr1727849pld.197.1583196568345; 
 Mon, 02 Mar 2020 16:49:28 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id x65sm9197758pfd.34.2020.03.02.16.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:27 -0800 (PST)
Subject: [PULL 18/38] target/riscv: Add support for virtual interrupt setting
Date: Mon,  2 Mar 2020 16:48:28 -0800
Message-Id: <20200303004848.136788-19-palmerdabbelt@google.com>
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
X-Received-From: 2607:f8b0:4864:20::1032
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
 target/riscv/cpu_helper.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9d5a06499f..ccf67aca05 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -37,13 +37,36 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 #ifndef CONFIG_USER_ONLY
 static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
+    target_ulong irqs;
+
     target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
     target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
-    target_ulong pending = env->mip & env->mie;
-    target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
-    target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
-    target_ulong irqs = (pending & ~env->mideleg & -mie) |
-                        (pending &  env->mideleg & -sie);
+    target_ulong hs_mstatus_sie = get_field(env->mstatus_hs, MSTATUS_SIE);
+
+    target_ulong pending = env->mip & env->mie &
+                               ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
+    target_ulong vspending = (env->mip & env->mie &
+                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)) >> 1;
+
+    target_ulong mie    = env->priv < PRV_M ||
+                          (env->priv == PRV_M && mstatus_mie);
+    target_ulong sie    = env->priv < PRV_S ||
+                          (env->priv == PRV_S && mstatus_sie);
+    target_ulong hs_sie = env->priv < PRV_S ||
+                          (env->priv == PRV_S && hs_mstatus_sie);
+
+    if (riscv_cpu_virt_enabled(env)) {
+        target_ulong pending_hs_irq = pending & -hs_sie;
+
+        if (pending_hs_irq) {
+            riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
+            return ctz64(pending_hs_irq);
+        }
+
+        pending = vspending;
+    }
+
+    irqs = (pending & ~env->mideleg & -mie) | (pending &  env->mideleg & -sie);
 
     if (irqs) {
         return ctz64(irqs); /* since non-zero */
-- 
2.25.0.265.gbab2e86ba0-goog


