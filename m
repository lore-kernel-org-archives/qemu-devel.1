Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464A0C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9B920775
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixkFq8Vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9B920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8NL-0006Xw-5q
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JP-0000CB-K0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JP-0005HY-7n
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:16:59 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jT8JO-0005Gf-Rq; Mon, 27 Apr 2020 14:16:58 -0400
Received: by mail-lj1-x243.google.com with SMTP id u6so18612808ljl.6;
 Mon, 27 Apr 2020 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yhbn5ObUlRXLSdZsWox5a/Dx90Rzfq3EfLk5bL4LODc=;
 b=ixkFq8VgmDMV3Is1MkLVmjPbXi9rK+RdNdnT1YQRZenBi4QE+5E3SzFZoMUBi7ZS1M
 bQ+LcEyu6B06ZTSmZMI07Y+BlmrC0Frwa23CdGzYVwLABSh9DHx+H5QFVAL3NAe6bx0g
 D+9+Bhh5QML+PijWjZPCn1AMgvnZdza1rW4mM7mqmVcwDITqWr6peBvvVOqdSWlQNkiO
 WhrxI281bKtfYVkTty3f0klw03JQtO+VLwLYCbV37mEChP7H6HyMg5r6ggVUF2rEzrcF
 22XL52iBM1uCtDzPCea3VV+Rc6sTN3hb/y8qA7sfBKxcjlHZueWci2NP3By3FVULTC/6
 2PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yhbn5ObUlRXLSdZsWox5a/Dx90Rzfq3EfLk5bL4LODc=;
 b=WN0FWuiwsEGdR88D9fYiUBko7bmCsn7GFrgv1gasD4Oq2IxwKfDiA14SC34q6z/o+t
 Jqdoh117vAQuU4qxV1b1GUGHjrIJDPT/9JBPKbluRxr99btfdkviV2XJiijEYU690axK
 5bOQr1aA39YxNHml1YrwQkEJHhj7+DEOyRdF38ArICN8d7BRvCYVlRjQ3oCg89WOYKxb
 fqnKDBQTKMMm2GjmZ2zJn3iwPYUIhaCCeq6udJKTwBfgjxhbaHFmd7ujmElMgtmiWWb3
 0pzm5rWWR80zLSJVtH5E3yEVwVv9ERTBya5YMvdrXYeh4hyaYTNuipcbhrpFKHRaxLE5
 4YhA==
X-Gm-Message-State: AGi0PubQgKXxjDP+r+HvWRX2Rm0DCUaQTpLK/GLj3deHsyRd1k2Sofqp
 SWFA+tvg+JINu6fxCjdisnFgQEaPhiU=
X-Google-Smtp-Source: APiQypJtr6MwhnPbz0ASElLt+tMIG/jNcMwa/RVvP7nTg+pixv1rfhOUZ4gG9xhh/qmxDiuiNqGyhA==
X-Received: by 2002:a2e:b4a5:: with SMTP id q5mr15395300ljm.58.1588011414315; 
 Mon, 27 Apr 2020 11:16:54 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id w29sm77771lfq.35.2020.04.27.11.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 11:16:53 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 03/11] hw/arm: versal-virt: Fix typo xlnx-ve -> xlnx-versal
Date: Mon, 27 Apr 2020 20:16:41 +0200
Message-Id: <20200427181649.26851-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427181649.26851-1-edgar.iglesias@gmail.com>
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::243
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Fix typo xlnx-ve -> xlnx-versal.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal-virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 878a275140..8a608074d1 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -440,7 +440,7 @@ static void versal_virt_init(MachineState *machine)
         psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     }
 
-    sysbus_init_child_obj(OBJECT(machine), "xlnx-ve", &s->soc,
+    sysbus_init_child_obj(OBJECT(machine), "xlnx-versal", &s->soc,
                           sizeof(s->soc), TYPE_XLNX_VERSAL);
     object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
                              "ddr", &error_abort);
-- 
2.20.1


