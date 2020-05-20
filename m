Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2D4207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9TQc3/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2D4207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKNy-0001oI-BH
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKK3-0001Ny-2y
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33846
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKK1-0006dh-4h
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589964208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhK5I6KM/fZFgDx8mOenKdAqjvyDlPH6uluHWhkizGE=;
 b=K9TQc3/fIY499Cp7DeTU3Mzi/cwa1zSo5EIFWz7yXOByumh/sEXXA2MvB9yJjuCpSQD/S8
 wZ4fn4E+rqtwm6uiyj5N9gxWaL9YzJEewVonjBf4Lzbysvg5h53mhJGaoRgam5fjn0LUby
 hcPOXf8g3G6S3GtLIHQePjThDiMRNeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-OWSb5vYkMQiCIxxSzdaXrw-1; Wed, 20 May 2020 04:43:22 -0400
X-MC-Unique: OWSb5vYkMQiCIxxSzdaXrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1378E8015CE;
 Wed, 20 May 2020 08:43:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DD5260C05;
 Wed, 20 May 2020 08:43:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 80C8A9DAD; Wed, 20 May 2020 10:43:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] ui/win32-kbd-hook: handle AltGr in a hook procedure
Date: Wed, 20 May 2020 10:43:06 +0200
Message-Id: <20200520084316.22057-2-kraxel@redhat.com>
In-Reply-To: <20200520084316.22057-1-kraxel@redhat.com>
References: <20200520084316.22057-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Import win32 keyboard hooking code from project spice-gtk. This
patch removes the extra left control key up/down input events
inserted by Windows for the right alt key up/down input events
with international keyboard layouts. Additionally there's some
code to grab the keyboard.

The next patches will use this code.

Only Windows needs this.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200516072014.7766-1-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/win32-kbd-hook.h |  14 +++++
 stubs/win32-kbd-hook.c      |  18 +++++++
 ui/win32-kbd-hook.c         | 102 ++++++++++++++++++++++++++++++++++++
 stubs/Makefile.objs         |   1 +
 ui/Makefile.objs            |   3 ++
 5 files changed, 138 insertions(+)
 create mode 100644 include/ui/win32-kbd-hook.h
 create mode 100644 stubs/win32-kbd-hook.c
 create mode 100644 ui/win32-kbd-hook.c

diff --git a/include/ui/win32-kbd-hook.h b/include/ui/win32-kbd-hook.h
new file mode 100644
index 000000000000..4bd9f00f973f
--- /dev/null
+++ b/include/ui/win32-kbd-hook.h
@@ -0,0 +1,14 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef UI_WIN32_KBD_HOOK_H
+#define UI_WIN32_KBD_HOOK_H
+
+void win32_kbd_set_window(void *hwnd);
+void win32_kbd_set_grab(bool grab);
+
+#endif
diff --git a/stubs/win32-kbd-hook.c b/stubs/win32-kbd-hook.c
new file mode 100644
index 000000000000..1a084b081ab6
--- /dev/null
+++ b/stubs/win32-kbd-hook.c
@@ -0,0 +1,18 @@
+/*
+ * Win32 keyboard hook stubs
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "ui/win32-kbd-hook.h"
+
+void win32_kbd_set_window(void *hwnd)
+{
+}
+
+void win32_kbd_set_grab(bool grab)
+{
+}
diff --git a/ui/win32-kbd-hook.c b/ui/win32-kbd-hook.c
new file mode 100644
index 000000000000..1ac237db9e9d
--- /dev/null
+++ b/ui/win32-kbd-hook.c
@@ -0,0 +1,102 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ *
+ * The win32 keyboard hooking code was imported from project spice-gtk.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+#include "ui/win32-kbd-hook.h"
+
+static Notifier win32_unhook_notifier;
+static HHOOK win32_keyboard_hook;
+static HWND win32_window;
+static DWORD win32_grab;
+
+static LRESULT CALLBACK keyboard_hook_cb(int code, WPARAM wparam, LPARAM lparam)
+{
+    if  (win32_window && code == HC_ACTION && win32_window == GetFocus()) {
+        KBDLLHOOKSTRUCT *hooked = (KBDLLHOOKSTRUCT *)lparam;
+
+        if (wparam != WM_KEYUP) {
+            DWORD dwmsg = (hooked->flags << 24) |
+                          ((hooked->scanCode & 0xff) << 16) | 1;
+
+            switch (hooked->vkCode) {
+            case VK_CAPITAL:
+                /* fall through */
+            case VK_SCROLL:
+                /* fall through */
+            case VK_NUMLOCK:
+                /* fall through */
+            case VK_LSHIFT:
+                /* fall through */
+            case VK_RSHIFT:
+                /* fall through */
+            case VK_RCONTROL:
+                /* fall through */
+            case VK_LMENU:
+                /* fall through */
+            case VK_RMENU:
+                break;
+
+            case VK_LCONTROL:
+                /*
+                 * When pressing AltGr, an extra VK_LCONTROL with a special
+                 * scancode with bit 9 set is sent. Let's ignore the extra
+                 * VK_LCONTROL, as that will make AltGr misbehave.
+                 */
+                if (hooked->scanCode & 0x200) {
+                    return 1;
+                }
+                break;
+
+            default:
+                if (win32_grab) {
+                    SendMessage(win32_window, wparam, hooked->vkCode, dwmsg);
+                    return 1;
+                }
+                break;
+            }
+
+        } else {
+            switch (hooked->vkCode) {
+            case VK_LCONTROL:
+                if (hooked->scanCode & 0x200) {
+                    return 1;
+                }
+                break;
+            }
+        }
+    }
+
+    return CallNextHookEx(NULL, code, wparam, lparam);
+}
+
+static void keyboard_hook_unhook(Notifier *n, void *data)
+{
+    UnhookWindowsHookEx(win32_keyboard_hook);
+    win32_keyboard_hook = NULL;
+}
+
+void win32_kbd_set_window(void *hwnd)
+{
+    if (hwnd && !win32_keyboard_hook) {
+        /* note: the installing thread must have a message loop */
+        win32_keyboard_hook = SetWindowsHookEx(WH_KEYBOARD_LL, keyboard_hook_cb,
+                                               GetModuleHandle(NULL), 0);
+        if (win32_keyboard_hook) {
+            win32_unhook_notifier.notify = keyboard_hook_unhook;
+            qemu_add_exit_notifier(&win32_unhook_notifier);
+        }
+    }
+
+    win32_window = hwnd;
+}
+
+void win32_kbd_set_grab(bool grab)
+{
+    win32_grab = grab;
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 45be5dc0ed78..6a9e3135e8f9 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -32,6 +32,7 @@ stub-obj-y += trace-control.o
 stub-obj-y += uuid.o
 stub-obj-y += vm-stop.o
 stub-obj-y += vmstate.o
+stub-obj-y += win32-kbd-hook.o
 stub-obj-y += fd-register.o
 stub-obj-y += qmp_memory_device.o
 stub-obj-y += target-monitor-defs.o
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index e6da6ff047fd..504b19647977 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -15,6 +15,9 @@ common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
 common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
 common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
+ifneq (,$(findstring m,$(CONFIG_SDL)$(CONFIG_GTK)))
+common-obj-$(CONFIG_WIN32) += win32-kbd-hook.o
+endif
 
 # ui-sdl module
 common-obj-$(CONFIG_SDL) += sdl.mo
-- 
2.18.4


