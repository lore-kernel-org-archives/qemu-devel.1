Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162A0C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5E120708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox3HtYJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5E120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnIU-0001Da-Qc
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpd-0003oz-WA
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:14 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpc-0003tJ-Gc
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id x7so6612438wrl.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wDo4Ac8Bvr/h/F3tHmitZ/IsFCAT0CVJ5bwb+MZqKJo=;
 b=Ox3HtYJ77Ug7pnxuU5PZM59OE9hh3Os3xaqCyy/nJp+kjOJMh/FFrvAI1EqDx8v4RJ
 +XQVjOST/ZFTKpY5mhivLhnzeqqIew6LpQ1AvEedsKpbsWNuRElOsExiBG88wJZDQGqB
 xke3KR1EIuiP/ZEaKoPbzCsoebpCnOoTTp0WrNcbSTIo9c9VxnTuV0slpHTFxbQ2K4YX
 04dqHRwg8ucFzgJazm0V/RjByyPkXk1bPZNqWsPdatkXDWA5JyjKpKBtAawbQWVIUq9Q
 1pulf/z3jl8XCHyYLbYMnRV9uT656dN3/xmN6b3V2MF0KrcOGSfELp/qJR36uASfOkY0
 6IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wDo4Ac8Bvr/h/F3tHmitZ/IsFCAT0CVJ5bwb+MZqKJo=;
 b=Wp+WSZvpxnWLSfdGia81Gz109M9fxonvj8cm0Js0yQHUPQgxSOKNnYySAeTeFtBI84
 f/Iq+K3rNCu0OYaW6VISimGF6ROJIYELI3wDBya4t2ynUhDoVjxCB8frpW+dn/3pGCGp
 NXViagBS6pYJS4WGyU8EIV/UQ1i9AaO4p5aLtcxE3MgjsM4H/gM32mZgpVDdNnMuoG6l
 jxJAqFiJ/bsZbz7L+jGmLRNNMIJi76aqmorsQL7mjMzyKQyc4iFfSh7Qt/BfhawpKRXz
 GJCedaztWhvP8Gt2xs5eUcCou6EFaY5Evv0nFPXLU6CmhQKRtmbU5ZmutJIVO91zLvBq
 Loqw==
X-Gm-Message-State: AOAM5332QbrQUGoi/8lt5GpYASUPj02H5r1ougsiypxpsSo8zJexqqoa
 c5gw8Gr14LMQxetljggxrbGRmxakn+Q=
X-Google-Smtp-Source: ABdhPJws1PIRtLZP1SPD/bJsJ3x0MEWSUD5aSYA4lJ0GnS05y4Gvxe0Oih/urz67IjnMoFgbQ6Sx0g==
X-Received: by 2002:adf:a50e:: with SMTP id i14mr10379247wrb.121.1602943510674; 
 Sat, 17 Oct 2020 07:05:10 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id p13sm7844630wmb.5.2020.10.17.07.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/44] hw/mips/malta: Fix FPGA I/O region size
Date: Sat, 17 Oct 2020 16:02:30 +0200
Message-Id: <20201017140243.1078718-32-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The FPGA present on the CoreCard has an I/O region 1MiB wide.

Refs:
- Atlas User’s Manual (Document Number: MD00005)
- Malta User’s Manual (Document Number: MD00048)

Fixes: ea85df72b60 ("mips_malta: convert to memory API")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200905213049.761949-1-f4bug@amsat.org>
---
 hw/mips/malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 1e2b750719e..a4a4c386268 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -578,7 +578,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
     memory_region_init_alias(&s->iomem_lo, NULL, "malta-fpga",
                              &s->iomem, 0, 0x900);
     memory_region_init_alias(&s->iomem_hi, NULL, "malta-fpga",
-                             &s->iomem, 0xa00, 0x10000 - 0xa00);
+                             &s->iomem, 0xa00, 0x100000 - 0xa00);
 
     memory_region_add_subregion(address_space, base, &s->iomem_lo);
     memory_region_add_subregion(address_space, base + 0xa00, &s->iomem_hi);
-- 
2.26.2


