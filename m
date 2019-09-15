Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA45BC4CECD
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEAC21479
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9Xz5Ml7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEAC21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aV4-0006Gw-Lm
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7t-0006Jk-LS
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7s-00023v-Ij
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:24:01 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:42359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9a7s-00023b-Cl
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:24:00 -0400
Received: by mail-ed1-x544.google.com with SMTP id y91so31230606ede.9
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=csUz3G+oANfAghQDvskgbpzawb3MHELRqPU8L59Mp1o=;
 b=q9Xz5Ml7ejx1GfUNFnQZprlO+Lk1vnKF0A7VcXdU9jzPREUyNRlQt8jMbKcu/NsxbQ
 uiJgeTY5WK4d5QODScPhSWpNsVBqr+opgB5ATDv0cZqTEU0PZ3yE3hZGTjPxasG8jDg+
 pKv/aCsqiav0ZB5/4zesP/Nts88eAtQ/M4tN/M/OUUFWnNGDl5J7tFtmNwBUCp4rLs0q
 ZOQjwu96eOEGK1Hs+fGx25jhxwBZL0yS0LyfoTAJCpN5GUwSiha+jC8POnsNijjWipwS
 UbHKli1ZTigQN9eNWZg2jpcA9QgNboR7CHRNOrOEjn+UE5GDlvpALmYF2ojf6eJ79gUL
 b6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=csUz3G+oANfAghQDvskgbpzawb3MHELRqPU8L59Mp1o=;
 b=aHkKEdy44AGaoSKt7wRGqYdZ2Fv7SavRl8BzrMAaId85ZvFRzKcsK3IUCphvI3SkGF
 K3xdwFFQfzx9HkudkWNHYDxn4KX/CHgQXeCUUvvVFJHkuMwFzfEkTK20kDHHYbYCBs4N
 ogC7ObTcDvEnT65VnpjCzTBeVgeQ5vO6siOzDWyLHt25NuMd1FOBE3fZHMCJvdr5ch6c
 vPv/7bUyhaXSq36qPmCyOOQhdW6T0Vu3MBA+B8ushg4JV8X46675TiyewDoTtRxllimG
 ZQ/v+yYELmeHI+UmME4da7ym0wEwondxUM56YYr6yO180UuHgZJaoskXgrEtv/Vd1wdQ
 1ffg==
X-Gm-Message-State: APjAAAXZiEz1zisG58p3dcg8iwLtlbHHVf1sy41/2+W5uIxfUDq4M4+y
 smcgR5qRVYHKIrjaBzL5wDsr/uZb
X-Google-Smtp-Source: APXvYqz0+gzmB5J0OQWHGvYkW5h9PbCSLIfynHuVVfn5EA0kc1wfu1feM9U4KAmX2BOgCi1liWpLjQ==
X-Received: by 2002:a17:906:5584:: with SMTP id
 y4mr3452932ejp.89.1568575439191; 
 Sun, 15 Sep 2019 12:23:59 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id j20sm6480562edy.95.2019.09.15.12.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 12:23:58 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 21:23:40 +0200
Message-Id: <c0a8d934c145bab55506e0623cc0206e2632a196.1568574965.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: [Qemu-devel] [PATCH v3 24/24] usbaudio: change playback counters to
 64 bit
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With stereo playback, they need about 375 minutes of continuous audio
playback to overflow, which is usually not a problem (as stopping and
later resuming playback resets the counters).  But with 7.1 audio, they
only need about 95 minutes to overflow.

After the overflow, the buf->prod % USBAUDIO_PACKET_SIZE(channels)
assertion no longer holds true, which will result in overflowing the
buffer.  With 64 bit variables, it would take about 762000 years to
overflow.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 hw/usb/dev-audio.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index e42bdfbdc1..ea604bbb8e 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -578,9 +578,9 @@ static const USBDesc desc_audio_multi = {
 
 struct streambuf {
     uint8_t *data;
-    uint32_t size;
-    uint32_t prod;
-    uint32_t cons;
+    size_t size;
+    uint64_t prod;
+    uint64_t cons;
 };
 
 static void streambuf_init(struct streambuf *buf, uint32_t size,
@@ -601,7 +601,7 @@ static void streambuf_fini(struct streambuf *buf)
 
 static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
 {
-    uint32_t free = buf->size - (buf->prod - buf->cons);
+    int64_t free = buf->size - (buf->prod - buf->cons);
 
     if (free < USBAUDIO_PACKET_SIZE(channels)) {
         return 0;
@@ -610,6 +610,8 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
         return 0;
     }
 
+    /* can happen if prod overflows */
+    assert(buf->prod % USBAUDIO_PACKET_SIZE(channels) == 0);
     usb_packet_copy(p, buf->data + (buf->prod % buf->size),
                     USBAUDIO_PACKET_SIZE(channels));
     buf->prod += USBAUDIO_PACKET_SIZE(channels);
@@ -618,10 +620,10 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
 
 static uint8_t *streambuf_get(struct streambuf *buf, size_t *len)
 {
-    uint32_t used = buf->prod - buf->cons;
+    int64_t used = buf->prod - buf->cons;
     uint8_t *data;
 
-    if (!used) {
+    if (used <= 0) {
         *len = 0;
         return NULL;
     }
-- 
2.23.0


