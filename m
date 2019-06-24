Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB21C4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B4820665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgoGK1s5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B4820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXeD-0005F3-Rg
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34067)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSL-00047M-LY
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSH-0005KB-Or
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSH-0005G9-II
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id f17so878767wme.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5dXEvYdBuMJfEvXkir0hEhmfw03d7UAVN7/M5JOtto0=;
 b=vgoGK1s5qWODw5qrxDj2KbfQuVz/Ek2j+3yC2Bd0DhthPj/Y2l0VMCFSgwOh6XiIQI
 cM5gscqDJhwHFLSdobBFt5wxNFo0ESF/YMoNB0KJsMRYxn7XnZtXoxxLLTFlmgFEVHnw
 FX2w5qmD5iyltJ+Zt6bMzjQW41CGjgmfxJIa7xLXb5CXHDB2DpU0uOVdtzXhgLgYIS01
 7iFiAlh45RgEbrlQipclGf5EfZ3+IEoPUyEmY4NG/Nj877L082JBjfTIPgu2t0bOumyz
 2hwlIrqzTyzlOskBtkTMeRARdREiB4iPQpYY3Z7dG0abPBB8X8RUouK+awFPvqxFXv/J
 Jh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5dXEvYdBuMJfEvXkir0hEhmfw03d7UAVN7/M5JOtto0=;
 b=jYJ0PTRMHpzUMDO2j5eHBg2nMWJw6cq1agm24JZyq8w5fjKhxysqzZ4kaz+JYqx6zk
 qGk7EipWmFcgP8DynsZ/UcLq+ht1Txh0SgfU6i23RwE4fCUNfGSjd3kWhjSoLOfze9yY
 9PiDH4DJrOBbrt0xyVMPN28GFb3+Pd447wIKx7Qfrz+yY6sZ7W2eRNt+ootVXyGJZpwO
 IGqNZpBoG8Hiu/o2auFMJAt+cMQjan5yAj7+SQqIYOgdnMe98CRa8MQGYNdsLShrrRXb
 iqEobpoVYYB9Qathd+21pzh1KjeazTLKMk7ao21XeShSHxXiMmK/gvcryFlkmt4CqtEK
 Maqw==
X-Gm-Message-State: APjAAAVV10cfQ6Oi6bcEgvZ5zeI6i7Qr+fac167S+BM8p36vJko13BGr
 KOquRHwf/M9cri6mxFAKLOGx3947
X-Google-Smtp-Source: APXvYqxo5nOW6kvYQcwr/iUQcYmi5fgCXXYDXuJQ8qM2MCFHVFBFuKaGjxdBG+EjeDEcilA8sH8Dqw==
X-Received: by 2002:a1c:20cf:: with SMTP id g198mr5482204wmg.88.1561415330618; 
 Mon, 24 Jun 2019 15:28:50 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l1sm646781wmg.13.2019.06.24.15.28.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:28:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:28:37 +0200
Message-Id: <20190624222844.26584-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624222844.26584-1-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 03/10] hw/mips/gt64xxx_pci: Fix 'braces' coding
 style issues
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we'll move this code around, fix its style first:

  ERROR: braces {} are necessary for all arms of this statement

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/gt64xxx_pci.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index bbd719f091..cfd497960c 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -257,19 +257,25 @@ static void check_reserved_space(hwaddr *start, hwaddr *length)
     hwaddr begin = *start;
     hwaddr end = *start + *length;
 
-    if (end >= 0x1e000000LL && end < 0x1f100000LL)
+    if (end >= 0x1e000000LL && end < 0x1f100000LL) {
         end = 0x1e000000LL;
-    if (begin >= 0x1e000000LL && begin < 0x1f100000LL)
+    }
+    if (begin >= 0x1e000000LL && begin < 0x1f100000LL) {
         begin = 0x1f100000LL;
-    if (end >= 0x1fc00000LL && end < 0x1fd00000LL)
+    }
+    if (end >= 0x1fc00000LL && end < 0x1fd00000LL) {
         end = 0x1fc00000LL;
-    if (begin >= 0x1fc00000LL && begin < 0x1fd00000LL)
+    }
+    if (begin >= 0x1fc00000LL && begin < 0x1fd00000LL) {
         begin = 0x1fd00000LL;
+    }
     /* XXX: This is broken when a reserved range splits the requested range */
-    if (end >= 0x1f100000LL && begin < 0x1e000000LL)
+    if (end >= 0x1f100000LL && begin < 0x1e000000LL) {
         end = 0x1e000000LL;
-    if (end >= 0x1fd00000LL && begin < 0x1fc00000LL)
+    }
+    if (end >= 0x1fd00000LL && begin < 0x1fc00000LL) {
         end = 0x1fc00000LL;
+    }
 
     *start = begin;
     *length = end - begin;
@@ -385,8 +391,9 @@ static void gt64120_writel (void *opaque, hwaddr addr,
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
     uint32_t saddr;
 
-    if (!(s->regs[GT_CPU] & 0x00001000))
+    if (!(s->regs[GT_CPU] & 0x00001000)) {
         val = bswap32(val);
+    }
 
     saddr = (addr & 0xfff) >> 2;
     switch (saddr) {
@@ -937,8 +944,9 @@ static uint64_t gt64120_readl (void *opaque,
         break;
     }
 
-    if (!(s->regs[GT_CPU] & 0x00001000))
+    if (!(s->regs[GT_CPU] & 0x00001000)) {
         val = bswap32(val);
+    }
 
     return val;
 }
@@ -990,8 +998,9 @@ static void gt64120_pci_set_irq(void *opaque, int irq_num, int level)
         /* The pic level is the logical OR of all the PCI irqs mapped to it. */
         pic_level = 0;
         for (i = 0; i < 4; i++) {
-            if (pic_irq == piix4_dev->config[0x60 + i])
+            if (pic_irq == piix4_dev->config[0x60 + i]) {
                 pic_level |= pci_irq_levels[i];
+            }
         }
         qemu_set_irq(pic[pic_irq], pic_level);
     }
-- 
2.19.1


