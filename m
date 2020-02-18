Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC37C34049
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB33121D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USz99uwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB33121D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48lZ-00009i-T6
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48iX-0003Za-UO
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48iW-0004Id-VP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:37 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:43521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48iW-0004HA-P8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:36 -0500
Received: by mail-pg1-x534.google.com with SMTP id u12so11079556pgb.10
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UwMVy3DhT2jUtkg7ZPdWAKnQO+6DWfWffPjgYExKp2o=;
 b=USz99uwmXbaCrCFCIdZdP+xafQVcgC6G98Bq9WZr7x1asRBL5IjEieOMIxYsGBarDR
 RWr1c2bUsWvCsjuvhg/nt8MzYfcmwmAIHKXsUDbVjQpjAbDx49WIDb2Wa4C4gwcK0F2t
 cn8iBQkkDOsDBoBADfA2Efu40UmlE2mGaIdx+/BCSadlAFYkSolKViTwfgh23LzMqFKr
 4sCpKl5Q/eYBAzbcuigEbM4/49/WJLSwdZ67U4XHIl74uh8zlWNcVgZ2alp4OBWtf/5p
 KcRi/283uE1vpmLIFwQD9MkWJf0vZfFdD8ut1QG4kofFsq7dou1NMTL3WqCCRS2/cVZg
 HUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UwMVy3DhT2jUtkg7ZPdWAKnQO+6DWfWffPjgYExKp2o=;
 b=gkjpAV3K6GFOWoeU3FO/n19RJj+QR5DoOpAdyfctJ7z1nTAVORyqgiOi0XN2H8aQ0s
 VvUw70J0zMJYuC7Ps3hAx8OPThFIYoKECiapjyDb1Kv/2e3WsvsBij+1KuuBMGjU/5wu
 YtaO0nwOE0m4ESS4pajy+EKsdXdStLP+44J8XDzganesaxlx5+60awfDcJjQE8LzYBik
 lBB8mjQLLZBnLHnPaUsraRxWZMHJxy1RBPcyLU+XISt7rie+H4t5zpnbBFsnlHuhtSX1
 C+IIc4NxFwb+g/YbvnXjhL2rjRfILbi3A2U6GjkdLiRbBTM1Ebr+/Gk1c+u4bkHPdJZi
 LKgg==
X-Gm-Message-State: APjAAAXuSny9ImHaGRPsdiJM4r/yF0CTtkjqEeriCOh7/S11S97xiKpC
 TRm5rXL3DC6V+FhYYBE1HG337C3FT3c=
X-Google-Smtp-Source: APXvYqyuuM7yxe9PKF8rws8qjylXhQ6D3pBz6Rj4zEYeoimt0MeF7+9anuIRUQ84btrvjNcnNP9/jA==
X-Received: by 2002:a63:d207:: with SMTP id a7mr24561623pgg.225.1582054775469; 
 Tue, 18 Feb 2020 11:39:35 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y15sm424395pgj.78.2020.02.18.11.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:39:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] hw/display/artist: Delay some variables initialization
Date: Tue, 18 Feb 2020 11:39:23 -0800
Message-Id: <20200218193929.11404-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218193929.11404-1-richard.henderson@linaro.org>
References: <20200218193929.11404-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
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

We want to have an early exit path. Delay some initializations
before the variables are used.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20200214001303.12873-4-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/display/artist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 47f0e9f0bc..97c811b35e 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -558,7 +558,7 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
                       bool update_start, int skip_pix, int max_pix)
 {
     struct vram_buffer *buf;
-    uint8_t color = artist_get_color(s);
+    uint8_t color;
     int dx, dy, t, e, x, y, incy, diago, horiz;
     bool c1;
     uint8_t *p;
@@ -569,10 +569,6 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
         s->vram_start = (x2 << 16) | y2;
     }
 
-    buf = &s->vram_buffer[ARTIST_BUFFER_AP];
-
-    c1 = false;
-
     if (x2 > x1) {
         dx = x2 - x1;
     } else {
@@ -583,6 +579,8 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
     } else {
         dy = y1 - y2;
     }
+
+    c1 = false;
     if (dy > dx) {
         t = y2;
         y2 = x2;
@@ -620,6 +618,8 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
     }
     x = x1;
     y = y1;
+    color = artist_get_color(s);
+    buf = &s->vram_buffer[ARTIST_BUFFER_AP];
 
     do {
         if (c1) {
-- 
2.20.1


