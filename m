Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E9DC4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D385D20673
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi0EIOp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D385D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJk7b-00037a-Td
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 16:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0P-0005WL-NR
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0O-0003Kk-HZ
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iJk0O-0003Jj-Bg
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id y19so17263611wrd.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=csUz3G+oANfAghQDvskgbpzawb3MHELRqPU8L59Mp1o=;
 b=Yi0EIOp+W2VbjGAlZL5lS6f+iUizXeLfTrpgMXCWZdyqW6va867y6ITHu1sx+RO74a
 JyYp8WhoZ31zGaLiY4Z8RT2gQagCYu9Pa/qu34qnoXlqP1d4L6ANVS5yNNdpa0v5d4We
 VqNZW1YYKAPIbvDgXW7iFaS1JlokPqZLUgDSJ2s7XTAH9pd7t+VCjyHsZTjuzoqZ1t71
 L7ePEUZ8vNA3eUtJfrIv7SuBWzOwjTobL4LXb7Tnl6z2Zrd9+JxIbkC3zG1mRiPDqMAg
 5vHMy1bX6uNispzjP4kVwO7XfznunHch4RpJMGbPvCUAd66FAEws39bhmUKYeoYmKJYg
 lPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=csUz3G+oANfAghQDvskgbpzawb3MHELRqPU8L59Mp1o=;
 b=tYW5dsLPKZJO4ntUFV1WsTCT5A37GSmE+jMj+uW6ifNHFGpeEtSuah+e3qMJy9mahf
 2qIWZfn+Q+6VCZ8fSWYWpwr4P/rORJYAyQ8CdGIPB2uimiyX0Gt8VYJQHQykcY/3WU8K
 7qW2zNTF2VANSRt+O94fsBW0a6JNPed72byvEWnt2Jq8mtJYRWkeKrMosmdeccTD5yLD
 NF7qDczyxFrP+cVI9lIfJDk4HqQOKd5i05IQb140RJYifbQ68CoC4C4MzAUR7DYW7oj0
 imXMzjODZq7mByLBT3lJZkOdf+4Sk0hFekZEjStxnbj4kLFvMFbw9y8Fv6dBrhikQQmw
 Niww==
X-Gm-Message-State: APjAAAVcTD88G3FlWRktAhRQUTdJRhzubeN1GhIZZ9SN/xoJC1O8vZet
 G4OSxv3ZGsqDuPNehJn+DmviNHgB
X-Google-Smtp-Source: APXvYqxAaRjfAcjAiLZ0hDfCoX7klP8WJQk2+2vFf4dNWuj4IpNVkSFkHVw8vUQRGxISKz+IUL75hg==
X-Received: by 2002:a5d:6a49:: with SMTP id t9mr21131198wrw.58.1570996695338; 
 Sun, 13 Oct 2019 12:58:15 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-0052-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:52::5])
 by smtp.gmail.com with ESMTPSA id x129sm29941857wmg.8.2019.10.13.12.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 12:58:15 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/10] usbaudio: change playback counters to 64 bit
Date: Sun, 13 Oct 2019 21:58:06 +0200
Message-Id: <ff866985ed369f1e18ea7c70da6a7fce8e241deb.1570996490.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
References: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
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


