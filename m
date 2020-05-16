Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30C8C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8B22074D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8B22074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZr9E-0000E1-TS
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 03:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7Q-0006Dk-L9
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:26 -0400
Received: from mailout08.t-online.de ([194.25.134.20]:36626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7O-00047i-0o
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:24 -0400
Received: from fwd03.aul.t-online.de (fwd03.aul.t-online.de [172.20.27.148])
 by mailout08.t-online.de (Postfix) with SMTP id 13C1D414061E;
 Sat, 16 May 2020 09:20:19 +0200 (CEST)
Received: from linpower.localnet
 (TJ3TjuZSghLPlpxaXwEz-dO3Z7W-I22yD76ReIuUhXeV-J3ZoXYjTDFcp+DIpBNQ-T@[46.86.59.135])
 by fwd03.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jZr7H-0aVebY0; Sat, 16 May 2020 09:20:15 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id D99302006C1; Sat, 16 May 2020 09:20:14 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 01/11] ui/win32-kbd-hook: handle AltGr in a hook procedure
Date: Sat, 16 May 2020 09:20:04 +0200
Message-Id: <20200516072014.7766-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
References: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: TJ3TjuZSghLPlpxaXwEz-dO3Z7W-I22yD76ReIuUhXeV-J3ZoXYjTDFcp+DIpBNQ-T
X-TOI-EXPURGATEID: 150726::1589613615-0001711A-7E43764A/0/0 CLEAN NORMAL
X-TOI-MSGID: b9f7a83c-747d-41e3-af2f-764fbbf4355e
Received-SPF: none client-ip=194.25.134.20;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout08.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 03:20:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Import win32 keyboard hooking code from project spice-gtk. This
patch removes the extra left control key up/down input events
inserted by Windows for the right alt key up/down input events
with international keyboard layouts. Additionally there's some
code to grab the keyboard.

The next patches will use this code.

Only Windows needs this.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 include/ui/win32-kbd-hook.h |  14 +++++
 stubs/Makefile.objs         |   1 +
 stubs/win32-kbd-hook.c      |  18 +++++++
 ui/Makefile.objs            |   3 ++
 ui/win32-kbd-hook.c         | 102 ++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+)
 create mode 100644 include/ui/win32-kbd-hook.h
 create mode 100644 stubs/win32-kbd-hook.c
 create mode 100644 ui/win32-kbd-hook.c

diff --git a/include/ui/win32-kbd-hook.h b/include/ui/win32-kbd-hook.h
new file mode 100644
index 0000000000..4bd9f00f97
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
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 45be5dc0ed..6a9e3135e8 100644
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
diff --git a/stubs/win32-kbd-hook.c b/stubs/win32-kbd-hook.c
new file mode 100644
index 0000000000..1a084b081a
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
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index e6da6ff047..504b196479 100644
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
diff --git a/ui/win32-kbd-hook.c b/ui/win32-kbd-hook.c
new file mode 100644
index 0000000000..1ac237db9e
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
-- 
2.26.1


