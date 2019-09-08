Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE23C433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930C5216C8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIyW3JYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930C5216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74sA-0001L6-D5
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74e5-0005eu-HI
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74e4-0005wT-Fa
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:53 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:36025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74e4-0005vv-8A
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:52 -0400
Received: by mail-qt1-x841.google.com with SMTP id o12so13867176qtf.3
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8TTUthXqXhh1DdLxMpTCEbLpELmMAAhIVdhapb9+b1E=;
 b=EIyW3JYYeXY+0Ce/Gt1EQ4sU8m0+4hbK9t1YHsRolUKArTIRjatmrs//WEXcIlC1d9
 V2pwELdE/XwX8mK3HMrmBOLXxFQN+0UKHSR79ESrRviKDnDq3ZQHawbnLi1Y6EI4C5aH
 M/ALeGyd0SLuiAd1hPtgq4XzShmbKRKAhF2u4+iyfFnMMYhwrFdAwjKrxsWp0WdlThHJ
 vWA14/IBRBXHfgHHzyOfn96ATQF9XY0XyUSrQg75m/3CmklF7MaJuMJQfBZToOOIjnic
 pwP7mNkNLPbQ6yESrTiLvgqb8OJ2JvTLTFDKNIVsgvUBhGpCT0B38j+FSVAtztQ24i3s
 Pruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8TTUthXqXhh1DdLxMpTCEbLpELmMAAhIVdhapb9+b1E=;
 b=ZNS6/thHRK9Wra/nUvTr7vBVbkX8m+FVIT40bSTp8ynzy159vZnVEN+SK0HQX5PXJz
 VtPenQkfwW0Q+TXMbmMYurD6zFnosxiJ9ScoBN4SGaJc58XrVYNlNrqjenBZw3+M59g3
 KWgJRguVq/opR95B8Sla5rWhFPrY71yuKXcRwZWJmQlhrqWZTjrN21qJYtTDojwlXTgl
 X3WXOuOOTTqLLD/T9T+GUV2sewYoj7ov/Dtc8hzIicl5J0sF3DY4LdMKDsqi5T2v1WQI
 b9eNHDI59KN23KSd6W2SV00VtpWmAiqUY5Yn+ffAuK6J+eRMQpAUkN42ZjEfUOmArgbH
 0XHQ==
X-Gm-Message-State: APjAAAUkjw+wtV4CVky1IJyigEBoY8VJlsfTm7qf3OQPfQbFSi3RPLDC
 hdkhB2wlM5MB0Wo6jxFPdanuLQI7
X-Google-Smtp-Source: APXvYqzH87MzUWfBCruVsfG9S/ZsQY8dObs7+6fD2mVx3oKnTKiy0JAI+k4VXVlQd3wgKHSHcjrz7g==
X-Received: by 2002:ac8:37d0:: with SMTP id e16mr20245521qtc.79.1567977771760; 
 Sun, 08 Sep 2019 14:22:51 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:51 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:22 +0200
Message-Id: <18cff45473f6dab021743ebb96fcee25b711b55d.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v2 22/24] usb-audio: do not count on avail
 bytes actually available
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


