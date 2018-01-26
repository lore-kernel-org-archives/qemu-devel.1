Received: from eggs.gnu.org ([2001:4830:134:3::10]:49663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1efBqb-0002Sa-Db
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1efBqY-0005tY-9M
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:47:45 -0500
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:40330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1efBqY-0005sr-2y
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:47:42 -0500
Received: by mail-io0-x235.google.com with SMTP id t22so1886338ioa.7
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 13:47:41 -0800 (PST)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Fri, 26 Jan 2018 16:47:31 -0500
Message-Id: <20180126214731.23506-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v5] cocoa.m: Add ability for user to specify
 mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, kraxel@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Currently the ungrab keys for the Cocoa and GTK interface are Control-Alt-g.
This combination may not be very fun for the user to have to enter, so we
now enable the user to specify their own key(s) as the ungrab key(s). The
list of keys that can be used is found in the file qapi/ui.json under QKeyCode.
The max number of keys that can be used is three.

Syntax: -ungrab <key-key-key>

Example usage:  -ungrab home
	        -ungrab shift-ctrl
		-ungrab ctrl-x
		-ungrab pgup-pgdn
		-ungrab kp_5-kp_6
		-ungrab kp_4-kp_5-kp_6
		-ungrab ctrl-alt

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v5 changes:
- Removed ungrab detection code from keydown event in handleEvent.
- Removed console_ungrab_sequence_length().
- Removed ability to always use the default ctrl-alt-g ungrab key sequence.
- Added ability to actually send keys to the guest that might overlap ungrab keys. 
Example for -ungrab ctrl-alt:
down(ctrl)
down(alt)
up(ctrl)
up(alt)
..ungrab activates..

down(ctrl)
down(alt)
down(f1)
up(ctrl)
up(alt)
up(f1)
..no ungrab activates..

v4 changes:
- Removed initialization code for key_value_array.
- Added void keyword to console_ungrab_key_sequence(),
  and console_ungrab_key_string() functions.

v3 changes:
- Added the ability for any "sendkey supported" key to be used.
- Added ability for one to three key sequences to be used.

v2 changes:
- Removed the "int i" code from the for loops. 

 include/ui/console.h |   8 ++++
 qemu-options.hx      |   2 +
 ui/cocoa.m           | 109 +++++++++++++++++++++++++++++++++++++++++++++------
 ui/console.c         |  62 +++++++++++++++++++++++++++++
 vl.c                 |   3 ++
 5 files changed, 173 insertions(+), 11 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 580dfc57ee..f346cb05d0 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -534,4 +534,12 @@ static inline void early_gtk_display_init(int opengl)
 /* egl-headless.c */
 void egl_headless_init(void);
 
+/* console.c */
+/* max number of keys that can be used as the ungrab keys */
+#define MAX_UNGRAB_KEYS 3
+void set_ungrab_seq(const char *new_seq);
+int *console_ungrab_key_sequence(void);
+const char *console_ungrab_key_string(void);
+void use_default_ungrab_keys(void);
+void init_ungrab_keys(void);
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 678181c599..5ba66905f5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4251,6 +4251,8 @@ contents of @code{iv.b64} to the second secret
 
 ETEXI
 
+DEF("ungrab", HAS_ARG, QEMU_OPTION_ungrab, \
+    "-ungrab <key sequence>", QEMU_ARCH_ALL)
 
 HXCOMM This is the last statement. Insert new options before this line!
 STEXI
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 330ccebf90..1dc9b23941 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -105,6 +105,8 @@
 bool stretch_video;
 NSTextField *pauseLabel;
 NSArray * supportedImageFileTypes;
+NSMutableSet *key_set, *ungrab_set;
+int ungrab_sequence_length;
 
 // Mac to QKeyCode conversion
 const int mac_to_qkeycode_map[] = {
@@ -303,6 +305,7 @@ - (float) cdx;
 - (float) cdy;
 - (QEMUScreen) gscreen;
 - (void) raiseAllKeys;
+- (BOOL) is_ungrab_seq;
 @end
 
 QemuCocoaView *cocoaView;
@@ -488,8 +491,6 @@ - (void) switchSurface:(DisplaySurface *)surface
         [[fullScreenWindow contentView] setFrame:[[NSScreen mainScreen] frame]];
         [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow frame].size.height - oldh) display:NO animate:NO];
     } else {
-        if (qemu_name)
-            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
         [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow frame].size.height - oldh) display:YES animate:NO];
     }
 
