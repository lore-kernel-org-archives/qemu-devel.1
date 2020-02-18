Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD27C34049
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C46724654
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXerTJA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C46724654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48k7-0005US-BE
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48ia-0003fd-Pa
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48iZ-0004O4-NB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:40 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:42681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48iZ-0004M7-GT
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:39 -0500
Received: by mail-pf1-x42e.google.com with SMTP id 4so11147922pfz.9
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jAN9/5WEnE9dxJr6iL5ixKsH798kIxR23zQ9JVcmqi8=;
 b=fXerTJA/78ZheSMhs2rpB8CviX/9SYutyA4Ct9KpYId2tli/PRUoCCi+a97qP4X0en
 KEZjvDulRV9zO09FuiTuPnXYblt3B0iHwv8CJQlTU+Ch1UbHqroqTSs481vcjT7rkDVn
 zsmr/cDLeB/ueyBN7JLkhkcJ03UzOcdMxy+qVL6u+lOCYTyn7z2y2sednQknpOXMn1Gj
 X1bDkwftYSlYkcOR1Gcb6NGnp/rTNEA+KsyS/MH/9jGAVYDBXm3//V1S7xGpwKUbtO05
 rHHE8ctINLN2TIM0DOIWQW4ND6PjP88d5K6uDbkwIKbY9GWEgv0li61svmRvLkHw4nh/
 Tlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jAN9/5WEnE9dxJr6iL5ixKsH798kIxR23zQ9JVcmqi8=;
 b=Yf1wQjihJsCu3EaqGuDgfFZf7+D5ChQOkctG/J5xkDHegnCvC1Y8NYCxDSbU2h9Blv
 74IvY51N45IeZbQ89iZCVHJD/yS5QBkD8nfbKaHaDeLiKxyP/WsISmjmHyp9uITduyJq
 N+AY2OjwtHaP//KM1+N2HZJW1ZDDWaZWXK+7x25NRl/lr3GkAVeYpm8RfjPrlC6TpL/8
 j+vxRkYBhruKEohi1mdCTk8kcjwm7BnAkJm+sszZb2wbsgSOePOUjHzH22l3kg4aDOtW
 kLwhO+SNNdQSn8HVGpNAH/ktn/Zxi5gNBtupqCxS9Xr4eUsXrFB2LDIaQu2D2F+ELYso
 Tcsw==
X-Gm-Message-State: APjAAAVNUOdHy1G2zvcrQKSpBAKsXhJET6WvSrkv7VeTk8xOjdHMBAQq
 JPLCO+jU9C3iq/ThZi402gC09MKBum8=
X-Google-Smtp-Source: APXvYqyGzJ+uFuMa5Xu14iEcBpQfewF+tFt+3pdltaZMo7g3D3rWg9e/oHEztCJxvZzewczeWSl36g==
X-Received: by 2002:a63:6407:: with SMTP id y7mr24377957pgb.45.1582054778035; 
 Tue, 18 Feb 2020 11:39:38 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y15sm424395pgj.78.2020.02.18.11.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:39:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] hw/display/artist: Remove dead code (CID 1419388 & 1419389)
Date: Tue, 18 Feb 2020 11:39:25 -0800
Message-Id: <20200218193929.11404-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218193929.11404-1-richard.henderson@linaro.org>
References: <20200218193929.11404-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
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

Coverity reports:

  *** CID 1419388:  Control flow issues  (DEADCODE)
  /hw/display/artist.c: 739 in draw_line_xy()
  733         if (endy < 0) {
  734             endy = 0;
  735         }
  736
  737
  738         if (endx < 0) {
  >>>     CID 1419388:  Control flow issues  (DEADCODE)
  >>>     Execution cannot reach this statement: "return;".
  739             return;
  740         }
  741
  742         if (endy < 0) {
  743             return;
  744         }

  *** CID 1419389:  Control flow issues  (DEADCODE)
  /hw/display/artist.c: 743 in draw_line_xy()
  737
  738         if (endx < 0) {
  739             return;
  740         }
  741
  742         if (endy < 0) {
  >>>     CID 1419389:  Control flow issues  (DEADCODE)
  >>>     Execution cannot reach this statement: "return;".
  743             return;
  744         }
  745
  746         trace_artist_draw_line(startx, starty, endx, endy);
  747         draw_line(s, startx, starty, endx, endy, false, -1, -1);
  748     }

Fixes: Covertiy CID 1419388 and 1419389 (commit 4765384ce33)
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20200214001303.12873-6-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/display/artist.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 5492079116..753dbb9a77 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -734,15 +734,6 @@ static void draw_line_xy(ARTISTState *s, bool update_start)
         endy = 0;
     }
 
-
-    if (endx < 0) {
-        return;
-    }
-
-    if (endy < 0) {
-        return;
-    }
-
     draw_line(s, startx, starty, endx, endy, false, -1, -1);
 }
 
-- 
2.20.1


