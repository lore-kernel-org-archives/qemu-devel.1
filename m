Received: from eggs.gnu.org ([2001:4830:134:3::10]:58865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvWB3-0008KY-KE
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 17:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvWAy-0002Yy-Kw
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 17:39:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:37968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cvWAy-0002Xy-8c
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 17:39:44 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Tue, 4 Apr 2017 21:39:39 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A4E5F6@ORSMSX112.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel]  [PATCH] Put all trace.o into libqemuutil.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Cc: 'Stefan Hajnoczi' <stefanha@gmail.com>, 'Daniel Berrange' <berrange@redhat.com>, 'Paolo Bonzini' <pbonzini@redhat.com>

Put all trace.o into libqemuutil.a

Currently all trace.o are linked into qemu-system, qemu-img,=20
qemu-nbd, qemu-io etc., even the corresponding components=20
are not included.
Put all trace.o into libqemuutil.a that the linker would only pull in .o=20
files containing symbols that are actually referenced by the=20
program.


Signed-off -by: Anthony Xu <anthony.xu@intel.com>



diff --git a/Makefile b/Makefile
index 6c359b2..31d41a7 100644
--- a/Makefile
+++ b/Makefile
@@ -346,7 +346,7 @@ dtc/%:
        mkdir -p $@

 $(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(chardev-obj=
-y) \
-       $(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY)) $(trace-obj-y)
+       $(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))

 ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
@@ -366,11 +366,11 @@ Makefile: $(version-obj-y)
 # Build libraries

 libqemustub.a: $(stub-obj-y)
-libqemuutil.a: $(util-obj-y)
+libqemuutil.a: $(util-obj-y) $(trace-obj-y)

 ######################################################################

-COMMON_LDADDS =3D $(trace-obj-y) libqemuutil.a libqemustub.a
+COMMON_LDADDS =3D libqemuutil.a libqemustub.a

 qemu-img.o: qemu-img-cmds.h

diff --git a/Makefile.target b/Makefile.target
index d5ff0c7..69239e0 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -185,8 +185,7 @@ dummy :=3D $(call unnest-vars,.., \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
-               common-obj-m \
-               trace-obj-y)
+               common-obj-m)
 target-obj-y :=3D $(target-obj-y-save)
 all-obj-y +=3D $(common-obj-y)
 all-obj-y +=3D $(target-obj-y)
@@ -198,7 +197,7 @@ all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)

 $(QEMU_PROG_BUILD): config-devices.mak

-COMMON_LDADDS =3D $(trace-obj-y) ../libqemuutil.a ../libqemustub.a
+COMMON_LDADDS =3D ../libqemuutil.a ../libqemustub.a

 # build either PROG or PROGW
 $(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f3de81f..579ec07 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -519,7 +519,7 @@ QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests


 # Deps that are common to various different sets of tests below
-test-util-obj-y =3D $(trace-obj-y) libqemuutil.a libqemustub.a
+test-util-obj-y =3D libqemuutil.a libqemustub.a
 test-qom-obj-y =3D $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y =3D tests/test-qapi-visit.o tests/test-qapi-types.o \
        tests/test-qapi-event.o tests/test-qmp-introspect.o \
