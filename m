Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65A5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC6020657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nca47osr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC6020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7irt-0008Ug-Ms
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 13:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7irC-00082d-UG
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:23:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30051
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7irB-0004ry-5Z
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597685016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qMP35PePSzZOiEVsCjdwEyJXKlCwN09VElhl+fMbxj8=;
 b=Nca47osrBgshF2t3Dk97lLCMrg544mYeE7iWgxPitdbphVVf/81R8oiRljUGehpXFrEm1i
 EyAdw1MJK9gwXZZTKP+HJLfL1IigUsXituV+vGtCS7i11/YBL/q/P3ztTROpfYe+G5BFJy
 IPbkB6xX+njaUHCHjC70s0vBIB+zULc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-T3lB-hXvNOGCHKpivH_9Gg-1; Mon, 17 Aug 2020 13:23:34 -0400
X-MC-Unique: T3lB-hXvNOGCHKpivH_9Gg-1
Received: by mail-wr1-f69.google.com with SMTP id e14so7272882wrr.7
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 10:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qMP35PePSzZOiEVsCjdwEyJXKlCwN09VElhl+fMbxj8=;
 b=oL690iS9K7gLJic7kK6oz8VqgMfmnXp1oKcqG5OSkPTt9KTA8mKSxhpp/2zBlvkbHJ
 CSg7Rd1QSKDnkJbTsPsJXIK8aI5QA/ve2d9jUWSFAl5ocibkn6ng3AoAwJNoKY81JDqc
 Qn/Dyp4BAIsvB8FqVWrzf/ioZ0aTqc2wA55I+BvYTwAIJNxXdCMU+ZLV6KnIXx3qLBz5
 q4W+O54RAuDFr7X7GLB+NxrGCK6/7S7EFhsC8GvFJ8RaQvPPWMx2eKHudv8HrZNoszUz
 dDVvgITyLJdR+Yo7bCc+rMJlRnq/xK4yiNI4ecE2EWQf6vKMwwWvDO7IGMouwzIsLl9S
 ShAw==
X-Gm-Message-State: AOAM531xSpdElzlXgnOQjkgJX/Hd0Y5lP5S0TYQi6XLTimT10URr6Hv7
 h/xwuhMsf7uFI1JGPbPL8Gf8Pk6XrMZ31cimH6f5TcZ+a8iEIBlbhjHCIys+Qa47DSfguFQG/iP
 XD5mTmLhrHbA3e1s=
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr16091514wmj.174.1597685013281; 
 Mon, 17 Aug 2020 10:23:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMX2EXKy52ni1J/HrQ++w0m7JVqGvqQsIawXr7auBJK8s6NKT406iA2NETBYaxg1NkDM0E3Q==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr16091488wmj.174.1597685013018; 
 Mon, 17 Aug 2020 10:23:33 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j11sm31113721wrw.79.2020.08.17.10.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 10:23:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Update refresh interval after widget is realized
Date: Mon, 17 Aug 2020 19:23:31 +0200
Message-Id: <20200817172331.598255-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nikola reported on Windows when gd_vc_gfx_init() is called, the
window is not yet realized, so we run gd_refresh_rate_millihz(NULL)
which returns 0 milli-Hertz.
When a Widget is realized, it fires a 'realized' event. We already
have the gd_draw_event() handler registered for this even, so simply
move the gd_refresh_rate_millihz() there. When the event fires, the
window is known to exist.
This completes commit c4c00922cc original intention.

Reported-by: Nikola Pavlica <pavlica.nikola@gmail.com>
Suggested-by: Nikola Pavlica <pavlica.nikola@gmail.com>
Tested-by: Nikola Pavlica <pavlica.nikola@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 ui/gtk.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index b0cc08ad6d..7a717ce8e5 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -744,6 +744,25 @@ static void gd_resize_event(GtkGLArea *area,
 
 #endif
 
+/*
+ * If available, return the refresh rate of the display in milli-Hertz,
+ * else return 0.
+ */
+static int gd_refresh_rate_millihz(GtkWidget *window)
+{
+#ifdef GDK_VERSION_3_22
+    GdkWindow *win = gtk_widget_get_window(window);
+
+    if (win) {
+        GdkDisplay *dpy = gtk_widget_get_display(window);
+        GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
+
+        return gdk_monitor_get_refresh_rate(monitor);
+    }
+#endif
+    return 0;
+}
+
 static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
 {
     VirtualConsole *vc = opaque;
@@ -751,6 +770,7 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
     int mx, my;
     int ww, wh;
     int fbw, fbh;
+    int refresh_rate_millihz;
 
 #if defined(CONFIG_OPENGL)
     if (vc->gfx.gls) {
@@ -771,6 +791,12 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
         return FALSE;
     }
 
+    refresh_rate_millihz = gd_refresh_rate_millihz(vc->window ?
+                                                   vc->window : s->window);
+    if (refresh_rate_millihz) {
+        vc->gfx.dcl.update_interval = MILLISEC_PER_SEC / refresh_rate_millihz;
+    }
+
     fbw = surface_width(vc->gfx.ds);
     fbh = surface_height(vc->gfx.ds);
 
@@ -1949,31 +1975,11 @@ static GtkWidget *gd_create_menu_machine(GtkDisplayState *s)
     return machine_menu;
 }
 
-/*
- * If available, return the refresh rate of the display in milli-Hertz,
- * else return 0.
- */
-static int gd_refresh_rate_millihz(GtkWidget *window)
-{
-#ifdef GDK_VERSION_3_22
-    GdkWindow *win = gtk_widget_get_window(window);
-
-    if (win) {
-        GdkDisplay *dpy = gtk_widget_get_display(window);
-        GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
-
-        return gdk_monitor_get_refresh_rate(monitor);
-    }
-#endif
-    return 0;
-}
-
 static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               QemuConsole *con, int idx,
                               GSList *group, GtkWidget *view_menu)
 {
     bool zoom_to_fit = false;
-    int refresh_rate_millihz;
 
     vc->label = qemu_console_get_label(con);
     vc->s = s;
@@ -2031,12 +2037,6 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
     vc->gfx.kbd = qkbd_state_init(con);
     vc->gfx.dcl.con = con;
 
-    refresh_rate_millihz = gd_refresh_rate_millihz(vc->window ?
-                                                   vc->window : s->window);
-    if (refresh_rate_millihz) {
-        vc->gfx.dcl.update_interval = MILLISEC_PER_SEC / refresh_rate_millihz;
-    }
-
     register_displaychangelistener(&vc->gfx.dcl);
 
     gd_connect_vc_gfx_signals(vc);
-- 
2.26.2


