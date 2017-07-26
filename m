Received: from eggs.gnu.org ([2001:4830:134:3::10]:36644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1daOuH-0007Ry-JB
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1daOuD-0004J8-D1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:11:29 -0400
Received: from mail-bn3nam01on0063.outbound.protection.outlook.com
	([104.47.33.63]:18400
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1daOuD-0004ID-5p
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:11:25 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 26 Jul 2017 09:07:59 -0700
Message-ID: <0b0baf0b0f0132a615e20fb7944d7cecac23933a.1501084908.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1501084908.git.alistair.francis@xilinx.com>
References: <cover.1501084908.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 5/5] Convert single line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Convert any remaining uses of fprintf(stderr, "warning:"...
to use warn_report() instead. This helps standardise on a single
method of printing warnings to the user.

All of the warnings were changed using this command:
  find ./* -type f -exec sed -i 's|fprintf(.*".*warning[,:] |warn_report("|Ig' {} +

The #include lines and chagnes to the test Makefile were manually
updated to allow the code to compile.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 tests/Makefile.include | 4 ++--
 util/cutils.c          | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7af278db55..4886caf565 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -560,8 +560,8 @@ tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
-tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
-tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
+tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-qom-obj-y)
+tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-qom-obj-y)
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
