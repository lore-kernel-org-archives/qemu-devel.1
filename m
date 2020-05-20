Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23472C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E588D207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O24otX0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E588D207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKKw-0002tc-4j
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKJx-0001CU-SN
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKJx-0006cV-32
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589964204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRHYaGS1LBT/IH54lYEaCrBHKuLKoBQxW+ut7Qbwy5Q=;
 b=O24otX0HEjX4uMf2ZeRCbNHNYp0emQEtD3kM8bO7tsoeguKkfnp21lGYhcFdxVHXkcIJBr
 qO2Hyz3JEt+mrzQsVEQs4Jwq5u83VWBOPEKycLos3fvYhtyLoYjxU7bB63ofy59ZX3FKpE
 Mclvs9Vp+hblzcUlWL6g2xXkUQntO3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-cC6PVsXRMPysSO-ln1--3Q-1; Wed, 20 May 2020 04:43:21 -0400
X-MC-Unique: cC6PVsXRMPysSO-ln1--3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F9D8464;
 Wed, 20 May 2020 08:43:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76CBD2B6F6;
 Wed, 20 May 2020 08:43:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8997E9DAE; Wed, 20 May 2020 10:43:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] ui/gtk: fix handling of AltGr key on Windows
Date: Wed, 20 May 2020 10:43:07 +0200
Message-Id: <20200520084316.22057-3-kraxel@redhat.com>
In-Reply-To: <20200520084316.22057-1-kraxel@redhat.com>
References: <20200520084316.22057-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker Rümelin <vr_qemu@t-online.de>

Wire up the keyboard hooking code on Windows to fix the AltGr
key and improve keyboard grabbing.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200516072014.7766-2-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 83f2f5d49b2a..a0b10a140330 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -38,6 +38,10 @@
 
 #include "ui/console.h"
 #include "ui/gtk.h"
+#ifdef G_OS_WIN32
+#include <gdk/gdkwin32.h>
+#endif
+#include "ui/win32-kbd-hook.h"
 
 #include <glib/gi18n.h>
 #include <locale.h>
@@ -428,6 +432,16 @@ static void gd_widget_reparent(GtkWidget *from, GtkWidget *to,
     g_object_unref(G_OBJECT(widget));
 }
 
+static void *gd_win32_get_hwnd(VirtualConsole *vc)
+{
+#ifdef G_OS_WIN32
+    return gdk_win32_window_get_impl_hwnd(
+        gtk_widget_get_window(vc->window ? vc->window : vc->s->window));
+#else
+    return NULL;
+#endif
+}
+
 /** DisplayState Callbacks **/
 
 static void gd_update(DisplayChangeListener *dcl,
@@ -1451,6 +1465,7 @@ static void gd_grab_keyboard(VirtualConsole *vc, const char *reason)
         }
     }
 
+    win32_kbd_set_grab(true);
 #if GTK_CHECK_VERSION(3, 20, 0)
     gd_grab_update(vc, true, vc->s->ptr_owner == vc);
 #else
@@ -1472,6 +1487,7 @@ static void gd_ungrab_keyboard(GtkDisplayState *s)
     }
     s->kbd_owner = NULL;
 
+    win32_kbd_set_grab(false);
 #if GTK_CHECK_VERSION(3, 20, 0)
     gd_grab_update(vc, false, vc->s->ptr_owner == vc);
 #else
@@ -1614,12 +1630,22 @@ static gboolean gd_leave_event(GtkWidget *widget, GdkEventCrossing *crossing,
     return TRUE;
 }
 
+static gboolean gd_focus_in_event(GtkWidget *widget,
+                                  GdkEventFocus *event, gpointer opaque)
+{
+    VirtualConsole *vc = opaque;
+
+    win32_kbd_set_window(gd_win32_get_hwnd(vc));
+    return TRUE;
+}
+
 static gboolean gd_focus_out_event(GtkWidget *widget,
-                                   GdkEventCrossing *crossing, gpointer opaque)
+                                   GdkEventFocus *event, gpointer opaque)
 {
     VirtualConsole *vc = opaque;
     GtkDisplayState *s = vc->s;
 
+    win32_kbd_set_window(NULL);
     gtk_release_modifiers(s);
     return TRUE;
 }
@@ -1878,6 +1904,8 @@ static void gd_connect_vc_gfx_signals(VirtualConsole *vc)
                          G_CALLBACK(gd_enter_event), vc);
         g_signal_connect(vc->gfx.drawing_area, "leave-notify-event",
                          G_CALLBACK(gd_leave_event), vc);
+        g_signal_connect(vc->gfx.drawing_area, "focus-in-event",
+                         G_CALLBACK(gd_focus_in_event), vc);
         g_signal_connect(vc->gfx.drawing_area, "focus-out-event",
                          G_CALLBACK(gd_focus_out_event), vc);
         g_signal_connect(vc->gfx.drawing_area, "configure-event",
-- 
2.18.4


