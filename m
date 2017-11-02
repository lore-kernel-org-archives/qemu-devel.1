Received: from eggs.gnu.org ([2001:4830:134:3::10]:47907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eABWB-0007rx-Af
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eABW6-0000Gn-Rj
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:10:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56196
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eABW6-0007bv-LV
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:10:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA294AMQ093152
	for <qemu-devel@nongnu.org>; Thu, 2 Nov 2017 05:09:20 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dywm30wdg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 05:09:20 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 2 Nov 2017 03:09:19 -0600
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu,  2 Nov 2017 07:09:06 -0200
Message-Id: <20171102090906.30391-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5] configure: check $CC available before
 verifying host CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, peter.maydell@linaro.org, f4bug@amsat.org

When executing 'configure' in a fresh QEMU clone, in a fresh
OS install running in a ppc64le host, this is the error
shown:

-----

../configure --enable-trace-backend=simple --enable-debug
    --target-list=ppc64-softmmu

ERROR: Unsupported CPU = ppc64le, try --enable-tcg-interpreter

-----

This isn't true, ppc64le host CPU is supported. This happens because,
in a fresh install, we don't have a C compiler to autodetect
the $cpu variable to "ppc64".

This patch moves the CC available check up a bit, just before verifying
the host CPU. This ensures that we bail out with a $CC not available
error instead of unsupported CPU (the host CPU detection without
the compiler wouldn't work properly anyway). It also allows --help to
keep working without a C compiler. With this patch, in the same ppc64le
host without gcc:

$ ../configure --enable-trace-backend=simple --enable-debug
    --target-list=ppc64-softmmu

ERROR: "cc" either does not exist or does not work

$ ../configure --help

Usage: configure [options]
Options: [defaults in brackets after descriptions]

Standard options:
  --help                   print this message
  --prefix=PREFIX          install in PREFIX [/usr/local]
  --interp-prefix=PREFIX   where to find shared libraries, etc.
(...)

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 configure | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 285d123dbf..e78f07d5d9 100755
--- a/configure
+++ b/configure
@@ -1572,6 +1572,20 @@ fi
 # Suppress writing compiled files
 python="$python -B"
 
+# Check that the C compiler works. Doing this here before testing
+# the host CPU ensures that we had a valid CC to autodetect the
+# $cpu var (and we should bail right here if that's not the case).
+# It also allows the help message to be printed without a CC.
+write_c_skeleton;
+if compile_object ; then
+  : C compiler works ok
+else
+    error_exit "\"$cc\" either does not exist or does not work"
+fi
+if ! compile_prog ; then
+    error_exit "\"$cc\" cannot build an executable (is your linker broken?)"
+fi
+
 # Now we have handled --enable-tcg-interpreter and know we're not just
 # printing the help message, bail out if the host CPU isn't supported.
 if test "$ARCH" = "unknown"; then
@@ -1593,17 +1607,6 @@ if test -z "$werror" ; then
     fi
 fi
 
-# check that the C compiler works.
-write_c_skeleton;
-if compile_object ; then
-  : C compiler works ok
-else
-    error_exit "\"$cc\" either does not exist or does not work"
-fi
-if ! compile_prog ; then
-    error_exit "\"$cc\" cannot build an executable (is your linker broken?)"
-fi
-
 if test "$bogus_os" = "yes"; then
     # Now that we know that we're not printing the help and that
     # the compiler works (so the results of the check_defines we used
-- 
2.13.6
