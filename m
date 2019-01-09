Received: from eggs.gnu.org ([209.51.188.92]:37839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghEmo-0005Ao-0Q
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghEmm-0006j1-QT
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:24:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ghEmk-0006eC-6h
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:24:48 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  9 Jan 2019 15:24:29 +0100
Message-Id: <1547043869-10520-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] configure: Force the C standard to gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>

Different versions of GCC and Clang use different versions of the C standard.
This repeatedly caused problems already, e.g. with duplicated typedefs:

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html

or with for-loop variable initializers:

 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html

To avoid these problems, we should enforce the C language version to the
same level for all compilers. Since our minimum compiler versions is
GCC v4.8, our best option is "gnu99" right now ("gnu17" is not available
there yet, and "gnu11" is marked as "experimental").

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use gnu99 instead of gnu11

 configure | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index b9f34af..721ade7 100755
--- a/configure
+++ b/configure
@@ -105,7 +105,8 @@ update_cxxflags() {
     for arg in $QEMU_CFLAGS; do
         case $arg in
             -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
-            -Wold-style-declaration|-Wold-style-definition|-Wredundant-decls)
+            -Wold-style-declaration|-Wold-style-definition|-Wredundant-decls|\
+            -std=gnu99)
                 ;;
             *)
                 QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
@@ -585,7 +586,7 @@ ARFLAGS="${ARFLAGS-rv}"
 # left shift of signed integers is well defined and has the expected
 # 2s-complement style results. (Both clang and gcc agree that it
 # provides these semantics.)
-QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
+QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv -std=gnu99 $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
-- 
1.8.3.1
