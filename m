Received: from eggs.gnu.org ([2001:4830:134:3::10]:54864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1emmml-0000DR-J8
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1emmmi-0001y9-BJ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:39:11 -0500
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:37603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1emmmi-0001xl-3d
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:39:08 -0500
Received: by mail-it0-x22a.google.com with SMTP id d10so3279159itj.2
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 12:39:07 -0800 (PST)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Fri, 16 Feb 2018 15:38:56 -0500
Message-Id: <20180216203856.8645-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v7] ui/cocoa.m: Add ability for user to specify
 mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Currently the ungrab keys for the Cocoa and GTK interface are Control-Alt-g.
This combination may not be very fun for the user to have to enter, so we
now enable the user to specify their own key(s) as the ungrab key(s). The
list of keys that can be used is found in the file qapi/ui.json under QKeyCode.
The max number of keys that can be used is three.

Syntax: -display cocoa,hotkey-grab=<key-key-key>

Example usage:  -display cocoa,hotkey-grab=home
	        -display cocoa,hotkey-grab=shift-ctrl
		-display cocoa,hotkey-grab=ctrl-x
		-display cocoa,hotkey-grab=pgup-pgdn
		-display cocoa,hotkey-grab=kp_5-kp_6
		-display cocoa,hotkey-grab=kp_4-kp_5-kp_6
		-display cocoa,hotkey-grab=ctrl-alt

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v7 changes:
- Prevent ungrab keys from being seen by guest.

v6 changes:
- changed ungrab command-line option to -display cocoa,hotkey-grab
- Removed NSMutableSet code
- Implemented C version of Set datatype

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

 include/ui/console.h |  22 +++++++
 qemu-options.hx      |   1 +
 ui/cocoa.m           |  98 +++++++++++++++++++++++++----
 ui/console.c         | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++
 vl.c                 |  17 ++++++
 5 files changed, 295 insertions(+), 12 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 12fef80923..5664b4c087 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -508,4 +508,26 @@ static inline void early_gtk_display_init(int opengl)
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
+
+/* Set datatype related code */
+typedef struct Set_struct {
+    int size;   /* The size of the array */
+    int *array; /* The array used to store the set's values */
+} Set;
+
+Set *new_set(int max_size);
+void add_number(Set *the_set, int the_number);
+void remove_number(Set *the_set, int the_number);
+bool contains_number(Set *the_set, int the_number);
+void clear_set(Set *the_set);
+bool are_sets_equal(Set *set1, Set *set2);
+
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 5050a49a5e..4a613e4e9c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1243,6 +1243,7 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
     "            [,window_close=on|off][,gl=on|off]\n"
     "-display gtk[,grab_on_hover=on|off][,gl=on|off]|\n"
     "-display vnc=<display>[,<optargs>]\n"
+    "-display cocoa[hotkey-grab=<key(s)>]\n"
     "-display curses\n"
     "-display none"
     "                select display type\n"
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 51db47cd71..a4b1f9b9f4 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -106,6 +106,8 @@
 bool stretch_video;
 NSTextField *pauseLabel;
 NSArray * supportedImageFileTypes;
+Set *key_set, *ungrab_set;
+int ungrab_sequence_length;
 
 // Mac to QKeyCode conversion
 const int mac_to_qkeycode_map[] = {
@@ -261,6 +263,15 @@ static void handleAnyDeviceErrors(Error * err)
     }
 }
 
