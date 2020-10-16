Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A00EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568BD20725
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJg/GSpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568BD20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUl2-0004Bm-SL
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgS-0000VT-3c
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:33 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgG-00027Q-Ll
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:31 -0400
Received: by mail-pf1-x444.google.com with SMTP id b26so1999153pff.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cq0uFj4EPvaT7XIB2x7QEFAKMyx7fIErYUcL6pVPEzc=;
 b=AJg/GSpfwAMptofEmN8Zw5f4rcthuQxJ81zUqSvkfobf0mE1Mqu12+dzUkqRuPBP+Y
 EWqoeZbWR8pMmSJriG2PaLg8DQq/BNdjJOMNZo388vZqsb/jgfG1OXDHnivQuxZgq2qm
 4tzIEGLh/UrfqkFMbJOSj9LeeS1kPlEXIBt+UCpm+x36VQE6awlSxkZstPcZNkBZQZ/B
 J1EMUR8WAzG1WzLgbR224vjBJXpzT34cLCr/njteowlo9FYv5Opd3mECoew3oK5tVD/B
 6vaW8JuModd/7By3W/t8eu4zfoGzuS1BTdoY016rMK6zLKtsgMxMHwamw+0QvETfd9mG
 /5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cq0uFj4EPvaT7XIB2x7QEFAKMyx7fIErYUcL6pVPEzc=;
 b=FqwHHrEd0rmBfLUvp2fhN5+jhjFxr8sMrNGQ66I6a5zs0xf1xT37foa70g88ubdbb6
 tseHzPjoIm+5hY6cDAH8XnMo9Q/3ZDDlBYf2S4+8n0H1T3yIHvw6PPCJvBhziMlm7YcT
 TLgLP87aqzCtlpDZFzIqlsFnGPSI2t41fArfLXxWpByw6ArPsQB81xNbg361K3RNmol5
 Ki5oD2fQKUqgg4bwkKHMhndVyPBleGAzzlTQo39Z5XnzcPZd3GFbMYZRFQIE91yTMLCE
 RfAn8gxijLnJdwUEfnMxg+YvAF4fqWA+uXPkyUXxMPFjNz/8h3mwB4cw56MszSP7LRJQ
 DBiA==
X-Gm-Message-State: AOAM530CyZMDoHx7yNXSbUFjD7YZFBis5JuPNt82GnkVeYFnYXNU3zWY
 nXSQDf4WgKJqqp5GhUyi8HQU1ZvtzEc2HQ==
X-Google-Smtp-Source: ABdhPJwmi2tPKDAF6m3T2YgJNvP1tGgjdNcnLIW71R9qTvkP9PVvOFhpZmQQiYipJhEN8sYoetjQTw==
X-Received: by 2002:a65:6493:: with SMTP id e19mr4219366pgv.276.1602873739069; 
 Fri, 16 Oct 2020 11:42:19 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 06/12] linux-user/elfload: Adjust iteration over phdr
Date: Fri, 16 Oct 2020 11:42:01 -0700
Message-Id: <20201016184207.786698-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The second loop uses a loop induction variable, and the first
does not.  Transform the first to match the second, to simplify
a following patch moving code between them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 290ef70222..210592aa90 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2426,17 +2426,18 @@ static void load_elf_image(const char *image_name, int image_fd,
     loaddr = -1, hiaddr = 0;
     info->alignment = 0;
     for (i = 0; i < ehdr->e_phnum; ++i) {
-        if (phdr[i].p_type == PT_LOAD) {
-            abi_ulong a = phdr[i].p_vaddr - phdr[i].p_offset;
+        struct elf_phdr *eppnt = phdr + i;
+        if (eppnt->p_type == PT_LOAD) {
+            abi_ulong a = eppnt->p_vaddr - eppnt->p_offset;
             if (a < loaddr) {
                 loaddr = a;
             }
-            a = phdr[i].p_vaddr + phdr[i].p_memsz;
+            a = eppnt->p_vaddr + eppnt->p_memsz;
             if (a > hiaddr) {
                 hiaddr = a;
             }
             ++info->nsegs;
-            info->alignment |= phdr[i].p_align;
+            info->alignment |= eppnt->p_align;
         }
     }
 
-- 
2.25.1


