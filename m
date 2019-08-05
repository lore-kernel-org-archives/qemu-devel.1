Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033ABC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5E22064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSLB/xhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5E22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufVM-0001ed-2N
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58546)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPq-0000iL-SX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPj-0002yU-JT
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:52 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPj-0002xt-7P; Mon, 05 Aug 2019 12:00:47 -0400
Received: by mail-pg1-x541.google.com with SMTP id i18so39971316pgl.11;
 Mon, 05 Aug 2019 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=X/eLFOPc89c7dqd+0xx5xUwkAX1UJ8O2PebiV5h7esI=;
 b=iSLB/xhjJMqoaSZ8xZ2pMAqlCvxEG3YyBzbEMQeZyDgmxliU4vISC+gOINgr2ifYNO
 SSxhRDBF8K+KtAfkyWt76Z9zv6MY8o6kh1yaLnP032ZYmFgJeXY7ACvVwFIFdnaDUzvW
 z3rGQQfaMf8AEpYYTjHsZVXfe+qbuHvSShIr3a2r/rNCkEbn9KjuHoHBR6Z9cnTQFX2N
 Gqf1IyeyXot6cO77gUXxLIpRuvZ9iqtxPcJufHVLUUsc6SG90+Sg3aNfXBXanr1WN5N+
 kpib/kUTi5arVgE+Z8JlTB8M6wPdNsRHQM2v6B+gR4yd/Y9Su/fustVkuWZe7DBHqpVG
 9v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=X/eLFOPc89c7dqd+0xx5xUwkAX1UJ8O2PebiV5h7esI=;
 b=dp54zKqxRuuWEKu8d/BRDUtqW2/vYSjo17gKiuwdWhXfkjsJiZ5qtphFEfKClCbpf+
 g9eLj50uWVej3tf6cGBX4J5hXdT2AzDtiJFug8UVPmxox57tpJakLd4hhix/zDFHW3XO
 OgSJwXeDfc5cMr0F9SdZZFL+zVyJ1qmVcGdGAfKISPLh/ptFIBoNNGNeitcuoKpbZKVc
 9aNMBm7sjC8zMaQkMSj694d/CierRCiSP+IWI5YI6am6I7gIr+NQdH1XrkLsalynGiIx
 286WMT2oCLJR8P9l6M4np3HJwBdm18lxco56YluPD0JBzvDP41msRV+BDVq33UVzmQt0
 t7Og==
X-Gm-Message-State: APjAAAVW9PDOzkDHKSkkTGoZCfjk0DhPFAVQLjGlOSa9ikpLFeRDQEa8
 By0Yv6Q4y6JMKjapptjoSLo=
X-Google-Smtp-Source: APXvYqxMrx/NNF89vqQ8+MjOqYv59P2oP0mgljwBnCX/CzJ37ipSdRv6zRA8nv5QnA1187gayLgtzg==
X-Received: by 2002:a63:89c7:: with SMTP id
 v190mr132242628pgd.299.1565020846325; 
 Mon, 05 Aug 2019 09:00:46 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.45
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:45 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:12 -0700
Message-Id: <1565020823-24223-18-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 17/28] riscv: sifive_u: Change UART node name
 in device tree
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

OpenSBI for fu540 does DT fix up (see fu540_modify_dt()) by updating
chosen "stdout-path" to point to "/soc/serial@...", and U-Boot will
use this information to locate the serial node and probe its driver.
However currently we generate the UART node name as "/soc/uart@...",
causing U-Boot fail to find the serial node in DT.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 20dee52..8044166 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -273,7 +273,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "reg", 0x0);
     g_free(nodename);
 
-    nodename = g_strdup_printf("/soc/uart@%lx",
+    nodename = g_strdup_printf("/soc/serial@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
-- 
2.7.4


