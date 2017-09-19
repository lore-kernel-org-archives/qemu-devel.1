Received: from eggs.gnu.org ([2001:4830:134:3::10]:60349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfi-0004Wp-7L
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfc-0005ft-KS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:38 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfc-0005eH-Ed
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:32 -0400
Received: by mail-wr0-x241.google.com with SMTP id g50so2141883wra.3
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:29 +0200
Message-Id: <1505824179-21541-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/50] Convert remaining single line fprintf()
 to warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Convert any remaining uses of fprintf(stderr, "warning:"...
to use warn_report() instead. This helps standardise on a single
method of printing warnings to the user.

All of the warnings were changed using this command:
  find ./* -type f -exec sed -i 's|fprintf(.*".*warning[,:] |warn_report("|Ig' {} +

The #include lines and chagnes to the test Makefile were manually
updated to allow the code to compile.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <2c94ac3bb116cc6b8ebbcd66a254920a69665515.1503077821.git.alistair.francis@xilinx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 2 +-
 util/cutils.c          | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2136036..0c64462 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -593,7 +593,7 @@ tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
 tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
-tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
+tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-obj-y)
 tests/test-int128$(EXESUF): tests/test-int128.o
 tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
 tests/test-rcu-list$(EXESUF): tests/test-rcu-list.o $(test-util-obj-y)
diff --git a/util/cutils.c b/util/cutils.c
index 1534682..b33ede8 100644
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
1.8.3.1
