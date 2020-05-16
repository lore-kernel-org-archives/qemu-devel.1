Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6AAC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6769C2074D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6769C2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZr8T-0007W5-JI
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 03:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7O-0006DL-M9
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:22 -0400
Received: from mailout01.t-online.de ([194.25.134.80]:51936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7N-00047X-Jz
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:22 -0400
Received: from fwd05.aul.t-online.de (fwd05.aul.t-online.de [172.20.27.149])
 by mailout01.t-online.de (Postfix) with SMTP id B57BF428F414;
 Sat, 16 May 2020 09:20:18 +0200 (CEST)
Received: from linpower.localnet
 (rxbY+UZe8hmJiOFZlO2aDmUGBfvTuN4eBpqSAnIRFa8OA0WoXTbPNRDQT+n2vowgLO@[46.86.59.135])
 by fwd05.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jZr7K-4BTqKG0; Sat, 16 May 2020 09:20:18 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id DB9242006C6; Sat, 16 May 2020 09:20:14 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 02/11] ui/gtk: fix handling of AltGr key on Windows
Date: Sat, 16 May 2020 09:20:05 +0200
Message-Id: <20200516072014.7766-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
References: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: rxbY+UZe8hmJiOFZlO2aDmUGBfvTuN4eBpqSAnIRFa8OA0WoXTbPNRDQT+n2vowgLO
X-TOI-EXPURGATEID: 150726::1589613618-0000E6B7-C9883BE3/0/0 CLEAN NORMAL
X-TOI-MSGID: 32dcee51-f538-4030-8c8e-51004100c198
Received-SPF: none client-ip=194.25.134.80;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout01.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 03:20:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wire up the keyboard hooking code on Windows to fix the AltGr
key and improve keyboard grabbing.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/gtk.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 83f2f5d49b..a0b10a1403 100644
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
2.26.1


