Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56A2C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892FD20661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fnunndk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892FD20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVsK-0006Vt-Mt
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo6-0000Dh-El
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo4-0001zA-Ew
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:14 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo4-0001uz-8B; Wed, 05 Feb 2020 20:18:12 -0500
Received: by mail-wm1-x341.google.com with SMTP id a9so5038992wmj.3;
 Wed, 05 Feb 2020 17:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DoWpvyfK+WfXXi5X9tns5WnEcL/fdg1MifgQLNVT/tQ=;
 b=Fnunndk7H0/ivXOE4GMqkk66DOc9U0xIZ5sLtA7MHt5fANK9TycDh7/BK+KOBWRCEz
 FPt5kpPILvX0AIjQqCUOnFGrB2ls86njaU8ZVDv96a9QNWWDJ7d3m/GtjNCHOCJcG8lN
 RegpaIaeDira5pFGzHkhg1OU0/HyTw0ELAcsFmB9XIX2F/P2KsVlV3y0XTuFkJw0BoRC
 abw5n8RHxkfv8KAy2BqIcWZkzgppjvg8lF+id5zPT1bGf9kHpRx0EPCjS4+GdEeylpO4
 I2u099wnVSMxahc8tHXKfE8hHijHrsLcU7TPpyyDJKeCZ+PfGqkZKQ97mj0YvEUEtyml
 i+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DoWpvyfK+WfXXi5X9tns5WnEcL/fdg1MifgQLNVT/tQ=;
 b=JA4QsgwjxM5GE6l1ktF9ug96Ya5TmDzFdTvN40AWS80cH1jnu8htGbi+1OgVHLQSom
 xAkH3DcaUDdv7O/CarWZL9UnA/s3InyWVlJ8vd71cEBqwUOjUJAPKNqqiKnEoSurQI+C
 KdFuYl957S+S/e2dudmZY7oMtBCwOqhWfm9io8UZUnrydPuAcBNnewZmX05TFyZCnap8
 axx3+IG/hyYIKDl5D/z74d8QCWegBut3BV7pyFkFDNUSZCQZWpDVnMXhpMGK0Uz/JYQz
 SObS/VuZYAWWDuKyuchzVYdoA3/86USfcxOu8X3U394cHXm86Yr/oumnZ0BnXekHWuiV
 0I9g==
X-Gm-Message-State: APjAAAXnxcyQJhaFgYQzdzC9wxWLlXr7tO2Wb1i4FR8ffDvpqB6bviOe
 jetSpXDcTLHpRl5Y9M7RqvTOnb5t
X-Google-Smtp-Source: APXvYqwNb260l6xW1ZyqsZkmbnoB64ruSEIkOpLCV7y4nmMa52R70aO0rFImc3bKczUivTODbYp2zQ==
X-Received: by 2002:a1c:988a:: with SMTP id a132mr579281wme.113.1580951891181; 
 Wed, 05 Feb 2020 17:18:11 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/30] hw/arm/raspi: Extract the processor type from the
 board revision
Date: Thu,  6 Feb 2020 02:17:31 +0100
Message-Id: <20200206011756.2413-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The board revision encode the processor type. Add a helper
to extract the type, and use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 2f5cd32c5e..20195227eb 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -66,6 +66,21 @@ static int board_version(uint32_t board_rev)
     return board_processor_id(board_rev) + 1;
 }
 
+static const char *board_soc_type(uint32_t board_rev)
+{
+    static const char *soc_types[] = {
+        NULL, TYPE_BCM2836, TYPE_BCM2837,
+    };
+    int proc_id = board_processor_id(board_rev);
+
+    if (proc_id >= ARRAY_SIZE(soc_types) || !soc_types[proc_id]) {
+        error_report("Unsupported processor id '%d' (board revision: 0x%x)",
+                     proc_id, board_rev);
+        exit(1);
+    }
+    return soc_types[proc_id];
+}
+
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     static const uint32_t smpboot[] = {
@@ -212,8 +227,7 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
     }
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            version == 3 ? TYPE_BCM2837 : TYPE_BCM2836,
-                            &error_abort, NULL);
+                            board_soc_type(board_rev), &error_abort, NULL);
 
     /* Allocate and map RAM */
     memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
-- 
2.21.1


