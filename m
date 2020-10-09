Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4CCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE012225F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHNoAKHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE012225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQviy-0002vN-Hw
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQvcv-0002gc-Dd
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:52:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQvct-0007iZ-OQ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:52:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so10982970wrp.10
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DiAeLSURx5/8to7pD3+MAvZ/fh+QMuvoNDWO9Nmn9Jg=;
 b=tHNoAKHMys+JykYiBYxqrBnU0se1jGKAAN6yiyvJfG8bMHwge7Pu7VaYnUh44wLXu8
 jb0qoN6ZmMzeSOpBt3N4qSsC8yzt9ZbMin3qa/WDQorA0qXbhkxofAoZXDNsy6OG1Dwu
 xGEIeibfKqIX9Ux8KQBqpo0inergiysSGIPkM2datTDzlznba22aFcstNn52bQylmyOJ
 j/83mrAqzHN2TIGOgYinwubavmWsUAAJyGe3jiMcaFK1oBfusly3tf/XhM68eO2/DO74
 hrNpzUhHkIcRbCCccNILy0R6Tj9B9zhoNRkrzaSEQFqfaPD4a+atix36Qbki1GBMxln2
 oOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DiAeLSURx5/8to7pD3+MAvZ/fh+QMuvoNDWO9Nmn9Jg=;
 b=LmOTpSGa1qMY0ua/0QCKm1jOeMUSN3GZgUNcOnHw0gGssEMwyDO16EbBll+XtnAXRc
 rodn1Jr/6AzzdF8yoHzadWhdBs7EoCkchS/N4bSGRD+wPm0QHj4m7Qoczl7MwXliv6JG
 JsZ0j+UoY1eQUKKiksPAx+kUC0UFvzDExxwiQuNMaexH0FRffJYfxzj58TVRUOgGzDI2
 1qM51t/vU8oK8WUGJ8cv+E3HvgQJM9kchqGnoQLSjJA6gJ8k0R2ABkC6gNMUzvxB/siv
 8QRbBsPfw+Z/OGX9+5g4H+EOJLjS4ADEtfkK4IybeR5FXY6TvGLKX6VfjVKu6GHxbcgW
 e/mg==
X-Gm-Message-State: AOAM533YPo+9VjA1cYxzBDhRpa+X4L9Zv9br/F2h5/zBMUo9pZyDzttj
 3AHaJwBGz0ydOcjH8ok3losfgsGAjPI=
X-Google-Smtp-Source: ABdhPJzkYIoY9CYj0Hhc1mxNYZjVoIgGGfCWghJBFd1mostDwj9eDqbSHzLbxUO2bjodtUnxtVtEww==
X-Received: by 2002:adf:fc0d:: with SMTP id i13mr16388222wrr.156.1602262334194; 
 Fri, 09 Oct 2020 09:52:14 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p13sm12777125wmb.5.2020.10.09.09.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:52:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] MAINTAINERS: Downgrade status of MIPS Boston to "Odd
 Fixes"
Date: Fri,  9 Oct 2020 18:52:06 +0200
Message-Id: <20201009165208.2905569-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009165208.2905569-1-f4bug@amsat.org>
References: <20201009165208.2905569-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paul's Wavecomp email has been bouncing for months. He told us
he "no longer has access to modern MIPS CPUs or Boston hardware,
and wouldn't currently have time to spend on them if he did." [1]
but "perhaps that might change in the future." [2].
Be fair and downgrade the status of the Boston board to "Odd Fixes"
(has a maintainer but they don't have time to do much other).

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718739.html
[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg728605.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2de5943e388..782743b7ef0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1163,7 +1163,7 @@ F: hw/intc/loongson_liointc.c
 Boston
 M: Paul Burton <pburton@wavecomp.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Maintained
+S: Odd Fixes
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
 F: hw/pci-host/xilinx-pcie.c
-- 
2.26.2


