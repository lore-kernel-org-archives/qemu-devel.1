Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B30C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4328222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YY3bS4gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4328222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irtj0-00006F-UF
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 20:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irtiC-00086R-Nk
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irti8-00064V-U9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:12:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27946
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irti8-00063Q-NJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579137155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uZf4xXGSrgu0iJ1m2di8r/o8rrTh6BO8CM7Fjof1QBs=;
 b=YY3bS4glBzMwHC/r6WhnNQaUGfkDLLoiMx7hnMQ4xAt+XwrB9bQoaRlkGseqKNBfE/RKJR
 E+UJHFaFYb82mkxCbZKYdODJLwuojMoJ82QvznWI5sLb8PHWc4UhJh+dbRTZ2O69hEShAC
 yWfO+AFQsy0QG0I7EaX7RbIj1aM+C40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-DmSoJL1JOlO5PRQOokNapw-1; Wed, 15 Jan 2020 20:12:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA7CB100550E;
 Thu, 16 Jan 2020 01:12:30 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-18.brq.redhat.com [10.40.204.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41F875D9C9;
 Thu, 16 Jan 2020 01:12:19 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] ui/gtk: Get display refresh rate with GDK version 3.22 or
 later
Date: Thu, 16 Jan 2020 02:12:17 +0100
Message-Id: <20200116011217.2144-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: DmSoJL1JOlO5PRQOokNapw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The GdkMonitor was introduced in GTK+ 3.22:
https://developer.gnome.org/gdk3/stable/api-index-3-22.html#api-index-3.22

If we build with older GTK+, the build fails:

    CC      ui/gtk.o
  qemu/ui/gtk.c: In function =E2=80=98gd_vc_gfx_init=E2=80=99:
  qemu/ui/gtk.c:1973:5: error: unknown type name =E2=80=98GdkMonitor=E2=80=
=99
       GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win);
       ^
  qemu/ui/gtk.c:1973:27: error: implicit declaration of function =E2=80=98g=
dk_display_get_monitor_at_window=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
       GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win);
                             ^
  qemu/ui/gtk.c:1973:5: error: nested extern declaration of =E2=80=98gdk_di=
splay_get_monitor_at_window=E2=80=99 [-Werror=3Dnested-externs]
       GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win);
       ^
  qemu/ui/gtk.c:1973:27: error: initialization makes pointer from integer w=
ithout a cast [-Werror=3Dint-conversion]
       GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win);
                             ^
  qemu/ui/gtk.c:2035:28: error: implicit declaration of function =E2=80=98g=
dk_monitor_get_refresh_rate=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
       refresh_rate_millihz =3D gdk_monitor_get_refresh_rate(monitor);
                              ^
  qemu/ui/gtk.c:2035:5: error: nested extern declaration of =E2=80=98gdk_mo=
nitor_get_refresh_rate=E2=80=99 [-Werror=3Dnested-externs]
       refresh_rate_millihz =3D gdk_monitor_get_refresh_rate(monitor);
       ^
  cc1: all warnings being treated as errors
  qemu/rules.mak:69: recipe for target 'ui/gtk.o' failed
  make: *** [ui/gtk.o] Error 1

We only use the GdkMonitor API to get the monitor refresh rate.

GTK+ provides convenient definition in <gdk/gdkversionmacros.h>
(already include by <gdk/gdk.h>) to check which API are available.

Extract this code as a new gd_refresh_rate_millihz() function,
and check GDK_VERSION_3_22 is defined before calling its API.
If it is not defined, return 0. This is safe and fixes our build
failure.

Fixes: c4c00922cc (display/gtk: get proper refreshrate)
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Sorry I missed that, I only tested Nikola's patch on my workstation
which runs Fedora 30:

  $ pkg-config --modversion gtk+-3.0
  3.24.11

If Gerd acks this patch, we might consider having it directly
applied as a build fix.
---
 ui/gtk.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 7355d34fcf..d18892d1de 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1961,6 +1961,23 @@ static GtkWidget *gd_create_menu_machine(GtkDisplayS=
tate *s)
     return machine_menu;
 }
=20
+/*
+ * If available, return the refresh rate of the display in milli-Hertz,
+ * else return 0.
+ */
+static int gd_refresh_rate_millihz(GtkDisplayState *s)
+{
+#ifdef GDK_VERSION_3_22
+    GdkDisplay *dpy =3D gtk_widget_get_display(s->window);
+    GdkWindow *win =3D gtk_widget_get_window(s->window);
+    GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win);
+
+    return gdk_monitor_get_refresh_rate(monitor);
+#else
+    return 0;
+#endif
+}
+
 static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               QemuConsole *con, int idx,
                               GSList *group, GtkWidget *view_menu)
@@ -1968,10 +1985,6 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, Vi=
rtualConsole *vc,
     bool zoom_to_fit =3D false;
     int refresh_rate_millihz;
=20
-    GdkDisplay *dpy =3D gtk_widget_get_display(s->window);
-    GdkWindow *win =3D gtk_widget_get_window(s->window);
-    GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win);
-
     vc->label =3D qemu_console_get_label(con);
     vc->s =3D s;
     vc->gfx.scale_x =3D 1.0;
@@ -2032,7 +2045,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, Vir=
tualConsole *vc,
     vc->gfx.kbd =3D qkbd_state_init(con);
     vc->gfx.dcl.con =3D con;
=20
-    refresh_rate_millihz =3D gdk_monitor_get_refresh_rate(monitor);
+    refresh_rate_millihz =3D gd_refresh_rate_millihz(s);
     if (refresh_rate_millihz) {
         vc->gfx.dcl.update_interval =3D MILLISEC_PER_SEC / refresh_rate_mi=
llihz;
     }
--=20
2.21.1


