Received: from eggs.gnu.org ([2001:4830:134:3::10]:48049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVR-0004qF-Cf
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVO-0006Gp-WB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:49 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVO-0006GG-Pp
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:46 -0500
Received: by mail-wm0-x241.google.com with SMTP id t6so22233856wmt.5
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:06 +0100
Message-Id: <1520342370-123606-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/34] build-sys: fix -fsanitize=address check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since 218bb57dd79d6843e0592c30a82ea8c1fddc74a5, the -fsanitize=address
check fails with:
config-temp/qemu-conf.c:3:20: error: integer overflow in expression [-Werror=overflow]
   return INT32_MIN / -1;

Interestingly, UBSAN check doesn't produce a compile time warning.
Use a test that doesn't have compile time warnings, and make it
specific to UBSAN check.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180215212552.26997-2-marcandre.lureau@redhat.com>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 27d3f66..7ff00f8 100755
--- a/configure
+++ b/configure
@@ -5316,25 +5316,27 @@ fi
 ##########################################
 # checks for sanitizers
 
-# we could use a simple skeleton for flags checks, but this also
-# detect the static linking issue of ubsan, see also:
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
-cat > $TMPC << EOF
-#include <stdint.h>
-int main(void) {
-  return INT32_MIN / -1;
-}
-EOF
-
 have_asan=no
 have_ubsan=no
 have_asan_iface_h=no
 have_asan_iface_fiber=no
 
 if test "$sanitizers" = "yes" ; then
+  write_c_skeleton
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=address" ""; then
       have_asan=yes
   fi
+
+  # we could use a simple skeleton for flags checks, but this also
+  # detect the static linking issue of ubsan, see also:
+  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
+  cat > $TMPC << EOF
+#include <stdlib.h>
+int main(void) {
+    void *tmp = malloc(10);
+    return *(int *)(tmp + 2);
+}
+EOF
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=undefined" ""; then
       have_ubsan=yes
   fi
-- 
1.8.3.1
