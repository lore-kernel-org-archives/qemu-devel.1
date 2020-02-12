Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9256C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9749B20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWCfOJYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9749B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ujs-0003F6-Oy
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1uiv-0001dC-OL
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1uit-0004Wd-H7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31988
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1uit-0004W7-Dj
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581524326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KIHTt1+MMh3tS0Tz2tXta1bnVaXy/hfgKs9ZpWu9zg=;
 b=AWCfOJYIVaq4RSHlvuWTUWy4MZTJ5EupIxWBzek619xgVpftw3MhStMpYqPwAi/m1d3kq7
 DFwUjYn354Ddua2kU4hvEaujlro5Tz2+2WcsEubiaJ178O/cylrOKstMZmU3FMMEf+O8Dm
 Pf67i2HtysfDYOKGo2utAllfSpI3gkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-zYWZ7mWCN7yoEiEsbU6ASA-1; Wed, 12 Feb 2020 11:18:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D51B18C8C01;
 Wed, 12 Feb 2020 16:18:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5E9E5C240;
 Wed, 12 Feb 2020 16:18:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D11669D1F; Wed, 12 Feb 2020 17:18:35 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/10] ui/gtk: Update gd_refresh_rate_millihz() to handle
 VirtualConsole
Date: Wed, 12 Feb 2020 17:18:26 +0100
Message-Id: <20200212161835.28576-2-kraxel@redhat.com>
In-Reply-To: <20200212161835.28576-1-kraxel@redhat.com>
References: <20200212161835.28576-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: zYWZ7mWCN7yoEiEsbU6ASA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Jan Kiszka <jan.kiszka@web.de>
Message-id: 20200208161048.11311-2-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index d18892d1de61..c59297ff4d2e 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1965,11 +1965,11 @@ static GtkWidget *gd_create_menu_machine(GtkDisplay=
State *s)
  * If available, return the refresh rate of the display in milli-Hertz,
  * else return 0.
  */
-static int gd_refresh_rate_millihz(GtkDisplayState *s)
+static int gd_refresh_rate_millihz(GtkWidget *window)
 {
 #ifdef GDK_VERSION_3_22
-    GdkDisplay *dpy =3D gtk_widget_get_display(s->window);
-    GdkWindow *win =3D gtk_widget_get_window(s->window);
+    GdkDisplay *dpy =3D gtk_widget_get_display(window);
+    GdkWindow *win =3D gtk_widget_get_window(window);
     GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win);
=20
     return gdk_monitor_get_refresh_rate(monitor);
@@ -2045,7 +2045,8 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, Vir=
tualConsole *vc,
     vc->gfx.kbd =3D qkbd_state_init(con);
     vc->gfx.dcl.con =3D con;
=20
-    refresh_rate_millihz =3D gd_refresh_rate_millihz(s);
+    refresh_rate_millihz =3D gd_refresh_rate_millihz(vc->window ?
+                                                   vc->window : s->window)=
;
     if (refresh_rate_millihz) {
         vc->gfx.dcl.update_interval =3D MILLISEC_PER_SEC / refresh_rate_mi=
llihz;
     }
--=20
2.18.2


