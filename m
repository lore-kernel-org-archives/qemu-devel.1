Received: from eggs.gnu.org ([2001:4830:134:3::10]:35950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cqKpV-0000f3-Od
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cqKpU-0002b9-J5
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:32:09 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cqKpU-0002W4-B5
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:32:08 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 14:31:57 +0000
Message-Id: <1490106717-9542-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org

We plan to drop support in a future QEMU release for host OSes
and host architectures for which we have no test machine where
we can build and run tests. For the 2.9 release, make configure
print a warning if it is run on such a host, so that the user
has some warning of the plans and can volunteer to help us
maintain the port if they need it to continue to function.

This commit flags up as deprecated the CPU architectures:
 * ia64
 * sparc
 * anything which we don't have a TCG port for
   (and which was presumably using TCI)
and the OSes:
 * GNU/kFreeBSD
 * DragonFly BSD
 * NetBSD
 * OpenBSD
 * Solaris
 * AIX
 * Haiku

It also makes entirely unrecognized host OS strings be
rejected rather than treated as if they were Linux (which
likely never worked).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v2: mark FreeBSD as 'supported' as I have got a
VM config going for it for build tests.
NetBSD doesn't boot inside KVM (!), and OpenBSD I have got
running but "make check" hangs where we try to run guest code.

 configure | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 02e3b69..3291603 100755
--- a/configure
+++ b/configure
@@ -321,6 +321,9 @@ tcmalloc="no"
 jemalloc="no"
 replication="yes"
 
+supported_cpu="no"
+supported_os="no"
+
 # parse CC options first
 for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
@@ -517,23 +520,32 @@ ARCH=
 # Normalise host CPU name and set ARCH.
 # Note that this case should only have supported host CPUs, not guests.
 case "$cpu" in
-  ia64|ppc|ppc64|s390|s390x|sparc64|x32)
+  ppc|ppc64|s390|s390x|x32)
+    cpu="$cpu"
+    supported_cpu="yes"
+  ;;
+  ia64|sparc64)
     cpu="$cpu"
   ;;
   i386|i486|i586|i686|i86pc|BePC)
     cpu="i386"
+    supported_cpu="yes"
   ;;
   x86_64|amd64)
     cpu="x86_64"
+    supported_cpu="yes"
   ;;
   armv*b|armv*l|arm)
     cpu="arm"
+    supported_cpu="yes"
   ;;
   aarch64)
     cpu="aarch64"
+    supported_cpu="yes"
   ;;
   mips*)
     cpu="mips"
+    supported_cpu="yes"
   ;;
   sparc|sun4[cdmuv])
     cpu="sparc"
@@ -562,6 +574,7 @@ MINGW32*)
   else
     audio_drv_list=""
   fi
+  supported_os="yes"
 ;;
 GNU/kFreeBSD)
   bsd="yes"
@@ -579,6 +592,7 @@ FreeBSD)
   libs_qga="-lutil $libs_qga"
   netmap=""  # enable netmap autodetect
   HOST_VARIANT_DIR="freebsd"
+  supported_os="yes"
 ;;
 DragonFly)
   bsd="yes"
@@ -620,6 +634,7 @@ Darwin)
   # won't work when we're compiling with gcc as a C compiler.
   QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
   HOST_VARIANT_DIR="darwin"
+  supported_os="yes"
 ;;
 SunOS)
   solaris="yes"
@@ -666,7 +681,7 @@ Haiku)
   QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
   LIBS="-lposix_error_mapper -lnetwork $LIBS"
 ;;
-*)
+Linux)
   audio_drv_list="oss"
   audio_possible_drivers="oss alsa sdl pa"
   linux="yes"
@@ -676,6 +691,10 @@ Haiku)
   vhost_scsi="yes"
   vhost_vsock="yes"
   QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
+  supported_os="yes"
+;;
+*)
+  error_exit "Unsupported host OS $targetos"
 ;;
 esac
 
@@ -5108,6 +5127,32 @@ if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
 fi
 
+if test "$supported_cpu" = "no"; then
+    echo
+    echo "WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!"
+    echo
+    echo "CPU host architecture $cpu support is not currently maintained."
+    echo "The QEMU project intends to remove support for this host CPU in"
+    echo "a future release if nobody volunteers to maintain it and to"
+    echo "provide a build host for our continuous integration setup."
+    echo "configure has succeeded and you can continue to build, but"
+    echo "if you care about QEMU on this platform you should contact"
+    echo "us upstream at qemu-devel@nongnu.org."
+fi
+
+if test "$supported_os" = "no"; then
+    echo
+    echo "WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEASES!"
+    echo
+    echo "CPU host OS $targetos support is not currently maintained."
+    echo "The QEMU project intends to remove support for this host CPU in"
+    echo "a future release if nobody volunteers to maintain it and to"
+    echo "provide a build host for our continuous integration setup."
+    echo "configure has succeeded and you can continue to build, but"
+    echo "if you care about QEMU on this platform you should contact"
+    echo "us upstream at qemu-devel@nongnu.org."
+fi
+
 config_host_mak="config-host.mak"
 
 echo "# Automatically generated by configure - do not modify" >config-all-disas.mak
-- 
2.7.4
