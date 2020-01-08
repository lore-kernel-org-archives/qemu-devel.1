Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414BBC33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE31206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br+CCXPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE31206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAEZ-0003cb-2y
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavlica.nikola@gmail.com>) id 1ipADs-0003BS-Fc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavlica.nikola@gmail.com>) id 1ipADr-0008Nr-B7
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:14:04 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pavlica.nikola@gmail.com>)
 id 1ipADr-0008NR-5J
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:14:03 -0500
Received: by mail-wr1-x441.google.com with SMTP id c14so3119503wrn.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+1w4jYGjAvmzR5ZCAhWJySfBpIbL70IiNAQ8BNCVt0A=;
 b=Br+CCXPiWpZNJFqqvF0ggIkS22AGg7TH/ciw+r6urpjfKnAjTxSJaDxfYmNq1ip/hV
 VIyWFloY1uStA7l6ubl3PMJEXi+z/s+C/87afO+HVPLKuwuvrmhdijxn0NGx3DVMY9wk
 JDfyG+rkTVkOJkBT6dtxXqU9uuwnyMszActbJ3B0JrPrLcGsuLwTfo4p07f3EOMrHfWY
 eu49J1yn0CbjmVgxU2Dl4ZtTrYehyaux7DI2Z/+/UVEkst3OODjb1onGJWhr0WIch4dw
 H5qnJZZiyz2XwQjYhvr66hWE78nwO5qFmGKkASk7gBTyUkkiiZzmr/4jtyE39m+ilbzL
 D4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+1w4jYGjAvmzR5ZCAhWJySfBpIbL70IiNAQ8BNCVt0A=;
 b=PJkDkshiERoV9hymXQhlBtm7pVCq8x4h1sLnvx7lvfv1mAFKKAAjAHfjVWae31kaMT
 kT6oFG2j2F+p/mfcXqieWY+SNIQONugBqKxbL7smwVRALNBTDuQsRM2PEXxolqqA8cen
 PviqHGpPvy8ZMkgqCIEWMVDPLNVanOUl3TKmEGwcbHgDfiPCSSGFAP3nF65RhcNKPXLW
 /IDiXldQZOx1p0jTF3XXIBpVgI9VBcARm3V21RSNZytl0EnpujXJt3JYhqqX/A2oj8k8
 D/8hFU0+WPqTM80ECf3ERIyCw2z7yZ1jImFKXZPFx2YYwxugAJxvOpLsGbd5GQJfMzqp
 Iosg==
X-Gm-Message-State: APjAAAWugaclxh39loXi4Mp/BBAY50JzUPgWzf5Af/5dtn1o8RGvfccf
 dfiBappcmY4tlsCBWNTsT8hAW/Ln/BeAwA==
X-Google-Smtp-Source: APXvYqye0drTB6rXo6TpGV0L1q/8uNagbYRI3Jm182RhuhT0gn7a/Eac+ktbs7bBk2CdlOYX5CmxMA==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr4286128wrn.5.1578485641819;
 Wed, 08 Jan 2020 04:14:01 -0800 (PST)
Received: from localhost.localdomain (93-139-26-156.adsl.net.t-com.hr.
 [93.139.26.156])
 by smtp.gmail.com with ESMTPSA id n3sm3783360wrs.8.2020.01.08.04.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 04:14:01 -0800 (PST)
From: pavlica.nikola@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v5] display/gtk: get proper refreshrate
Date: Wed,  8 Jan 2020 13:13:42 +0100
Message-Id: <20200108121342.29597-1-pavlica.nikola@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: kraxel@redhat.com, Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nikola Pavlica <pavlica.nikola@gmail.com>

Because some VMs in QEMU can get GPU virtualization (using technologies
such as iGVT-g, as mentioned previously), they could produce a video
output that had a higher display refresh rate than of what the GTK
display was displaying. (fxp. Playing a video game inside of a Windows
VM at 60 Hz, while the output stood locked at 33 Hz because of defaults
set in include/ui/console.h)

Since QEMU does indeed have internal systems for determining frame
times as defined in ui/console.c.
The code checks for a variable called update_interval that it later
uses for time calculation. This variable, however, isn't defined
anywhere in ui/gtk.c and instead ui/console.c just sets it to
GUI_REFRESH_INTERVAL_DEFAULT which is 30

update_interval represents the number of milliseconds per display
refresh, and by doing some math we get that 1000/30 = 33.33... Hz

This creates the mentioned problem and what this patch does is that it
checks for the display refresh rate reported by GTK itself (we can take
this as a safe value) and just converts it back to a number of
milliseconds per display refresh.

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
---
 include/ui/gtk.h |  2 ++
 ui/gtk.c         | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index d9eedad976..d1b230848a 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -28,6 +28,8 @@
 #include "ui/egl-context.h"
 #endif
 
+#define MILLISEC_PER_SEC 1000000
+
 typedef struct GtkDisplayState GtkDisplayState;
 
 typedef struct VirtualGfxConsole {
diff --git a/ui/gtk.c b/ui/gtk.c
index 692ccc7bbb..eb0efc70ee 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1966,6 +1966,10 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               GSList *group, GtkWidget *view_menu)
 {
     bool zoom_to_fit = false;
+    int refresh_rate_millihz;
+    GdkDisplay *dpy = gtk_widget_get_display(s->window);
+    GdkWindow *win = gtk_widget_get_window(s->window);
+    GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
 
     vc->label = qemu_console_get_label(con);
     vc->s = s;
@@ -2026,6 +2030,12 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
 
     vc->gfx.kbd = qkbd_state_init(con);
     vc->gfx.dcl.con = con;
+
+    refresh_rate_millihz = gdk_monitor_get_refresh_rate(monitor);
+    if (refresh_rate_millihz) {
+        vc->gfx.dcl.update_interval = MILLISEC_PER_SEC / refresh_rate_millihz;
+    }
+
     register_displaychangelistener(&vc->gfx.dcl);
 
     gd_connect_vc_gfx_signals(vc);
-- 
2.24.1


