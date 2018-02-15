Received: from eggs.gnu.org ([2001:4830:134:3::10]:47402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2f-0005qI-PE
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2c-0000lp-Ji
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42844 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1emR2c-0000jb-Fa
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E8008424D
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 21:26:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Feb 2018 22:25:47 +0100
Message-Id: <20180215212552.26997-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180215212552.26997-1-marcandre.lureau@redhat.com>
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/6] build-sys: fix -fsanitize=address check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Since 218bb57dd79d6843e0592c30a82ea8c1fddc74a5, the -fsanitize=3Daddress
check fails with:
config-temp/qemu-conf.c:3:20: error: integer overflow in expression [-Wer=
ror=3Doverflow]
   return INT32_MIN / -1;

Interestingly, UBSAN check doesn't produce a compile time warning.
Use a test that doesn't have compile time warnings, and make it
specific to UBSAN check.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 913e14839d..cc610823e1 100755
--- a/configure
+++ b/configure
@@ -5306,25 +5306,27 @@ fi
 ##########################################
 # checks for sanitizers
=20
-# we could use a simple skeleton for flags checks, but this also
-# detect the static linking issue of ubsan, see also:
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D84285
-cat > $TMPC << EOF
-#include <stdint.h>
-int main(void) {
-  return INT32_MIN / -1;
-}
-EOF
-
 have_asan=3Dno
 have_ubsan=3Dno
 have_asan_iface_h=3Dno
 have_asan_iface_fiber=3Dno
=20
 if test "$sanitizers" =3D "yes" ; then
+  write_c_skeleton
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress" ""; then
       have_asan=3Dyes
   fi
+
+  # we could use a simple skeleton for flags checks, but this also
+  # detect the static linking issue of ubsan, see also:
+  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D84285
+  cat > $TMPC << EOF
+#include <stdlib.h>
+int main(void) {
+    void *tmp =3D malloc(10);
+    return *(int *)(tmp + 2);
+}
+EOF
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dundefined" ""; then
       have_ubsan=3Dyes
   fi
--=20
2.16.1.73.g5832b7e9f2
