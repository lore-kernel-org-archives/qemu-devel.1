Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0249C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9372082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6N8wbu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9372082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZWO-00007Q-6H
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlM-0001yv-Lr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlL-0001lk-DO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:32 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlL-0001gm-5o
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:31 -0500
Received: by mail-wr1-x444.google.com with SMTP id e8so14380308wrm.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u4g6uRiXFIEOKcE3rCDO5ED3c3g1EUSc75nl9BzOigw=;
 b=R6N8wbu/CNIwMB1ugk1KGCdfIfoc9zvwIzlX198pt6cCt+yLSpxyz6X7/DZtToDJEz
 TTB5DdAQpIB7aIf/ewEuuTgOo6Xu/vpNO3hGDZLPBYThqpH8uCNqaQW4H+pPIHOdDcSh
 9W2D1DnU6HJA+qGmw7va/tIqUerGT/2wi5uIYeZNZ9s3oC3H0yYbL77J9sCsZlTKbazS
 FX3106TO+WQj+4uHm46OVZqCfr5fJROqgNpUpF+cBmJ5Rlbh7M/wr+XsWypUEDHRxtQW
 uthAUOaWuYJswdfbO/NQOV0FhkpbxAR2RHxHpj/C6FHGlf+OC7fiHfbVDb8a1K+8zo11
 CEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=u4g6uRiXFIEOKcE3rCDO5ED3c3g1EUSc75nl9BzOigw=;
 b=IqOVlOrPq5YMe6CMyelA/vXJnuxppLw8H3rTbBf8Y9kGjIA7cU8118FD4HIJ0blN0v
 LzwFxAVf1nA696kuQQeDjT0DoY/kquU43KajLkifQvItrD7BvzoVXtWCroDDrbTfX0L5
 sTlxp2oYzBmb08WvknvuNMVv3/oMx80PqJT8p5Y7Cygf83ytoCHcxURbNS4KJ4o4wOd8
 0FxVTuJklSq5FmuyTAc6sqixQwu4sLuFmCKigdda0EkHf6OkdK1VIlxDkEi/ZAPgFD+Q
 kOzOT7gV03ccPLqvQDpS1mDDm+Xr5iwFYfqsEAt4AGrzmkLueR9Qcu6MEZM7bCclp1Fu
 ik7g==
X-Gm-Message-State: APjAAAWm7yEgp1o9f2PwcsQAPYH/9Xj2eE5WwAz59ggQQdyQ2zMAPT2h
 7XXV/EM+TGLoOXR30hwfq0V8ZJyz
X-Google-Smtp-Source: APXvYqzdPO3iVG22YphYVVbvytHnTeUdR/USNf6Tw+uVA42RN2OA7s1WZRf+9FLqeDkohKgGWg+ClA==
X-Received: by 2002:a05:6000:1208:: with SMTP id
 e8mr76272370wrx.351.1582631549911; 
 Tue, 25 Feb 2020 03:52:29 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 090/136] hw/ide: Let the DMAIntFunc prototype use a boolean
 'is_write' argument
Date: Tue, 25 Feb 2020 12:50:20 +0100
Message-Id: <1582631466-13880-90-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The 'is_write' argument is either 0 or 1.
Convert it to a boolean type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/dma/rc4030.c           | 6 +++---
 hw/ide/ahci.c             | 2 +-
 hw/ide/core.c             | 2 +-
 hw/ide/macio.c            | 2 +-
 hw/ide/pci.c              | 2 +-
 include/hw/ide/internal.h | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index ca0becd..21e2c36 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -590,7 +590,7 @@ static const VMStateDescription vmstate_rc4030 = {
 };
 
 static void rc4030_do_dma(void *opaque, int n, uint8_t *buf,
-                          int len, int is_write)
+                          int len, bool is_write)
 {
     rc4030State *s = opaque;
     hwaddr dma_addr;
@@ -630,13 +630,13 @@ struct rc4030DMAState {
 void rc4030_dma_read(void *dma, uint8_t *buf, int len)
 {
     rc4030_dma s = dma;
-    rc4030_do_dma(s->opaque, s->n, buf, len, 0);
+    rc4030_do_dma(s->opaque, s->n, buf, len, false);
 }
 
 void rc4030_dma_write(void *dma, uint8_t *buf, int len)
 {
     rc4030_dma s = dma;
-    rc4030_do_dma(s->opaque, s->n, buf, len, 1);
+    rc4030_do_dma(s->opaque, s->n, buf, len, true);
 }
 
 static rc4030_dma *rc4030_allocate_dmas(void *opaque, int n)
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 68264a2..13d91e1 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1461,7 +1461,7 @@ static void ahci_commit_buf(IDEDMA *dma, uint32_t tx_bytes)
     ad->cur_cmd->status = cpu_to_le32(tx_bytes);
 }
 
-static int ahci_dma_rw_buf(IDEDMA *dma, int is_write)
+static int ahci_dma_rw_buf(IDEDMA *dma, bool is_write)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
     IDEState *s = &ad->port.ifs[0];
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 80000eb..689bb36 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2570,7 +2570,7 @@ static void ide_init1(IDEBus *bus, int unit)
                                            ide_sector_write_timer_cb, s);
 }
 
-static int ide_nop_int(IDEDMA *dma, int x)
+static int ide_nop_int(IDEDMA *dma, bool is_write)
 {
     return 0;
 }
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 7a8470e..a9f25e5 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -376,7 +376,7 @@ static void macio_ide_reset(DeviceState *dev)
     ide_bus_reset(&d->bus);
 }
 
-static int ide_nop_int(IDEDMA *dma, int x)
+static int ide_nop_int(IDEDMA *dma, bool is_write)
 {
     return 0;
 }
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index cce1da8..1a6a287 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -181,7 +181,7 @@ static int32_t bmdma_prepare_buf(IDEDMA *dma, int32_t limit)
 }
 
 /* return 0 if buffer completed */
-static int bmdma_rw_buf(IDEDMA *dma, int is_write)
+static int bmdma_rw_buf(IDEDMA *dma, bool is_write)
 {
     BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
     IDEState *s = bmdma_active_if(bm);
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index ce766ac..1bc1fc7 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -322,7 +322,7 @@ typedef void EndTransferFunc(IDEState *);
 
 typedef void DMAStartFunc(IDEDMA *, IDEState *, BlockCompletionFunc *);
 typedef void DMAVoidFunc(IDEDMA *);
-typedef int DMAIntFunc(IDEDMA *, int);
+typedef int DMAIntFunc(IDEDMA *, bool);
 typedef int32_t DMAInt32Func(IDEDMA *, int32_t len);
 typedef void DMAu32Func(IDEDMA *, uint32_t);
 typedef void DMAStopFunc(IDEDMA *, bool);
-- 
1.8.3.1



