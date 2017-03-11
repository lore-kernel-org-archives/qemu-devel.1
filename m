Received: from eggs.gnu.org ([2001:4830:134:3::10]:58334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cmq1g-0000S5-UQ
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 18:02:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cmq1f-0000pJ-5Y
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 18:02:17 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cmq1f-0000pC-13
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 18:02:15 -0500
Received: by mail-pf0-x244.google.com with SMTP id 67so14859878pfg.2
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 15:02:14 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 11 Mar 2017 15:01:53 -0800
Message-Id: <1489273313-22628-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: fix semihosting argc/argv
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

So far xtensa provides fixed dummy argc/argv for the corresponding
semihosting calls. Now that there are semihosting_get_argc and
semihosting_get_arg, use them to pass actual command line arguments
to guest.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/xtensa-semi.c | 49 +++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 370e365..a888a9d 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "exec/semihost.h"
 #include "qemu/log.h"
 
 enum {
@@ -261,28 +262,50 @@ void HELPER(simcall)(CPUXtensaState *env)
         break;
 
     case TARGET_SYS_argc:
-        regs[2] = 1;
+        regs[2] = semihosting_get_argc();
         regs[3] = 0;
         break;
 
     case TARGET_SYS_argv_sz:
-        regs[2] = 128;
-        regs[3] = 0;
+        {
+            int argc = semihosting_get_argc();
+            int sz = (argc + 1) * sizeof(uint32_t);
+            int i;
+
+            for (i = 0; i < argc; ++i) {
+                sz += 1 + strlen(semihosting_get_arg(i));
+            }
+            regs[2] = sz;
+            regs[3] = 0;
+        }
         break;
 
     case TARGET_SYS_argv:
         {
-            struct Argv {
-                uint32_t argptr[2];
-                char text[120];
-            } argv = {
-                {0, 0},
-                "test"
-            };
-
-            argv.argptr[0] = tswap32(regs[3] + offsetof(struct Argv, text));
+            int argc = semihosting_get_argc();
+            int str_offset = (argc + 1) * sizeof(uint32_t);
+            int i;
+            uint32_t argptr;
+
+            for (i = 0; i < argc; ++i) {
+                const char *str = semihosting_get_arg(i);
+                int str_size = strlen(str) + 1;
+
+                argptr = tswap32(regs[3] + str_offset);
+
+                cpu_memory_rw_debug(cs,
+                                    regs[3] + i * sizeof(uint32_t),
+                                    (uint8_t *)&argptr, sizeof(argptr), 1);
+                cpu_memory_rw_debug(cs,
+                                    regs[3] + str_offset,
+                                    (uint8_t *)str, str_size, 1);
+                str_offset += str_size;
+            }
+            argptr = 0;
             cpu_memory_rw_debug(cs,
-                                regs[3], (uint8_t *)&argv, sizeof(argv), 1);
+                                regs[3] + i * sizeof(uint32_t),
+                                (uint8_t *)&argptr, sizeof(argptr), 1);
+            regs[3] = 0;
         }
         break;
 
-- 
2.1.4
