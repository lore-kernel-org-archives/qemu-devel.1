Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BFFC352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4DF420873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvTojqqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DF420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2OcQ-0005uq-88
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 19:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObW-0004Wm-TA
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObV-0006yP-Qd
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:10 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObV-0006xO-LA
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:09 -0500
Received: by mail-wr1-x432.google.com with SMTP id y11so8911343wrt.6
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BURr7oChrNXkwDXgH5BYlsw5Omt/vezePcTIQ4aD6qU=;
 b=YvTojqqNlH6r1jEo+Lmf9lgk5mUKXhz0GgfAyXMu+38Ji33j+u4OJ5lCR62AGCP9Ws
 MrbbeF4ugdqjDRkOlJ7Vb9lhGJFdTqbRUUHWXbSJ4+0kQH3/43tjniJZIu6u85LqmyOK
 oLXjWwgLYrRDYUyJz1ZLH7Stt/B57sbWqFZFfYAswEof31V9mWZMT4G69mvl3FO6uwtD
 jO3cwYLTFMv8uxb5787x0l1bUxpTvXZ5ZsVBp24jFhsgp62CWoHyybizlLvcJ32Iy1iI
 xEurRRYeZfKgAYGhQlAovirQ6NY+f7teI/S9/fID9UQGJKgEUGFBo9qP7EVFJKnUuswv
 SrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BURr7oChrNXkwDXgH5BYlsw5Omt/vezePcTIQ4aD6qU=;
 b=cpHf5RQhHtzHpUngyDD5yK7ddUMca4SvqRSo1f1GdU1Fa78F4DDSBuLv1qX0TqrGZn
 sA84Xp/Www/N6b82jlCh+3ELra5QCwDfb7Wd3/UeGzs/OMd7Pf0SiusDPli76c0m7/B7
 QrDJ5szoprCoOpYdSJUvP1Cz+x5oKijM0OP2zxUQ3c1No+WnL+ASpeZy/lZnE8BIg6nc
 faVIjPN8wUeQqjAmfMg1ft3+O1zNhmvYMx77jEZlygVg4h8yJivH8tr1HynvSrU13bo3
 vC8YeNdh2WEPwPr7d0BqNHPx7UIe/SRrLCh9dL/2inIAT1/C8cQkGWuo7gIMZ10026Fz
 fbMw==
X-Gm-Message-State: APjAAAW8J4mhVmapqFttIcxxv+FAjxVKaowjnOoi6Rl/d1BofbOevTVj
 sHA7fVlcnbK1st7LfISyx/A=
X-Google-Smtp-Source: APXvYqwfLHQ8DuKrtSlctxFPyN4v5UR/b1UmD5QasLCJkSquNgJhtjxtcV+7fFud89h0zoWgJrFSgQ==
X-Received: by 2002:a5d:61c2:: with SMTP id q2mr14492wrv.425.1581639188745;
 Thu, 13 Feb 2020 16:13:08 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a16sm4679230wrx.87.2020.02.13.16.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 16:13:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 2/5] hw/display/artist: Remove pointless initialization
Date: Fri, 14 Feb 2020 01:12:59 +0100
Message-Id: <20200214001303.12873-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214001303.12873-1-f4bug@amsat.org>
References: <20200214001303.12873-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

We are initializating incy inconditionally:

    if (y1 <= y2) {
        incy = 1;
    } else {
        incy = -1;
    }

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/artist.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index abacb0e27d..47f0e9f0bc 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -557,91 +557,90 @@ static void fill_window(ARTISTState *s, int startx, int starty,
 static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
                       bool update_start, int skip_pix, int max_pix)
 {
     struct vram_buffer *buf;
     uint8_t color = artist_get_color(s);
     int dx, dy, t, e, x, y, incy, diago, horiz;
     bool c1;
     uint8_t *p;
 
     trace_artist_draw_line(x1, y1, x2, y2);
 
     if (update_start) {
         s->vram_start = (x2 << 16) | y2;
     }
 
     buf = &s->vram_buffer[ARTIST_BUFFER_AP];
 
     c1 = false;
-    incy = 1;
 
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


