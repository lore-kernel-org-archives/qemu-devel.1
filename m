Received: from eggs.gnu.org ([209.51.188.92]:33049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyDRE-0006AL-3A
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyDRC-000302-SJ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:24:43 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyDRC-0002yz-Ju
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:24:42 -0500
Received: by mail-wm1-x342.google.com with SMTP id z84so7468446wmg.4
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 02:24:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 10:24:29 +0000
Message-Id: <20190225102433.22401-4-peter.maydell@linaro.org>
In-Reply-To: <20190225102433.22401-1-peter.maydell@linaro.org>
References: <20190225102433.22401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/7] ui/cocoa: Factor out initial menu
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
Cc: patches@linaro.org, Roman Bolshakov <r.bolshakv@yadro.com>, BALATON Zoltan <balaton@eik.bme.hu>, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>

Factor out the long code sequence in main() which creates
the initial set of menus. This will make later patches
which move initialization code around a bit clearer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-id: 20190214102816.3393-4-peter.maydell@linaro.org
---
 ui/cocoa.m | 78 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index a913a51a2d..4baec0b2ff 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1465,43 +1465,8 @@ - (void)adjustSpeed:(id)sender
 
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
2.17.2 (Apple Git-113)
