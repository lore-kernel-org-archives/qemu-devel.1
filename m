Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1CCC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CB02190F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgfWw3kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CB02190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4GKC-0003x2-Vr
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzi-0007fx-Hu
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzg-0006S7-3T
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:34 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzf-0006Os-TG; Sat, 31 Aug 2019 22:53:32 -0400
Received: by mail-pf1-x442.google.com with SMTP id v12so6916866pfn.10;
 Sat, 31 Aug 2019 19:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=InrNd1kY5fhWv6+wZr4U5uOiCT/8aoXjdZ+OCAfAKeQ=;
 b=XgfWw3kh6Psrc8p8Vd/pjMdHSdXfYacZEiqAtomgbkrnIEPILFfKtKTMUg3lUUdory
 ovyFBiVkN0XHEdIO1eHqaleXv9sHaFI2DHNMb7+ASMWuGXYY5CfykU4hGCuv0SXBfc+b
 kDFo9t/mrSJy334nyghb3neH8fvzkPn2VdOXeP0g9PVZl2N+z9X8BjxhdUInYPw5vIMG
 WND/FFDZf9dXt5yCd9zCX0RTKFoJdoKp4Yh/2V8Dujt/vSQxZ3bWFz0lddsbuoje78AM
 qWdt5zKjQe0cuUzWZ12i0Rc6F2N7PZqz8xeU1IG2nR45D2NrOufLdiyy7tz7JIzwlBdB
 0oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=InrNd1kY5fhWv6+wZr4U5uOiCT/8aoXjdZ+OCAfAKeQ=;
 b=WubggYuppXLC4Rty9Cu3crNpY8AT8j/dD6V2ypUF93nuGsGQabril2KdmY3CNToV0c
 +V/N6OjRuvtjAkvN1Y6gca7kescLXqdUij+NDJwrZgnO3q5kz0WTqS7BmwocD7rb7rkY
 8kTvERk+K0mqBGU8lwiOH0BEBojatoz8RK34BlnT83lLpWVF9383/7saMXwYjk5L4xL/
 sBTMtpSOMjvnYNB/lNMzfY+khH+RX2CivJ9B1DlxYzYsSh38mkyY+pdGpgRAKhvbRIJF
 BiMriu5XZn+0uvad5SJSnL/TdAQUt7su1bNJXw3jGiJD5TrpKtvr6LUcq3VKIwmkWJ/A
 TqXg==
X-Gm-Message-State: APjAAAWH124lsEIeNure2oxeLlS/KTCdZvRdVgNwnboH2OevnnkvOU3F
 pDN119tReZ/TyB4NiFFYDqE=
X-Google-Smtp-Source: APXvYqwg3q6z95pIWksWT2neqNj3WRlHEWKqlyFy1+sb4RSTXLhaklbuzbiKpCK2gdz0/L3IPMhxFQ==
X-Received: by 2002:aa7:9e42:: with SMTP id z2mr14657069pfq.2.1567306409628;
 Sat, 31 Aug 2019 19:53:29 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.28
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:29 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:52:51 -0700
Message-Id: <1567306391-2682-11-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 10/30] riscv: sifive_e: prci: Fix a typo of
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

Changes in v7: None
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


