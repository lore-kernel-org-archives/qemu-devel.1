Received: from eggs.gnu.org ([209.51.188.92]:52481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qn0-0004N1-4b
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qmz-0005ia-6y
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:32889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0qmz-0005hw-0M
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:05 -0500
Received: by mail-wr1-x42a.google.com with SMTP id i12so6325201wrw.0
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 08:50:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	x74sm7238018wmf.22.2019.03.04.08.50.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Mar 2019 08:50:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Mar 2019 16:49:54 +0000
Message-Id: <20190304164958.9362-4-peter.maydell@linaro.org>
In-Reply-To: <20190304164958.9362-1-peter.maydell@linaro.org>
References: <20190304164958.9362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/7] ui/cocoa: Factor out initial menu creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Factor out the long code sequence in main() which creates
the initial set of menus. This will make later patches
which move initialization code around a bit clearer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-id: 20190225102433.22401-4-peter.maydell@linaro.org
Message-id: 20190214102816.3393-4-peter.maydell@linaro.org
---
 ui/cocoa.m | 78 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index a913a51a2d8..4baec0b2ff7 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1465,43 +1465,8 @@ QemuCocoaView *cocoaView;
 
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
@@ -1585,6 +1550,45 @@ int main (int argc, const char * argv[]) {
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
2.20.1
