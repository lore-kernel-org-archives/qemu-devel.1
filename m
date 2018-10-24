Received: from eggs.gnu.org ([2001:4830:134:3::10]:43445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFq6-0004qC-6N
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFq4-0006CW-66
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gFFq2-00068A-7B
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:31 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 24 Oct 2018 10:52:08 +0100
Message-Id: <1540374728-27579-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1540374728-27579-1-git-send-email-thuth@redhat.com>
References: <1540374728-27579-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] configure: Provide option to explicitly
 disable AVX2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

From: Liam Merwick <Liam.Merwick@oracle.com>

The configure script detects if the compiler has AVX2 support and
automatically sets avx2_opt="yes" which in turn defines CONFIG_AVX2_OPT.
There is no way of explicitly overriding this setting so this commit adds
two command-line options: --enable-avx2 and --disable-avx2.

The default behaviour, when no option is specified, is to maintain the
current behaviour and enable AVX2 if the compiler supports it.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index e39f63d..1ee09bd 100755
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
@@ -1329,6 +1329,10 @@ for opt do
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
@@ -1703,6 +1707,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   libxml2         for Parallels image format
   tcmalloc        tcmalloc support
   jemalloc        jemalloc support
+  avx2            AVX2 optimization support
   replication     replication support
   vhost-vsock     virtio sockets device support
   opengl          opengl support
@@ -5032,7 +5037,7 @@ fi
 # There is no point enabling this if cpuid.h is not usable,
 # since we won't be able to select the new routines.
 
-if test $cpuid_h = yes; then
+if test "$cpuid_h" = "yes" -a "$avx2_opt" != "no"; then
   cat > $TMPC << EOF
 #pragma GCC push_options
 #pragma GCC target("avx2")
@@ -5046,6 +5051,8 @@ int main(int argc, char *argv[]) { return bar(argv[0]); }
 EOF
   if compile_object "" ; then
     avx2_opt="yes"
+  else
+    avx2_opt="no"
   fi
 fi
 
-- 
1.8.3.1