@@ -669,14 +670,29 @@ - (void) handleEvent:(NSEvent *)event
                 if (keycode == Q_KEY_CODE_CAPS_LOCK ||
                     keycode == Q_KEY_CODE_NUM_LOCK) {
                     [self toggleStatefulModifier:keycode];
-                } else if (qemu_console_is_graphic(NULL)) {
+                } else {
                   [self toggleModifier:keycode];
                 }
             }
 
+            /*
+             * This code has to be here because the user might use a modifier
+             * key like shift as an ungrab key.
+             */
+            if (modifiers_state[keycode] == YES) { // if the key is down
+                [self check_key: keycode];
+            } else {                               // if the key is up
+                if ([self is_ungrab_seq] == YES) {
+                    [self ungrabMouse];
+                    [self clear_ungrab_array];
+                    return;
+                }
+                [self remove_key_from_ungrab_array: keycode];
+            }
             break;
         case NSEventTypeKeyDown:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
+            [self check_key: keycode];
 
             // forward command key combos to the host UI unless the mouse is grabbed
             if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
@@ -686,7 +702,7 @@ - (void) handleEvent:(NSEvent *)event
 
             // default
 
-            // handle control + alt Key Combos (ctrl+alt+[1..9,g] is reserved for QEMU)
+            // handle control + alt Key Combos (ctrl+alt+[1..9] is reserved for QEMU)
             if (([event modifierFlags] & NSEventModifierFlagControl) && ([event modifierFlags] & NSEventModifierFlagOption)) {
                 NSString *keychar = [event charactersIgnoringModifiers];
                 if ([keychar length] == 1) {
@@ -697,11 +713,6 @@ - (void) handleEvent:(NSEvent *)event
                         case '1' ... '9':
                             console_select(key - '0' - 1); /* ascii math */
                             return;
-
-                        // release the mouse grab
-                        case 'g':
-                            [self ungrabMouse];
-                            return;
                     }
                 }
             }
@@ -715,6 +726,13 @@ - (void) handleEvent:(NSEvent *)event
         case NSEventTypeKeyUp:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
+            if ([self is_ungrab_seq] == YES) {
+                [self ungrabMouse];
+                [self clear_ungrab_array];
+                return;
+            }
+            [self remove_key_from_ungrab_array: keycode];
+
             // don't pass the guest a spurious key-up if we treated this
             // command-key combo as a host UI action
             if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
@@ -842,10 +860,13 @@ - (void) grabMouse
     COCOA_DEBUG("QemuCocoaView: grabMouse\n");
 
     if (!isFullscreen) {
+        NSString * message_string;
+        message_string = [NSString stringWithFormat: @"- (Press %s to release Mouse)", console_ungrab_key_string()];
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
@@ -898,6 +919,47 @@ - (void) raiseAllKeys
        }
    }
 }
+
+/* Determines if a key is one of the mouse ungrab keys */
+- (BOOL) is_an_ungrab_key: (int) keycode
+{
+    return [ungrab_set containsObject: [NSNumber numberWithInt: keycode]];
+}
+
+/* Adds an ungrab key to an array that tracks if the ungrab keys are pushed */
+- (void) add_key_to_ungrab_array: (int) keycode
+{
+    [key_set addObject: [NSNumber numberWithInt: keycode]];
+}
+
+/* Removes a key from ungrab key tracking */
+- (void) remove_key_from_ungrab_array: (int) keycode
+{
+    [key_set removeObject: [NSNumber numberWithInt: keycode]];
+}
+
+/* Clears the array used to track the ungrab keys */
+- (void) clear_ungrab_array
+{
+    [key_set removeAllObjects];
+}
+
+/* Check the keycode to see if it one of the ungrab keys */
+- (void) check_key: (int) keycode
+{
+    if ([self is_an_ungrab_key: keycode]) {
+        [self add_key_to_ungrab_array: keycode];
+    } else {
+        [self clear_ungrab_array];
+    }
+}
+
+/* Determines if the user specified ungrab sequence is being used */
+- (BOOL) is_ungrab_seq
+{
+    return [ungrab_set isEqualToSet: key_set];
+}
+
 @end
 
 
