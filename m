Received: from eggs.gnu.org ([2001:4830:134:3::10]:48105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eTzha-0005HK-JS
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 19:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eTzhW-0006bb-GH
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 19:36:10 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:38301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eTzhW-0006an-A2
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 19:36:06 -0500
Received: by mail-io0-x241.google.com with SMTP id 87so29698975ior.5
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 16:36:06 -0800 (PST)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Tue, 26 Dec 2017 19:35:44 -0500
Message-Id: <20171227003544.39826-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v3] Add ability for user to specify mouse
 ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, kraxel@redhat.com, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Currently the ungrab keys for the Cocoa and GTK interface are Control-Alt-g.
This combination may not be very fun for the user to have to enter, so we
now enable the user to specify their own key(s) as the ungrab key(s). The
list of keys that can be used is found in the file qapi/ui.json under QKeyCode.
The max number of keys that can be used is three. The original ungrab keys
still remain usable because there is a real risk of the user forgetting 
the keys he or she specified as the ungrab keys. They remain as a plan B
if plan A is forgotten.

Syntax: -ungrab <key-key-key>

Example usage:  -ungrab home
	        -ungrab shift-ctrl
		-ungrab ctrl-x
		-ungrab pgup-pgdn
		-ungrab kp_5-kp_6
		-ungrab kp_4-kp_5-kp_6

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v3 changes:
- Added the ability for any "sendkey supported" key to be used.
- Added ability for one to three key sequences to be used.

v2 changes:
- Removed the "int i" code from the for loops. 

 include/ui/console.h |  6 ++++++
 qemu-options.hx      |  2 ++
 ui/cocoa.m           | 48 +++++++++++++++++++++++++++++++++++++++--
 ui/console.c         | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 vl.c                 |  3 +++
 5 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 580dfc57ee..37dc150268 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -534,4 +534,10 @@ static inline void early_gtk_display_init(int opengl)
 /* egl-headless.c */
 void egl_headless_init(void);
 
+/* console.c */
+void set_ungrab_seq(const char *new_seq);
+int *console_ungrab_key_sequence(void);
+const char *console_ungrab_key_string(void);
+int console_ungrab_sequence_length(void);
+
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 94647e21e3..51666e6f74 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4264,6 +4264,8 @@ contents of @code{iv.b64} to the second secret
 
 ETEXI
 
+DEF("ungrab", HAS_ARG, QEMU_OPTION_ungrab, \
+    "-ungrab <key sequence>", QEMU_ARCH_ALL)
 
 HXCOMM This is the last statement. Insert new options before this line!
 STEXI
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 330ccebf90..412a5fc02d 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -303,6 +303,7 @@ - (float) cdx;
 - (float) cdy;
 - (QEMUScreen) gscreen;
 - (void) raiseAllKeys;
+- (bool) user_ungrab_seq;
 @end
 
 QemuCocoaView *cocoaView;
@@ -674,9 +675,24 @@ - (void) handleEvent:(NSEvent *)event
                 }
             }
 
+            /*
+             * This code has to be here because the user might use a modifier
+             * key like shift as an ungrab key.
+             */
+            if ([self user_ungrab_seq] == true) {
+                [self ungrabMouse];
+                return;
+            }
             break;
         case NSEventTypeKeyDown:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
+            [self toggleModifier: keycode];
+
+            // If the user is issuing the custom ungrab key sequence
+            if ([self user_ungrab_seq] == true) {
+                [self ungrabMouse];
+                return;
+            }
 
             // forward command key combos to the host UI unless the mouse is grabbed
             if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
@@ -714,6 +730,7 @@ - (void) handleEvent:(NSEvent *)event
             break;
         case NSEventTypeKeyUp:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
+            [self toggleModifier: keycode];
 
             // don't pass the guest a spurious key-up if we treated this
             // command-key combo as a host UI action
