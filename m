Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAC5C3B18F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4599020873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI+QBxV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4599020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Odh-0008R1-FN
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 19:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObZ-0004Ze-41
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObY-00071E-2j
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:13 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObX-00070O-Ss
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:12 -0500
Received: by mail-wr1-x434.google.com with SMTP id w12so8922867wrt.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oCtK+42l2rwmoTfk+qizXxhXlan3l2UxeBXnHI+77tM=;
 b=QI+QBxV5lX8oBqhAQPFsozi+7uVWC6eRMoLP1PTU7oTTAofVo6/WklzshMvn8lpb7u
 2oRENyiKsWZYT5d3IFcG/cTjd07pd1x3s4bxZj2szae2+PyaDp/g3hCJ6fqem7rH5VvN
 ItimTSwZ+sNT8U3k+PPltPYjsqnupk3PlNltAb6sjeNCGYCw/mspJAagew6oaR4OkjHU
 mBRqj8pMTEdbXgEnD0DsrN5HZknlf/Pymg6xfJZ/LtBJtBVdFGrrBgxL+Arwigi9RB2A
 rxgk9csxETO8jSfVAsTBzmtC6RQhBNuW7GgvVyXUSYe8Xten8Knc89vHkASGW1o0ybEI
 K+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oCtK+42l2rwmoTfk+qizXxhXlan3l2UxeBXnHI+77tM=;
 b=gpGkCD0lpvD28+KjU9sQ9XY93FyVyF6dI05FdhvJPCSNRzIrUEcXzWRk6QqjGftIuB
 vHy4YHmHHMrsAi6ot4GXkhwOv02kykDmzZZS9EjcyBsun6UCXbige6BuQQycFeWjcz/U
 UdQJo3wdTozhZJO/z2J+ks9r5YYn3OxjqfTYxhoVvHTSV1hyjFxyoQfv0ox9rlLz/tNu
 RdCp11BhAGByzehqoZ8ZbeKFY0wzocXbgBaJLM+Iap74HVFVKir3TXC/+/p3/FSGox0S
 xBhhBk+e1AXKX8GduFiyh1GjIv3TmFpNYPo/ifaeTjWfq2AW6xwVXUTnRNlcCJh2iCNl
 vNGw==
X-Gm-Message-State: APjAAAVPnE98Fu79/qXKFuoOlauyTvZp1MdxQXiFOZOOVnZnr+MpLIL+
 Ol25jPgovKEERc2aFpou1og=
X-Google-Smtp-Source: APXvYqzhGTgSfAQk8uAOtlDHVzxAKl0UmIUGENqpH/8wbpnDst4QzsuhChAh6959BU9MNMhEJQuJyA==
X-Received: by 2002:adf:e742:: with SMTP id c2mr74252wrn.346.1581639191059;
 Thu, 13 Feb 2020 16:13:11 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a16sm4679230wrx.87.2020.02.13.16.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 16:13:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [RFC PATCH 4/5] hw/display/artist: Avoid drawing line when nothing to
 display
Date: Fri, 14 Feb 2020 01:13:01 +0100
Message-Id: <20200214001303.12873-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214001303.12873-1-f4bug@amsat.org>
References: <20200214001303.12873-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because untested =)
---
 hw/display/artist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 97c811b35e..5492079116 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -557,90 +557,93 @@ static void fill_window(ARTISTState *s, int startx, int starty,
 static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
                       bool update_start, int skip_pix, int max_pix)
 {
     struct vram_buffer *buf;
     uint8_t color;
     int dx, dy, t, e, x, y, incy, diago, horiz;
     bool c1;
     uint8_t *p;
 
     trace_artist_draw_line(x1, y1, x2, y2);
 
     if (update_start) {
         s->vram_start = (x2 << 16) | y2;
     }
 
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
+    if (!dx || !dy) {
+        return;
+    }
 
     c1 = false;
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
     color = artist_get_color(s);
     buf = &s->vram_buffer[ARTIST_BUFFER_AP];
 
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


