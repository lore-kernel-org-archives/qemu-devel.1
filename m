Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F92C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E2C20704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oev4IKKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E2C20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRj6-00084i-4c
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYRe7-0001v6-KE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:28:35 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYRe5-0001t8-Tx
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:28:35 -0400
Received: by mail-pf1-x444.google.com with SMTP id c20so4862897pfr.8
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6Vj7rJ1HbGvjo2klZQHezr8aeMv8wuLNCnIvPj2MkoI=;
 b=oev4IKKj39K+dlRv61PDTEHJjun6fGQE93WWrQ/HRplMBxzXsh6aigCRtcQLjDnmo3
 qsSALxyHPwmxmUEzNjw3X1S/SKJWCoYhGfMCzQ5J4GTWMA3MHnnhkpqxalNki+Ol3gNZ
 yGz8zQHTptrMREQ3bk6grq349MNlqoxT3xNEEKBfkS4QD1Kg4vXoVBN2LVoTw4Sawpvm
 hxLACrmXaxgmAr3u5S/1Q5X9aNN7X17i7T+0W9eI/pa9RaN6FhN9uiSNwytohqr6a7b9
 hrEOVP1PcRdSHrMcrQtS/4BCulNQN2taHX/rr9KleV8GMlR0ZcoUN+MwKKjh+7ZnCKof
 lQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6Vj7rJ1HbGvjo2klZQHezr8aeMv8wuLNCnIvPj2MkoI=;
 b=jKQbraVGbb8KJ8MWlth4Apeahw8Rd17xtdPMZ4BuQTeb8OHbqsgMKlRV3GZJBKo1Hq
 tHgcpuUy8M0dfEgER3FcIxrCbXRYNodlEDbEvmU8zD3cuKf0Grvj8cObHjFh/72ZAF8S
 KIP+CPVPzaXF4ZT0cyCoAGPCmKVNp6mjV0/nwysAHb+fU2ONWiD2gv+8lj4xxVO1PYwM
 lFN0BYQyMkwE1sa0UolfjUDnccPl5MsQCy6NfOxEiyybGGuhFgQ56Syo6B6mzVEkOaEg
 8GWUcy8NJWFfwHItFfbPGz2aoVBRHXw/EAqh97vhWy+FT3eiSfJO3j5EBihKfcThZ+Vx
 HjkQ==
X-Gm-Message-State: AOAM530qirtYq8S0klPUw9baTDDhSc0Heyh2nAkx380An/9dAALQy4qT
 CeFH30NfjXiKd0JWzlKcC6aueRuo4zziYw==
X-Google-Smtp-Source: ABdhPJzMYW+bQZlbKZ8CP4O35XO8tAPKxBma9WxRixH9mpmMGXfv08/NA1jtFAaFPumlbOEdNQ/j5A==
X-Received: by 2002:a63:845:: with SMTP id 66mr1559645pgi.318.1604053712735;
 Fri, 30 Oct 2020 03:28:32 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id v79sm6062146pfc.197.2020.10.30.03.28.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Oct 2020 03:28:32 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V16 6/6] docs/system: Update MIPS machine documentation
Date: Fri, 30 Oct 2020 18:25:41 +0800
Message-Id: <1604053541-27822-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
References: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x444.google.com
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
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update MIPS machine documentation to add Loongson-3 based machine description.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 docs/system/target-mips.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index cd2a931..138441b 100644
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
+-  GPEX and virtio as peripheral devices
+
+-  Both KVM and TCG supported
+
 The mipssim pseudo board emulation provides an environment similar to
 what the proprietary MIPS emulator uses for running Linux. It supports:
 
-- 
2.7.0


