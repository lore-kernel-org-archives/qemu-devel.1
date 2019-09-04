Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00108C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB532087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwKwH1ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB532087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Z14-0002b1-Ca
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqX-0001PF-Gc
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqW-00071w-0s
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:29 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqV-00071Y-Pi; Wed, 04 Sep 2019 13:13:27 -0400
Received: by mail-wm1-x344.google.com with SMTP id o184so4695504wme.3;
 Wed, 04 Sep 2019 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ELAbj/wA1Xj60eRjG4YFXEUkK6OU0pIolX6z3Dq1NCw=;
 b=nwKwH1efKkXbYgo8Eru3f23GBHkTNejzA+XTuYBSjrKYDl9b2zMugd8Eu7+5Wt/QwK
 DZNRmD6mvrTIevcuoVfqlPJn9Mf56eG5dkDt/GhI2oMdzr88nhlMg/58vgE0sfPNz1EY
 25btbWkoWUF+sUPGqm98pUqIYqJGqjWINZMf1e5sLR5DZWpYDHfryYwuzcodZh79KinP
 E6sXHoDghvXQzS25O4QMEYnk1WRiOph+DMOcomxoxx9rlSFdauCCOhDw5EmJGQpzBtMw
 PSElOzQXTpTeWHqfFaANauJwneyEfCR5Qk4xytpAZANO80UAuxbltLIg72ejsdqr3pFH
 SdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ELAbj/wA1Xj60eRjG4YFXEUkK6OU0pIolX6z3Dq1NCw=;
 b=kKLM6ctoQ4a61KhMjYYyYsz82V6NwMEy16rJ3WnNq3M6l9Y0aVzLrDF/7TZBdB0B5B
 OEJeeSVRekKSeFKo3u90dCwumVzi7dz6sSUk9/i/4urknUw1SHRxZowdbn3VlyD16EdS
 IitOyc35rm7uWfZ20UGF0UMEavbUE4QULDiRFsf3HsQ9g5Pz39/J+IfZOBBQJ7IY8Y1g
 GBNWpnDS0nzN8JLEXAxOU53snDcv5LtejyjXQRLigR7bXjJEieZhmIrWsi4sEiNZhAwa
 cVb4GcSwSKrd5QluSXA54STK3mj0EdGBVKvakTLYuy3cvKxnor7XvgyCGXSzbm1ss51z
 ckWw==
X-Gm-Message-State: APjAAAXygmmqiMlTYnNdbquhgMJEQy7aPvc9Vs5W5o7JptBCs3WzAS3+
 icQUkqKcy7xTY7t1vI7bNzM=
X-Google-Smtp-Source: APXvYqx691vttX6XS0mJd5gNajfoQTff1JFfR4mzVdzCMpp9ghKtvOufxI/5T54ASFdhFw/VJdQzlQ==
X-Received: by 2002:a05:600c:12:: with SMTP id
 g18mr5461628wmc.95.1567617206828; 
 Wed, 04 Sep 2019 10:13:26 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:06 +0200
Message-Id: <20190904171315.8354-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 05/14] hw/arm/bcm2835_peripherals: Name various
 address spaces
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
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various address spaces from the BCM2835 are reported as
'anonymous' in memory tree:

  (qemu) info mtree

  address-space: anonymous
    0000000000000000-000000000000008f (prio 0, i/o): bcm2835-mbox
      0000000000000010-000000000000001f (prio 0, i/o): bcm2835-fb
      0000000000000080-000000000000008f (prio 0, i/o): bcm2835-property

  address-space: anonymous
    0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
      0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff

  [...]

Since the address_space_init() function takes a 'name' argument,
set it to correctly describe each address space:

  (qemu) info mtree

  address-space: bcm2835-mbox-memory
    0000000000000000-000000000000008f (prio 0, i/o): bcm2835-mbox
      0000000000000010-000000000000001f (prio 0, i/o): bcm2835-fb
      0000000000000080-000000000000008f (prio 0, i/o): bcm2835-property

  address-space: bcm2835-fb-memory
    0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
      0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff

  address-space: bcm2835-property-memory
    0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
      0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff

  address-space: bcm2835-dma-memory
    0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
      0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/bcm2835_fb.c    | 2 +-
 hw/dma/bcm2835_dma.c       | 2 +-
 hw/misc/bcm2835_mbox.c     | 2 +-
 hw/misc/bcm2835_property.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 8f856878cd..85aaa54330 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -425,7 +425,7 @@ static void bcm2835_fb_realize(DeviceState *dev, Error **errp)
     s->initial_config.base = s->vcram_base + BCM2835_FB_OFFSET;
 
     s->dma_mr = MEMORY_REGION(obj);
-    address_space_init(&s->dma_as, s->dma_mr, NULL);
+    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_FB "-memory");
 
     bcm2835_fb_reset(dev);
 
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 6acc2b644e..1e458d7fba 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -383,7 +383,7 @@ static void bcm2835_dma_realize(DeviceState *dev, Error **errp)
     }
 
     s->dma_mr = MEMORY_REGION(obj);
-    address_space_init(&s->dma_as, s->dma_mr, NULL);
+    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_DMA "-memory");
 
     bcm2835_dma_reset(dev);
 }
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 7690b9afaf..77285624c9 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -311,7 +311,7 @@ static void bcm2835_mbox_realize(DeviceState *dev, Error **errp)
     }
 
     s->mbox_mr = MEMORY_REGION(obj);
-    address_space_init(&s->mbox_as, s->mbox_mr, NULL);
+    address_space_init(&s->mbox_as, s->mbox_mr, TYPE_BCM2835_MBOX "-memory");
     bcm2835_mbox_reset(dev);
 }
 
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index ab66d3572e..3dff5a7157 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -417,7 +417,7 @@ static void bcm2835_property_realize(DeviceState *dev, Error **errp)
     }
 
     s->dma_mr = MEMORY_REGION(obj);
-    address_space_init(&s->dma_as, s->dma_mr, NULL);
+    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_PROPERTY "-memory");
 
     /* TODO: connect to MAC address of USB NIC device, once we emulate it */
     qemu_macaddr_default_if_unset(&s->macaddr);
-- 
2.20.1