@@ -842,10 +859,18 @@ - (void) grabMouse
     COCOA_DEBUG("QemuCocoaView: grabMouse\n");
 
     if (!isFullscreen) {
+        NSString * message_string;
+        if (console_ungrab_sequence_length() == 0) {
+            message_string = [NSString stringWithFormat: @"- (Press ctrl + alt + g to release Mouse"];
+        } else {
+            message_string = [NSString stringWithFormat: @"- (Press ctrl + alt + g or %s to release Mouse", console_ungrab_key_string()];
+        }
+
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
@@ -898,6 +923,25 @@ - (void) raiseAllKeys
        }
    }
 }
+
+/* Determines if the user specified ungrab sequence is being used */
+- (bool) user_ungrab_seq
+{
+    int *ungrab_seq, index, length;
+    bool return_value = true;
+
+    ungrab_seq = console_ungrab_key_sequence();
+    length = console_ungrab_sequence_length();
+
+    for (index = 0; index < length; index++) {
+        if (modifiers_state[ungrab_seq[index]] == NO) {
+            return_value = false;
+            break;
+        }
+    }
+    return return_value;
+}
+
 @end
 
 
diff --git a/ui/console.c b/ui/console.c
index c4c95abed7..3f52d696f0 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -63,6 +63,18 @@ typedef struct QEMUFIFO {
     int count, wptr, rptr;
 } QEMUFIFO;
 
+/* max number of user specified keys that can be used as the ungrab keys*/
+static const int max_keys = 3;
+
+/* stores the ungrab keys' values */
+static int key_value_array[max_keys + 1] = {0};
+
+/* stores the length the user's ungrab sequence */
+int ungrab_seq_length;
+
+/* stores the string that is returned by console_ungrab_key_string */
+static char *ungrab_key_string;
+
 static int qemu_fifo_write(QEMUFIFO *f, const uint8_t *buf, int len1)
 {
     int l, len;
@@ -2237,6 +2249,55 @@ void qemu_console_early_init(void)
 static void register_types(void)
 {
     type_register_static(&qemu_console_info);
+    ungrab_seq_length = 0;
+}
+
+/* Sets the mouse ungrab key sequence to what the user wants */
+void set_ungrab_seq(const char *new_seq)
+{
+    char *buffer1 = (char *) malloc(strlen(new_seq) * sizeof(char));
+    char *buffer2 = (char *) malloc(strlen(new_seq) * sizeof(char));
+    int count = 0;
+    int key_value;
+    char *token;
+    const char *separator = "-";  /* What the user places between keys */
+
+    sprintf(buffer1, "%s", new_seq); /* edited by strtok */
+    sprintf(buffer2, "%s", new_seq); /* used for ungrab_key_string */
+    ungrab_key_string = buffer2;
+
+    token = strtok(buffer1, separator);
+    while (token != NULL && count < max_keys) {
+        /* Translate the names into Q_KEY_CODE values */
+        key_value = index_from_key(token, strlen(token));
+        if (key_value == Q_KEY_CODE__MAX) {
+            printf("-ungrab: unknown key: %s\n", token);
+            exit(EXIT_FAILURE);
+        }
+        key_value_array[count] = key_value;
+
+        count++;
+        token = strtok(NULL, separator);
+    }
+    ungrab_seq_length = count;
+}
+
+/* Returns the user specified ungrab key sequence */
+int *console_ungrab_key_sequence()
+{
+    return key_value_array;
+}
+
+/* Returns the name of the user specified ungrab keys */
+const char *console_ungrab_key_string()
+{
+    return ungrab_key_string;
+}
+
+/* indicates how many keys the user ungrab sequence is */
+int console_ungrab_sequence_length(void)
+{
+    return ungrab_seq_length;
 }
 
 type_init(register_types);
diff --git a/vl.c b/vl.c
index d3a5c5d021..86203344eb 100644
--- a/vl.c
+++ b/vl.c
@@ -4155,6 +4155,9 @@ int main(int argc, char **argv, char **envp)
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
