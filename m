Received: from eggs.gnu.org ([2001:4830:134:3::10]:51610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gson@gson.org>) id 1eX9Ud-0005fH-AD
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gson@gson.org>) id 1eX9UY-0002h0-Bk
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:39:51 -0500
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:53329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gson@gson.org>) id 1eX9UY-0002cj-47
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:39:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23118.26328.811644.330716@guava.gson.org>
Date: Thu, 4 Jan 2018 19:39:36 +0200
From: Andreas Gustafsson <gson@gson.org>
Subject: [Qemu-devel] [PATCH] oslib-posix: check for posix_memalign in
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
Cc: Kamil Rytarowski <kamil@NetBSD.org>

Check for the presence of posix_memalign() in the configure script,
not using "defined(_POSIX_C_SOURCE) && !defined(__sun__)".  This
lets qemu use posix_memalign() on NetBSD versions that have it,
instead of falling back to valloc() which is wasteful when the
required alignment is smaller than a page.

Signed-off-by: Andreas Gustafsson <gson@gson.org>
---
 configure          | 19 +++++++++++++++++++
 util/oslib-posix.c |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 100309c33f..9f8580332a 100755
--- a/configure
+++ b/configure
@@ -4573,6 +4573,21 @@ if compile_prog "" "" ; then
     posix_madvise=yes
 fi
 
+##########################################
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
 ##########################################
 # check if we have posix_syslog
 
@@ -5542,6 +5557,7 @@ echo "preadv support    $preadv"
 echo "fdatasync         $fdatasync"
 echo "madvise           $madvise"
 echo "posix_madvise     $posix_madvise"
+echo "posix_memalign    $posix_memalign"
 echo "libcap-ng support $cap_ng"
 echo "vhost-net support $vhost_net"
 echo "vhost-scsi support $vhost_scsi"
@@ -6015,6 +6031,9 @@ fi
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
2.15.1
