Received: from eggs.gnu.org ([2001:4830:134:3::10]:48299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVl-0005RX-3f
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVh-0006X2-48
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:09 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:42125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVg-0006WQ-Rm
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:05 -0500
Received: by mail-wr0-x229.google.com with SMTP id k9so20878858wre.9
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:21 +0100
Message-Id: <1520342370-123606-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/34] Fixing WHPX casing to match SDK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Justin Terry (VM)" <juterry@microsoft.com>

From: "Justin Terry (VM) via Qemu-devel" <qemu-devel@nongnu.org>

Fixes an issue where the SDK that was releases had a different casing for the
*.h and *.lib files causing a build break if linked directly from Windows Kits.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1519665216-1078-2-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
---
 configure              | 10 +++++-----
 target/i386/whpx-all.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index ebbda23..6f3921c 100755
--- a/configure
+++ b/configure
@@ -2486,20 +2486,20 @@ fi
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
index 0015b27..eeee43e 100644
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
1.8.3.1
