Received: from eggs.gnu.org ([2001:4830:134:3::10]:54968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ctnl4-0006YE-6D
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ctnl1-00083l-5X
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:01:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40263
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ctnl1-000837-0M
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:01:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2V4026n021319
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 00:01:50 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29h4ekum8w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 00:01:49 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 30 Mar 2017 22:01:48 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 30 Mar 2017 23:01:09 -0500
In-Reply-To: <1490932869-31217-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490932869-31217-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490932869-31217-3-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL for-2.9 2/2] qga: Make qemu-ga compile
 statically for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sameeh Jubran <sameeh@daynix.com>

From: Sameeh Jubran <sameeh@daynix.com>

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

Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 configure | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure b/configure
index d1ce33b..07018e0 100755
--- a/configure
+++ b/configure
@@ -3066,6 +3066,13 @@ if test "$modules" = yes; then
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
2.7.4
