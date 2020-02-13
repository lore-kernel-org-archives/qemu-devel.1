Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C7CC3B18F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76E4222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7uK8Kyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76E4222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2O85-0000zc-Us
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7K-00089H-6J
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7J-0002wS-AY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:58 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7J-0002vb-4V
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:57 -0500
Received: by mail-wr1-x441.google.com with SMTP id z7so8832116wrl.13
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K3jU1DlzIeT5aazRZD5c7uQ9ch7IHGbrpGTEyi2PlAw=;
 b=N7uK8Kyy6lM1lge8Vdsb5ibzr/N1UUN597O98Eeo8HitITIj+31VR1ivhhEgkyrAjN
 wGuCqD4u4ukEtTCr3bWsLebgMQfM2SiWmibLyuEZUgOqjRrWjJk5EtgdqLXCbF1g8WPM
 cMh1VxbQoB50ctAsmbq2OmSIJ3Z4rsy7kF27pnJ/MDkwMyLFn59V1AicuHMeA9us04jn
 mUEvBrriwYM4OC9KrQIF1JFTREq9snCXZqYzB40mIuQOtG8aolsDtieQ8OXqTo2dlRsc
 Y1W6+UAmO3yt6ZJJmoVOYIlBx9HRTVw6u1JYfMIJAUyMXjXpfr1O88YhCSHk26GTnysa
 0jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=K3jU1DlzIeT5aazRZD5c7uQ9ch7IHGbrpGTEyi2PlAw=;
 b=cuuH0T89ugihJNFAg87RBR9Id+xwELMbl0ZP5HXJ4twNSFZhsPrgziTkDFCacD1x3W
 qoKs9R9CvhsHBysyIqy63Gtz3hIxGhUnKN2rzn1uMWLKWIc/Q69lT+2Us/08LYAKgNA6
 /oZULKl5J+LlsUTF0BHqC7qYDDAVWO5tAc5PySx49XmWYn7ni0XThJrzvRNsbSqUUqj8
 Nk0MQP/Vp99QkRsjwDbu6BFFtDJs9ZPjbs+668fCNP6KIZcgkkGRmmffdSaxFi0X/MzH
 aJ7BcgDTHD6NIiZFtXM0AL1AyYeB5YKYQr8b/hcCFC/Jk5JXJ0133yJA+GGecsmS+XKI
 /TaA==
X-Gm-Message-State: APjAAAVxLk+lqNEgkscV7mRLhH5DQTptXoVOTQ80gaOczG99zHnB/Kv2
 dAqs/tNhIdl9HIJRNVMDUjM=
X-Google-Smtp-Source: APXvYqy4/ysfFEayBzEZO9SA6LVO8yVI3yyLcMsgJz7rYe+t02Z3BzjQbbWy7DRRWzLqwSdFOyiiOw==
X-Received: by 2002:adf:b254:: with SMTP id y20mr23698402wra.362.1581637316147; 
 Thu, 13 Feb 2020 15:41:56 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id d4sm1521065wra.14.2020.02.13.15.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 15:41:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: [RFC PATCH 4/4] hw/hppa/dino: Do not accept accesses to registers
 0x818 and 0x82c
Date: Fri, 14 Feb 2020 00:41:48 +0100
Message-Id: <20200213234148.8434-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200213234148.8434-1-f4bug@amsat.org>
References: <20200213234148.8434-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Register 0x818 is documented as 'undefined', and register
0x82c is not documented. Refuse their access.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/dino.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index be799aad43..2b1b38c58a 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -181,7 +181,9 @@ static bool dino_chip_mem_valid(void *opaque, hwaddr addr,
     case DINO_IO_ADDR_EN:
     case DINO_PCI_IO_DATA:
     case DINO_TOC_ADDR:
-    case DINO_GMASK ... DINO_TLTIM:
+    case DINO_GMASK ... DINO_PCISTS:
+    case DINO_MLTIM ... DINO_PCIWOR:
+    case DINO_TLTIM:
         ret = true;
         break;
     case DINO_PCI_IO_DATA + 2:
-- 
2.21.1


