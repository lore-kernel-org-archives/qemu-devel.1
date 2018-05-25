Received: from eggs.gnu.org ([2001:4830:134:3::10]:38107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fM9vr-00069u-P6
	for qemu-devel@nongnu.org; Fri, 25 May 2018 06:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fM9vp-0005PB-WE
	for qemu-devel@nongnu.org; Fri, 25 May 2018 06:26:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fM9vp-0005L4-Pa
	for qemu-devel@nongnu.org; Fri, 25 May 2018 06:26:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 11:26:36 +0100
Message-Id: <20180525102636.13136-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] ui/cocoa: Suppress NSFileHandlingPanelOKButton
 deprecation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>

OSX 10.13 deprecates the NSFileHandlingPanelOKButton constant, and
would rather you use NSModalResponseOK, which was introduced in OS 10.9.
Use the recommended new constant name, with a backward compatibility
define if we're building on an older OSX.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Tested on 10.13; I don't hvae anything older to test on.

 ui/cocoa.m | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 110b393e4e..f5ecd66fd3 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -79,6 +79,13 @@
 #define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask
 #define NSWindowStyleMaskTitled         NSTitledWindowMask
 #endif
+/* 10.13 deprecates NSFileHandlingPanelOKButton in favour of
+ * NSModalResponseOK, which was introduced in 10.9. Define
+ * it for older versions.
+ */
+#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_9
+#define NSModalResponseOK NSFileHandlingPanelOKButton
+#endif
 
 //#define DEBUG
 
@@ -1218,7 +1225,7 @@ QemuCocoaView *cocoaView;
     [openPanel setCanChooseFiles: YES];
     [openPanel setAllowsMultipleSelection: NO];
     [openPanel setAllowedFileTypes: supportedImageFileTypes];
-    if([openPanel runModal] == NSFileHandlingPanelOKButton) {
+    if([openPanel runModal] == NSModalResponseOK) {
         NSString * file = [[[openPanel URLs] objectAtIndex: 0] path];
         if(file == nil) {
             NSBeep();
-- 
2.17.0
