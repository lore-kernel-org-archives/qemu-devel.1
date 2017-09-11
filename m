Received: from eggs.gnu.org ([2001:4830:134:3::10]:40022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1drUpE-0006JU-4c
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1drUpA-0002KR-7u
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:56 -0400
Received: from mail-co1nam03on0045.outbound.protection.outlook.com
	([104.47.40.45]:30592
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1drUp9-0002Je-ST
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:52 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 11 Sep 2017 12:53:05 -0700
Message-ID: <ecdb8767affbfab3ea963169607981dcf0571140.1505158760.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1505158760.git.alistair.francis@xilinx.com>
References: <cover.1505158760.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 8/8] Convert remaining single line fprintf()
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, pbonzini@redhat.com

Convert any remaining uses of fprintf(stderr, "warning:"...
to use warn_report() instead. This helps standardise on a single
method of printing warnings to the user.

All of the warnings were changed using this command:
  find ./* -type f -exec sed -i 's|fprintf(.*".*warning[,:] |warn_report("|=
Ig' {} +

The #include line and the change to the test Makefile were manually
updated to allow the code to compile.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---

This pattern matches any case of fprintf(stderr, "warning:"... and is
the most open pattern match in the series.


 tests/Makefile.include | 2 +-
 util/cutils.c          | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3d6726e95c..2647aaaa65 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -593,7 +593,7 @@ tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-o=
bj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(tes=
t-crypto-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
 tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migrati=
on/page_cache.o $(test-util-obj-y)
-tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
+tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-=
obj-y)
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
=20
 void strpadcpy(char *buf, int buf_size, const char *str, char pad)
 {
@@ -601,7 +602,7 @@ int parse_debug_env(const char *name, int max, int init=
ial)
         return initial;
     }
     if (debug < 0 || debug > max || errno !=3D 0) {
-        fprintf(stderr, "warning: %s not in [0, %d]", name, max);
+        warn_report("%s not in [0, %d]", name, max);
         return initial;
     }
     return debug;
--=20
2.11.0
