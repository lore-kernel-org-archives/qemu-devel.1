Received: from eggs.gnu.org ([209.51.188.92]:52520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qn4-0004Qb-2T
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qn2-0005lF-8G
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:10 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:40940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0qn2-0005ke-19
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:08 -0500
Received: by mail-wr1-x42d.google.com with SMTP id q1so6331569wrp.7
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 08:50:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	x74sm7238018wmf.22.2019.03.04.08.50.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Mar 2019 08:50:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Mar 2019 16:49:57 +0000
Message-Id: <20190304164958.9362-7-peter.maydell@linaro.org>
In-Reply-To: <20190304164958.9362-1-peter.maydell@linaro.org>
References: <20190304164958.9362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/7] ui/cocoa: Subclass NSApplication so we can
 implement sendEvent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When we switch away from our custom event handling, we still want to
be able to have first go at any events our application receives,
because in full-screen mode we want to send key events to the guest,
even if they would be menu item activation events. There are several
ways we could do that, but one simple approach is to subclass
NSApplication so we can implement a custom sendEvent method.
Do that, but for the moment have our sendEvent just invoke the
superclass method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-id: 20190225102433.22401-7-peter.maydell@linaro.org
Message-id: 20190214102816.3393-7-peter.maydell@linaro.org
---
 ui/cocoa.m | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 1b54d42aba6..00e3db69c91 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1482,6 +1482,17 @@ QemuCocoaView *cocoaView;
 
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
@@ -1695,7 +1706,7 @@ int main (int argc, const char * argv[]) {
     ProcessSerialNumber psn = { 0, kCurrentProcess };
     TransformProcessType(&psn, kProcessTransformToForegroundApplication);
 
-    [NSApplication sharedApplication];
+    [QemuApplication sharedApplication];
 
     create_initial_menus();
 
-- 
2.20.1
