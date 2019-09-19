Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4D2C4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C6C217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEAIDvr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C6C217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4Ih-0002Ct-O5
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3uv-0002uE-Qt
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3uu-0000k9-2G
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iB3ut-0000jk-QL
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id r5so4574832wrm.12
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8TTUthXqXhh1DdLxMpTCEbLpELmMAAhIVdhapb9+b1E=;
 b=sEAIDvr/w/jncZIJMs54Dwu0Vf6ErZ6zInfGFlcIdGGHx0ARaMrzeZHH04/kn4zsdi
 8vpxpliz6Pw7Q8Ye4VbHR6hAoWMqOSpIFifBdvW7Vv7nYBUXqslr9IDH0s/9KLBZ6Fpy
 o4wG/HMbY9+hhAYkeCrgJolnhIfE8VhYI8PYWd9qB2OZQI8XYKMj6oHRCO4L8YdkRQJq
 QLUQJRJVE51pOIqBJaSKm699xN64cRUeX4jMQko1cE/lUTUay+xQAb9BcdTJnrrPy7J5
 rYAUmihTEd4wntEFDssFXa2A2rk8i7h57r36+a920RqVoSabazwbxi1nXVznh497opci
 f6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8TTUthXqXhh1DdLxMpTCEbLpELmMAAhIVdhapb9+b1E=;
 b=C9wpggCKMj099ZEb6qbMQ/6/tNvAZXzjyj7DwQul0/aWnAAmNiSXpOpt6YJobT57EM
 d2Hu1viiggqmyw3nOhVBI8txWRKrRP4Kip9WnJ4WwWkqlSrRGvX0rUcYbkJHheQRgM74
 C2WH/Xguv20jjqvT/6CrGLMjwHpq1zOnO3lzqZjWPIYXChVnmIKskpsJ5GJcl8YV6F1H
 LQw0AI0bkX0o3JS7x8m1OTLIiJ8hWijRQm/9VERcXQKU/0hq6BAmc56IOLBCvz7Skyyq
 DGdY3vL3Hxmz3N9ffigKiPUfq3xoxG3qfD7y9Ep7WT0iABBwv89dAjOu9F4Hb8Q0gAc4
 VImw==
X-Gm-Message-State: APjAAAUNfBemjWTzWam92iwdskF45WPNXxm2BMzUW/gghN95YHxByXE1
 MLJfsIOc3DoaO0HyRo66q4JI5q4b
X-Google-Smtp-Source: APXvYqy57j1yKJ8ycKOBM8xXk+FK10g9C+YzUBKnW+tpElyuEeURZrmgAKbi6ZdgP7PUbfLMOOF5HA==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr2834732wru.239.1568928282547; 
 Thu, 19 Sep 2019 14:24:42 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id w125sm13191292wmg.32.2019.09.19.14.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:24:42 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 22/24] usb-audio: do not count on avail bytes actually
 available
Date: Thu, 19 Sep 2019 23:24:30 +0200
Message-Id: <aee95223703429f21a7ebf502095d5976091c773.1568927990.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

This assumption is no longer true when mixeng is turned off.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 hw/usb/dev-audio.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index ae42e5a2f1..74c99b1f12 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -319,30 +319,31 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p)
 {
     uint32_t free = buf->size - (buf->prod - buf->cons);
 
-    if (!free) {
+    if (free < USBAUDIO_PACKET_SIZE) {
         return 0;
     }
     if (p->iov.size != USBAUDIO_PACKET_SIZE) {
         return 0;
     }
-    assert(free >= USBAUDIO_PACKET_SIZE);
+
     usb_packet_copy(p, buf->data + (buf->prod % buf->size),
                     USBAUDIO_PACKET_SIZE);
     buf->prod += USBAUDIO_PACKET_SIZE;
     return USBAUDIO_PACKET_SIZE;
 }
 
-static uint8_t *streambuf_get(struct streambuf *buf)
+static uint8_t *streambuf_get(struct streambuf *buf, size_t *len)
 {
     uint32_t used = buf->prod - buf->cons;
     uint8_t *data;
 
     if (!used) {
+        *len = 0;
         return NULL;
     }
-    assert(used >= USBAUDIO_PACKET_SIZE);
     data = buf->data + (buf->cons % buf->size);
-    buf->cons += USBAUDIO_PACKET_SIZE;
+    *len = MIN(buf->prod - buf->cons,
+               buf->size - (buf->cons % buf->size));
     return data;
 }
 
@@ -374,16 +375,21 @@ static void output_callback(void *opaque, int avail)
     USBAudioState *s = opaque;
     uint8_t *data;
 
-    for (;;) {
-        if (avail < USBAUDIO_PACKET_SIZE) {
+    while (avail) {
+        size_t written, len;
+
+        data = streambuf_get(&s->out.buf, &len);
+        if (!data) {
             return;
         }
-        data = streambuf_get(&s->out.buf);
-        if (!data) {
+
+        written = AUD_write(s->out.voice, data, len);
+        avail -= written;
+        s->out.buf.cons += written;
+
+        if (written < len) {
             return;
         }
-        AUD_write(s->out.voice, data, USBAUDIO_PACKET_SIZE);
-        avail -= USBAUDIO_PACKET_SIZE;
     }
 }
 
-- 
2.23.0


