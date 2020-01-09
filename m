Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D27C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2226320643
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q96i1pTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2226320643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipLNI-0007Fg-36
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 19:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKQ-0003WC-QU
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKP-0007a0-LG
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:34 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKP-0007Xo-1H
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:33 -0500
Received: by mail-wm1-x343.google.com with SMTP id b19so880834wmj.4
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 16:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xszouJcJkyjO2tEfTiOLX/vhd4HLvHS2IcH8OxDqlko=;
 b=q96i1pTieYQQbkcGDWfPkSngaBAENYitOvkNatt5bnrM4SXyCOvA30Xx8GWKyJBAR/
 mNCaFP9ZojOFeuuwqIGQgeLXk5LZWxHMR1zowFH3f8pY23HtvaGYl+doN6elUlaDZndt
 7KsKyrDSp6oY2S5MjrokYaqCkVDvKQyvYpdTrYPbmxPNZAL732vnlhP/2/U5B+IUNgCI
 I8pMcuymqGUWKBtc9k8cs/jxZXffGAGr/6G5OsbrAZaC3P98xRQFzBASL80cMkTfo6AM
 YCnSnMf1dbeg56gYsviFok52SmlSI0WVLKwyQOwFmvoEyXgjBPQkTv7lqslSZVhfUW/o
 YdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xszouJcJkyjO2tEfTiOLX/vhd4HLvHS2IcH8OxDqlko=;
 b=euRw+O9xNCRPTkEcOpkfu+Gkp2JN/MM4vontz43zqO+RbS/QuLjMnW2t89cUxd5OWM
 ts2l1th6zPw+fnVYumlg0/XmiZg9dWeQemtjsi4BLGuIY2wnQVvKN4GMT61dkg5ydErn
 DWOlWaJedgh4HOkR5Ef6A627HAjpiC6Hqhn3scSDruCb4jS4I6P3FpuGCckQJSl+qKx8
 ud7BYNEAIbPNO1KFGBVbioaxDX/SDpGSgvpV9/BxMeYE/ZqNW2OqQctxjrAlAbDbtMQf
 10IdwGuMEgXGjbypKSByvfqzpfm9a6VtIPEaj1YFa6HkXu+g4RzE9U5yhwkUvzYsro6u
 T9TA==
X-Gm-Message-State: APjAAAVTjy2CBrbJYhK9LbenqtGsMDm1/bT1Qr8OaiiTaShtdF+fwLHo
 VfP+yATbz9lGcJf76QVoVv0=
X-Google-Smtp-Source: APXvYqz/FkI1U+yEbOFWZrdyIYnBoL/jqKkpMfx1pOFCA9Crk5ntR0n+WqAGKcas9iTfHCarXQMNZQ==
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr1289206wmi.15.1578528332085; 
 Wed, 08 Jan 2020 16:05:32 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w13sm5947827wru.38.2020.01.08.16.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 16:05:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] hw/hppa/machine: Map the PDC memory region with higher
 priority
Date: Thu,  9 Jan 2020 01:05:25 +0100
Message-Id: <20200109000525.24744-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109000525.24744-1-f4bug@amsat.org>
References: <20200109000525.24744-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The region in range [0xf0000000 - 0xf1000000] is the PDC area
(Processor Dependent Code), where the firmware is loaded.
This region has higher priority than the main memory.

When the machine has more than 3840MB of RAM, there is an
overlap. Since the PDC is closer to the CPU in the bus
hierarchy, it gets accessed first, and the CPU does not have
access to the RAM in this range.

To model the same behavior and keep a simple memory layout,
reduce the priority of the RAM region. The PDC region ends
overlapping the RAM.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 119ae4d3c8..810e6718d9 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -98,7 +98,7 @@ static void machine_hppa_init(MachineState *machine)
     ram_region = g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ram_region, OBJECT(machine),
                                          "ram", ram_size);
-    memory_region_add_subregion(addr_space, 0, ram_region);
+    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
 
     /* Init Dino (PCI host bus chip).  */
     pci_bus = dino_init(addr_space, &rtc_irq, &serial_irq);
-- 
2.21.1


