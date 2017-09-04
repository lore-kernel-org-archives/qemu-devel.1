Received: from eggs.gnu.org ([2001:4830:134:3::10]:38943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dov1P-000259-Bn
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dov1K-0007cI-7B
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:18:51 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dov1J-0007bF-WF
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:18:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 18:19:00 +0100
Message-Id: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] configure: Drop AIX host support
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

Nobody has mentioned AIX host support on the mailing list for years,
and we have no test systems for it so it is most likely broken.
We've advertised in configure for two releases now that we plan
to drop support for this host OS, and have had no complaints.
Drop the AIX host support code.

We can also drop the now-unused AIX version of sys_cache_info().

Note that the _CALL_AIX define used in the PPC tcg backend is
also used for Linux PPC64, and so that code should not be removed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure        | 13 +------------
 util/cacheinfo.c | 11 +----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/configure b/configure
index fb7e34a..931b3ba 100755
--- a/configure
+++ b/configure
@@ -350,7 +350,6 @@ cocoa="no"
 softmmu="yes"
 linux_user="no"
 bsd_user="no"
-aix="no"
 blobs="yes"
 pkgversion=""
 pie=""
@@ -554,8 +553,6 @@ elif check_define __NetBSD__; then
   targetos='NetBSD'
 elif check_define __APPLE__; then
   targetos='Darwin'
-elif check_define _AIX; then
-  targetos='AIX'
 else
   # This is a fatal error, but don't report it yet, because we
   # might be going to just print the --help text, or it might
@@ -767,10 +764,6 @@ SunOS)
   LIBS="$solarisnetlibs $LIBS"
   libs_qga="$solarisnetlibs $libs_qga"
 ;;
-AIX)
-  aix="yes"
-  make="${MAKE-gmake}"
-;;
 Haiku)
   haiku="yes"
   QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
@@ -4214,7 +4207,7 @@ elif compile_prog "" "$pthread_lib -lrt" ; then
 fi
 
 if test "$darwin" != "yes" -a "$mingw32" != "yes" -a "$solaris" != yes -a \
-        "$aix" != "yes" -a "$haiku" != "yes" ; then
+        "$haiku" != "yes" ; then
     libs_softmmu="-lutil $libs_softmmu"
 fi
 
@@ -5523,10 +5516,6 @@ if test "$darwin" = "yes" ; then
   echo "CONFIG_DARWIN=y" >> $config_host_mak
 fi
 
-if test "$aix" = "yes" ; then
-  echo "CONFIG_AIX=y" >> $config_host_mak
-fi
-
 if test "$solaris" = "yes" ; then
   echo "CONFIG_SOLARIS=y" >> $config_host_mak
 fi
diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index 593940f..db5172d 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -15,16 +15,7 @@ int qemu_dcache_linesize = 0;
  * Operating system specific detection mechanisms.
  */
 
-#if defined(_AIX)
-# include <sys/systemcfg.h>
-
-static void sys_cache_info(int *isize, int *dsize)
-{
-    *isize = _system_configuration.icache_line;
-    *dsize = _system_configuration.dcache_line;
-}
-
-#elif defined(_WIN32)
+#if defined(_WIN32)
 
 static void sys_cache_info(int *isize, int *dsize)
 {
-- 
2.7.4
