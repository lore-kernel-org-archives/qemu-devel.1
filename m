Received: from eggs.gnu.org ([2001:4830:134:3::10]:60704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dimMW-0004dM-0C
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dimMS-0002hN-UJ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:51:16 -0400
Received: from mail-by2nam01on0051.outbound.protection.outlook.com
	([104.47.34.51]:9952
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dimMS-0002gl-Gf
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:51:12 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 18 Aug 2017 11:47:35 -0700
Message-ID: <2c94ac3bb116cc6b8ebbcd66a254920a69665515.1503077821.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1503077821.git.alistair.francis@xilinx.com>
References: <cover.1503077821.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 2/2] Convert remaining single line fprintf()
 to warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, pbonzini@redhat.com

Convert any remaining uses of fprintf(stderr, "warning:"...
to use warn_report() instead. This helps standardise on a single
method of printing warnings to the user.

All of the warnings were changed using this command:
  find ./* -type f -exec sed -i 's|fprintf(.*".*warning[,:] |warn_report("|Ig' {} +

The #include lines and chagnes to the test Makefile were manually
updated to allow the code to compile.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
This was split out of my original series fixing QEMU warnings.

 tests/Makefile.include | 2 +-
 util/cutils.c          | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 80527a8763..91d5a4544f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -584,7 +584,7 @@ tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
 tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
-tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
+tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-obj-y)
 tests/test-int128$(EXESUF): tests/test-int128.o
 tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
 tests/test-rcu-list$(EXESUF): tests/test-rcu-list.o $(test-util-obj-y)
diff --git a/util/cutils.c b/util/cutils.c
index 1534682083..b33ede83d1 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -30,6 +30,7 @@
 #include "qemu/iov.h"
 #include "net/net.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 
 void strpadcpy(char *buf, int buf_size, const char *str, char pad)
 {
@@ -601,7 +602,7 @@ int parse_debug_env(const char *name, int max, int initial)
         return initial;
     }
     if (debug < 0 || debug > max || errno != 0) {
-        fprintf(stderr, "warning: %s not in [0, %d]", name, max);
+        warn_report("%s not in [0, %d]", name, max);
         return initial;
     }
     return debug;
-- 
2.11.0
