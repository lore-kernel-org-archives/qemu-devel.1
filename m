Received: from eggs.gnu.org ([2001:4830:134:3::10]:50930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gT4QL-0005av-MX
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gT4QK-0008SV-Vj
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:05 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gT4QK-0008Qj-Ox
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:04 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat,  1 Dec 2018 12:30:54 +0000
Message-Id: <20181201123056.432-4-peter.maydell@linaro.org>
In-Reply-To: <20181201123056.432-1-peter.maydell@linaro.org>
References: <20181201123056.432-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 3/5] ui/cocoa: Factor out initial menu creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>

Factor out the long code sequence in main() which creates
the initial set of menus. This will make later patches
which move initialization code around a bit clearer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 78 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 997b0199c6c..da511bfb4fa 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1444,43 +1444,8 @@ QemuCocoaView *cocoaView;
 
 @end
 
-
-int main (int argc, const char * argv[]) {
-
-    gArgc = argc;
-    gArgv = (char **)argv;
-    int i;
-
-    /* In case we don't need to display a window, let's not do that */
-    for (i = 1; i < argc; i++) {
-        const char *opt = argv[i];
-
-        if (opt[0] == '-') {
-            /* Treat --foo the same as -foo.  */
-            if (opt[1] == '-') {
-                opt++;
-            }
-            if (!strcmp(opt, "-h") || !strcmp(opt, "-help") ||
-                !strcmp(opt, "-vnc") ||
-                !strcmp(opt, "-nographic") ||
-                !strcmp(opt, "-version") ||
-                !strcmp(opt, "-curses") ||
-                !strcmp(opt, "-display") ||
-                !strcmp(opt, "-qtest")) {
-                return qemu_main(gArgc, gArgv, *_NSGetEnviron());
-            }
-        }
-    }
-
-    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
-
-    // Pull this console process up to being a fully-fledged graphical
-    // app with a menubar and Dock icon
-    ProcessSerialNumber psn = { 0, kCurrentProcess };
-    TransformProcessType(&psn, kProcessTransformToForegroundApplication);
-
-    [NSApplication sharedApplication];
-
+static void create_initial_menus(void)
+{
     // Add menus
     NSMenu      *menu;
     NSMenuItem  *menuItem;
@@ -1564,6 +1529,45 @@ int main (int argc, const char * argv[]) {
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Window" action:nil keyEquivalent:@""] autorelease];
     [menuItem setSubmenu:menu];
     [[NSApp mainMenu] addItem:menuItem];
+}
+
+int main (int argc, const char * argv[]) {
+
+    gArgc = argc;
+    gArgv = (char **)argv;
+    int i;
+
+    /* In case we don't need to display a window, let's not do that */
+    for (i = 1; i < argc; i++) {
+        const char *opt = argv[i];
+
+        if (opt[0] == '-') {
+            /* Treat --foo the same as -foo.  */
+            if (opt[1] == '-') {
+                opt++;
+            }
+            if (!strcmp(opt, "-h") || !strcmp(opt, "-help") ||
+                !strcmp(opt, "-vnc") ||
+                !strcmp(opt, "-nographic") ||
+                !strcmp(opt, "-version") ||
+                !strcmp(opt, "-curses") ||
+                !strcmp(opt, "-display") ||
+                !strcmp(opt, "-qtest")) {
+                return qemu_main(gArgc, gArgv, *_NSGetEnviron());
+            }
+        }
+    }
+
+    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
+
+    // Pull this console process up to being a fully-fledged graphical
+    // app with a menubar and Dock icon
+    ProcessSerialNumber psn = { 0, kCurrentProcess };
+    TransformProcessType(&psn, kProcessTransformToForegroundApplication);
+
+    [NSApplication sharedApplication];
+
+    create_initial_menus();
 
     // Create an Application controller
     QemuCocoaAppController *appController = [[QemuCocoaAppController alloc] init];
-- 
2.19.2
