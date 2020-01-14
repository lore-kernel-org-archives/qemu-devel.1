Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE347C33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7E62467E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn9OwrjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7E62467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJ6A-0007a2-S9
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1irJ0w-0001bh-1n
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1irJ0u-0007xO-RP
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:01:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37351
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1irJ0u-0007xB-NG
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578996092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+wwx5gtqKMjzn51dAG5RDWTWqf4qRz3vTw65dq5YdA=;
 b=Nn9OwrjDfBuFZTcwTToyW+nceFG0t2bD4PJniE+nL6ke77VZtimAD+qsG+ZJIBIBXyCffO
 KZG8PNJT6WrAYFh+V2xB1EJdVu0yK5R2LXnd5gYxmHy4emttj+moaY8JeUObYrKQebXA2C
 6OAntEb5Ze6uox8M9hkCUAqHZR4EuVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315--aZ7qzk8O5WKVHZHxOXTeg-1; Tue, 14 Jan 2020 05:01:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99733801E7A;
 Tue, 14 Jan 2020 10:01:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF4D55C1B0;
 Tue, 14 Jan 2020 10:01:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 30F5031E8E; Tue, 14 Jan 2020 11:01:25 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] display/gtk: get proper refreshrate
Date: Tue, 14 Jan 2020 11:01:25 +0100
Message-Id: <20200114100125.31604-3-kraxel@redhat.com>
In-Reply-To: <20200114100125.31604-1-kraxel@redhat.com>
References: <20200114100125.31604-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: -aZ7qzk8O5WKVHZHxOXTeg-1
X-Mimecast-Spam-Score: 0
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Nikola Pavlica <pavlica.nikola@gmail.com>
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
refresh, and by doing some math we get that 1000/30 =3D 33.33... Hz

This creates the mentioned problem and what this patch does is that it
checks for the display refresh rate reported by GTK itself (we can take
this as a safe value) and just converts it back to a number of
milliseconds per display refresh.

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20200108121342.29597-1-pavlica.nikola@gmail.com

[ kraxel: style tweak: add blank line between vars and code ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/gtk.h |  2 ++
 ui/gtk.c         | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index d9eedad976ef..d1b230848a7b 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -28,6 +28,8 @@
 #include "ui/egl-context.h"
 #endif
=20
+#define MILLISEC_PER_SEC 1000000
+
 typedef struct GtkDisplayState GtkDisplayState;
=20
 typedef struct VirtualGfxConsole {
diff --git a/ui/gtk.c b/ui/gtk.c
index 692ccc7bbb90..7355d34fcffd 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1966,6 +1966,11 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, Vi=
rtualConsole *vc,
                               GSList *group, GtkWidget *view_menu)
 {
     bool zoom_to_fit =3D false;
+    int refresh_rate_millihz;
+
+    GdkDisplay *dpy =3D gtk_widget_get_display(s->window);
+    GdkWindow *win =3D gtk_widget_get_window(s->window);
+    GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win);
=20
     vc->label =3D qemu_console_get_label(con);
     vc->s =3D s;
@@ -2026,6 +2031,12 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, Vi=
rtualConsole *vc,
=20
     vc->gfx.kbd =3D qkbd_state_init(con);
     vc->gfx.dcl.con =3D con;
+
+    refresh_rate_millihz =3D gdk_monitor_get_refresh_rate(monitor);
+    if (refresh_rate_millihz) {
+        vc->gfx.dcl.update_interval =3D MILLISEC_PER_SEC / refresh_rate_mi=
llihz;
+    }
+
     register_displaychangelistener(&vc->gfx.dcl);
=20
     gd_connect_vc_gfx_signals(vc);
--=20
2.18.1


