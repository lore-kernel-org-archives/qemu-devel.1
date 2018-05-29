Received: from eggs.gnu.org ([2001:4830:134:3::10]:42792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fNj2v-00045c-34
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fNj2r-0005bX-AH
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:08:33 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:37154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fNj2r-0005bC-5J
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:08:29 -0400
Received: by mail-it0-x241.google.com with SMTP id l6-v6so6402313iti.2
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 11:08:29 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Tue, 29 May 2018 14:08:13 -0400
Message-Id: <20180529180813.2647-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] ui/cocoa.m: Suppress
 NSFileHandlingPanelOKButton depreciation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, patches@linaro.org
Cc: John Arbuckle <programmingkidx@gmail.com>

OSX 10.13 deprecates the NSFileHandlingPanelOKButton constant, and
would rather you use NSModalResponseOK, which was introduced in OS 10.9.
Use the recommended new constant name, with a backward compatibility
define if we're building on an older OSX.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 110b393..c9473f0 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -79,6 +79,13 @@
 #define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask
 #define NSWindowStyleMaskTitled         NSTitledWindowMask
 #endif
+/* 10.13 deprecates NSFileHandlingPanelOKButton in favor of
+ * NSModalResponseOK, which was introduced in 10.9. Define
+ * it for older versions.
+ */
+#if !defined MAC_OS_X_VERSION_10_9 || MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_9
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
2.10.2
