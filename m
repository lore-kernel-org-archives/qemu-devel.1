Received: from eggs.gnu.org ([2001:4830:134:3::10]:56664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yPY-0004sx-BM
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yPT-0004HA-7e
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:10:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54068
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9yPT-0004GT-1z
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:10:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA1J9QK5058851
	for <qemu-devel@nongnu.org>; Wed, 1 Nov 2017 15:10:40 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dyj5dxemk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 15:10:40 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 1 Nov 2017 15:10:39 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed,  1 Nov 2017 17:10:30 -0200
Message-Id: <20171101191030.16136-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] configure: adding ppc64le to supported host
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, peter.maydell@linaro.org

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

Since we need a C compiler to properly get the value of $cpu
in this and other cases, this patch changes the location of the C
compiler check right after setting the preferred CC.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 configure | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 285d123dbf..5a4e0f0468 100755
--- a/configure
+++ b/configure
@@ -467,6 +467,17 @@ else
   cc="${CC-${cross_prefix}gcc}"
 fi
 
+# check that the C compiler works.
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
 if test -z "${CXX}${cross_prefix}"; then
   cxx="c++"
 else
@@ -1593,17 +1604,6 @@ if test -z "$werror" ; then
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
