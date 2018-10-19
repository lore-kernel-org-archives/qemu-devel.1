Received: from eggs.gnu.org ([2001:4830:134:3::10]:54751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbXz-0007wL-TV
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbXw-0002Xo-Pg
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:39:03 -0400
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 19 Oct 2018 21:38:59 +0100
Message-Id: <1539981546-10596-2-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v4 1/8] configure: Provide option to explicitly
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com, mreitz@redhat.com

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
index 9138af37f8a0..3a3e5f7004ce 100755
--- a/configure
+++ b/configure
@@ -428,7 +428,7 @@ usb_redir=""
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
@@ -1706,6 +1710,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   libxml2         for Parallels image format
   tcmalloc        tcmalloc support
   jemalloc        jemalloc support
+  avx2            AVX2 optimization support
   replication     replication support
   vhost-vsock     virtio sockets device support
   opengl          opengl support
@@ -5094,7 +5099,7 @@ fi
 # There is no point enabling this if cpuid.h is not usable,
 # since we won't be able to select the new routines.
 
-if test $cpuid_h = yes; then
+if test "$cpuid_h" = "yes" -a "$avx2_opt" != "no"; then
   cat > $TMPC << EOF
 #pragma GCC push_options
 #pragma GCC target("avx2")
@@ -5108,6 +5113,8 @@ int main(int argc, char *argv[]) { return bar(argv[0]); }
 EOF
   if compile_object "" ; then
     avx2_opt="yes"
+  else
+    avx2_opt="no"
   fi
 fi
 
-- 
1.8.3.1
