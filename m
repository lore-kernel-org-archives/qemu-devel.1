Received: from eggs.gnu.org ([2001:4830:134:3::10]:45477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ePUdd-0003Wv-EJ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ePUdZ-00019m-Ct
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:37:29 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:40414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1ePUdZ-000199-6Q
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:37:25 -0500
Received: by mail-it0-x241.google.com with SMTP id f190so11520730ita.5
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 06:37:25 -0800 (PST)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu, 14 Dec 2017 09:37:13 -0500
Message-Id: <20171214143713.3795-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v2] Add ability for user to specify mouse
 ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com
Cc: John Arbuckle <programmingkidx@gmail.com>

Currently the ungrab keys for the Cocoa and GTK interface are Control-Alt-g.
This combination may not be very fun for the user to have to enter, so we
now enable the user to specify their own key as the ungrab key. Since the 
function keys are the keys that don't tend to be used that often and are
usually available, they will be the ones the user can pick to be the ungrab
key.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v2 changes:
- Removed the "int i" code from the for loops. 

 qemu-options.hx |  2 ++
 ui/cocoa.m      | 20 ++++++++++++++--
 vl.c            | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index f11c4ac960..0a727ea50a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4472,6 +4472,8 @@ contents of @code{iv.b64} to the second secret
 
 ETEXI
 
+DEF("ungrab", HAS_ARG, QEMU_OPTION_ungrab, \
+    "-ungrab <key>", QEMU_ARCH_ALL)
 
 HXCOMM This is the last statement. Insert new options before this line!
 STEXI
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 330ccebf90..8dc603adf0 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -106,6 +106,9 @@
 NSTextField *pauseLabel;
 NSArray * supportedImageFileTypes;
 
+int get_ungrab_key_value(void);
+const char * get_ungrab_key_name(void);
+
 // Mac to QKeyCode conversion
 const int mac_to_qkeycode_map[] = {
     [kVK_ANSI_A] = Q_KEY_CODE_A,
@@ -678,6 +681,12 @@ - (void) handleEvent:(NSEvent *)event
         case NSEventTypeKeyDown:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
+            // if the user wants to release the mouse grab
+            if (keycode == get_ungrab_key_value()) {
+                [self ungrabMouse];
+                return;
+            }
+
             // forward command key combos to the host UI unless the mouse is grabbed
             if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
                 [NSApp sendEvent:event];
@@ -842,10 +851,17 @@ - (void) grabMouse
     COCOA_DEBUG("QemuCocoaView: grabMouse\n");
 
     if (!isFullscreen) {
+        NSString * message_string;
+        if (get_ungrab_key_value() < 0) {
+            message_string = [NSString stringWithFormat: @"- (Press ctrl + alt + g to release Mouse"];
+        } else {
+            message_string = [NSString stringWithFormat: @"- (Press ctrl + alt + g or %s to release Mouse", get_ungrab_key_name()];
+        }
+
         if (qemu_name)
-            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s - (Press ctrl + alt + g to release Mouse)", qemu_name]];
+            [normalWindow setTitle:[NSString stringWithFormat: @"QEMU %s %@", qemu_name, message_string]];
         else
-            [normalWindow setTitle:@"QEMU - (Press ctrl + alt + g to release Mouse)"];
+            [normalWindow setTitle:[NSString stringWithFormat: @"QEMU %@", message_string]];
     }
     [self hideCursor];
     if (!isAbsoluteEnabled) {
diff --git a/vl.c b/vl.c
index 1ad1c04637..c2d848fabc 100644
--- a/vl.c
+++ b/vl.c
@@ -185,7 +185,8 @@ bool boot_strict;
 uint8_t *boot_splash_filedata;
 size_t boot_splash_filedata_size;
 uint8_t qemu_extra_params_fw[2];
-
+int ungrab_key_value = -1;
+char *ungrab_key_name;
 int icount_align_option;
 
 /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
@@ -3088,6 +3089,73 @@ static void register_global_properties(MachineState *ms)
     user_register_global_props();
 }
 
+/* Sets the mouse ungrab key to what the user wants */
+static void set_ungrab_key(const char *new_key)
+{
+    const char *keys[] = {
+        [0 ... 0xff]    = "",
+        [Q_KEY_CODE_F1] = "f1",
+        [Q_KEY_CODE_F2] = "f2",
+        [Q_KEY_CODE_F3] = "f3",
+        [Q_KEY_CODE_F4] = "f4",
+        [Q_KEY_CODE_F5] = "f5",
+        [Q_KEY_CODE_F6] = "f6",
+        [Q_KEY_CODE_F7] = "f7",
+        [Q_KEY_CODE_F8] = "f8",
+        [Q_KEY_CODE_F9] = "f9",
+        [Q_KEY_CODE_F10] = "f10",
+        [Q_KEY_CODE_F11] = "f11",
+        [Q_KEY_CODE_F12] = "f12",
+        [Q_KEY_CODE_PRINT] = "f13",
+        [Q_KEY_CODE_SCROLL_LOCK] = "f14",
+        [Q_KEY_CODE_PAUSE] = "f15",
+    };
+
+    int key_value = -1;
+    int i;
+
+    /* see if the user's key is recognized */
+    for (i = 0; i < ARRAY_SIZE(keys); i++) {
+        if (strcmp(keys[i], new_key) == 0) {
+            key_value = i;
+            break;
+        }
+    }
+
+    /* if the user's key isn't recognized print the usable keys */
+    if (key_value == -1) {
+        printf("Unrecognized key: %s\n", new_key);
+        printf("Usable ungrab keys: ");
+        for (i = 0; i < ARRAY_SIZE(keys); i++) {
+            if (strlen(keys[i]) > 0) { /* filters out undefined values */
+                printf("%s ", keys[i]);
+            }
+        }
+        printf("\n\n");
+        exit(1);
+    }
+
+    ungrab_key_name = (char *) malloc(4 * sizeof(char));
+    strncpy(ungrab_key_name, new_key, 3);
+    ungrab_key_value = key_value;
+}
+
+int get_ungrab_key_value(void);
+
+/* Returns the user specified ungrab key's value or -1 if not specified */
+int get_ungrab_key_value(void)
+{
+    return ungrab_key_value;
+}
+
+const char *get_ungrab_key_name(void);
+
+/* Returns the name of the user specified ungrab key */
+const char *get_ungrab_key_name(void)
+{
+    return ungrab_key_name;
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -4204,6 +4272,9 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_ungrab:
+                set_ungrab_key(optarg);
+                break;
             default:
                 os_parse_cmd_args(popt->index, optarg);
             }
-- 
2.14.3 (Apple Git-98)
