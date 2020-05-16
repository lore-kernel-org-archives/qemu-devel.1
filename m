Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CDEC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FBE2074D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FBE2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZrBx-0004X0-VD
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 03:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7i-0006a5-HA
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:42 -0400
Received: from mailout07.t-online.de ([194.25.134.83]:59154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7h-0004Nf-7F
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:42 -0400
Received: from fwd39.aul.t-online.de (fwd39.aul.t-online.de [172.20.27.138])
 by mailout07.t-online.de (Postfix) with SMTP id 9F8DE420692C;
 Sat, 16 May 2020 09:20:39 +0200 (CEST)
Received: from linpower.localnet
 (bpYICQZCght86CknVnQWgw8WyqUA8opTP+Dw2ik1CyDftB26UCfJFeDwEj6ahXwgod@[46.86.59.135])
 by fwd39.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jZr7e-15STse0; Sat, 16 May 2020 09:20:38 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id ECA452006D8; Sat, 16 May 2020 09:20:14 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 10/11] ui/gtk: use native keyboard scancodes on Windows
Date: Sat, 16 May 2020 09:20:13 +0200
Message-Id: <20200516072014.7766-10-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
References: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: bpYICQZCght86CknVnQWgw8WyqUA8opTP+Dw2ik1CyDftB26UCfJFeDwEj6ahXwgod
X-TOI-EXPURGATEID: 150726::1589613638-0001727C-B22A38CE/0/0 CLEAN NORMAL
X-TOI-MSGID: 4747b318-5c33-4e05-b98e-396a1d2cdb52
Received-SPF: none client-ip=194.25.134.83;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout07.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 03:18:54
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

Since GTK 3.22 the function gdk_event_get_scancode() is
available. On Windows this function returns keyboard scancodes
and some extended flags. These raw keyboard scancodes are much
better suited for this use case than the half-cooked win32
virtual-key codes because scancodes report the key position on
the keyboard and the positions are independent of national
language settings.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/gtk.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 1d51e14bb5..68a5b901c7 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1026,8 +1026,13 @@ static const guint16 *gd_get_keymap(size_t *maplen)
 #ifdef GDK_WINDOWING_WIN32
     if (GDK_IS_WIN32_DISPLAY(dpy)) {
         trace_gd_keymap_windowing("win32");
+#if GTK_CHECK_VERSION(3, 22, 0)
+        *maplen = qemu_input_map_atset1_to_qcode_len;
+        return qemu_input_map_atset1_to_qcode;
+#else
         *maplen = qemu_input_map_win32_to_qcode_len;
         return qemu_input_map_win32_to_qcode;
+#endif
     }
 #endif
 
@@ -1073,6 +1078,25 @@ static int gd_map_keycode(int scancode)
     return keycode_map[scancode];
 }
 
+static int gd_get_keycode(GdkEventKey *key)
+{
+#if defined G_OS_WIN32 && GTK_CHECK_VERSION(3, 22, 0)
+    int scancode = gdk_event_get_scancode((GdkEvent *)key);
+
+    /* translate Windows native scancodes to atset1 keycodes */
+    switch (scancode & (KF_EXTENDED | 0xff)) {
+    case 0x145:     /* NUMLOCK */
+        return scancode & 0xff;
+    }
+
+    return scancode & KF_EXTENDED ?
+        0xe000 | (scancode & 0xff) : scancode & 0xff;
+
+#else
+    return key->hardware_keycode;
+#endif
+}
+
 static gboolean gd_text_key_down(GtkWidget *widget,
                                  GdkEventKey *key, void *opaque)
 {
@@ -1084,7 +1108,7 @@ static gboolean gd_text_key_down(GtkWidget *widget,
     } else if (key->length) {
         kbd_put_string_console(con, key->string, key->length);
     } else {
-        int qcode = gd_map_keycode(key->hardware_keycode);
+        int qcode = gd_map_keycode(gd_get_keycode(key));
         kbd_put_qcode_console(con, qcode, false);
     }
     return TRUE;
@@ -1093,7 +1117,7 @@ static gboolean gd_text_key_down(GtkWidget *widget,
 static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
 {
     VirtualConsole *vc = opaque;
-    int qcode;
+    int keycode, qcode;
 
 #ifdef G_OS_WIN32
     /* on windows, we ought to ignore the reserved key event? */
@@ -1121,9 +1145,10 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
         return TRUE;
     }
 
-    qcode = gd_map_keycode(key->hardware_keycode);
+    keycode = gd_get_keycode(key);
+    qcode = gd_map_keycode(keycode);
 
-    trace_gd_key_event(vc->label, key->hardware_keycode, qcode,
+    trace_gd_key_event(vc->label, keycode, qcode,
                        (key->type == GDK_KEY_PRESS) ? "down" : "up");
 
     qkbd_state_key_event(vc->gfx.kbd, qcode,
-- 
2.26.1


