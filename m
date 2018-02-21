Received: from eggs.gnu.org ([2001:4830:134:3::10]:51533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eoIoe-0001GD-4K
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 20:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eoIoY-0008K8-Ty
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 20:03:24 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eoIoY-0008JP-MI
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 20:03:18 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 20 Feb 2018 20:03:15 -0500
Message-Id: <1519174995-1039-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] configure: fix sanitizers' test program to
 mend ASan detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Commit 218bb57 ("build-sys: check static linking of UBSAN", 2018-02-13)
adds a small test program to check whether ubsan works even when
configuring with --static. This added program is used to
detect all sanitizers, which breaks ASan's detection since the
compilation fails with -fsanitize=address, at least with gcc 5.4.0
and 7.2.0:

  qemu-conf.c: In function ‘main’:
  qemu-conf.c:3:20: error: integer overflow in expression [-Werror=overflow]
     return INT32_MIN / -1;
                      ^
  cc1: all warnings being treated as errors

Fix it by:

- Changing the test program to one that incurs undefined behaviour that isn't
  detected at compile-time, even with -fsanitize=address.

- To be extra safe (since compilers might evolve and eventually figure out
  the UB at compile-time), use this newly-added test only when checking
  for UBSan; use the skeleton otherwise.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 configure | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 913e148..56f647f 100755
--- a/configure
+++ b/configure
@@ -5306,13 +5306,13 @@ fi
 ##########################################
 # checks for sanitizers
 
-# we could use a simple skeleton for flags checks, but this also
-# detect the static linking issue of ubsan, see also:
+# Use this program to detect the static linking issue of ubsan; see
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
 cat > $TMPC << EOF
-#include <stdint.h>
-int main(void) {
-  return INT32_MIN / -1;
+int main(int argc, char **argv) {
+  int k = 0x7fffffff;
+  k += argc;
+  return 0;
 }
 EOF
 
@@ -5322,12 +5322,16 @@ have_asan_iface_h=no
 have_asan_iface_fiber=no
 
 if test "$sanitizers" = "yes" ; then
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=undefined" ""; then
+    have_ubsan=yes
+  fi
+
+  # Use the skeleton for all other sanitizer checks
+  write_c_skeleton
+
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=address" ""; then
       have_asan=yes
   fi
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=undefined" ""; then
-      have_ubsan=yes
-  fi
 
   if check_include "sanitizer/asan_interface.h" ; then
       have_asan_iface_h=yes
-- 
2.7.4
