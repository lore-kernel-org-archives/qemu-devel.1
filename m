Received: from eggs.gnu.org ([2001:4830:134:3::10]:50526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqyx1-0005C1-9E
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqyww-0006Ov-Id
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:22:35 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cqyww-0006Om-B7
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:22:30 -0400
Received: by mail-wm0-x242.google.com with SMTP id n11so15234265wma.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 02:22:30 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 23 Mar 2017 11:22:11 +0200
Message-Id: <20170323092211.29990-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH qemu-ga v2] qga: Make qemu-ga compile
 statically for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

Attempting to compile qemu-ga statically as follows for Windows causes
the following error:

Compilation:
    ./configure --disable-docs --target-list=x86_64-softmmu \
    --cross-prefix=x86_64-w64-mingw32- --static \
    --enable-guest-agent-msi --with-vss-sdk=/path/to/VSSSDK72

    make -j8 qemu-ga

Error:
    path/to/qemu/stubs/error-printf.c:7: undefined reference to `__imp_g_test_config_vars'
    collect2: error: ld returned 1 exit status
    Makefile:444: recipe for target 'qemu-ga.exe' failed
    make: *** [qemu-ga.exe] Error 1

This is caused by a bug in the pkg-config file for glib as it doesn't define
GLIB_STATIC_COMPILATION for pkg-config --static.

Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
---
 configure | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure b/configure
index b9a30cf..8210494 100755
--- a/configure
+++ b/configure
@@ -3041,6 +3041,13 @@ if test "$modules" = yes; then
     glib_modules="$glib_modules gmodule-2.0"
 fi
 
+# This workaround is required due to a bug in pkg-config file for glib as it
+# doesn't define GLIB_STATIC_COMPILATION for pkg-config --static
+
+if test "$static" = yes -a "$mingw32" = yes; then
+    QEMU_CFLAGS="-DGLIB_STATIC_COMPILATION $QEMU_CFLAGS"
+fi
+
 for i in $glib_modules; do
     if $pkg_config --atleast-version=$glib_req_ver $i; then
         glib_cflags=$($pkg_config --cflags $i)
-- 
2.9.3
