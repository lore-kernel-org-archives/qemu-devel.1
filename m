Received: from eggs.gnu.org ([2001:4830:134:3::10]:46534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVGw-0008Ez-6p
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVGn-0001AH-HZ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:28 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a]:35635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHVGn-000168-8x
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:25 -0400
Received: by mail-qt1-x82a.google.com with SMTP id a10-v6so13732970qtp.2
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:45:22 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 09:43:38 -0500
Message-Id: <20181030144358.23144-5-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/24] configure: add test for libudev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

From: Tomáš Golembiovský <tgolembi@redhat.com>

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
*make libudev optional to avoid breaking existing build/test environments
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 configure | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/configure b/configure
index 1c473ce95b..eea3b0c7a4 100755
--- a/configure
+++ b/configure
@@ -474,6 +474,7 @@ libxml2=""
 docker="no"
 debug_mutex="no"
 libpmem=""
+libudev="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -870,6 +871,7 @@ Linux)
   vhost_vsock="yes"
   QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
+  libudev="yes"
 ;;
 esac
 
@@ -5603,6 +5605,17 @@ if test "$libnfs" != "no" ; then
   fi
 fi
 
+##########################################
+# Do we have libudev
+if test "$libudev" != "no" ; then
+  if $pkg_config libudev; then
+    libudev="yes"
+    libudev_libs=$($pkg_config --libs libudev)
+  else
+    libudev="no"
+  fi
+fi
+
 # Now we've finished running tests it's OK to add -Werror to the compiler flags
 if test "$werror" = "yes"; then
     QEMU_CFLAGS="-Werror $QEMU_CFLAGS"
@@ -6027,6 +6040,7 @@ echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
 echo "docker            $docker"
 echo "libpmem support   $libpmem"
+echo "libudev           $libudev"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6862,6 +6876,11 @@ if test "$docker" != "no"; then
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
2.17.1
