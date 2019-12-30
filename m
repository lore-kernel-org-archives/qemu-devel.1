Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BA7C2D0D3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 22:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56D1206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 22:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu+FHE0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56D1206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1im38P-0007UZ-Kj
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 17:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavlica.nikola@gmail.com>) id 1ilypr-00054O-1l
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavlica.nikola@gmail.com>) id 1ilypq-0006gM-4I
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:28:06 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51480)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pavlica.nikola@gmail.com>)
 id 1ilypp-0006g5-VG
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:28:06 -0500
Received: by mail-wm1-x343.google.com with SMTP id d73so114577wmd.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 09:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=DKxEyQEWWonv3/oV1ZRaUYsqd9/HbiTnWCnnF1QJ9tE=;
 b=Cu+FHE0daDdCw7KqzJ9fLAWkpPfuiY5nYK084HoVM9wXw03Qx28RJvcdkOdvNi3Bay
 KbHaed4YLov0Ex82hf+prf/i8VgmoLOOgGrXcBDr7krj79+W29ABSZLqUMjvi6t29Reb
 fp5FmBPa20uSiZV6tPCHyz0wa25hYbX+ojM5JdOxtjxoVXuIClWTmK60GNmiFpVvuNsl
 fdLq79mj1LuXmhyz+jhl8YgJrTWegibDaDmzq4jyEB6lSKNT6uwehLShhaWoepLaSenI
 oOSqIS36HS7yaj8CuQh25E/wLaFCxVSuiDw5Q+U66//S4375yaXRl110KEE2Df68nw0X
 sQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:date:user-agent
 :mime-version:content-transfer-encoding;
 bh=DKxEyQEWWonv3/oV1ZRaUYsqd9/HbiTnWCnnF1QJ9tE=;
 b=NB48rMpRbDKMpVJ2TekhkhMIjEIj2fdL+thYpvOI+mPzBwGaLQHpSljpJoU0QXfWt3
 JwFNwxWTjH3LhVX2Z/QmFN+HYQAzLQ0ra+/7Xq2fqRor6XxaKFvOhUG+palrw21V3U/m
 ueOesqMWd9JujR2dhY0iP4RdKNWwqY358keKhT2U2o83f7AGGc3FhexE3ZC0c8qG/ftf
 gEyoLWvX13fgmRx9hgIkAiduDEFtRLMOTyDrnbfCucAzQdYcXy4qgkqe93aU2j/7fBP3
 h8g9BOjlGnv3qCVgzqb8wByJigopMwOK26iPuzk6u8u3YoQaaOEgXokGm8/VLhWIJFKI
 IxvA==
X-Gm-Message-State: APjAAAVRCSo3OMatXsvvq2M3wuAACmmrnaijRTlpAK82KPqHdZ+2fiLU
 +49gu0hDIyCtzBamM9wyGqKeAjAUfeQ=
X-Google-Smtp-Source: APXvYqwTwZLPXeSTzHWmFTCrvEsgX1dkUjDSxNfSoOLHnh3PwC0edrnpYvzr+y2eB/Cl8le2vyHySw==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr135815wmk.42.1577726884232;
 Mon, 30 Dec 2019 09:28:04 -0800 (PST)
Received: from HP-Laptop (93-143-218-144.adsl.net.t-com.hr. [93.143.218.144])
 by smtp.gmail.com with ESMTPSA id
 v22sm82405wml.11.2019.12.30.09.28.03 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2019 09:28:03 -0800 (PST)
Message-ID: <8531e41f28df7f4bebe4db257ff95e92f5145afc.camel@gmail.com>
Subject: [PATCH] display/gtk: get proper refreshrate
From: Nikola Pavlica <pavlica.nikola@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 30 Dec 2019 18:28:02 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
X-Mailman-Approved-At: Mon, 30 Dec 2019 17:01:56 -0500
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 70c95b18fa056b2dd0ecc202ab517bc775b986da Mon Sep 17 00:00:00 2001
From: Nikola Pavlica <pavlica.nikola@gmail.com>
Date: Mon, 30 Dec 2019 18:17:35 +0100
Subject: [PATCH] display/gtk: get proper refreshrate

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
---
 ui/gtk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 692ccc7bbb..7a041457f2 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2259,6 +2259,11 @@ static void gtk_display_init(DisplayState *ds,
DisplayOptions *opts)
         opts->u.gtk.grab_on_hover) {
         gtk_menu_item_activate(GTK_MENU_ITEM(s->grab_on_hover_item));
     }
+
+    GdkDisplay *display = gdk_display_get_default();
+    GdkMonitor *monitor = gdk_display_get_primary_monitor(display);
+    vc->gfx.dcl.update_interval = 1000000 /
+        gdk_monitor_get_refresh_rate(monitor);
 }
 
 static void early_gtk_display_init(DisplayOptions *opts)
-- 
2.24.0



