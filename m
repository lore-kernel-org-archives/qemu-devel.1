Received: from eggs.gnu.org ([2001:4830:134:3::10]:51214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ7o-00006C-AV
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ7k-0000Vm-EL
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:03:08 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:55:06 +0300
Message-Id: <9bc5a7193fb422ee53187601eba577ee5d195522.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 11/17] oslib-posix: check for posix_memalign in
 configure script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andreas Gustafsson <gson@gson.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Andreas Gustafsson <gson@gson.org>

Check for the presence of posix_memalign() in the configure script,
not using "defined(_POSIX_C_SOURCE) && !defined(__sun__)".  This
lets qemu use posix_memalign() on NetBSD versions that have it,
instead of falling back to valloc() which is wasteful when the
required alignment is smaller than a page.

Signed-off-by: Andreas Gustafsson <gson@gson.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure          | 19 +++++++++++++++++++
 util/oslib-posix.c |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index c1bbf17559..fe9eea9218 100755
--- a/configure
+++ b/configure
@@ -4659,6 +4659,21 @@ if compile_prog "" "" ; then
 fi
 
 ##########################################
+# check if we have posix_memalign()
+
+posix_memalign=no
+cat > $TMPC << EOF
+#include <stdlib.h>
+int main(void) {
+    void *p;
+    return posix_memalign(&p, 8, 8);
+}
+EOF
+if compile_prog "" "" ; then
+    posix_memalign=yes
+fi
+
+##########################################
 # check if we have posix_syslog
 
 posix_syslog=no
@@ -5746,6 +5761,7 @@ echo "preadv support    $preadv"
 echo "fdatasync         $fdatasync"
 echo "madvise           $madvise"
 echo "posix_madvise     $posix_madvise"
+echo "posix_memalign    $posix_memalign"
 echo "libcap-ng support $cap_ng"
 echo "vhost-net support $vhost_net"
 echo "vhost-scsi support $vhost_scsi"
@@ -6232,6 +6248,9 @@ fi
 if test "$posix_madvise" = "yes" ; then
   echo "CONFIG_POSIX_MADVISE=y" >> $config_host_mak
 fi
+if test "$posix_memalign" = "yes" ; then
+  echo "CONFIG_POSIX_MEMALIGN=y" >> $config_host_mak
+fi
 
 if test "$spice" = "yes" ; then
   echo "CONFIG_SPICE=y" >> $config_host_mak
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 77369c92ce..4655bc1f89 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -105,7 +105,7 @@ void *qemu_try_memalign(size_t alignment, size_t size)
         alignment = sizeof(void*);
     }
 
-#if defined(_POSIX_C_SOURCE) && !defined(__sun__)
+#if defined(CONFIG_POSIX_MEMALIGN)
     int ret;
     ret = posix_memalign(&ptr, alignment, size);
     if (ret != 0) {
-- 
2.11.0
