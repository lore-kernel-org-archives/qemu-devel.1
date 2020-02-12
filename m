Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F5EC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE7C20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXzbfw8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE7C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ulf-000704-IS
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1uj0-0001kI-0w
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1uiy-0004cT-Nt
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59918
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1uiy-0004c2-Jf
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581524332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=31dz9GiRQ4PDE/nDhDuPz2Klvu3+qgLjkLjr4ChUaCs=;
 b=JXzbfw8WzGEG2tljsJzueyb9AM7Q5xsfxV6vqdd+koiqdmuMcmGLRSn2E/UTMGIAmF+OVP
 eHY+5V+4OKmykIm+d0jMAZXZ86LuT1IRwYQ6UlvIS6MvKlHT5hfoVB6vLezGTQCpnLaor7
 KNuEySODpqNj8HkN6VKUK3evfQLH9hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-PwFQTfzSOhqejfOdHfDcuw-1; Wed, 12 Feb 2020 11:18:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07010DB21;
 Wed, 12 Feb 2020 16:18:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F89360FC1;
 Wed, 12 Feb 2020 16:18:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D976F9CA7; Wed, 12 Feb 2020 17:18:35 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] ui/gtk: Fix gd_refresh_rate_millihz() when widget window
 is not realized
Date: Wed, 12 Feb 2020 17:18:27 +0100
Message-Id: <20200212161835.28576-3-kraxel@redhat.com>
In-Reply-To: <20200212161835.28576-1-kraxel@redhat.com>
References: <20200212161835.28576-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: PwFQTfzSOhqejfOdHfDcuw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

gtk_widget_get_window() returns NULL if the widget's window is not
realized, and QEMU crashes. Example under gtk 3.22.30 (mate 1.20.1):

  qemu-system-x86_64: Gdk: gdk_window_get_origin: assertion 'GDK_IS_WINDOW =
(window)' failed
  (gdb) bt
  #0  0x00007ffff496cf70 in gdk_window_get_origin () from /usr/lib64/libgdk=
-3.so.0
  #1  0x00007ffff49582a0 in gdk_display_get_monitor_at_window () from /usr/=
lib64/libgdk-3.so.0
  #2  0x0000555555bb73e2 in gd_refresh_rate_millihz (window=3D0x5555579d628=
0) at ui/gtk.c:1973
  #3  gd_vc_gfx_init (view_menu=3D0x5555579f0590, group=3D0x0, idx=3D0, con=
=3D<optimized out>, vc=3D0x5555579d4a90, s=3D0x5555579d49f0) at ui/gtk.c:20=
48
  #4  gd_create_menu_view (s=3D0x5555579d49f0) at ui/gtk.c:2149
  #5  gd_create_menus (s=3D0x5555579d49f0) at ui/gtk.c:2188
  #6  gtk_display_init (ds=3D<optimized out>, opts=3D0x55555661ed80 <dpy>) =
at ui/gtk.c:2256
  #7  0x000055555583d5a0 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at vl.c:4358

Fixes: c4c00922cc and 28b58f19d2 (display/gtk: get proper refreshrate)
Reported-by: Jan Kiszka <jan.kiszka@web.de>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Jan Kiszka <jan.kiszka@web.de>
Message-id: 20200208161048.11311-3-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index c59297ff4d2e..850c49bee02a 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1968,14 +1968,16 @@ static GtkWidget *gd_create_menu_machine(GtkDisplay=
State *s)
 static int gd_refresh_rate_millihz(GtkWidget *window)
 {
 #ifdef GDK_VERSION_3_22
-    GdkDisplay *dpy =3D gtk_widget_get_display(window);
     GdkWindow *win =3D gtk_widget_get_window(window);
-    GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win);
=20
-    return gdk_monitor_get_refresh_rate(monitor);
-#else
+    if (win) {
+        GdkDisplay *dpy =3D gtk_widget_get_display(window);
+        GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win=
);
+
+        return gdk_monitor_get_refresh_rate(monitor);
+    }
+#endif
     return 0;
-#endif
 }
=20
 static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
--=20
2.18.2


