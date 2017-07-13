Received: from eggs.gnu.org ([2001:4830:134:3::10]:50528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVf27-0007iw-2c
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVf22-0001G7-9b
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:23:59 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 15:21:37 +0100
Message-Id: <1499955697-28045-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] configure: Drop ancient Solaris 9 and earlier
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

Solaris 9 was released in 2002, its successor Solaris 10 was
released in 2005, and Solaris 9 was end-of-lifed in 2014.
Nobody has stepped forward to express interest in supporting
Solaris of any flavour, so removing support for the ancient
versions seems uncontroversial.

In particular, this allows us to remove a use of 'uname'
in configure that won't work if you're cross-compiling.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Not a big thing, but it's a start on cleaning out some
of the untested and untestable cruft from configure...

 configure               | 21 ---------------------
 include/fpu/softfloat.h |  5 -----
 2 files changed, 26 deletions(-)

diff --git a/configure b/configure
index 5096cbc..ff77896 100755
--- a/configure
+++ b/configure
@@ -730,23 +730,6 @@ SunOS)
   install="${INSTALL-ginstall}"
   ld="gld"
   smbd="${SMBD-/usr/sfw/sbin/smbd}"
-  needs_libsunmath="no"
-  solarisrev=$(uname -r | cut -f2 -d.)
-  if [ "$cpu" = "i386" -o "$cpu" = "x86_64" ] ; then
-    if test "$solarisrev" -le 9 ; then
-      if test -f /opt/SUNWspro/prod/lib/libsunmath.so.1; then
-        needs_libsunmath="yes"
-        QEMU_CFLAGS="-I/opt/SUNWspro/prod/include/cc $QEMU_CFLAGS"
-        LDFLAGS="-L/opt/SUNWspro/prod/lib -R/opt/SUNWspro/prod/lib $LDFLAGS"
-        LIBS="-lsunmath $LIBS"
-      else
-        error_exit "QEMU will not link correctly on Solaris 8/X86 or 9/x86 without" \
-            "libsunmath from the Sun Studio compilers tools, due to a lack of" \
-            "C99 math features in libm.so in Solaris 8/x86 and Solaris 9/x86" \
-            "Studio 11 can be downloaded from www.sun.com."
-      fi
-    fi
-  fi
   if test -f /usr/include/sys/soundcard.h ; then
     audio_drv_list="oss"
   fi
@@ -5430,10 +5413,6 @@ fi
 
 if test "$solaris" = "yes" ; then
   echo "CONFIG_SOLARIS=y" >> $config_host_mak
-  echo "CONFIG_SOLARIS_VERSION=$solarisrev" >> $config_host_mak
-  if test "$needs_libsunmath" = "yes" ; then
-    echo "CONFIG_NEEDS_LIBSUNMATH=y" >> $config_host_mak
-  fi
 fi
 if test "$haiku" = "yes" ; then
   echo "CONFIG_HAIKU=y" >> $config_host_mak
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index d9689ec..0f96a0e 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -82,11 +82,6 @@ this code that are retained.
 #ifndef SOFTFLOAT_H
 #define SOFTFLOAT_H
 
-#if defined(CONFIG_SOLARIS) && defined(CONFIG_NEEDS_LIBSUNMATH)
-#include <sunmath.h>
-#endif
-
-
 /* This 'flag' type must be able to hold at least 0 and 1. It should
  * probably be replaced with 'bool' but the uses would need to be audited
  * to check that they weren't accidentally relying on it being a larger type.
-- 
2.7.4
