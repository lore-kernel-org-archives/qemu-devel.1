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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB36C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F8C21479
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXPTiX+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F8C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aTz-0005OY-Gv
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7r-0006Gz-Vh
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7r-00023H-0o
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:59 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:42357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9a7q-000231-RC
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:58 -0400
Received: by mail-ed1-x542.google.com with SMTP id y91so31230572ede.9
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8TTUthXqXhh1DdLxMpTCEbLpELmMAAhIVdhapb9+b1E=;
 b=QXPTiX+guQt09Ag/fj6GZFCedi0ojZSI2Jb9u0COhUjkfcTbyvXNp1q5CcRL5mDz6N
 R6FMMjgdfRx0ceM3ND5hdoPMEZv5+8QAViVa01hFVC65UTqgfGMvcrtU21beeinTMPC6
 EgQ+422mttTm+/uKkvUL+dZgLjmZgjYpBYWPodRBlsY28tmB9vXqGJ/IQsGcIQzOMml6
 vykFbz51XBByCpdZ9LysAiyDVahprJc8uTX6EI6AqfW3PjzxWw5sKm+o8lF4sTQVeyPw
 WTk/V6TxLk/j3mrnAPV/fBXfO/zUe8ALt/N42UgyCInC8WJEIuGxygr0/ir5Hfx9Llwh
 3aBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8TTUthXqXhh1DdLxMpTCEbLpELmMAAhIVdhapb9+b1E=;
 b=R8WrdMVwkXS3mvnPa+f/vn60zGL/aAV/96HBAWjjDwkvxXhsmtreSSetsLzEPx+tEA
 ah9EsKR4vUI/qYnH4drf6pG9VvNPQO+tc6Sr7kqRb5udmm61kygNQ3/4kk23uuc9zVSt
 lKALb1mV83FMboE2kB4jlePeMVzrs/eXb1WdAnebrsfmdAStbvDR55qRNAQIPoJK/bHI
 WLFIAP+ZsZwljONCAZ4Xl5rMKgSA3W51JmC+AzPkScsGGmoCM7zqbN9VupRdStgvA+1b
 /66Gsy6ZK+ExXTI0GVCNpZsQjeTBrYhIRosMFKnOQPiAzrFpAezG+v0PMvKFf+npsXGw
 pJPg==
X-Gm-Message-State: APjAAAUbWYaijAOInkvG2JkyO7ROF/DFYaGi2rCSdNx7FPvVCpH2OJS3
 wDpnqZt9Di7ZTIQrVFShg6Fa0sFS
X-Google-Smtp-Source: APXvYqwIw3D+21d7T0Q1M1x72sVVaDxIi9QMHijACbpt/8RmUTMx135EiuDvv+iRIgjA4XbdXmy6bQ==
X-Received: by 2002:a17:906:8406:: with SMTP id
 n6mr18485573ejx.138.1568575437717; 
 Sun, 15 Sep 2019 12:23:57 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id j20sm6480562edy.95.2019.09.15.12.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 12:23:57 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 21:23:38 +0200
Message-Id: <90b5ec62109a69ee7c28d95b367e40dc41ad658a.1568574965.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: [Qemu-devel] [PATCH v3 22/24] usb-audio: do not count on avail
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


