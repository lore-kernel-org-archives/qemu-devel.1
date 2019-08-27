Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB0BC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6917F20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcoWEO1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6917F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2d3W-0001Yt-0S
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cw7-0003K1-NT
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cw1-0003Zn-1m
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:03 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cvz-0003Ti-2e; Tue, 27 Aug 2019 10:58:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id y8so11933300plr.12;
 Tue, 27 Aug 2019 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4WJCx+KkFqxUiJ7i2t7dWrFeqJqfy5xQ4bHLONc/qpY=;
 b=jcoWEO1A6OxaVmdhWNZzSz982QUsm06A6E1Ua7B/JSvRwfany1dfsLYJ2BWIEfYUez
 pDawc8Xvi8b1QmI3EXxEgHYTJqMjJI5RlWH3QLRGBIkb+wgjUshOHy/Gqz0QT/+TgUco
 G8VI4EWoSfIvEIKeO1VKY8c5DTJDVWTynIg561qkaxazSjAYsW/NBkt3tR+sDvTshGjJ
 K9T6VNkKjAPcv/EQUd1rCF7fhVgHy7nQSJ6KFaJgbzYwGqc/uvQATWC+1Pxm5Fz9TkL8
 aK09DEPnO+YMZzFmauzQ6aAXnMyewhduVmy6BXP0IrHFGQyrsYeeDJR4NF0NdJVWiFsN
 k5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4WJCx+KkFqxUiJ7i2t7dWrFeqJqfy5xQ4bHLONc/qpY=;
 b=IV2IjAlFQopMp1dxjq3lKTHKXby+iS9HRTusgRqn4dFRU3GEkv/I7FZiWZv6QwU3F2
 kLVtiJqGNCeptOkdZsbwXQbMEEGcIAalwGudav7mKcRrC7rEZevTpPp701XtBl+EOWHi
 brFkcycQlLrQSfcibTRRi6TZFzBB8fF8ouCYODWF5+FzcJ3KOxsW4gP6MsZoUdFOgZ+5
 STrCQ/1qhNLVqgl+4DrfWdqb0SALruAxAt84GKwZjHDBdEWgDoJz3/juvJBvp8vti/ey
 SbkDSYa0Bo/6h3abLyX7mAoPe1xjrnzIAh9qeecSU35iY25sOc2Q5qM/Gu6cS8HJHfbu
 lZzQ==
X-Gm-Message-State: APjAAAUx2e6pVn6l1nPSDajmMLY8rvY9AEtK+PK6QxxmnD2o2N5tjz34
 p294B9Pv96GdCVQ1L9YOBYs=
X-Google-Smtp-Source: APXvYqxqFxxBhnZKLBbo6FYA53O8YE0G27r5P+0+UXNc7jm8/DQ3ksmlKewHKCVgj4G1XvJwZcSWNg==
X-Received: by 2002:a17:902:2bc5:: with SMTP id
 l63mr25026985plb.239.1566917936021; 
 Tue, 27 Aug 2019 07:58:56 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.58.55
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:58:55 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:19 -0700
Message-Id: <1566917919-25381-11-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v6 10/30] riscv: sifive_e: prci: Fix a typo of
 hfxosccfg register programming
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

For hfxosccfg register programming, SIFIVE_E_PRCI_HFXOSCCFG_RDY and
SIFIVE_E_PRCI_HFXOSCCFG_EN should be used.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_e_prci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index c514032..71de089 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -90,7 +90,7 @@ static void sifive_e_prci_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_E_PRCI_HFROSCCFG_RDY | SIFIVE_E_PRCI_HFROSCCFG_EN);
-    s->hfxosccfg = (SIFIVE_E_PRCI_HFROSCCFG_RDY | SIFIVE_E_PRCI_HFROSCCFG_EN);
+    s->hfxosccfg = (SIFIVE_E_PRCI_HFXOSCCFG_RDY | SIFIVE_E_PRCI_HFXOSCCFG_EN);
     s->pllcfg = (SIFIVE_E_PRCI_PLLCFG_REFSEL | SIFIVE_E_PRCI_PLLCFG_BYPASS |
                  SIFIVE_E_PRCI_PLLCFG_LOCK);
     s->plloutdiv = SIFIVE_E_PRCI_PLLOUTDIV_DIV1;
-- 
2.7.4


