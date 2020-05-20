Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14332C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7617207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ki+s0DeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7617207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKMU-0007Cx-WC
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKJz-0001F7-S7
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47076
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKJx-0006cn-Vx
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589964205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UaD4rYvLxcB1FA4C2TNqEWBEVXbc6nUjHd+2laVoEgQ=;
 b=Ki+s0DePghmtUcviiyyB4imCW3b0L/idZJWBI0D5aDBQ2IbubfZgKlbi4cc1rhHivygHk4
 jXv6g7UqdnKlRQ55VWQn5H6F1fBC3dTHYe/qsRjqUP+spuGSRwUOTce6du/Ui6QGdo6ppV
 xbYvk6nHIADiY3+VOAt+y8gf7OcYXQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-fu7JA6ZJPeGoBj6dvAUi9g-1; Wed, 20 May 2020 04:43:23 -0400
X-MC-Unique: fu7JA6ZJPeGoBj6dvAUi9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A63F8005AA;
 Wed, 20 May 2020 08:43:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4D1D10002A5;
 Wed, 20 May 2020 08:43:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D1CA29D59; Wed, 20 May 2020 10:43:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] ui/gtk: use native keyboard scancodes on Windows
Date: Wed, 20 May 2020 10:43:15 +0200
Message-Id: <20200520084316.22057-11-kraxel@redhat.com>
In-Reply-To: <20200520084316.22057-1-kraxel@redhat.com>
References: <20200520084316.22057-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since GTK 3.22 the function gdk_event_get_scancode() is
available. On Windows this function returns keyboard scancodes
and some extended flags. These raw keyboard scancodes are much
better suited for this use case than the half-cooked win32
virtual-key codes because scancodes report the key position on
the keyboard and the positions are independent of national
language settings.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200516072014.7766-10-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 1d51e14bb58d..68a5b901c72d 100644
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
2.18.4


