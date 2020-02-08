Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7820C352A1
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B5121741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdI0qJAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B5121741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Si0-00077J-KI
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 11:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Sh6-0005L6-Kd
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Sh5-0008Bj-Jn
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:10:56 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Sh5-00089N-De
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:10:55 -0500
Received: by mail-wr1-x441.google.com with SMTP id w12so2429039wrt.2
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 08:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FoWmL8sKylM8WJIpC88DanoYTeGhcfzC10Wj5Ji+jA4=;
 b=AdI0qJAFfPTKevtGMBS0JiisLq0VHg9mFKPXFrQLw5oRs4gdaputMeEeWcwaJix4B5
 1HTRGWTR3A6C36aUbDBoifrisztDXg46iz22P/8sj6jgYa9Jd+TrYBpdWMwu1mJ7Z+4t
 PbvkPW17yA1oVK4a3pfGSG6KwQ8mDuwo6A7/oY8uEwmnO4aA0Y6XqfNsv8ZECZIILr7B
 cRdvnE6xc9FNrYkfNCARB6psT/VGPoKq6JbdxT0Uv786pL8LGLz7SL+YtDslXS6h52qT
 k3Red+JidBLcr1X13GwJsUG8TiPICFdHU28TStfuxczbC42HNlpqqtb1GkcCk//0DgQl
 ICCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FoWmL8sKylM8WJIpC88DanoYTeGhcfzC10Wj5Ji+jA4=;
 b=eU0OhH3tgAhOtONg4WxLNCuUJTaCDvFwgziDOBdYBPslRHpQKGa4rxWabrYsLsWS70
 VwRWFBvAWVvY/V6PtyC7yZFSlor2WVNIT/RTkI5gJBvS5UjFzNL5uRZnjnMsTu7yt5Bj
 Bz9K0vjT+YtFAwKQRDoUekD9knddClch4H5B6JrxkIeT8TaPm4PLcFIolb0ZMa+Mz7MT
 49/ZanZKhhp/kh97JOxaojEBtjXUeYs7z7ztWHhMd2hh6ltz/DoM0rjJ+OY+esuyD39o
 jIEqXbQuZUMQ4zOvsouLnVmv5ASuuYzkG+dSY7IgheqHLEH9ZWKWo7hGfrx//n8PtAmh
 bb0A==
X-Gm-Message-State: APjAAAVaULJeI0h4X0G3/mCVyyHV9H/3y8sQ7R37uqLByz5Pemwh4t2o
 DVWDoTWK7chMzZR8Th6Fd1SYOSwg
X-Google-Smtp-Source: APXvYqxGpKDkOs2Py73RTJhZ9YMuL34RAdd+SQ/74J7wjMIvf/2gMxsXS62LYdISlZDGoq/k6fzhtA==
X-Received: by 2002:a05:6000:1183:: with SMTP id
 g3mr6064565wrx.374.1581178254241; 
 Sat, 08 Feb 2020 08:10:54 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l8sm7931669wmj.2.2020.02.08.08.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:10:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH v2 2/2] ui/gtk: Fix gd_refresh_rate_millihz() when widget
 window is not realized
Date: Sat,  8 Feb 2020 17:10:48 +0100
Message-Id: <20200208161048.11311-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208161048.11311-1-f4bug@amsat.org>
References: <20200208161048.11311-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Gerd Hoffmann <kraxel@redhat.com>, Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gtk_widget_get_window() returns NULL if the widget's window is not
realized, and QEMU crashes. Example under gtk 3.22.30 (mate 1.20.1):

  qemu-system-x86_64: Gdk: gdk_window_get_origin: assertion 'GDK_IS_WINDOW (window)' failed
  (gdb) bt
  #0  0x00007ffff496cf70 in gdk_window_get_origin () from /usr/lib64/libgdk-3.so.0
  #1  0x00007ffff49582a0 in gdk_display_get_monitor_at_window () from /usr/lib64/libgdk-3.so.0
  #2  0x0000555555bb73e2 in gd_refresh_rate_millihz (window=0x5555579d6280) at ui/gtk.c:1973
  #3  gd_vc_gfx_init (view_menu=0x5555579f0590, group=0x0, idx=0, con=<optimized out>, vc=0x5555579d4a90, s=0x5555579d49f0) at ui/gtk.c:2048
  #4  gd_create_menu_view (s=0x5555579d49f0) at ui/gtk.c:2149
  #5  gd_create_menus (s=0x5555579d49f0) at ui/gtk.c:2188
  #6  gtk_display_init (ds=<optimized out>, opts=0x55555661ed80 <dpy>) at ui/gtk.c:2256
  #7  0x000055555583d5a0 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4358

Fixes: c4c00922cc and 28b58f19d2 (display/gtk: get proper refreshrate)
Reported-by: Jan Kiszka <jan.kiszka@web.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 ui/gtk.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index c59297ff4d..850c49bee0 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1968,14 +1968,16 @@ static GtkWidget *gd_create_menu_machine(GtkDisplayState *s)
 static int gd_refresh_rate_millihz(GtkWidget *window)
 {
 #ifdef GDK_VERSION_3_22
-    GdkDisplay *dpy = gtk_widget_get_display(window);
     GdkWindow *win = gtk_widget_get_window(window);
-    GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
 
-    return gdk_monitor_get_refresh_rate(monitor);
-#else
-    return 0;
+    if (win) {
+        GdkDisplay *dpy = gtk_widget_get_display(window);
+        GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
+
+        return gdk_monitor_get_refresh_rate(monitor);
+    }
 #endif
+    return 0;
 }
 
 static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
-- 
2.21.1


