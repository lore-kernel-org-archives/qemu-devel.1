Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3233AC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC76F20704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUcTr3z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC76F20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn06-0002Ik-SU
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmps-0004Gt-7Z
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:28 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpq-0003zb-DO
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:27 -0400
Received: by mail-wr1-x432.google.com with SMTP id g12so6557076wrp.10
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4E8kG4ILRSk7MsJbvzjJRPB5rdnj2Bu4UJI6JB3HuIQ=;
 b=iUcTr3z67+6NWNFjA7GDPK4xAEXZT/ImzFGxJEiBeQOurmkUgkmsPOWlluFg2sbsPG
 VqUWHPP4OREMQW2mq0vwsBeN9TE0zcRMpNaN7K8A5aPKUxiyUJBZc5e1aMnQQyjPK0p5
 GeR2S7KF+7KuBNxNNteu8BiX8nx7VHAtNq8e2MRpWoL9bhrV9Mn3IvyXVy/63g9lXpPW
 KEFdkiofDn3rETSsX1BGkFTQy2Fu4z8bJ3yML1eDTIrJErAmDR0OJADK2pyAFsdi2B1h
 Ett0+KMx2mJ3FPobFrXvSZ3sFziHSz0p+ez1+gxUc6A/41KBXsCs1MWyGGdeJjeLgAou
 q99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4E8kG4ILRSk7MsJbvzjJRPB5rdnj2Bu4UJI6JB3HuIQ=;
 b=T+eS3iyc54ObDVHJhr98OYa3egRYDKHMLxkZF4GT8Ukts9v2Nd2zSCbkM3goSNKvN7
 FIu+uWzOGUzHcJZAR2ShYgs+EzjkJCBqxke+J2E9S5zZ6QoAYGKma8FcqSRIr5mqy0AQ
 DrNK+u+PDiud6LKDLwM7g4sbMz8I4fmKAhBUPu/RbshZRFHjdzuHOSU6aT5t8zFZuaMu
 u5QF/4YYaviWm9kvh0fYUamnPJyAlw++KkRaGaz18zJ82/LsinABYAapCJFMbSPl3myy
 H64ceMyYD+04i0vWNz8szytgXNtiIgMEZvYGRbKezXg04qXm47PH65Ymbnd/p70iRzJB
 C7HQ==
X-Gm-Message-State: AOAM533tirwtHqIeJvgMNaSW0lSAb+Na9E9/CqQ/HU6XUKM4f2z/PrX6
 Rz8HGDerPRiJuji4JdDodpV5ltg6DGA=
X-Google-Smtp-Source: ABdhPJy062B0Et3e5Fm/WJ0XhHay2TILDCL+FijssvofiueYvzkbfq5IOZb5gfP7smUTo1VQpn3VNQ==
X-Received: by 2002:adf:f3cb:: with SMTP id g11mr10886090wrp.210.1602943524903; 
 Sat, 17 Oct 2020 07:05:24 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id o129sm7229274wmb.25.2020.10.17.07.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/44] hw/mips: Simplify loading 64-bit ELF kernels
Date: Sat, 17 Oct 2020 16:02:33 +0200
Message-Id: <20201017140243.1078718-35-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Paul Burton <paulburton@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 82790064116 ("Cast ELF datatypes properly to host 64bit types")
we don't need to sign-extend the entry_point address. Remove this
unnecessary code.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200927163943.614604-2-f4bug@amsat.org>
---
 hw/mips/mipssim.c | 6 +-----
 hw/mips/r4k.c     | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index f0042f7f436..afef4f2e77a 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -77,11 +77,7 @@ static int64_t load_kernel(void)
                            (uint64_t *)&entry, NULL,
                            (uint64_t *)&kernel_high, NULL, big_endian,
                            EM_MIPS, 1, 0);
-    if (kernel_size >= 0) {
-        if ((entry & ~0x7fffffffULL) == 0x80000000) {
-            entry = (int32_t)entry;
-        }
-    } else {
+    if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
index 39bc626e7c5..7ee37c49689 100644
--- a/hw/mips/r4k.c
+++ b/hw/mips/r4k.c
@@ -102,11 +102,7 @@ static int64_t load_kernel(void)
                            (uint64_t *)&entry, NULL,
                            (uint64_t *)&kernel_high, NULL, big_endian,
                            EM_MIPS, 1, 0);
-    if (kernel_size >= 0) {
-        if ((entry & ~0x7fffffffULL) == 0x80000000) {
-            entry = (int32_t)entry;
-        }
-    } else {
+    if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
-- 
2.26.2


