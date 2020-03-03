Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834C0C3F2D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5061624673
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRz8aHvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5061624673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vln-0003on-Eu
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkI-00018k-Bm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkH-0004Cf-D2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:14 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkH-0004Bp-7R
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:13 -0500
Received: by mail-pg1-x542.google.com with SMTP id a14so651331pgb.11
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=0wZeGuDyxxT2VXK+x2HGJY5RPxs/tRKAPEIo8LLk5uY=;
 b=XRz8aHvw9mwXIJllfEdN32Joh0I3Q5KyN9t1qf2pl3aow0+Oz/XbUVVORg3OxrvMCH
 KbI7ckgAJfYWV61vCmwZdEin6oZ2iV3raqj0SMUJ2z7/KqPESE6n14xqv9ju/SQyyqqi
 zpdbQ8n8MmsNIp6VMJfKnoLw2gGYAnAreSETe2N4k7K6yClqi/KRi1TVnD6JOHp7umWW
 pDXznfp2zVwIhMw5JERt580AO0VUlx/g6CjUNdob333xB269aqXJbGbxbJsTbEpZc9Op
 NAaa8fLqQqv4mPCbJiJlJLJHqlRFwH2RZ2+dkEIUXJ36FkX4oIAbI4EmU13GoDrW9ljy
 LX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=0wZeGuDyxxT2VXK+x2HGJY5RPxs/tRKAPEIo8LLk5uY=;
 b=TsWKF6ZlhMCX3D54qMSM4nj1Aq4hCGcr7lHBEwAsUYeFVzwt6HzkJ/iRQHzEqG6U7s
 HlgRV2R8e0sRFQ5LTmXJrNI65QyaJcLycNB7b3z1TIwYeOTkVFKGcv1UBo3bPe6BFChr
 QSe3NEExJszCBZ3ielzTgvlTCZnI2cLKohvgBQWQjZW8vK3snd4+JlGNGebjKsws8SYR
 PKgKgK0zj9m5c0NLMvhgTuZNCVz8CLDNTT6jCyKCZXIpT5qeOx74FdoOutlfMY6wwN2V
 qpJfK+EiWLPsfNSKT3TuOM7aFhZly5Hz4l62ADuK8uOW+VRY92BCtoyPVM48kWFbpWyd
 MrAQ==
X-Gm-Message-State: ANhLgQ0ff9qb+7XzuzauRV8E4ryN11KwA6buRBAq5co27K9GyHLIyxvL
 rftlv/ErLV4u0n1uWtd9WQD1DK5QYnliAQ==
X-Google-Smtp-Source: ADFU+vv5Ipqs5xdMPzfxCudGrPEMJ6k4idS0ZguWp8X8ocBZ5hk1TF1s8F+brQviKvny+Az8eeOlFQ==
X-Received: by 2002:a63:8dc7:: with SMTP id z190mr1524728pgd.39.1583196552103; 
 Mon, 02 Mar 2020 16:49:12 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id 186sm8168133pfz.145.2020.03.02.16.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:11 -0800 (PST)
Subject: [PULL 09/38] target/riscv: Print priv and virt in disas log
Date: Mon,  2 Mar 2020 16:48:19 -0800
Message-Id: <20200303004848.136788-10-palmerdabbelt@google.com>
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
X-Received-From: 2607:f8b0:4864:20::542
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
 target/riscv/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d5de7f468a..eff064dc44 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -810,7 +810,15 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 
 static void riscv_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
 {
+#ifndef CONFIG_USER_ONLY
+    RISCVCPU *rvcpu = RISCV_CPU(cpu);
+    CPURISCVState *env = &rvcpu->env;
+#endif
+
     qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+#ifndef CONFIG_USER_ONLY
+    qemu_log("Priv: "TARGET_FMT_ld"; Virt: "TARGET_FMT_ld"\n", env->priv, env->virt);
+#endif
     log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog


