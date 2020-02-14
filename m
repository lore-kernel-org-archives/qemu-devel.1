Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA96C352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C53B20873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttXJH5U0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C53B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2OdY-0008Fz-GU
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 19:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObY-0004XT-0u
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObW-0006zs-VZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:11 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObW-0006yz-PQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:10 -0500
Received: by mail-wm1-x343.google.com with SMTP id s10so8217109wmh.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yP9ZmNzMNal3Q8l+6FmOLMJ3w/noghwCGkFho029Ppw=;
 b=ttXJH5U0v1Xi3a4PZcP8z0wRXcXHU5m058eW47UMg3lVQmVgIyvkrPTm5QHnYtH8Sa
 HFTo7Fg2usLvJ4H0jPvYXnCDvJICOAqN4QkvdhNUJhbIp7BbY6qDgz8yXnxpP7B3Ogpb
 elBog8yerWblRiXGbpmrjCEUTyCqq33zEMSxPqGnqyY+OnNaxidkVwU8tZH10fE2rJXn
 tVBp16k/w92no1AFRcL1QKGCvGONNFVNlWIGTqoHvi/sIR1ctYxasxAIi8lckEzrM8Mp
 w6hGMsNxFLQ6/0nOWmxpyfLODsqr9WWNGtgakfilGRt2J/gz2xb5UqkGxoknijC9w35N
 E0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yP9ZmNzMNal3Q8l+6FmOLMJ3w/noghwCGkFho029Ppw=;
 b=F7poE4OfT3QtRymi9DVAsz5Br9S+a9ZI8glO0mnC53JgV4ATlms0aXRsm4Ek2+JEHR
 NV8dJ3a9h88MQsY5KFv1+mOqB4z4E7maQobO2c/YaXN5XlXYRg3uq9KlPklFSJwC578p
 Z2jEkAg5bcoezKjYMC+sZ5R4fTQqxV/fFxfow1ZfDc/796dJ8v9r8MHvWB2pF3JDk0uT
 TnCiBsanxYEBuyK3zwnS4SxOWlMiziI7vXaMOZ2o8Yiy8On/s2K63aqi4r5VU6sBbldZ
 kfdBQePa6mA7yO+982++taFNp84TgDpmiHzDU98ytoxSP56gVXBmwS9TKRqk+J+7xktw
 WBIQ==
X-Gm-Message-State: APjAAAXKFMERPSK1wFZXlmf4weJ7fTZr+/6KRfd/rpgs1A0EqOXkvuGZ
 Armqc1fyV8JN9qHs+U1PUkg=
X-Google-Smtp-Source: APXvYqydPo6xuhkWDqGB4u75ug48zex7RW5HQ7wJeMMj3qRmtL8Lo3FB8Rm5kUKo92UbI7ETsR7CLw==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr662952wmg.20.1581639189859; 
 Thu, 13 Feb 2020 16:13:09 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a16sm4679230wrx.87.2020.02.13.16.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 16:13:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 3/5] hw/display/artist: Delay some variables initialization
Date: Fri, 14 Feb 2020 01:13:00 +0100
Message-Id: <20200214001303.12873-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214001303.12873-1-f4bug@amsat.org>
References: <20200214001303.12873-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to have an early exit path. Delay some initializations
before the variables are used.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/artist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 47f0e9f0bc..97c811b35e 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -557,90 +557,90 @@ static void fill_window(ARTISTState *s, int startx, int starty,
 static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
                       bool update_start, int skip_pix, int max_pix)
 {
     struct vram_buffer *buf;
-    uint8_t color = artist_get_color(s);
+    uint8_t color;
     int dx, dy, t, e, x, y, incy, diago, horiz;
     bool c1;
     uint8_t *p;
 
     trace_artist_draw_line(x1, y1, x2, y2);
 
     if (update_start) {
         s->vram_start = (x2 << 16) | y2;
     }
 
-    buf = &s->vram_buffer[ARTIST_BUFFER_AP];
-
-    c1 = false;
-
     if (x2 > x1) {
         dx = x2 - x1;
     } else {
         dx = x1 - x2;
     }
     if (y2 > y1) {
         dy = y2 - y1;
     } else {
         dy = y1 - y2;
     }
+
+    c1 = false;
     if (dy > dx) {
         t = y2;
         y2 = x2;
         x2 = t;
 
         t = y1;
         y1 = x1;
         x1 = t;
 
         t = dx;
         dx = dy;
         dy = t;
 
         c1 = true;
     }
 
     if (x1 > x2) {
         t = y2;
         y2 = y1;
         y1 = t;
 
         t = x1;
         x1 = x2;
         x2 = t;
     }
 
     horiz = dy << 1;
     diago = (dy - dx) << 1;
     e = (dy << 1) - dx;
 
     if (y1 <= y2) {
         incy = 1;
     } else {
         incy = -1;
     }
     x = x1;
     y = y1;
+    color = artist_get_color(s);
+    buf = &s->vram_buffer[ARTIST_BUFFER_AP];
 
     do {
         if (c1) {
             p = buf->data + x * s->width + y;
         } else {
             p = buf->data + y * s->width + x;
         }
 
         if (skip_pix > 0) {
             skip_pix--;
         } else {
             artist_rop8(s, p, color);
         }
 
         if (e > 0) {
             artist_invalidate_lines(buf, y, 1);
             y  += incy;
             e  += diago;
         } else {
             e += horiz;
         }
         x++;
     } while (x <= x2 && (max_pix == -1 || --max_pix > 0));
 }
-- 
2.21.1


