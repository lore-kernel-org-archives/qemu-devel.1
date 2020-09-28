Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8696C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C97420757
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdljRBKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C97420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpvG-0004Ux-Ga
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kMpub-0003gh-0i
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:57:37 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:35851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kMpuY-0007uP-UN
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:57:36 -0400
Received: by mail-pj1-x102b.google.com with SMTP id b17so346952pji.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/nx0v7Y3v/7WYmx+DAfRIR0wl6I4NLnpVoOUzG4A1dE=;
 b=DdljRBKdcciJKr7sOUra+LLUQxx0A/8glKsEU3NvQuWFfhQ/afswMqgc3+R4R404yr
 M2xLZodu6ZlfbPONFh8PC55Vrn+dChleOGvS93JihX/fXkxBvKqMuO6LTlRHJHbiFkD+
 SxzZKEnQd/0Tit2t8Qkq4vjRM1w9Dt13Sr33biArEx5YgUPFoFXPK5pIdQb7zd5TWf/C
 2JX2EeO6jPMqdHMxVUYz69vSZ9ZwNb1W0BhnjIwA2pfMvB5dYIzP+kMhBouiS7r8E+7s
 ghj7pKVht5y3gi75E6WRMpdhToEEYrUsURQZc77mMcpE6Ruufob9lzinLBnhYYxzi84F
 MgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/nx0v7Y3v/7WYmx+DAfRIR0wl6I4NLnpVoOUzG4A1dE=;
 b=ZbGQsfJI1qJweiuzcpct7kNUUvZLz3W600I+D6XI3YapGH2wrSGrHBYjQps0eYS1zy
 nuEgs1Mu/9y9ZNZ0ii8+2MLYEnfps5vNu055hZ4cgOnI42oYP5K8C83oEMAkqZPL+R2q
 FJfmqqw3IFPe+dAZzz0im6Zw6H9vFa983YxkIeMiwfG0FZEZAiUNC4f9xQGLaIyA0nzM
 AHZ247iZlddUl++VoVeL0kL3uwXDMtyCdbg4GUxeDL5IlJfMMaABWKN+8bmhuG6ZGmSo
 itvzmvHOt6mehugsO8qIeQ1pS0QEdV3rIi+IQMrt7uFPBWJv/NOAfRLw06pklAcXyDcI
 GU+Q==
X-Gm-Message-State: AOAM530ycaW7GcAwjWMKxAlBEEMXsrpIY25GscMqux6anQCnHeQaQB7q
 geppJbQjWjGMZ60QbLUbbMs=
X-Google-Smtp-Source: ABdhPJxfcozTshV9Zh53cutCQTQv+BwJUeLath33eKbh0T1aQRAAPVeWSKMekIgQJ6jN1HXe0urJaA==
X-Received: by 2002:a17:90a:6741:: with SMTP id c1mr606563pjm.6.1601287053504; 
 Mon, 28 Sep 2020 02:57:33 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id j4sm865417pfj.143.2020.09.28.02.57.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 02:57:32 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V12 8/8] docs/system: Update MIPS machine documentation
Date: Mon, 28 Sep 2020 17:49:46 +0800
Message-Id: <1601286586-1810-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1601286586-1810-1-git-send-email-chenhc@lemote.com>
References: <1601286586-1810-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pj1-x102b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add Loongson-3A CPU models and Loongson-3 based machine description.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 docs/system/cpu-models-mips.rst.inc | 10 ++++++++--
 docs/system/target-mips.rst         | 10 ++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/docs/system/cpu-models-mips.rst.inc b/docs/system/cpu-models-mips.rst.inc
index 499b5b6..02cc4bb 100644
--- a/docs/system/cpu-models-mips.rst.inc
+++ b/docs/system/cpu-models-mips.rst.inc
@@ -48,11 +48,17 @@ across all desired hosts.
 ``I6400``
     MIPS64 Processor (Release 6, 2014)
 
+``Loongson-2E``
+    MIPS64 Processor (Loongson 2, 2006)
+
 ``Loongson-2F``
     MIPS64 Processor (Loongson 2, 2008)
 
-``Loongson-2E``
-    MIPS64 Processor (Loongson 2, 2006)
+``Loongson-3A1000``
+    MIPS64 Processor (Loongson 3, 2010)
+
+``Loongson-3A4000``
+    MIPS64 Processor (Loongson 3, 2018)
 
 ``mips64dspr2``
     MIPS64 Processor (Release 2, 2006)
diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index cd2a931..1f86ccb 100644
--- a/docs/system/target-mips.rst
+++ b/docs/system/target-mips.rst
@@ -84,6 +84,16 @@ The Fuloong 2E emulation supports:
 
 -  RTL8139D as a network card chipset
 
+The Loongson-3 virtual platform emulation supports:
+
+-  Loongson 3A CPU
+
+-  LIOINTC as interrupt controller
+
+-  GPEX and virtio as variable devices
+
+-  Both KVM and TCG supported
+
 The mipssim pseudo board emulation provides an environment similar to
 what the proprietary MIPS emulator uses for running Linux. It supports:
 
-- 
2.7.0


