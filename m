Received: from eggs.gnu.org ([2001:4830:134:3::10]:37705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cMeRl-0002jn-Fb
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 12:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cMeRi-0008ON-BH
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 12:24:57 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cMeRi-0008OE-67
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 12:24:54 -0500
Received: by mail-io0-x244.google.com with SMTP id m204so13857406ioe.3
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 09:24:54 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Dec 2016 12:24:50 -0500
Message-Id: <E14D0C7B-2C4B-4D29-AC31-A651AB7573DE@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Qemu-devel] [PATCH] ui/cocoa.m: add Speed menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

Programs running inside of QEMU can sometimes use more CPU time than is =
really
needed. To solve this problem, we just need to throttle the virtual CPU. =
This
feature will stop laptops from burning up.=20

This patch adds a menu called Speed that has menu items from 10 to 1. =
They
represent the speed options. 10 is full speed and 1 is slowest.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 56 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 26d4a1c..293e910 100644
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
@@ -1234,6 +1236,41 @@ QemuCocoaView *cocoaView;
     [superView addSubview: copyright_label];
 }
=20
+/* Used by the Speed menu items */
+- (void)adjustSpeed:(id)sender
+{
+    /* 10 has two digits in it - plus the NULL termination at the end =
*/
+    const int max_title_size =3D 3;
+    char menu_item_title[max_title_size];
+    int speed, menu_number, count, item;
+    NSMenu *menu;
+    NSArray *itemArray;
+
+    // uncheck all the menu items in the Speed menu
+    menu =3D [sender menu];
+	if(menu !=3D nil)
+	{
+		count =3D [[menu itemArray] count];
+		itemArray =3D [menu itemArray];
+		for(item =3D 0; item < count; item++)  // unselect each =
item
+			[[itemArray objectAtIndex: item] setState: =
NSOffState];
+	}
+
+    // check the menu item
+    [sender setState: NSOnState];
+
+    // get the menu number
+    snprintf(menu_item_title, max_title_size, "%s", [[sender title] =
cStringUsingEncoding: NSASCIIStringEncoding]);
+    sscanf(menu_item_title, "%d", &menu_number);
+
+     /* Calculate the speed */
+    // inverse relationship between menu item number and speed
+    speed =3D -1 * menu_number + 10;
+    speed =3D speed * 10;
+    cpu_throttle_set(speed);
+    COCOA_DEBUG("cpu throttling at %d%c\n", =
cpu_throttle_get_percentage(), '%');
+}
+
 @end
=20
=20
@@ -1316,6 +1353,25 @@ int main (int argc, const char * argv[]) {
     [menuItem setSubmenu:menu];
     [[NSApp mainMenu] addItem:menuItem];
=20
+    // Speed menu
+    menu =3D [[NSMenu alloc] initWithTitle:@"Speed"];
+    menuItem =3D [[[NSMenuItem alloc] initWithTitle:@"10 (fastest)" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease];
+    [menuItem setState: NSOnState];
+    [menu addItem: menuItem];
+    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"9" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
+    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"8" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
+    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"7" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
+    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"6" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
+    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"5" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
+    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"4" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
+    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"3" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
+    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"2" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
+    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"1" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
+    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"0 (slowest)" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
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
