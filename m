Received: from eggs.gnu.org ([2001:4830:134:3::10]:50028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwE-0007Co-KS
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwC-0005tO-05
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvnwB-0005t7-Pt
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7VIDtgA094208
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:27 GMT
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp2120.oracle.com with ESMTP id 2m2y2q4vj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7VIEPot021138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:26 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7VIEPeT023688
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:25 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 31 Aug 2018 19:16:05 +0100
Message-Id: <1535739372-24454-2-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v3 1/8] configure: Provide option to explicitly
 disable AVX2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The configure script detects if the compiler has AVX2 support and
automatically sets avx2_opt="yes" which in turn defines CONFIG_AVX2_OPT.
There is no way of explicitly overriding this setting so this commit adds
two command-line options: --enable-avx2 and --disable-avx2.

The default behaviour, when no option is specified, is to maintain the
current behaviour and enable AVX2 if the compiler supports it.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
---
 configure | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 58862d2ae88a..8904a91715b3 100755
--- a/configure
+++ b/configure
@@ -427,7 +427,7 @@ usb_redir=""
 opengl=""
 opengl_dmabuf="no"
 cpuid_h="no"
-avx2_opt="no"
+avx2_opt=""
 zlib="yes"
 capstone=""
 lzo=""
@@ -1332,6 +1332,10 @@ for opt do
   ;;
   --disable-glusterfs) glusterfs="no"
   ;;
+  --disable-avx2) avx2_opt="no"
+  ;;
+  --enable-avx2) avx2_opt="yes"
+  ;;
   --enable-glusterfs) glusterfs="yes"
   ;;
   --disable-virtio-blk-data-plane|--enable-virtio-blk-data-plane)
@@ -1709,6 +1713,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   libxml2         for Parallels image format
   tcmalloc        tcmalloc support
   jemalloc        jemalloc support
+  avx2            AVX2 optimization support
   replication     replication support
   vhost-vsock     virtio sockets device support
   opengl          opengl support
@@ -5127,7 +5132,7 @@ fi
 # There is no point enabling this if cpuid.h is not usable,
 # since we won't be able to select the new routines.
 
-if test $cpuid_h = yes; then
+if test "$cpuid_h" = "yes" -a "$avx2_opt" != "no"; then
   cat > $TMPC << EOF
 #pragma GCC push_options
 #pragma GCC target("avx2")
@@ -5141,6 +5146,8 @@ int main(int argc, char *argv[]) { return bar(argv[0]); }
 EOF
   if compile_object "" ; then
     avx2_opt="yes"
+  else
+    avx2_opt="no"
   fi
 fi
 
-- 
1.8.3.1
