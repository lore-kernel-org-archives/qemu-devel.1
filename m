Received: from eggs.gnu.org ([2001:4830:134:3::10]:37095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1csazb-0004SD-Ih
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1csazY-0002zt-Bu
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:11:55 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:55032
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan@weilnetz.de>) id 1csazY-0002zN-1R
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:11:52 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Mon, 27 Mar 2017 22:11:46 +0200
Message-Id: <20170327201146.1820-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH for-2.9] Fix check for target OS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

This check had several problems which are fixed here:

* Calling "configure --help" was no longer possible on Cygwin.
  Fix  this by introducing a third state for supported_os and
  by moving the error handling code.
  Move the error handling code for supported_cpu, too.

* Fix the error text. Use target cpu and target os because the
  build cpu and build host don't matter here.

* Support cross compilation with the most common cross prefixes
  for Mingw-w64. Other cross builds are still broken!

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

This fixes a regression: building QEMU for Windows with a cross
build under Cygwin is currently broken.

Can the patch be applied directly, or who should send a pull request?

Stefan

 configure | 68 +++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/configure b/configure
index d1ce33bc79..902bd20070 100755
--- a/configure
+++ b/configure
@@ -322,7 +322,7 @@ jemalloc="no"
 replication="yes"
 
 supported_cpu="no"
-supported_os="no"
+supported_os="deprecated"
 
 # parse CC options first
 for opt do
@@ -440,7 +440,13 @@ int main(void) { return 0; }
 EOF
 }
 
-if check_define __linux__ ; then
+if test "$cross_prefix" = "i686_64-w64-mingw32-" ; then
+  targetos='MINGW32'
+elif test "$cross_prefix" = "x86_64-w64-mingw32-" ; then
+  targetos='MINGW32'
+elif test -n "$cross_prefix" ; then
+  targetos="$cross_prefix"
+elif check_define __linux__ ; then
   targetos="Linux"
 elif check_define _WIN32 ; then
   targetos='MINGW32'
@@ -694,7 +700,7 @@ Linux)
   supported_os="yes"
 ;;
 *)
-  error_exit "Unsupported host OS $targetos"
+  supported_os="no"
 ;;
 esac
 
@@ -1428,6 +1434,34 @@ EOF
 exit 0
 fi
 
+if test "$supported_cpu" = "no"; then
+    echo "WARNING: SUPPORT FOR THIS TARGET CPU WILL GO AWAY IN FUTURE RELEASES!"
+    echo
+    echo "CPU target architecture $cpu support is not currently maintained."
+    echo "The QEMU project intends to remove support for this target CPU in"
+    echo "a future release if nobody volunteers to maintain it and to"
+    echo "provide a build host for our continuous integration setup."
+    echo "configure has succeeded and you can continue to build, but"
+    echo "if you care about QEMU on this platform you should contact"
+    echo "us upstream at qemu-devel@nongnu.org."
+    echo
+fi
+
+if test "$supported_os" = "no"; then
+  error_exit "Unsupported target OS $targetos"
+elif test "$supported_os" = "deprecated"; then
+    echo "WARNING: SUPPORT FOR THIS TARGET OS WILL GO AWAY IN FUTURE RELEASES!"
+    echo
+    echo "Target OS $targetos support is not currently maintained."
+    echo "The QEMU project intends to remove support for this target OS in"
+    echo "a future release if nobody volunteers to maintain it and to"
+    echo "provide a build host for our continuous integration setup."
+    echo "configure has succeeded and you can continue to build, but"
+    echo "if you care about QEMU on this platform you should contact"
+    echo "us upstream at qemu-devel@nongnu.org."
+    echo
+fi
+
 # Now we have handled --enable-tcg-interpreter and know we're not just
 # printing the help message, bail out if the host CPU isn't supported.
 if test "$ARCH" = "unknown"; then
@@ -5127,32 +5161,6 @@ if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
 fi
 
-if test "$supported_cpu" = "no"; then
-    echo
-    echo "WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!"
-    echo
-    echo "CPU host architecture $cpu support is not currently maintained."
-    echo "The QEMU project intends to remove support for this host CPU in"
-    echo "a future release if nobody volunteers to maintain it and to"
-    echo "provide a build host for our continuous integration setup."
-    echo "configure has succeeded and you can continue to build, but"
-    echo "if you care about QEMU on this platform you should contact"
-    echo "us upstream at qemu-devel@nongnu.org."
-fi
-
-if test "$supported_os" = "no"; then
-    echo
-    echo "WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEASES!"
-    echo
-    echo "Host OS $targetos support is not currently maintained."
-    echo "The QEMU project intends to remove support for this host OS in"
-    echo "a future release if nobody volunteers to maintain it and to"
-    echo "provide a build host for our continuous integration setup."
-    echo "configure has succeeded and you can continue to build, but"
-    echo "if you care about QEMU on this platform you should contact"
-    echo "us upstream at qemu-devel@nongnu.org."
-fi
-
 config_host_mak="config-host.mak"
 
 echo "# Automatically generated by configure - do not modify" >config-all-disas.mak
@@ -5212,7 +5220,7 @@ if test "$mingw32" = "yes" ; then
     echo "CONFIG_QGA_NTDDDISK=y" >> $config_host_mak
   fi
   if test "$guest_agent_msi" = "yes"; then
-    echo "QEMU_GA_MSI_ENABLED=yes" >> $config_host_mak  
+    echo "QEMU_GA_MSI_ENABLED=yes" >> $config_host_mak
     echo "QEMU_GA_MSI_MINGW_DLL_PATH=${QEMU_GA_MSI_MINGW_DLL_PATH}" >> $config_host_mak
     echo "QEMU_GA_MSI_WITH_VSS=${QEMU_GA_MSI_WITH_VSS}" >> $config_host_mak
     echo "QEMU_GA_MSI_ARCH=${QEMU_GA_MSI_ARCH}" >> $config_host_mak
-- 
2.11.0
