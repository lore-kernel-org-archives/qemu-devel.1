Received: from eggs.gnu.org ([209.51.188.92]:43465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hB56c-0006Wg-L7
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 18:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hB56Z-0007qC-0w
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 18:08:36 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:40844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hB56P-0007cz-Jc
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 18:08:28 -0400
Received: by mail-it1-x142.google.com with SMTP id k64so1823381itb.5
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 15:08:21 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  1 Apr 2019 18:07:52 -0400
Message-Id: <20190401220752.22577-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] capstone: Support capstone/capstone.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>

Starting with version 4 of capstone, the header files live in the
`$prefix/include/capstone` directory.

This modifies the configure script to check for <capstone/capstone.h> if
<capstone.h> cannot be found.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 configure                | 9 +++++++++
 include/disas/capstone.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/configure b/configure
index 1c563a7027..da87c18f14 100755
--- a/configure
+++ b/configure
@@ -5039,6 +5039,12 @@ case "$capstone" in
     ;;
 esac
 
+if test "$capstone" != no; then
+  if ! check_include "capstone.h" && check_include "capstone/capstone.h"; then
+    have_capstone_capstone_h=yes
+  fi
+fi
+
 ##########################################
 # check if we have fdatasync
 
@@ -7199,6 +7205,9 @@ if test "$ivshmem" = "yes" ; then
 fi
 if test "$capstone" != "no" ; then
   echo "CONFIG_CAPSTONE=y" >> $config_host_mak
+  if test "$have_capstone_capstone_h" = "yes" ; then
+    echo "HAVE_CAPSTONE_CAPSTONE_H=y" >> $config_host_mak
+  fi
 fi
 if test "$debug_mutex" = "yes" ; then
   echo "CONFIG_DEBUG_MUTEX=y" >> $config_host_mak
diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index 84e214956d..e1477bf6a2 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -3,7 +3,11 @@
 
 #ifdef CONFIG_CAPSTONE
 
+#ifdef HAVE_CAPSTONE_CAPSTONE_H
+#include <capstone/capstone.h>
+#else
 #include <capstone.h>
+#endif
 
 #else
 
-- 
2.20.1 (Apple Git-117)
