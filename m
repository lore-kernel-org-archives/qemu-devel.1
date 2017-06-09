Received: from eggs.gnu.org ([2001:4830:134:3::10]:60021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dJLQW-0000Ck-Er
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dJLQR-0007QX-PE
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:02:16 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:34752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dJLQR-0007PS-IG
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:02:11 -0400
Received: by mail-io0-x244.google.com with SMTP id a96so5812187ioj.1
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 08:02:08 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 9 Jun 2017 11:02:04 -0400
Message-Id: <659939DD-F3BB-4FB9-B242-E0BB624EFED8@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Qemu-devel] [PATCH v2] ui/cocoa.m: add Speed menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

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
v2 changes:
Fixed missing space with 'if' and 'for' structures.
Fixed tab damage.
Use loop to create menu items.
Changed name of menu items to use percentages.
Use tags to determine selected menu item.

 ui/cocoa.m | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 26d4a1c..772629e 100644
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
@@ -828,6 +829,7 @@ QemuCocoaView *cocoaView;
 - (void)openDocumentation:(NSString *)filename;
 - (IBAction) do_about_menu_item: (id) sender;
 - (void)make_about_window;
+- (void)adjustSpeed:(id)sender;
 @end
=20
 @implementation QemuCocoaAppController
@@ -1234,6 +1236,35 @@ QemuCocoaView *cocoaView;
     [superView addSubview: copyright_label];
 }
=20
+/* Used by the Speed menu items */
+- (void)adjustSpeed:(id)sender
+{
+    int speed, menu_number, count, item;
+    NSMenu *menu;
+    NSArray *itemArray;
+
+    // uncheck all the menu items in the Speed menu
+    menu =3D [sender menu];
+    if (menu !=3D nil)
+    {
+        count =3D [[menu itemArray] count];
+        itemArray =3D [menu itemArray];
+        for (item =3D 0; item < count; item++)  // unselect each item
+            [[itemArray objectAtIndex: item] setState: NSOffState];
+    }
+
+    // check the menu item
+    [sender setState: NSOnState];
+
+    // get the menu number
+    menu_number =3D [sender tag];
+
+    /* Calculate the speed */
+    speed =3D -1 * menu_number + 100;
+    cpu_throttle_set(speed);
+    COCOA_DEBUG("cpu throttling at %d%c\n", =
cpu_throttle_get_percentage(), '%');
+}
+
 @end
=20
=20
@@ -1316,6 +1347,29 @@ int main (int argc, const char * argv[]) {
     [menuItem setSubmenu:menu];
     [[NSApp mainMenu] addItem:menuItem];
=20
+    // Speed menu
+    menu =3D [[NSMenu alloc] initWithTitle:@"Speed"];
+
+    // The 100% menu item has to be checked at the start
+    menuItem =3D [[[NSMenuItem alloc] initWithTitle:@"100%" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease];
+    [menuItem setTag: 100];
+    [menuItem setState: NSOnState];
+    [menu addItem: menuItem];
+
+    // Add the rest of the menu items
+    int p, percentage;
+    for (p =3D 9; p >=3D 0; p--)
+    {
+        percentage =3D p * 10 > 1 ? p * 10 : 1; // prevent a 0% menu =
item
+        menuItem =3D [[[NSMenuItem alloc]
+                   initWithTitle: [NSString stringWithFormat: @"%d%c", =
percentage, '%'] action:@selector(adjustSpeed:) keyEquivalent:@""] =
autorelease];
+        [menuItem setTag: percentage];
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
