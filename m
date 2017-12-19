Received: from eggs.gnu.org ([2001:4830:134:3::10]:60119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eREsm-0002m3-4m
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eREsg-0008Fd-2J
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:12:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1eREsf-0008En-QI
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:12:13 -0500
From: Yoni Bettan <ybettan@redhat.com>
Date: Tue, 19 Dec 2017 12:11:22 +0200
Message-Id: <20171219101122.31711-1-ybettan@redhat.com>
Subject: [Qemu-devel] [PATCH V3] vl.c && linux-user/main.c : removed **envp
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

it was added on 2008 902b3d5c39 when introduced cache-utils.[ch]

since then cache-utils.[ch] were removed but **envp was left
behind.

By the way "to be portable it is best to write main to take two
arguments, and use the value of environ" according to
https://www.gnu.org/software/libc/manual/html_node/Program-\
      Arguments.html#Program-Arguments

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
---

V2 -> V3:
    
    since ui/cocoa.c rename main() is using qemu_main() ,because it uses it 
    inside its main() function, the function qemu_main() can't be removed
  

V1 -> V2:

    removed the ui/cocoa.c renaming of main() function since i thought that we 
    no longer need qemu_main()


 include/qemu-common.h | 2 +-
 linux-user/main.c     | 2 +-
 ui/cocoa.m            | 5 ++---
 vl.c                  | 7 +++----
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 05319b9ddc..8a5b7ec5ec 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -29,7 +29,7 @@
 
 /* main function, renamed */
 #if defined(CONFIG_COCOA)
-int qemu_main(int argc, char **argv, char **envp);
+int qemu_main(int argc, char **argv);
 #endif
 
 void qemu_get_timedate(struct tm *tm, int offset);
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
index 330ccebf90..4d18153659 100644
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
+    status = qemu_main(argc, argv);
     exit(status);
 }
 
@@ -1391,7 +1390,7 @@ int main (int argc, const char * argv[]) {
                 !strcmp(opt, "-curses") ||
                 !strcmp(opt, "-display") ||
                 !strcmp(opt, "-qtest")) {
-                return qemu_main(gArgc, gArgv, *_NSGetEnviron());
+                return qemu_main(gArgc, gArgv);
             }
         }
     }
diff --git a/vl.c b/vl.c
index fc8bd9372f..ea17cc34f6 100644
--- a/vl.c
+++ b/vl.c
@@ -35,10 +35,10 @@
 #ifdef CONFIG_SDL
 #if defined(__APPLE__) || defined(main)
 #include <SDL.h>
-int qemu_main(int argc, char **argv, char **envp);
+int qemu_main(int argc, char **argv);
 int main(int argc, char **argv)
 {
-    return qemu_main(argc, argv, NULL);
+    return qemu_main(argc, argv);
 }
 #undef main
 #define main qemu_main
@@ -50,7 +50,6 @@ int main(int argc, char **argv)
 #define main qemu_main
 #endif /* CONFIG_COCOA */
 
-
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "hw/hw.h"
@@ -3044,7 +3043,7 @@ static void register_global_properties(MachineState *ms)
     user_register_global_props();
 }
 
-int main(int argc, char **argv, char **envp)
+int main(int argc, char **argv)
 {
     int i;
     int snapshot, linux_boot;
-- 
2.14.3
