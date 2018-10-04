Received: from eggs.gnu.org ([2001:4830:134:3::10]:34956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81tG-0004Dx-UO
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81iU-0003Y1-NN
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:54 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1g81iU-0003X4-FE
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:50 -0400
Received: by mail-wr1-f52.google.com with SMTP id d2-v6so5058801wro.7
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 04:22:50 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu,  4 Oct 2018 13:22:33 +0200
Message-Id: <2510f7c260bd2cbdf1b6089c2a021e6434cb0d38.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <cover.1538652143.git.tgolembi@redhat.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 06/11] configure: add test for libudev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 configure | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/configure b/configure
index 0f168607e8..ac24cb3975 100755
--- a/configure
+++ b/configure
@@ -477,6 +477,7 @@ libxml2=""
 docker="no"
 debug_mutex="no"
 libpmem=""
+libudev="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -873,6 +874,7 @@ Linux)
   vhost_vsock="yes"
   QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
+  libudev="yes"
 ;;
 esac
 
@@ -5676,6 +5678,20 @@ if test "$libnfs" != "no" ; then
   fi
 fi
 
+##########################################
+# Do we have libudev
+if test "$libudev" != "no" ; then
+  if $pkg_config libudev; then
+    libudev="yes"
+    libudev_libs=$($pkg_config --libs libudev)
+  else
+    if test "$libudev" = "yes" ; then
+      feature_not_found "libudev" "Install systemd development files"
+    fi
+    libudev="no"
+  fi
+fi
+
 # Now we've finished running tests it's OK to add -Werror to the compiler flags
 if test "$werror" = "yes"; then
     QEMU_CFLAGS="-Werror $QEMU_CFLAGS"
@@ -6100,6 +6116,7 @@ echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
 echo "docker            $docker"
 echo "libpmem support   $libpmem"
+echo "libudev           $libudev"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6944,6 +6961,11 @@ if test "$docker" != "no"; then
     echo "HAVE_USER_DOCKER=y" >> $config_host_mak
 fi
 
+if test "$libudev" != "no"; then
+    echo "CONFIG_LIBUDEV=y" >> $config_host_mak
+    echo "LIBUDEV_LIBS=$libudev_libs" >> $config_host_mak
+fi
+
 # use included Linux headers
 if test "$linux" = "yes" ; then
   mkdir -p linux-headers
-- 
2.19.0
