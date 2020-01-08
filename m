Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F04CC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 18:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404E720656
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 18:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ5s/Lq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404E720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipFri-0000M3-6e
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 13:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipFqk-0007sv-0a
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipFqj-0000js-1m
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:14:33 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipFqi-0000jN-S8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:14:33 -0500
Received: by mail-wm1-x343.google.com with SMTP id w5so227068wmi.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 10:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y0nCBh7LvS7wrnGHA1PHHJW7ya35z6WKzjOhE+TYtds=;
 b=HZ5s/Lq9qRRyE8yRT99Fh/JCCQslPKifdQW1Ri4lD/m1L2lEXy/jt73vBEV2tKjjkg
 m1VgDfqfYbLuuDYc0pYVJ7aKs5/cMZ/+Cg8gDLVsRcRKR9uwJ6U9QbyixR51rbvwVAyT
 yl9bJbyHHrvpV9UQbuNWRr4917dPA2oaB+JHObvjK+QfmUcy1hOjVi6LfRWVh/fdctG0
 BHkzmffCA7GYSzDprbIFNHzUwEB9WJyi1PHYczoVM0LjxzxW2GJCW2ZEzknvgdwqy4N1
 DQ5YgrcQLiGxiNtu9N9JLnKNn/0UyIBUKLax5vakHHZymLq3V9pKC+ZROmYvitJZP0/n
 vTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Y0nCBh7LvS7wrnGHA1PHHJW7ya35z6WKzjOhE+TYtds=;
 b=Cp6FZ/4GrXhW3sOx5rcCjdwS8+9UxTmHLZCaGappxDNC+nppqNOW9APJX942NdVxzG
 /UtrkW4xaZ45QFsG5enTOb9qzd5/0UwMw7D8Q1PYMKcWMwil4yxxK6UrOyHP+6zwkeQz
 XqguAeEE0sCkSsAaJH1hbN3znC2Brjtju/w50zkaJtHEkLkqolEHb2KvbhdabKvjN8KH
 axGNzeWBDiPcrCQtiUfoHxn+38bRPR5QyxklesUF2ZaJ1wMO1nogmRaWquJMDQpz8Ye7
 GGhu6H7Z9Tv8fUHiyU8O3YgRteZtbyVIdASPiA4WsTp9bxApnOCGf2hY+okcuSAQolQB
 D1Nw==
X-Gm-Message-State: APjAAAWxq4j2TmPNTwHQC9SPS6A2CV1Ypqyf40qpy7nlasx/qJwDX+2G
 P5ymlBK+B/lXTRukXcTLSf0=
X-Google-Smtp-Source: APXvYqwS9mTtCD+i1gqnZJXih6C4kIdZ7CtYv+eiP26Rza616D3p8SoH7BbC0bTjWTphua8FeCHdlA==
X-Received: by 2002:a05:600c:224a:: with SMTP id
 a10mr5536589wmm.143.1578507271982; 
 Wed, 08 Jan 2020 10:14:31 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id l19sm2908653wmj.12.2020.01.08.10.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 10:14:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 2/3] hw/hppa/machine: Do not limit the RAM to 3840MB
Date: Wed,  8 Jan 2020 19:14:24 +0100
Message-Id: <20200108181425.21485-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200108181425.21485-1-f4bug@amsat.org>
References: <20200108181425.21485-1-f4bug@amsat.org>
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

The hardware expects DIMM slots of 1 or 2 GB, allowing up to
4 GB of memory. Accept the same amount of memory the hardware
can deal with.

The CPU doesn't have access to the RAM mapped in the
[0xf0000000 - 0xf1000000] range because this is the PDC area
(Processor Dependent Code) where the firmware is loaded.
To keep this region with higher priority than the RAM, lower
the RAM priority. The PDC will overlap it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/machine.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 6775d879f8..d10c967d06 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -90,16 +90,15 @@ static void machine_hppa_init(MachineState *machine)
         g_free(name);
     }
 
-    /* Limit main memory. */
-    if (ram_size > FIRMWARE_START) {
-        machine->ram_size = ram_size = FIRMWARE_START;
-    }
-
     /* Main memory region. */
+    if (machine->ram_size > 4 * GiB) {
+        error_report("RAM size of 4GB or more is not supported");
+        exit(EXIT_FAILURE);
+    }
     ram_region = g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ram_region, OBJECT(machine),
                                          "ram", ram_size);
-    memory_region_add_subregion(addr_space, 0, ram_region);
+    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
 
     /* Init Dino (PCI host bus chip).  */
     pci_bus = dino_init(addr_space, &rtc_irq, &serial_irq);
-- 
2.21.1


