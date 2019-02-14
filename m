Received: from eggs.gnu.org ([209.51.188.92]:46375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guEMK-0002Fs-MO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guEG5-0004C0-90
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:28:46 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guEG2-0003rs-9L
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:28:44 -0500
Received: by mail-wm1-x334.google.com with SMTP id j125so5536499wmj.1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 02:28:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 10:28:15 +0000
Message-Id: <20190214102816.3393-7-peter.maydell@linaro.org>
In-Reply-To: <20190214102816.3393-1-peter.maydell@linaro.org>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 6/7] ui/cocoa: Subclass NSApplication so we
 can implement sendEvent
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

When we switch away from our custom event handling, we still want to
be able to have first go at any events our application receives,
because in full-screen mode we want to send key events to the guest,
even if they would be menu item activation events. There are several
ways we could do that, but one simple approach is to subclass
NSApplication so we can implement a custom sendEvent method.
Do that, but for the moment have our sendEvent just invoke the
superclass method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
New patch in v2
---
 ui/cocoa.m | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 5a84e1aea7..184fbd877d 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1478,6 +1478,17 @@ - (void)adjustSpeed:(id)sender
 
 @end
 
+@interface QemuApplication : NSApplication
+@end
+
+@implementation QemuApplication
+- (void)sendEvent:(NSEvent *)event
+{
+    COCOA_DEBUG("QemuApplication: sendEvent\n");
+    [super sendEvent: event];
+}
+@end
+
 static void create_initial_menus(void)
 {
     // Add menus
@@ -1691,7 +1702,7 @@ int main (int argc, const char * argv[]) {
     ProcessSerialNumber psn = { 0, kCurrentProcess };
     TransformProcessType(&psn, kProcessTransformToForegroundApplication);
 
-    [NSApplication sharedApplication];
+    [QemuApplication sharedApplication];
 
     create_initial_menus();
 
-- 
2.17.2 (Apple Git-113)
