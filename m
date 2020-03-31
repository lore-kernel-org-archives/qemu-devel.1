Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00E3C2D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDB720B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJd40Loz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDB720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEXQ-0006f8-L5
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU3-0002Q7-Lv
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU2-0006JF-If
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU2-0006Il-D0
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id a25so25350203wrd.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 03:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DF8+zMwnTWpvkhxGJn3XQCWqhl7knakcPY4RQn/CDdU=;
 b=nJd40LozPdurEkzqGIMbNv9ByRGsAYjG175eDxp4BshF7wxW9MXR3XEJy+tG7rfxXy
 KkIDoHrYCww+0f1udT5fFf4PBXFBuRsQqjIe4+in/SGJLCQzbmSnYYPrPaPFJIFpGaFj
 pDxwoSwBSzig2VyvOzmkhpsK46bVnkhCqRiN8F7y0vSvcYQtBJy0r1UgMzU3C+2zqM2E
 95HkIRsNznRyYdJR8nEKDMo4n3fhp7JGWssFE9iKZunfxscIvRAUXaYI5FYaOJzE4iGb
 jUbD1gVb77Pt6eH9AnWD2Y/GaBuP6Efp1m747ZctX7SsdT3iyHyeD+u2Y7GSVn5WmOTX
 wpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DF8+zMwnTWpvkhxGJn3XQCWqhl7knakcPY4RQn/CDdU=;
 b=qL+6ZU48TVUE2zNysLWoT30AVCQA+5xWKN40OZj5VhUKxG21DyQa4ecB0G5e5+UAGp
 piiPuukCqVvSqfwSykd2FqAEEVCEttjS5+HdrCbT356RD/NXhKIPvTOhd2CjNjn4I7Bu
 Wheb3PJWCWnIOZd+23LprICWj7Zz/zFf5nxcCIZu4gjmHz3kzBW9ZKUx+gWONQhOR30B
 xDG29N+DBqjaC/BzRfHZ2Ezu5gdVPZ80oZk7T5RkMqAnt8nb71v7PehTu4u6CZq2q24o
 0EyLsl6FFhnIEHquNAXz8/mgOilLrhT2l4yyoni/Lkqln2kLln40o6OdcSp3EmdZpigf
 VAQA==
X-Gm-Message-State: ANhLgQ3N6YTSvclLJf9Tcac73YQtuIsRP5R8Xct53eFAAb+tGC+qZ6Ew
 BTD1NSjTBilqtS5YP3xudwCyoh+Pus8=
X-Google-Smtp-Source: ADFU+vvLJG1OUdVDpwQwmuN/aB8lLj9Y2rK62Wcx1Y17tVS5NHJ5RKMuF3oINxiPZvKa+wIGuTDzxQ==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr19338959wru.131.1585651860923; 
 Tue, 31 Mar 2020 03:51:00 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w3sm26042830wrn.31.2020.03.31.03.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 03:51:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 3/7] hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit
 accesses
Date: Tue, 31 Mar 2020 12:50:44 +0200
Message-Id: <20200331105048.27989-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200331105048.27989-1-f4bug@amsat.org>
References: <20200331105048.27989-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Plug & Play region of the AHB/APB bridge can be accessed
by various word size, however the implementation is clearly
restricted to 32-bit:

  static uint64_t grlib_ahb_pnp_read(void *opaque, hwaddr offset, unsigned size)
  {
      AHBPnp *ahb_pnp = GRLIB_AHB_PNP(opaque);

      return ahb_pnp->regs[offset >> 2];
  }

Similarly to commit 0fbe394a64 with the APB PnP registers,
set the MemoryRegionOps::impl min/max fields to 32-bit, so
memory.c::access_with_adjusted_size() can adjust when the
access is not 32-bit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/grlib_ahb_apb_pnp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index 72a8764776..d22ed00206 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -146,6 +146,10 @@ static const MemoryRegionOps grlib_ahb_pnp_ops = {
     .read       = grlib_ahb_pnp_read,
     .write      = grlib_ahb_pnp_write,
     .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
 };
 
 static void grlib_ahb_pnp_realize(DeviceState *dev, Error **errp)
-- 
2.21.1


