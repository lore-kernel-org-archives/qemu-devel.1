Received: from eggs.gnu.org ([209.51.188.92]:44950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz5B-0005lR-HX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz5A-0007gU-G7
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:03:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57699)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz5A-0007fr-AX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:03:00 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:19 +0100
Message-Id: <1547460140-1473-25-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/25] configure: Force the C standard to gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

Different versions of GCC and Clang use different versions of the C stand=
ard.
This repeatedly caused problems already, e.g. with duplicated typedefs:

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html

or with for-loop variable initializers:

 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html

To avoid these problems, we should enforce the C language version to the
same level for all compilers. Since our minimum compiler versions is
GCC v4.8, our best option is "gnu99" for C code right now ("gnu17" is not
available there yet, and "gnu11" is marked as "experimental"), and "gnu++=
98"
for the few C++ code that we have in the repository.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index e0915da..05b7e85 100755
--- a/configure
+++ b/configure
@@ -107,6 +107,9 @@ update_cxxflags() {
             -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
             -Wold-style-declaration|-Wold-style-definition|-Wredundant-d=
ecls)
                 ;;
+            -std=3Dgnu99)
+                QEMU_CXXFLAGS=3D${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }"-std=3D=
gnu++98"
+                ;;
             *)
                 QEMU_CXXFLAGS=3D${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
                 ;;
@@ -585,7 +588,7 @@ ARFLAGS=3D"${ARFLAGS-rv}"
 # left shift of signed integers is well defined and has the expected
 # 2s-complement style results. (Both clang and gcc agree that it
 # provides these semantics.)
-QEMU_CFLAGS=3D"-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
+QEMU_CFLAGS=3D"-fno-strict-aliasing -fno-common -fwrapv -std=3Dgnu99 $QE=
MU_CFLAGS"
 QEMU_CFLAGS=3D"-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_=
CFLAGS"
 QEMU_CFLAGS=3D"-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS=3D"-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURC=
E $QEMU_CFLAGS"
--=20
1.8.3.1
