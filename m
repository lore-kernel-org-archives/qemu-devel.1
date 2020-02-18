Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1006CC3404B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE1421D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqNDPA96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE1421D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48k1-0005Hd-S6
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48iV-0003YQ-DG
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48iU-0004Cx-AV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:35 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:43602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48iU-0004BO-4v
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:34 -0500
Received: by mail-pf1-x429.google.com with SMTP id s1so11149970pfh.10
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oxNPd/QkKRHeWi1ZwK35YEXvYDOJm8fo+psN51CFfCE=;
 b=QqNDPA96P6n8HKuahSWYbC6VO/tDywq9jGpeOVoQIlhZnod8THLzSpU9IJQkmMT9x1
 I5/P7WfapfgYf1hLF5GFkAtfK5lBxnU5C+zgOEClroyU/hzD5dKusLAplgJHAP2rhKPN
 LURe35h5QbwEdLLfrMH8Nn4S7dpLKYZTUTvq0EiivEaZz74NPaFwtG7c7XM7ntcLN1Jo
 +rF1/9OjvZyvZLk07k+Uov/vEyCF6mqsH4v7YF92g12uRKEAglMco9z3ywatVliCsq/K
 MOjc59ccpXPdwaR5nuYfr1wZMl1DMDrxj09kGKZiiJ2mTB7ENa3mNxAdTRoL18YjblzB
 iZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oxNPd/QkKRHeWi1ZwK35YEXvYDOJm8fo+psN51CFfCE=;
 b=CC6EyFdDQ3MQktAqtrft471LZC3zeMegZ0BNtwfxRmrfGeKIFuk3i4KU+w55ExWL86
 9KyOVJqVvyDaX/UZZv0xv1lyUAaAHUnfhXnyF2PoCI4K9NxXNFHLAWeE+3JxVCh6zIJN
 pwpivyQ7dcPYycc3jYQFg0tmEaSW1U2N9tUgz1dFcrSNAeHaq6j9A4iqWvIpby10hd2U
 VqLpZU1D91W6vpdvSXrRbkVGPWWa/hppfyUBM6ngzfVZ3/VaGW+2Aah9qHgM1KPZxaUK
 b5A94NG/mqCP75MttoZqLPBPMOKNYktAGhdApv94oMz5zueeBRNWOwPaZ0Iy3WwDgcAQ
 xTSQ==
X-Gm-Message-State: APjAAAXNXFwsBXv9rgYZ/07ICnl0IN6SfM7gyIB/I11MPY1JXzA3Z2zS
 rBy+tRsFax4KzToIzpOK9c50NYJtcnM=
X-Google-Smtp-Source: APXvYqyI9DnLipebkx5F5sPCi4mcKwdTAnF/oSEJoDfacdBQIG869LxzOCd6bd98qoaA2nsJWfWu6g==
X-Received: by 2002:aa7:9ec9:: with SMTP id r9mr23001986pfq.85.1582054772794; 
 Tue, 18 Feb 2020 11:39:32 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y15sm424395pgj.78.2020.02.18.11.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:39:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] hw/display/artist: Move trace event to draw_line()
Date: Tue, 18 Feb 2020 11:39:21 -0800
Message-Id: <20200218193929.11404-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218193929.11404-1-richard.henderson@linaro.org>
References: <20200218193929.11404-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::429
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
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Instead of emitting the trace event before each call to
draw_line(), call it once at draw_line() entrance.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20200214001303.12873-2-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/display/artist.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 65be9e3554..abacb0e27d 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -563,6 +563,7 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
     bool c1;
     uint8_t *p;
 
+    trace_artist_draw_line(x1, y1, x2, y2);
 
     if (update_start) {
         s->vram_start = (x2 << 16) | y2;
@@ -654,7 +655,6 @@ static void draw_line_pattern_start(ARTISTState *s)
     int endy = artist_get_y(s->blockmove_size);
     int pstart = s->line_pattern_start >> 16;
 
-    trace_artist_draw_line(startx, starty, endx, endy);
     draw_line(s, startx, starty, endx, endy, false, -1, pstart);
     s->line_pattern_skip = pstart;
 }
@@ -668,7 +668,6 @@ static void draw_line_pattern_next(ARTISTState *s)
     int endy = artist_get_y(s->blockmove_size);
     int line_xy = s->line_xy >> 16;
 
-    trace_artist_draw_line(startx, starty, endx, endy);
     draw_line(s, startx, starty, endx, endy, false, s->line_pattern_skip,
               s->line_pattern_skip + line_xy);
     s->line_pattern_skip += line_xy;
@@ -683,7 +682,6 @@ static void draw_line_size(ARTISTState *s, bool update_start)
     int endx = artist_get_x(s->line_size);
     int endy = artist_get_y(s->line_size);
 
-    trace_artist_draw_line(startx, starty, endx, endy);
     draw_line(s, startx, starty, endx, endy, update_start, -1, -1);
 }
 
@@ -743,7 +741,6 @@ static void draw_line_xy(ARTISTState *s, bool update_start)
         return;
     }
 
-    trace_artist_draw_line(startx, starty, endx, endy);
     draw_line(s, startx, starty, endx, endy, false, -1, -1);
 }
 
@@ -755,7 +752,6 @@ static void draw_line_end(ARTISTState *s, bool update_start)
     int endx = artist_get_x(s->line_end);
     int endy = artist_get_y(s->line_end);
 
-    trace_artist_draw_line(startx, starty, endx, endy);
     draw_line(s, startx, starty, endx, endy, update_start, -1, -1);
 }
 
-- 
2.20.1


