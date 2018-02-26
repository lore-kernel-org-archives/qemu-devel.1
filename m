Received: from eggs.gnu.org ([2001:4830:134:3::10]:46323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLr-0007IP-RU
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLo-0004dA-1K
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:11 -0500
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com
	([104.47.36.115]:20112
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1eqMLn-0004c7-Rf
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:07 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 26 Feb 2018 09:13:29 -0800
Message-Id: <1519665216-1078-2-git-send-email-juterry@microsoft.com>
In-Reply-To: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
References: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/8] Fixing WHPX casing to match SDK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

Fixes an issue where the SDK that was releases had a different casing for the
*.h and *.lib files causing a build break if linked directly from Windows Kits.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 configure              | 10 +++++-----
 target/i386/whpx-all.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 39f3a43001..220b9ce52b 100755
--- a/configure
+++ b/configure
@@ -2475,20 +2475,20 @@ fi
 if test "$whpx" != "no" ; then
     cat > $TMPC << EOF
 #include <windows.h>
-#include <winhvplatform.h>
-#include <winhvemulation.h>
+#include <WinHvPlatform.h>
+#include <WinHvEmulation.h>
 int main(void) {
     WHV_CAPABILITY whpx_cap;
     WHvGetCapability(WHvCapabilityCodeFeatures, &whpx_cap, sizeof(whpx_cap));
     return 0;
 }
 EOF
-    if compile_prog "" "-lwinhvplatform -lwinhvemulation" ; then
-        libs_softmmu="$libs_softmmu -lwinhvplatform -lwinhvemulation"
+    if compile_prog "" "-lWinHvPlatform -lWinHvEmulation" ; then
+        libs_softmmu="$libs_softmmu -lWinHvPlatform -lWinHvEmulation"
         whpx="yes"
     else
         if test "$whpx" = "yes"; then
-            feature_not_found "winhvplatform" "winhvemulation is not installed"
+            feature_not_found "WinHvPlatform" "WinHvEmulation is not installed"
         fi
         whpx="no"
     fi
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 0015b27509..eeee43e187 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -26,8 +26,8 @@
 #include "qapi/error.h"
 #include "migration/blocker.h"
 
-#include <winhvplatform.h>
-#include <winhvemulation.h>
+#include <WinHvPlatform.h>
+#include <WinHvEmulation.h>
 
 struct whpx_state {
     uint64_t mem_quota;
-- 
2.13.6
