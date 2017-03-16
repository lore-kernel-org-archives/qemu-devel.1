Received: from eggs.gnu.org ([2001:4830:134:3::10]:41310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jordan.l.justen@intel.com>) id 1coRHI-0002qg-8J
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jordan.l.justen@intel.com>) id 1coRHC-00081i-DY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:55651)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jordan.l.justen@intel.com>)
	id 1coRHC-000816-0f
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:00:54 -0400
From: Jordan Justen <jordan.l.justen@intel.com>
Date: Thu, 16 Mar 2017 02:00:48 -0700
Message-Id: <20170316090048.23185-1-jordan.l.justen@intel.com>
Subject: [Qemu-devel] [PATCH] qemu: Fix -version with configure
 --with-pkgversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jordan Justen <jordan.l.justen@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, 1673373@bugs.launchpad.net

This appears to have regressed in 67a1de0d19.

When the configure --with-pkgversion=foo option is used, the output
from -version will look like:

QEMU emulator version 2.8.90(foo)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

After this patch, it will be:

QEMU emulator version 2.8.90 (foo)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>
Fixes: https://bugs.launchpad.net/bugs/1673373
Cc: 1673373@bugs.launchpad.net
Signed-off-by: Jordan Justen <jordan.l.justen@intel.com>
---
 Makefile  | 2 +-
 configure | 2 +-
 vl.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 1c4c04f6f2..c9df119798 100644
--- a/Makefile
+++ b/Makefile
@@ -289,7 +289,7 @@ qemu-version.h: FORCE
 			printf '"$(PKGVERSION)"\n'; \
 		else \
 			if test -d .git; then \
-				printf '" ('; \
+				printf '"('; \
 				git describe --match 'v*' 2>/dev/null | tr -d '\n'; \
 				if ! git diff-index --quiet HEAD &>/dev/null; then \
 					printf -- '-dirty'; \
diff --git a/configure b/configure
index 99d8bece70..e94b06b5fc 100755
--- a/configure
+++ b/configure
@@ -1004,7 +1004,7 @@ for opt do
   ;;
   --disable-blobs) blobs="no"
   ;;
-  --with-pkgversion=*) pkgversion=" ($optarg)"
+  --with-pkgversion=*) pkgversion="($optarg)"
   ;;
   --with-coroutine=*) coroutine="$optarg"
   ;;
diff --git a/vl.c b/vl.c
index 0b4ed5241c..3e60e61905 100644
--- a/vl.c
+++ b/vl.c
@@ -1904,7 +1904,7 @@ static void main_loop(void)
 
 static void version(void)
 {
-    printf("QEMU emulator version " QEMU_VERSION QEMU_PKGVERSION "\n"
+    printf("QEMU emulator version " QEMU_VERSION " " QEMU_PKGVERSION "\n"
            QEMU_COPYRIGHT "\n");
 }
 
-- 
2.11.0
