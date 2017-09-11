Received: from eggs.gnu.org ([2001:4830:134:3::10]:40024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1drUpE-0006JV-5W
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1drUpA-0002KK-7M
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:56 -0400
Received: from mail-by2nam03on0078.outbound.protection.outlook.com
	([104.47.42.78]:23232
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1drUp9-0002Ji-SM
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:52 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 11 Sep 2017 12:53:02 -0700
Message-ID: <f5441f63f6527c38a198ae566823238bb92bc489.1505158760.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1505158760.git.alistair.francis@xilinx.com>
References: <cover.1505158760.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 7/8] Makefile: Remove libqemustub.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, pbonzini@redhat.com

Using two libraries (libqemuutil.a and libqemustub.a) would sometimes
result in circular dependencies. To avoid these issues let's just
combine both into a single library that functions as both.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---

V3:
 - Fix up the docs
 - Rebase into this series
V2:
 - Skipped

 Makefile                    |  7 +++----
 Makefile.target             |  2 +-
 docs/devel/build-system.txt | 16 +++++++---------
 tests/Makefile.include      |  6 +++---
 4 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index 337a1f6f9b..8f1273a159 100644
--- a/Makefile
+++ b/Makefile
@@ -344,7 +344,7 @@ subdir-dtc:dtc/libfdt dtc/tests
 dtc/%:
 	mkdir -p $@
=20
-$(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(chardev-obj=
-y) \
+$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
 	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
=20
 ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))
@@ -364,12 +364,11 @@ Makefile: $(version-obj-y)
 ######################################################################
 # Build libraries
=20
-libqemustub.a: $(stub-obj-y)
-libqemuutil.a: $(util-obj-y) $(trace-obj-y)
+libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
=20
 ######################################################################
=20
-COMMON_LDADDS =3D libqemuutil.a libqemustub.a
+COMMON_LDADDS =3D libqemuutil.a
=20
 qemu-img.o: qemu-img-cmds.h
=20
diff --git a/Makefile.target b/Makefile.target
index 7f42c45db8..0a80caf79c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -193,7 +193,7 @@ all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
=20
 $(QEMU_PROG_BUILD): config-devices.mak
=20
-COMMON_LDADDS =3D ../libqemuutil.a ../libqemustub.a
+COMMON_LDADDS =3D ../libqemuutil.a
=20
 # build either PROG or PROGW
 $(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index 2af1e668c5..0d54294cb1 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -232,15 +232,13 @@ The utility code that is used by all binaries is buil=
t into a
 static archive called libqemuutil.a, which is then linked to all the
 binaries. In order to provide hooks that are only needed by some of the
 binaries, code in libqemuutil.a may depend on other functions that are
-not fully implemented by all QEMU binaries. To deal with this there is a
-second library called libqemustub.a which provides dummy stubs for all
-these functions. These will get lazy linked into the binary if the real
-implementation is not present. In this way, the libqemustub.a static
-library can be thought of as a portable implementation of the weak
-symbols concept. All binaries should link to both libqemuutil.a and
-libqemustub.a. e.g.
-
- qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a libqemustub.a
+not fully implemented by all QEMU binaries. Dummy stubs for all  these
+functions are also provided by this library, and will get lazy linked
+into the binary if the real implementation is not present. In this way,
+this static library can be thought of as a portable implementation of
+the weak symbols concept. All binaries should link to libqemuutil.a. e.g.
+
+ qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a
=20
=20
 Windows platform portability
diff --git a/tests/Makefile.include b/tests/Makefile.include
index fae5715e9c..3d6726e95c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -561,7 +561,7 @@ QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests
=20
=20
 # Deps that are common to various different sets of tests below
-test-util-obj-y =3D libqemuutil.a libqemustub.a
+test-util-obj-y =3D libqemuutil.a
 test-qom-obj-y =3D $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y =3D tests/test-qapi-visit.o tests/test-qapi-types.o \
 	tests/test-qapi-event.o tests/test-qmp-introspect.o \
@@ -617,8 +617,8 @@ tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	$(test-io-obj-y)
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-=
obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o \
-	libqemuutil.a libqemustub.a
-tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o =
hw/core/ptimer.o libqemustub.a
+	libqemuutil.a
+tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o =
hw/core/ptimer.o $(test-util-obj-y)
=20
 tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
=20
--=20
2.11.0
