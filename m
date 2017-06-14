Received: from eggs.gnu.org ([2001:4830:134:3::10]:56585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dKyoU-0002fR-CJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dKyoR-0006n6-81
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:17:46 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:33870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dKyoR-0006mb-1n
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:17:43 -0400
Received: by mail-it0-x244.google.com with SMTP id 201so14557248itu.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 20:17:41 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 23:17:38 -0400
Message-Id: <D6FAAABF-064D-49C0-B572-C73679F34052@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Qemu-devel] [PATCH v3] ui/cocoa.m: add Speed menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Programs running inside of QEMU can sometimes use more CPU time than is =
really
needed. To solve this problem, we just need to throttle the virtual CPU. =
This
feature will stop laptops from burning up.=20

This patch adds a menu called Speed that has menu items from 100% to 1% =
that
represent the speed options. 100% is full speed and 1% is slowest.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v3 changes:
Changed the item deselection loop.
Moved speed calculation equation to main function.
Replaced "%c" with "%%".
Changed how 100% menu item is made.

v2 changes:
Fixed missing space with 'if' and 'for' structures.
Fixed tab damage.
Use loop to create menu items.
Changed name of menu items to use percentages.
Use tags to determine selected menu item.

 ui/cocoa.m | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 004ec27..a866a66 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -35,6 +35,7 @@
 #include "sysemu/blockdev.h"
 #include "qemu-version.h"
 #include <Carbon/Carbon.h>
+#include "qom/cpu.h"
=20
 #ifndef MAC_OS_X_VERSION_10_5
 #define MAC_OS_X_VERSION_10_5 1050
@@ -857,6 +858,7 @@ QemuCocoaView *cocoaView;
 - (void)openDocumentation:(NSString *)filename;
 - (IBAction) do_about_menu_item: (id) sender;
 - (void)make_about_window;
+- (void)adjustSpeed:(id)sender;
 @end
=20
 @implementation QemuCocoaAppController
@@ -1263,6 +1265,34 @@ QemuCocoaView *cocoaView;
     [superView addSubview: copyright_label];
 }
=20
+/* Used by the Speed menu items */
+- (void)adjustSpeed:(id)sender
+{
+    int throttle_pct; /* throttle percentage */
+    NSMenu *menu;
+
+    menu =3D [sender menu];
+    if (menu !=3D nil)
+    {
+        /* Unselect the currently selected item */
+        for (NSMenuItem *item in [menu itemArray]) {
+            if (item.state =3D=3D NSOnState) {
+                [item setState: NSOffState];
+                break;
+            }
+        }
+    }
+
+    // check the menu item
+    [sender setState: NSOnState];
+
+    // get the throttle percentage
+    throttle_pct =3D [sender tag];
+
+    cpu_throttle_set(throttle_pct);
+    COCOA_DEBUG("cpu throttling at %d%c\n", =
cpu_throttle_get_percentage(), '%');
+}
+
 @end
=20
=20
@@ -1345,6 +1375,31 @@ int main (int argc, const char * argv[]) {
     [menuItem setSubmenu:menu];
     [[NSApp mainMenu] addItem:menuItem];
=20
+    // Speed menu
+    menu =3D [[NSMenu alloc] initWithTitle:@"Speed"];
+
+    // Add the rest of the Speed menu items
+    int p, percentage, throttle_pct;
+    for (p =3D 10; p >=3D 0; p--)
+    {
+        percentage =3D p * 10 > 1 ? p * 10 : 1; // prevent a 0% menu =
item
+
+        if (percentage =3D=3D 100) {
+            [menuItem setState: NSOnState];
+        }
+        menuItem =3D [[[NSMenuItem alloc]
+                   initWithTitle: [NSString stringWithFormat: @"%d%%", =
percentage] action:@selector(adjustSpeed:) keyEquivalent:@""] =
autorelease];
+
+        /* Calculate the throttle percentage */
+        throttle_pct =3D -1 * percentage + 100;
+
+        [menuItem setTag: throttle_pct];
+        [menu addItem: menuItem];
+    }
+    menuItem =3D [[[NSMenuItem alloc] initWithTitle:@"Speed" action:nil =
keyEquivalent:@""] autorelease];
+    [menuItem setSubmenu:menu];
+    [[NSApp mainMenu] addItem:menuItem];
+
     // Window menu
     menu =3D [[NSMenu alloc] initWithTitle:@"Window"];
     [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Minimize" =
action:@selector(performMiniaturize:) keyEquivalent:@"m"] autorelease]]; =
// Miniaturize
--=20
2.7.2
