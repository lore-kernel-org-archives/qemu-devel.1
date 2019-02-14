Received: from eggs.gnu.org ([209.51.188.92]:46147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guEML-00029E-24
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guEG2-00044x-56
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:28:45 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:34091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guEFw-0003p8-Qv
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:28:38 -0500
Received: by mail-wm1-x32d.google.com with SMTP id y185so3953839wmd.1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 02:28:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 10:28:12 +0000
Message-Id: <20190214102816.3393-4-peter.maydell@linaro.org>
In-Reply-To: <20190214102816.3393-1-peter.maydell@linaro.org>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/7] ui/cocoa: Factor out initial menu
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>, BALATON Zoltan <balaton@eik.bme.hu>

Factor out the long code sequence in main() which creates
the initial set of menus. This will make later patches
which move initialization code around a bit clearer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 78 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 9d23732ff9..0b1cd31543 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1461,43 +1461,8 @@ - (void)adjustSpeed:(id)sender
 
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
@@ -1581,6 +1546,45 @@ int main (int argc, const char * argv[]) {
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
2.17.2 (Apple Git-113)
