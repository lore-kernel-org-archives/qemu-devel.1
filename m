Received: from eggs.gnu.org ([2001:4830:134:3::10]:53367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eY8tn-0000j2-77
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 06:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eY8tm-0005O3-8d
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 06:13:55 -0500
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:46795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patricktsen@gmail.com>)
	id 1eY8tm-0005NS-2d
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 06:13:54 -0500
Received: by mail-pl0-x231.google.com with SMTP id i6so5931341plt.13
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 03:13:53 -0800 (PST)
From: byxk <patricktsen@gmail.com>
Date: Sun,  7 Jan 2018 03:13:41 -0800
Message-Id: <20180107111341.8879-2-patricktsen@gmail.com>
In-Reply-To: <20180107111341.8879-1-patricktsen@gmail.com>
References: <20180107111341.8879-1-patricktsen@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] input-linux: provide hotkeys for evdev
 toggle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, byxk <patricktsen@gmail.com>

---
 include/ui/input.h |  3 +++
 qemu-options.hx    | 13 +++++++++++++
 ui/input-linux.c   |  4 ++--
 vl.c               |  8 ++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 5cc76d6e41..94b1468159 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -80,4 +80,7 @@ extern const guint16 qemu_input_map_qnum_to_qcode[];
 extern const guint qemu_input_map_qcode_to_linux_len;
 extern const guint16 qemu_input_map_qcode_to_linux[];
 
+extern int qemu_evdev_rhotkey;
+extern int qemu_evdev_lhotkey;
+
 #endif /* INPUT_H */
diff --git a/qemu-options.hx b/qemu-options.hx
index 94647e21e3..56cafd7592 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4264,6 +4264,19 @@ contents of @code{iv.b64} to the second secret
 
 ETEXI
 
+DEF("evdev-lhotkey", HAS_ARG, QEMU_OPTION_evdev_lhotkey, "--evdev-lhotkey    left hotkey for evdev input toggle, default=LEFTCTRL(29)\n", QEMU_ARCH_ALL)
+STEXI
+@item --evdev-lhotkey @var{evdevLHotkey}
+@findex --evdev-lhotkey
+Left keycode to use in toggling evdev
+ETEXI
+
+DEF("evdev-rhotkey", HAS_ARG, QEMU_OPTION_evdev_rhotkey, "--evdev-rhotkey     right hotkey for evdev input toggle, default=RIGHTCTRL(97)\n", QEMU_ARCH_ALL)
+STEXI
+@item --evdev-rhotkey @var{evdevRHotkey}
+@findex --evdev-rhotkey
+Right keycode to use in toggling evdev
+ETEXI
 
 HXCOMM This is the last statement. Insert new options before this line!
 STEXI
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 9720333b2c..8af1450dce 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -134,8 +134,8 @@ static void input_linux_handle_keyboard(InputLinux *il,
         }
 
         /* hotkey -> record switch request ... */
-        if (il->keydown[KEY_LEFTCTRL] &&
-            il->keydown[KEY_RIGHTCTRL]) {
+        if (il->keydown[qemu_evdev_lhotkey] &&
+            il->keydown[qemu_evdev_rhotkey]) {
             il->grab_request = true;
         }
 
diff --git a/vl.c b/vl.c
index d3a5c5d021..7bdf6030cf 100644
--- a/vl.c
+++ b/vl.c
@@ -184,6 +184,8 @@ bool boot_strict;
 uint8_t *boot_splash_filedata;
 size_t boot_splash_filedata_size;
 uint8_t qemu_extra_params_fw[2];
+int qemu_evdev_lhotkey = 29;  /* LEFTCONTROL */
+int qemu_evdev_rhotkey = 97;  /* RIGHTCONTROL */
 
 int icount_align_option;
 
@@ -3378,6 +3380,12 @@ int main(int argc, char **argv, char **envp)
                 qemu_opts_set(qemu_find_opts("machine"), 0, "initrd", optarg,
                               &error_abort);
                 break;
+            case QEMU_OPTION_evdev_rhotkey:
+                qemu_evdev_rhotkey = strtol(optarg, NULL, 0);
+                break;
+            case QEMU_OPTION_evdev_lhotkey:
+                qemu_evdev_lhotkey = strtol(optarg, NULL, 0);
+                break;
             case QEMU_OPTION_append:
                 qemu_opts_set(qemu_find_opts("machine"), 0, "append", optarg,
                               &error_abort);
-- 
2.15.1