+/* Sends any keys that were delayed because they were part of the ungrab set */
+static void send_key_if_delayed(Set *the_set, int keycode)
+{
+    if (contains_number(the_set, keycode)) {
+        qemu_input_event_send_key_qcode(dcl->con, keycode, true);
+        qemu_input_event_send_key_qcode(dcl->con, keycode, false);
+    }
+}
+
 /*
  ------------------------------------------------------
     QemuCocoaView
@@ -489,8 +500,6 @@ - (void) switchSurface:(DisplaySurface *)surface
         [[fullScreenWindow contentView] setFrame:[[NSScreen mainScreen] frame]];
         [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow frame].size.height - oldh) display:NO animate:NO];
     } else {
-        if (qemu_name)
-            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
         [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow frame].size.height - oldh) display:YES animate:NO];
     }
 
@@ -670,14 +679,31 @@ - (void) handleEvent:(NSEvent *)event
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
+                if (are_sets_equal(ungrab_set, key_set)) {
+                    [self ungrabMouse];
+                    clear_set(key_set);
+                    return;
+                }
+                remove_number(key_set, keycode);
+            }
             break;
         case NSEventTypeKeyDown:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
+            if ([self check_key: keycode]) {
+                return;
+            }
 
             // forward command key combos to the host UI unless the mouse is grabbed
             if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
@@ -687,7 +713,7 @@ - (void) handleEvent:(NSEvent *)event
 
             // default
 
-            // handle control + alt Key Combos (ctrl+alt+[1..9,g] is reserved for QEMU)
+            // handle control + alt Key Combos (ctrl+alt+[1..9] is reserved for QEMU)
             if (([event modifierFlags] & NSEventModifierFlagControl) && ([event modifierFlags] & NSEventModifierFlagOption)) {
                 NSString *keychar = [event charactersIgnoringModifiers];
                 if ([keychar length] == 1) {
@@ -698,11 +724,6 @@ - (void) handleEvent:(NSEvent *)event
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
@@ -716,6 +737,14 @@ - (void) handleEvent:(NSEvent *)event
         case NSEventTypeKeyUp:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
+            if (are_sets_equal(ungrab_set, key_set)) {
+                [self ungrabMouse];
+                clear_set(key_set);
+                return;
+            }
+            send_key_if_delayed(key_set, keycode);
+            remove_number(key_set, keycode);
+
             // don't pass the guest a spurious key-up if we treated this
             // command-key combo as a host UI action
             if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
@@ -854,10 +883,13 @@ - (void) grabMouse
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
@@ -910,6 +942,23 @@ - (void) raiseAllKeys
        }
    }
 }
+
+/*
+ * Check the keycode to see if it one of the ungrab keys
+ * Returns true if the keycode is part of the ungrab sequence
+ * and false if it isn't.
+ */
+- (int) check_key: (int) keycode
+{
+    if (contains_number(ungrab_set, keycode)) {
+        add_number(key_set, keycode);
+        return true;
+    } else {
+        clear_set(key_set);
+        return false;
+    }
+}
+
 @end
 
 
@@ -1401,7 +1450,7 @@ int main (int argc, const char * argv[]) {
                 !strcmp(opt, "-nographic") ||
                 !strcmp(opt, "-version") ||
                 !strcmp(opt, "-curses") ||
-                !strcmp(opt, "-display") ||
+                !strcmp(opt, "-display cocoa") ||
                 !strcmp(opt, "-qtest")) {
                 return qemu_main(gArgc, gArgv, *_NSGetEnviron());
             }
@@ -1683,6 +1732,29 @@ static void addRemovableDevicesMenuItems(void)
     qapi_free_BlockInfoList(pointerToFree);
 }
 
+/* initializes the mouse ungrab system */
+static void ungrab_init(void)
+{
+    key_set = new_set(MAX_UNGRAB_KEYS);
+    ungrab_set = new_set(MAX_UNGRAB_KEYS);
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
+        add_number(ungrab_set, ungrab_seq[index]);
+    }
+}
+
 void cocoa_display_init(DisplayState *ds, int full_screen)
 {
     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
@@ -1712,4 +1784,6 @@ void cocoa_display_init(DisplayState *ds, int full_screen)
      * find out what removable devices it has.
      */
     addRemovableDevicesMenuItems();
+
+    ungrab_init();
 }
diff --git a/ui/console.c b/ui/console.c
index 36584d039e..34adb19f14 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -32,9 +32,13 @@
 #include "chardev/char-fe.h"
 #include "trace.h"
 #include "exec/memory.h"
+#include <stdio.h>
+#include <memory.h>
+#include <stdbool.h>
 
 #define DEFAULT_BACKSCROLL 512
 #define CONSOLE_CURSOR_PERIOD 500
