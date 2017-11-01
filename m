Received: from eggs.gnu.org ([2001:4830:134:3::10]:33469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yjo-0004L4-Eh
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yjk-0001UH-AS
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:31:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44312
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9yjk-0001TS-5Q
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:31:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA1JTW7U121563
	for <qemu-devel@nongnu.org>; Wed, 1 Nov 2017 15:31:36 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dyj5dydgd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 15:31:35 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 1 Nov 2017 15:31:35 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed,  1 Nov 2017 17:31:26 -0200
Message-Id: <20171101193126.19730-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4] configure: do CC check before verifying
 host CPU
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
 configure | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index 285d123dbf..a641bf18b6 100755
--- a/configure
+++ b/configure
@@ -467,6 +467,23 @@ else
   cc="${CC-${cross_prefix}gcc}"
 fi
 
+write_c_skeleton() {
+    cat > $TMPC <<EOF
+int main(void) { return 0; }
+EOF
+}
+
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
@@ -537,12 +554,6 @@ EOF
   compile_object
 }
 
-write_c_skeleton() {
-    cat > $TMPC <<EOF
-int main(void) { return 0; }
-EOF
-}
-
 if check_define __linux__ ; then
   targetos="Linux"
 elif check_define _WIN32 ; then
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
