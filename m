Received: from eggs.gnu.org ([2001:4830:134:3::10]:44245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eQusF-0003Wq-0I
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eQusA-00054c-Ru
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:50:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1eQusA-00052g-6w
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:50:22 -0500
From: Yoni Bettan <ybettan@redhat.com>
Date: Mon, 18 Dec 2017 14:49:42 +0200
Message-Id: <20171218124943.28529-1-ybettan@redhat.com>
Subject: [Qemu-devel] [PATCH V2] vl.c && linux-user/main.c : removed **envp
 from main() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoni Bettan <ybettan@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

         * it was added on 2008 902b3d5c392bb6f48ef340ad8ecc3311705d2800
           when introduced cache-utils.[ch]

         * since then cache-utils.[ch] were removed but **envp was left
           behind

        * by the way "to be portable it is best to write main to take two
          arguments, and use the value of environ" according to
          https://www.gnu.org/software/libc/manual/html_node/Program-\
                Arguments.html#Program-Arguments

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
---
 include/qemu-common.h |  5 -----
 linux-user/main.c     |  2 +-
 ui/cocoa.m            |  5 ++---
 vl.c                  | 15 +--------------
 4 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 05319b9ddc..e1bc8690c9 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -27,11 +27,6 @@
     "See <https://qemu.org/contribute/report-a-bug> for how to report bugs.\n" \
     "More information on the QEMU project at <https://qemu.org>."
 
-/* main function, renamed */
-#if defined(CONFIG_COCOA)
-int qemu_main(int argc, char **argv, char **envp);
-#endif
-
 void qemu_get_timedate(struct tm *tm, int offset);
 int qemu_timedate_diff(struct tm *tm);
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 6286661bd3..fe81d410da 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4237,7 +4237,7 @@ static int parse_args(int argc, char **argv)
     return optind;
 }
 
-int main(int argc, char **argv, char **envp)
+int main(int argc, char **argv)
 {
     struct target_pt_regs regs1, *regs = &regs1;
     struct image_info info1, *info = &info1;
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 330ccebf90..851a2dcd06 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 
 #import <Cocoa/Cocoa.h>
-#include <crt_externs.h>
 
 #include "qemu-common.h"
 #include "ui/console.h"
@@ -1050,7 +1049,7 @@ QemuCocoaView *cocoaView;
     COCOA_DEBUG("QemuCocoaAppController: startEmulationWithArgc\n");
 
     int status;
-    status = qemu_main(argc, argv, *_NSGetEnviron());
+    status = main(argc, argv);
     exit(status);
 }
 
@@ -1391,7 +1390,7 @@ int main (int argc, const char * argv[]) {
                 !strcmp(opt, "-curses") ||
                 !strcmp(opt, "-display") ||
                 !strcmp(opt, "-qtest")) {
-                return qemu_main(gArgc, gArgv, *_NSGetEnviron());
+                return main(gArgc, gArgv);
             }
         }
     }
diff --git a/vl.c b/vl.c
index fc8bd9372f..d862ec292d 100644
--- a/vl.c
+++ b/vl.c
@@ -35,22 +35,9 @@
 #ifdef CONFIG_SDL
 #if defined(__APPLE__) || defined(main)
 #include <SDL.h>
-int qemu_main(int argc, char **argv, char **envp);
-int main(int argc, char **argv)
-{
-    return qemu_main(argc, argv, NULL);
-}
-#undef main
-#define main qemu_main
 #endif
 #endif /* CONFIG_SDL */
 
-#ifdef CONFIG_COCOA
-#undef main
-#define main qemu_main
-#endif /* CONFIG_COCOA */
-
-
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "hw/hw.h"
@@ -3044,7 +3031,7 @@ static void register_global_properties(MachineState *ms)
     user_register_global_props();
 }
 
-int main(int argc, char **argv, char **envp)
+int main(int argc, char **argv)
 {
     int i;
     int snapshot, linux_boot;
-- 
2.14.3
