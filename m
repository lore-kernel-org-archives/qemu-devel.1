Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1321C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F59F2074D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F59F2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZrAU-0002VO-PX
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 03:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7Z-0006NG-S6
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:33 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:48316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7Y-0004GN-Pw
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:33 -0400
Received: from fwd03.aul.t-online.de (fwd03.aul.t-online.de [172.20.27.148])
 by mailout11.t-online.de (Postfix) with SMTP id 1865F42483DF;
 Sat, 16 May 2020 09:20:31 +0200 (CEST)
Received: from linpower.localnet
 (GvvlOoZQrhfs8+AKif4hik7fVDK0Hdarq7dTi69tYSGCHeqPUyYNACuCz+wxAS8gKf@[46.86.59.135])
 by fwd03.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jZr7U-0v2Xzs0; Sat, 16 May 2020 09:20:28 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id E3D462006D4; Sat, 16 May 2020 09:20:14 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 06/11] ui/sdl2: fix handling of AltGr key on Windows
Date: Sat, 16 May 2020 09:20:09 +0200
Message-Id: <20200516072014.7766-6-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
References: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: GvvlOoZQrhfs8+AKif4hik7fVDK0Hdarq7dTi69tYSGCHeqPUyYNACuCz+wxAS8gKf
X-TOI-EXPURGATEID: 150726::1589613628-0001711A-C6CB7F71/0/0 CLEAN NORMAL
X-TOI-MSGID: 9f8f44f4-95c7-4c8b-995a-5fee8e618491
Received-SPF: none client-ip=194.25.134.85;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout11.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 03:20:31
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
 ui/sdl2.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 61c7956da3..79c1ea29d2 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -30,6 +30,7 @@
 #include "ui/sdl2.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "ui/win32-kbd-hook.h"
 
 static int sdl2_num_outputs;
 static struct sdl2_console *sdl2_console;
@@ -220,6 +221,7 @@ static void sdl_grab_start(struct sdl2_console *scon)
     }
     SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
     gui_grab = 1;
+    win32_kbd_set_grab(true);
     sdl_update_caption(scon);
 }
 
@@ -227,6 +229,7 @@ static void sdl_grab_end(struct sdl2_console *scon)
 {
     SDL_SetWindowGrab(scon->real_window, SDL_FALSE);
     gui_grab = 0;
+    win32_kbd_set_grab(false);
     sdl_show_cursor(scon);
     sdl_update_caption(scon);
 }
@@ -325,6 +328,19 @@ static int get_mod_state(void)
     }
 }
 
+static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
+{
+#ifdef CONFIG_WIN32
+    SDL_SysWMinfo info;
+
+    SDL_VERSION(&info.version);
+    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
+        return info.info.win.window;
+    }
+#endif
+    return NULL;
+}
+
 static void handle_keydown(SDL_Event *ev)
 {
     int win;
@@ -544,6 +560,11 @@ static void handle_windowevent(SDL_Event *ev)
         sdl2_redraw(scon);
         break;
     case SDL_WINDOWEVENT_FOCUS_GAINED:
+        win32_kbd_set_grab(gui_grab);
+        if (qemu_console_is_graphic(scon->dcl.con)) {
+            win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
+        }
+        /* fall through */
     case SDL_WINDOWEVENT_ENTER:
         if (!gui_grab && (qemu_input_is_absolute() || absolute_enabled)) {
             absolute_mouse_grab(scon);
@@ -558,6 +579,9 @@ static void handle_windowevent(SDL_Event *ev)
         scon->ignore_hotkeys = get_mod_state();
         break;
     case SDL_WINDOWEVENT_FOCUS_LOST:
+        if (qemu_console_is_graphic(scon->dcl.con)) {
+            win32_kbd_set_window(NULL);
+        }
         if (gui_grab && !gui_fullscreen) {
             sdl_grab_end(scon);
         }
-- 
2.26.1