+#define EMPTY_VALUE -1
 
 typedef struct TextAttributes {
     uint8_t fgcol:4;
@@ -65,6 +69,12 @@ typedef struct QEMUFIFO {
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
@@ -2241,4 +2251,163 @@ static void register_types(void)
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
+            error_report("-hotkey-grab: unknown key: %s", *key_array);
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
+/*
+ * Set implements a set datatype. It is a collection of numbers with no
+ * repeats.
+ */
+
+/* Creates a new Set object with a size of max_size */
+Set *new_set(int max_size)
+{
+    Set *new_set_obj;
+    new_set_obj = (Set *) malloc(sizeof(Set));
+
+    int *array_obj;
+    array_obj = (int *) malloc(sizeof(int) * max_size);
+    new_set_obj->array = array_obj;
+    new_set_obj->size = max_size;
+
+    /* initialize the array */
+    int index;
+    for (index = 0; index < max_size; index++) {
+        new_set_obj->array[index] = EMPTY_VALUE;
+    }
+
+    return new_set_obj;
+}
+
+/* Adds a number to a set */
+void add_number(Set *the_set, int the_number)
+{
+    int index;
+
+    /* Check if the number if already in the list */
+    for (index = 0; index < the_set->size; index++) {
+        if (the_set->array[index] == the_number) {
+            return;
+        }
+    }
+
+    /* Find an empty spot and place the number there */
+    for (index = 0; index < the_set->size; index++) {
+        if (the_set->array[index] == EMPTY_VALUE) {
+            the_set->array[index] = the_number;
+            return;
+        }
+    }
+    error_report("Failed to add number to set");
+}
+
+/* Removes a number from a set */
+void remove_number(Set *the_set, int the_number)
+{
+    int index;
+    for (index = 0; index < the_set->size; index++) {
+        if (the_set->array[index] == the_number) {
+            the_set->array[index] = EMPTY_VALUE;
+        }
+    }
+}
+
+/* Determines if a number is in a set */
+bool contains_number(Set *the_set, int the_number)
+{
+    int index;
+    for (index = 0; index < the_set->size; index++) {
+        if (the_set->array[index] == the_number) {
+            return true;
+        }
+    }
+    return false;
+}
+
+/* Clears a set of all values */
+void clear_set(Set *the_set)
+{
+    int index;
+    for (index = 0; index < the_set->size; index++) {
+        the_set->array[index] = EMPTY_VALUE;
+    }
+}
+
+/* Determines if two sets contain the same values */
+bool are_sets_equal(Set *set1, Set *set2)
+{
+    if (set1->size != set2->size) {
+        return false;
+    }
+
+    /* see if both sets contain the same numbers */
+    int index1, index2, found_value;
+    for (index1 = 0; index1 < set1->size; index1++) {
+        found_value = 0;
+        for (index2 = 0; index2 < set1->size; index2++) {
+            if (set1->array[index1] == set2->array[index2]) {
+                found_value = 1;
+                break;
+            }
+        }
+        if (found_value != 1) {
+            return false;
+        }
+    }
+    return true;
+}
+
 type_init(register_types);
diff --git a/vl.c b/vl.c
index 7a5554bc41..a6c7b6f992 100644
--- a/vl.c
+++ b/vl.c
@@ -2220,6 +2220,23 @@ static DisplayType select_display(const char *p)
 #endif
     } else if (strstart(p, "none", &opts)) {
         display = DT_NONE;
+    } else if (strstart(p, "cocoa", &opts)) {
+#ifdef CONFIG_COCOA
+        display = DT_COCOA;
+        if (strstart(opts, ",hotkey-grab=", &opts)) {
+            if (strcmp(opts, "") == 0) {
+                error_report("Please add the key(s) argument");
+                exit(1);
+            }
+            set_ungrab_seq(opts);
+        } else {
+            error_report("invalid Cocoa option");
+            exit(1);
+        }
+#else
+        error_report("Cocoa support is disabled");
+        exit(1);
+#endif
     } else {
         error_report("unknown display type");
         exit(1);
-- 
2.14.3 (Apple Git-98)