@@ -1671,6 +1733,29 @@ static void addRemovableDevicesMenuItems(void)
     qapi_free_BlockInfoList(pointerToFree);
 }
 
+/* initializes the mouse ungrab system */
+static void ungrab_init(void)
+{
+    key_set = [NSMutableSet new];
+    ungrab_set = [NSMutableSet new];
+    init_ungrab_keys();
+
+    /* determine length of the mouse ungrab sequence */
+    int index, *ungrab_seq;
+    ungrab_sequence_length = 0;
+    ungrab_seq = console_ungrab_key_sequence();
+    for (index = 0; index < MAX_UNGRAB_KEYS; index++) {
+        if (ungrab_seq[index] != 0) {
+            ungrab_sequence_length++;
+        }
+    }
+
+    /* make the ungrab set */
+    for (index = 0; index < ungrab_sequence_length; index++) {
+        [ungrab_set addObject: [NSNumber numberWithInt: ungrab_seq[index]]];
+    }
+}
+
 void cocoa_display_init(DisplayState *ds, int full_screen)
 {
     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
@@ -1700,4 +1785,6 @@ void cocoa_display_init(DisplayState *ds, int full_screen)
      * find out what removable devices it has.
      */
     addRemovableDevicesMenuItems();
+
+    ungrab_init();
 }
diff --git a/ui/console.c b/ui/console.c
index c4c95abed7..9ff599706d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -63,6 +63,12 @@ typedef struct QEMUFIFO {
     int count, wptr, rptr;
 } QEMUFIFO;
 
+/* stores the ungrab keys' values */
+static int key_value_array[MAX_UNGRAB_KEYS + 1];
+
+/* stores the string that is returned by console_ungrab_key_string */
+static char *ungrab_key_string;
+
 static int qemu_fifo_write(QEMUFIFO *f, const uint8_t *buf, int len1)
 {
     int l, len;
@@ -2239,4 +2245,60 @@ static void register_types(void)
     type_register_static(&qemu_console_info);
 }
 
+/* Sets the mouse ungrab key sequence to what the user wants */
+void set_ungrab_seq(const char *new_seq)
+{
+    const char *separator = "-";  /* What the user places between keys */
+    gchar **key_array;
+    int key_value, count;
+
+    count = 0;
+    key_array = g_strsplit(new_seq, separator, -1);
+    ungrab_key_string = g_strdup(new_seq);
+
+    for (; *key_array; key_array++) {
+        key_value = index_from_key(*key_array, strlen(*key_array));
+        if (key_value == Q_KEY_CODE__MAX) {
+            printf("-ungrab: unknown key: %s\n", *key_array);
+            exit(EXIT_FAILURE);
+        }
+        key_value_array[count] = key_value;
+        count++;
+    }
+}
+
+/* Returns the user specified ungrab key sequence */
+int *console_ungrab_key_sequence(void)
+{
+    return key_value_array;
+}
+
+/* Returns the name of the user specified ungrab keys */
+const char *console_ungrab_key_string(void)
+{
+    return ungrab_key_string;
+}
+
+/* Sets the UI to use the default ungrab key sequence */
+void use_default_ungrab_keys(void)
+{
+    /* Default ungrab keys: Control Alt g */
+    ungrab_key_string = (char *) malloc(sizeof(char) * 14);
+    sprintf(ungrab_key_string, "%s", "ctrl-alt-g");
+    key_value_array[0] = Q_KEY_CODE_CTRL;
+    key_value_array[1] = Q_KEY_CODE_ALT;
+    key_value_array[2] = Q_KEY_CODE_G;
+}
+
+/*
+ * Initializes the ungrab key settings - should be called by the front-end on
+ * startup.
+ */
+void init_ungrab_keys(void)
+{
+    if (console_ungrab_key_string() == NULL) {
+        use_default_ungrab_keys();
+    }
+}
+
 type_init(register_types);
diff --git a/vl.c b/vl.c
index 444b7507da..bfe61ad2fa 100644
--- a/vl.c
+++ b/vl.c
@@ -4073,6 +4073,9 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_ungrab:
+                set_ungrab_seq(optarg);
+                break;
             default:
                 os_parse_cmd_args(popt->index, optarg);
             }
-- 
2.14.3 (Apple Git-98)
