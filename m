Received: from eggs.gnu.org ([2001:4830:134:3::10]:34284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cPBsi-0006JM-Lq
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cPBse-0008GH-Rz
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:31:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cPBse-0008Ff-JY
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:31:12 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  5 Jan 2017 17:31:06 +0000
Message-Id: <20170105173107.5426-2-stefanha@redhat.com>
In-Reply-To: <20170105173107.5426-1-stefanha@redhat.com>
References: <20170105173107.5426-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] configure: add libsystemd check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

libsystemd provides APIs for daemons that wish to integrate socket
activation and other systemd-related functionality.  This will be used
as an optional dependency by qemu-guest-agent.

In the future it could also be used for systemd logging or sd_notify(3)
service startup notification.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 configure | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/configure b/configure
index 218df87..c353ff7 100755
--- a/configure
+++ b/configure
@@ -321,6 +321,7 @@ numa=""
 tcmalloc="no"
 jemalloc="no"
 replication="yes"
+systemd=""
 
 # parse CC options first
 for opt do
@@ -1168,6 +1169,10 @@ for opt do
   ;;
   --enable-replication) replication="yes"
   ;;
+  --disable-systemd) systemd="no"
+  ;;
+  --enable-systemd) systemd="yes"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1401,6 +1406,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   tcmalloc        tcmalloc support
   jemalloc        jemalloc support
   replication     replication support
+  systemd         systemd support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -4720,6 +4726,27 @@ if compile_prog "" "" ; then
     have_af_vsock=yes
 fi
 
+##########################################
+# check for libsystemd
+if test "$systemd" != "no" ; then
+  cat > $TMPC << EOF
+#include <systemd/sd-daemon.h>
+int main(void) { (void)sd_listen_fds(1); return 0; }
+EOF
+  systemd_cflags=$($pkg_config --cflags libsystemd 2>/dev/null)
+  systemd_libs=$($pkg_config --libs libsystemd 2>/dev/null)
+  if $pkg_config libsystemd >/dev/null 2>&1 && \
+     compile_prog "$systemd_cflags" "$systemd_libs" ; then
+    systemd="yes"
+  else
+    if test "$systemd" = "yes" ; then
+      feature_not_found "systemd"
+    fi
+    systemd="no"
+  fi
+fi
+
+
 #################################################
 # Sparc implicitly links with --relax, which is
 # incompatible with -r, so --no-relax should be
@@ -5112,6 +5139,7 @@ echo "tcmalloc support  $tcmalloc"
 echo "jemalloc support  $jemalloc"
 echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
+echo "systemd support   $systemd"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -5721,6 +5749,12 @@ if test "$have_af_vsock" = "yes" ; then
   echo "CONFIG_AF_VSOCK=y" >> $config_host_mak
 fi
 
+if test "$systemd" = "yes" ; then
+  echo "CONFIG_SYSTEMD=y" >> $config_host_mak
+  echo "SYSTEMD_CFLAGS=$systemd_cflags" >> $config_host_mak
+  echo "SYSTEMD_LIBS=$systemd_libs" >> $config_host_mak
+fi
+
 # Hold two types of flag:
 #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name on
 #                                     a thread we have a handle to
-- 
2.9.3
