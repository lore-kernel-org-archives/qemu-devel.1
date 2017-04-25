Received: from eggs.gnu.org ([2001:4830:134:3::10]:48029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d2vyf-0003yF-Jk
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d2vyc-0007kp-Cr
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:37:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48022
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1d2vyc-0007kl-7O
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:37:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3P8XsmI046241
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 04:37:37 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a1v4rd8dg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 04:37:33 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 18:37:01 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 14:05:55 +0530
Message-Id: <20170425083555.13547-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC] configure: fix clang failure for libatomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: alex.bennee@linaro.org, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org, pbonzini@redhat.com

Travis builds failure was reported for powernv boot-serial test with
qemu built with clang.

Debugging revealed that CONFIG_ATOMIC64 wasnt getting set for the clang
build because of that atomic operations weren't being used and was
resulting in MTTCG failure in the powernv boot-serial test.

libatomic is required to successfully test atomic64 and atomic128 for
clang. Introduced newer checks for the same. And on failure default to
single threaded tcg support in PPC64.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---

Reference:
https://lists.gnu.org/archive/html/qemu-ppc/2017-04/msg00277.html

---
 configure | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/configure b/configure
index d31a3e8..1e5f7af 100755
--- a/configure
+++ b/configure
@@ -4598,6 +4598,9 @@ int main(void)
 EOF
   if compile_prog "" "" ; then
     atomic128=yes
+  elif compile_prog "" "-latomic" ; then
+     atomic128=yes
+     lib_atomic="-latomic"
   fi
 fi
 
@@ -4628,6 +4631,9 @@ int main(void)
 EOF
 if compile_prog "" "" ; then
   atomic64=yes
+elif compile_prog "" "-latomic" ; then
+  atomic64=yes
+  lib_atomic="-latomic"
 fi
 
 ########################################
@@ -6065,6 +6071,16 @@ if [ "$TARGET_BASE_ARCH" = "" ]; then
   TARGET_BASE_ARCH=$TARGET_ARCH
 fi
 
+if test $atomic64 == "yes" || test $atomic128 == "yes" ; then
+    libs_softmmu="$lib_atomic $libs_softmmu"
+elif test $mttcg == "yes" && test $TARGET_BASE_ARCH == "ppc"; then
+    echo
+    echo "Note: Atomic library (-latomic) not available, falling"
+    echo "      back to single threaded mode by default"
+    echo
+    mttcg=no
+fi
+
 symlink "$source_path/Makefile.target" "$target_dir/Makefile"
 
 upper() {
-- 
2.9.3
