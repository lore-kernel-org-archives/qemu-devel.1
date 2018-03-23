Received: from eggs.gnu.org ([2001:4830:134:3::10]:36032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0M-0008GL-O4
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0L-0007hP-Ep
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ezP0L-0007gh-8v
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:21 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Fri, 23 Mar 2018 18:53:02 +0300
Message-Id: <20180323155306.83812-5-marcel@redhat.com>
In-Reply-To: <20180323155306.83812-1-marcel@redhat.com>
References: <20180323155306.83812-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel]  [PATCH PULL 4/8] make: switch from -I to -iquote
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com, mst@redhat.com, marcel@redhat.com, f4bug@amsat.org, eblake@redhat.com, berrange@redhat.com, stefanha@redhat.com

From: "Michael S. Tsirkin" <mst@redhat.com>

Our rule right now is to use <> for external headers,
"" for internal ones. The idea was to avoid conflicts
between e.g. a system file named <trace.h> and an
internal one by the same name.

Unfortunately we use -I compiler flag so it does not
help: a system file doing #include <trace.h> will
still pick up ours first.

To fix, switch to -iquote which is supported by both
gcc and clang and only affects #include "" directives.

As a side effect, this catches any future uses of
 #include <> for internal headers.

Suggested-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 Makefile.target |  4 ++--
 configure       | 16 ++++++++--------
 rules.mak       |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 6549481096..d0ec77a307 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -11,9 +11,9 @@ $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
 ifdef CONFIG_LINUX
 QEMU_CFLAGS +=3D -I../linux-headers
 endif
-QEMU_CFLAGS +=3D -I.. -I$(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEED_CP=
U_H
+QEMU_CFLAGS +=3D -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_ARC=
H) -DNEED_CPU_H
=20
-QEMU_CFLAGS+=3D-I$(SRC_PATH)/include
+QEMU_CFLAGS+=3D-iquote $(SRC_PATH)/include
=20
 ifdef CONFIG_USER_ONLY
 # user emulator name
diff --git a/configure b/configure
index f156805981..8376cb151a 100755
--- a/configure
+++ b/configure
@@ -534,7 +534,7 @@ QEMU_CFLAGS=3D"-fno-strict-aliasing -fno-common -fwra=
pv $QEMU_CFLAGS"
 QEMU_CFLAGS=3D"-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_=
CFLAGS"
 QEMU_CFLAGS=3D"-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS=3D"-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURC=
E $QEMU_CFLAGS"
-QEMU_INCLUDES=3D"-I. -I\$(SRC_PATH) -I\$(SRC_PATH)/accel/tcg -I\$(SRC_PA=
TH)/include"
+QEMU_INCLUDES=3D"-iquote . -iquote \$(SRC_PATH) -iquote \$(SRC_PATH)/acc=
el/tcg -iquote \$(SRC_PATH)/include"
 if test "$debug_info" =3D "yes"; then
     CFLAGS=3D"-g $CFLAGS"
     LDFLAGS=3D"-g $LDFLAGS"
@@ -6600,19 +6600,19 @@ if test "$vxhs" =3D "yes" ; then
 fi
=20
 if test "$tcg_interpreter" =3D "yes"; then
-  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
+  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" =3D "sparc64" ; then
-  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/sparc $QEMU_INCLUDES"
+  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/sparc $QEMU_INCLUDES"
 elif test "$ARCH" =3D "s390x" ; then
-  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/s390 $QEMU_INCLUDES"
+  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/s390 $QEMU_INCLUDES"
 elif test "$ARCH" =3D "x86_64" -o "$ARCH" =3D "x32" ; then
-  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
+  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
 elif test "$ARCH" =3D "ppc64" ; then
-  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
+  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
 else
-  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
+  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
 fi
-QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg $QEMU_INCLUDES"
+QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg $QEMU_INCLUDES"
=20
 echo "TOOLS=3D$tools" >> $config_host_mak
 echo "ROMS=3D$roms" >> $config_host_mak
diff --git a/rules.mak b/rules.mak
index 6e943335f3..93a07027b0 100644
--- a/rules.mak
+++ b/rules.mak
@@ -29,7 +29,7 @@ QEMU_DGFLAGS +=3D -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 # dir, one absolute and the other relative to the compiler working
 # directory. These are the same for target-independent files, but
 # different for target-dependent ones.
-QEMU_LOCAL_INCLUDES =3D -I$(BUILD_DIR)/$(@D) -I$(@D)
+QEMU_LOCAL_INCLUDES =3D -iquote $(BUILD_DIR)/$(@D) -iquote $(@D)
=20
 WL_U :=3D -Wl,-u,
 find-symbols =3D $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
--=20
2.13.5
