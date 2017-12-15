Received: from eggs.gnu.org ([2001:4830:134:3::10]:48405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1ePqOY-0000oh-OO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1ePqOX-0001Jd-Mq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:51:22 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:42930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <miika9764@gmail.com>) id 1ePqOX-0001J6-HE
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:51:21 -0500
Received: by mail-qk0-x241.google.com with SMTP id a193so1692394qkc.9
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 05:51:20 -0800 (PST)
MIME-Version: 1.0
From: Miika S <miika9764@gmail.com>
Date: Fri, 15 Dec 2017 15:51:19 +0200
Message-ID: <CABMrAhLV6LLwBR70-P4EnekWHKD4AkaatzxQwuxtOnNYQ3MEqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Key code conflict in keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com

Hi

I tried to add JIS keyboard support to virtio-input-hid but ran
into a problem with keys that have the "Linux Name" KEY_ISO and
KEY_KATAKANAHIRAGANA. The problem appears to be that they have
the same "AT set1 keycode" 0x70. I worked around it by removing
KEY_ISO from keycodemapdb and got the keys working, but that
doesn't work for the rest of QEMU. Is it intended that the keys
have the same "AT set1 keycode"?

Patch attached (also includes support for some mouse buttons):
---
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index e78faec0b1..2cac659469 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -139,6 +139,13 @@ static const unsigned int keymap_qcode[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_META_L]              = KEY_LEFTMETA,
     [Q_KEY_CODE_META_R]              = KEY_RIGHTMETA,
     [Q_KEY_CODE_MENU]                = KEY_MENU,
+
+    [Q_KEY_CODE_MUHENKAN]            = KEY_MUHENKAN,
+    [Q_KEY_CODE_HENKAN]              = KEY_HENKAN,
+    [Q_KEY_CODE_KATAKANAHIRAGANA]    = KEY_KATAKANAHIRAGANA,
+    [Q_KEY_CODE_COMPOSE]             = KEY_COMPOSE,
+    [Q_KEY_CODE_RO]                  = KEY_RO,
+    [Q_KEY_CODE_YEN]                 = KEY_YEN,
 };

 static const unsigned int keymap_button[INPUT_BUTTON__MAX] = {
@@ -147,6 +154,8 @@ static const unsigned int
keymap_button[INPUT_BUTTON__MAX] = {
     [INPUT_BUTTON_MIDDLE]            = BTN_MIDDLE,
     [INPUT_BUTTON_WHEEL_UP]          = BTN_GEAR_UP,
     [INPUT_BUTTON_WHEEL_DOWN]        = BTN_GEAR_DOWN,
+    [INPUT_BUTTON_SIDE]              = BTN_SIDE,
+    [INPUT_BUTTON_EXTRA]             = BTN_EXTRA,
 };

 static const unsigned int axismap_rel[INPUT_AXIS__MAX] = {
diff --git a/qapi/ui.json b/qapi/ui.json
index 07b468f625..da4be505ac 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -775,7 +775,7 @@
             'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', 'again',
             'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
             'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
-            'ro', 'hiragana', 'henkan', 'yen',
+            'ro', 'hiragana', 'muhenkan', 'henkan', 'katakanahiragana', 'yen',
             'kp_comma', 'kp_equals', 'power', 'sleep', 'wake',
             'audionext', 'audioprev', 'audiostop', 'audioplay', 'audiomute',
             'volumeup', 'volumedown', 'mediaselect',
Submodule ui/keycodemapdb contains modified content
diff --git a/ui/keycodemapdb/data/keymaps.csv b/ui/keycodemapdb/data/keymaps.csv
index 0ef2ec1..825ce47 100644
--- a/ui/keycodemapdb/data/keymaps.csv
+++ b/ui/keycodemapdb/data/keymaps.csv
@@ -154,9 +154,9 @@
KEY_KATAKANA,90,JIS_Kana,0x68,0x78,0x63,,146,VK_KANA,0x15,,,,,Lang3,KATA,,,
 KEY_HIRAGANA,91,,,0x77,0x62,0x87,147,,,,,,,Hiragana,HIRA,hiragana,,
 KEY_HIRAGANA,91,,,0x77,0x62,0x87,147,,,,,,,Lang4,HIRA,hiragana,,
 KEY_HENKAN,92,,,0x79,0x64,0x86,138,,,,,,,Convert,HENK,henkan,,
-KEY_KATAKANAHIRAGANA,93,,,0x70,0x13,0x87,136,,,0xc8,0xc8,,,KanaMode,HKTG,,,
-KEY_MUHENKAN,94,,,0x7b,0x67,0x85,139,,,,,,,NonConvert,NFER,,,
-KEY_MUHENKAN,94,,,0x7b,0x67,0x85,139,,,,,,,NonConvert,MUHE,,,
+KEY_KATAKANAHIRAGANA,93,,,0x70,0x13,0x87,136,,,0xc8,0xc8,,,KanaMode,HKTG,katakanahiragana,,
+KEY_MUHENKAN,94,,,0x7b,0x67,0x85,139,,,,,,,NonConvert,NFER,muhenkan,,
+KEY_MUHENKAN,94,,,0x7b,0x67,0x85,139,,,,,,,NonConvert,MUHE,muhenkan,,
 KEY_KPJPCOMMA,95,JIS_KeypadComma,0x5f,0x5c,0x27,,140,,,,,XK_KP_Separator,0xffac,,KPSP,,,
 KEY_KPJPCOMMA,95,JIS_KeypadComma,0x5f,0x5c,0x27,,140,,,,,XK_KP_Separator,0xffac,,JPCM,,,
 KEY_KPENTER,96,ANSI_KeypadEnter,0x4c,0xe01c,0xe05a,0x79,88,,,0x64,0x64,XK_KP_Enter,0xff8d,NumpadEnter,KPEN,kp_enter,0x5a,0x4c
@@ -246,7 +246,6 @@
KEY_STOPCD,166,,,0xe024,0xe03b,0x98,233,VK_MEDIA_STOP,0xb2,,,,,MediaStop,I174,au
 KEY_RECORD,167,,,0xe031,,0x9e,,,,,,,,,I175,,,
 KEY_REWIND,168,,,0xe018,,0x9f,,,,,,,,,I176,,,
 KEY_PHONE,169,,,0x63,,,,,,,,,,,I177,,,
-KEY_ISO,170,ISO_Section,0xa,0x70,,,,,,,,,,,I178,,,
 KEY_CONFIG,171,,,0xe001,,,,,,,,,,,I179,,,
 KEY_HOMEPAGE,172,,,0xe032,0xe03a,0x97,,VK_BROWSER_HOME,0xac,,,,,BrowserHome,I180,ac_home,,
 KEY_REFRESH,173,,,0xe067,0xe020,,250,VK_BROWSER_REFRESH,0xa8,,,,,BrowserRefresh,I181,ac_refresh,,
