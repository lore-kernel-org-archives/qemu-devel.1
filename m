Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF1C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D59021D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2uFP1f/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D59021D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vyv-0006gx-7a
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkx-0002ie-Tr
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkt-0004VG-Ql
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:54 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vks-0004Tl-Tx
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:51 -0500
Received: by mail-pl1-x644.google.com with SMTP id x17so497590plm.10
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=K4iuwnZKk8MjfgAofzgXfmuGJvew57sqzgzfazcOgLo=;
 b=p2uFP1f/C7Br/ykLKeSK8IA4rQcKuI/tYyaAGts02769Ux9xbuXth8cdz33/+peND9
 J042EH+c3Q10H/iABTVu4W0BRVOY8IGQwqCRUV6s8bjD7oSLIBHQR1ziDCadoQwrUpo6
 wEB2X2369vyIBl051MM8dJG35MMCgbbv9Cmndnwcyiwf4Acq84Nz/MQbmgW85enkjXVR
 8GcYK9HILbxMLTmAWiWPgRz9DP30mN5oWE51O7bVFJCNu6XlMh50MffWTgb0LvE++sRE
 POYF+Ev7LwB0GH4XFGaqCWxHz5Bs5XuYq9VtAG6w/xGX4Jck0+LFb8i1NroqywAITkhP
 +sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=K4iuwnZKk8MjfgAofzgXfmuGJvew57sqzgzfazcOgLo=;
 b=kkqP0cvSfzrI339P0g4B9hw9hHHe71GC/QO3ynry3ZrdNhExCphC0KgIt2O2+S3Py2
 YgxFVK/FVhPYQlpozG1g5EduZ3cq2MxuBCl1Seq6kkV3zhDVX6rEcljEaKGWn5svNDdW
 6HjueCwI1B57qNAlPaihE6c+2Kf0tXdR9G/m1zxxoJ790+WGu5CyxkXdJZimrT0ngcCl
 xj/x+YHxePWxSFVJ0wg0bWtp+blKURuh1FuqmaeIAOkG/ofubIQ8szozc3qrdJ/7n6GH
 7oSOapGKkwe7S60DgDK/e2i/8o3ItJX9B5azmzkJNtiwi475IqycWGfKgSTPdnb1RWd2
 YTUA==
X-Gm-Message-State: ANhLgQ2n4FAYHlqtsZOB/xkgObrN2mEoCQzg+dRSZcMKAsGXf2ZaePkH
 wEYdPbM5f2qvXrsb3exQLK+rCg==
X-Google-Smtp-Source: ADFU+vukNh3FxGhY8lT6adpRrBhNLhsl4gGteSU5zfzM62/YqJnsnp9l9JYWvoM5rQxXnvcYTQE96w==
X-Received: by 2002:a17:90a:f0c4:: with SMTP id
 fa4mr1186814pjb.125.1583196587713; 
 Mon, 02 Mar 2020 16:49:47 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id d1sm21802272pgj.79.2020.03.02.16.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:47 -0800 (PST)
Subject: [PULL 28/38] target/riscv: Respect MPRV and SPRV for floating point
 ops
Date: Mon,  2 Mar 2020 16:48:38 -0800
Message-Id: <20200303004848.136788-29-palmerdabbelt@google.com>
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

From: Alistair Francis <alistair.francis@wdc.com>

mark_fs_dirty() is the only place in translate.c that uses the
virt_enabled bool. Let's respect the contents of MSTATUS.MPRV and
HSTATUS.SPRV when setting the bool as this is used for performing
floating point operations when V=0.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/translate.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 3ce86adb89..b51ab92068 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -751,7 +751,21 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
     ctx->priv_ver = env->priv_ver;
 #if !defined(CONFIG_USER_ONLY)
-    ctx->virt_enabled = riscv_cpu_virt_enabled(env);
+    if (riscv_has_ext(env, RVH)) {
+        ctx->virt_enabled = riscv_cpu_virt_enabled(env);
+        if (env->priv_ver == PRV_M &&
+            get_field(env->mstatus, MSTATUS_MPRV) &&
+            get_field(env->mstatus, MSTATUS_MPV)) {
+            ctx->virt_enabled = true;
+        } else if (env->priv == PRV_S &&
+                   !riscv_cpu_virt_enabled(env) &&
+                   get_field(env->hstatus, HSTATUS_SPRV) &&
+                   get_field(env->hstatus, HSTATUS_SPV)) {
+            ctx->virt_enabled = true;
+        }
+    } else {
+        ctx->virt_enabled = false;
+    }
 #else
     ctx->virt_enabled = false;
 #endif
-- 
2.25.0.265.gbab2e86ba0-goog


