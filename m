Received: from eggs.gnu.org ([209.51.188.92]:48101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghGtW-0000Jr-9Y
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghGtV-0005B7-Fm
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:39:54 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  9 Jan 2019 17:39:36 +0100
Message-Id: <1547051976-13982-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1547051976-13982-1-git-send-email-thuth@redhat.com>
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/2] configure: Force the C standard to gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org

Different versions of GCC and Clang use different versions of the C standard.
This repeatedly caused problems already, e.g. with duplicated typedefs:

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html

or with for-loop variable initializers:

 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html

To avoid these problems, we should enforce the C language version to the
same level for all compilers. Since our minimum compiler versions is
GCC v4.8, our best option is "gnu99" for C code right now ("gnu17" is not
available there yet, and "gnu11" is marked as "experimental"), and "gnu++98"
for the few C++ code that we have in the repository.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3: Compile C++ code with -std=gnu++98

 configure | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index b9f34af..448dbc8 100755
--- a/configure
+++ b/configure
@@ -107,6 +107,9 @@ update_cxxflags() {
             -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
             -Wold-style-declaration|-Wold-style-definition|-Wredundant-decls)
                 ;;
+            -std=gnu99)
+                QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }"-std=gnu++98"
+                ;;
             *)
                 QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
                 ;;
@@ -585,7 +588,7 @@ ARFLAGS="${ARFLAGS-rv}"
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
