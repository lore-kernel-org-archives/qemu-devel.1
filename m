Received: from eggs.gnu.org ([2001:4830:134:3::10]:42077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1crS4x-0007qC-CU
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1crS4t-0007wD-F8
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:28:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:37707)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1crS4t-0007vg-28
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:28:39 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Fri, 24 Mar 2017 16:28:32 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A3D97E@ORSMSX112.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel]  [PATCH] Create libqemutrace.a for all trace.o
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Daniel Berrange <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Create libqemutrace.a for all trace.o
Currently all trace.o are linked into qemu-system, qemu-img,=20
qemu-nbd, qemu-io etc., even the corresponding components=20
are not included.
Create a libqemutrace.a that the linker would only pull in .o=20
files containing symbols that are actually referenced by the=20
program.
./trace.o, ./qapi/trace.o and ./util/trace.o are added into=20
libqemuutil.a  to avoid recursive dependencies between=20
libqemuutil.a and libqemutrace.a.

Signed-off -by: Anthony Xu <anthony.xu@intel.com>


diff --git a/Makefile b/Makefile
index 6c359b2..565f5c7 100644
--- a/Makefile
+++ b/Makefile
@@ -345,8 +345,8 @@ subdir-dtc:dtc/libfdt dtc/tests
 dtc/%:
        mkdir -p $@

-$(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(chardev-obj=
-y) \
-       $(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY)) $(trace-obj-y)
+$(SUBDIR_RULES): libqemutrace.a libqemuutil.a libqemustub.a $(common-obj-y=
) $(chardev-obj-y) \
+       $(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))

 ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
@@ -367,10 +367,11 @@ Makefile: $(version-obj-y)

 libqemustub.a: $(stub-obj-y)
 libqemuutil.a: $(util-obj-y)
+libqemutrace.a: $(trace-obj-y)

 ######################################################################

-COMMON_LDADDS =3D $(trace-obj-y) libqemuutil.a libqemustub.a
+COMMON_LDADDS =3D libqemutrace.a libqemuutil.a libqemustub.a

 qemu-img.o: qemu-img-cmds.h

diff --git a/Makefile.objs b/Makefile.objs
index 6167e7b..4289ef9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -3,6 +3,7 @@
 stub-obj-y =3D stubs/ crypto/
 util-obj-y =3D util/ qobject/ qapi/
 util-obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
+util-obj-y +=3D $(trace-root-obj-y)

 chardev-obj-y =3D chardev/

@@ -167,8 +168,9 @@ trace-events-subdirs +=3D qapi

 trace-events-files =3D $(SRC_PATH)/trace-events $(trace-events-subdirs:%=
=3D$(SRC_PATH)/%/trace-events)

-trace-obj-y =3D trace-root.o
+trace-root-obj-y =3D trace-root.o
+trace-root-obj-$(CONFIG_TRACE_DTRACE) +=3D trace-dtrace-root.o
+trace-obj-y =3D $(trace-root-obj-y)
 trace-obj-y +=3D $(trace-events-subdirs:%=3D%/trace.o)
 trace-obj-$(CONFIG_TRACE_UST) +=3D trace-ust-all.o
-trace-obj-$(CONFIG_TRACE_DTRACE) +=3D trace-dtrace-root.o
 trace-obj-$(CONFIG_TRACE_DTRACE) +=3D $(trace-events-subdirs:%=3D%/trace-d=
trace.o)
diff --git a/Makefile.target b/Makefile.target
index 7df2b8c..6f508c8 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -201,7 +201,7 @@ all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)

 $(QEMU_PROG_BUILD): config-devices.mak

-COMMON_LDADDS =3D $(trace-obj-y) ../libqemuutil.a ../libqemustub.a
+COMMON_LDADDS =3D ../libqemutrace.a ../libqemuutil.a ../libqemustub.a

 # build either PROG or PROGW
 $(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 33906ff..d543d56 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -4,3 +4,5 @@ util-obj-y +=3D string-input-visitor.o string-output-visito=
r.o
 util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
 util-obj-y +=3D qmp-event.o
 util-obj-y +=3D qapi-util.o
+util-obj-y +=3D  trace.o
+util-obj-$(CONFIG_TRACE_DTRACE) +=3D trace-dtrace.o
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f3de81f..6cbd602 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -519,7 +519,7 @@ QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests


 # Deps that are common to various different sets of tests below
-test-util-obj-y =3D $(trace-obj-y) libqemuutil.a libqemustub.a
+test-util-obj-y =3D libqemutrace.a libqemuutil.a libqemustub.a
 test-qom-obj-y =3D $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y =3D tests/test-qapi-visit.o tests/test-qapi-types.o \
        tests/test-qapi-event.o tests/test-qmp-introspect.o \
diff --git a/util/Makefile.objs b/util/Makefile.objs
index c6205eb..e38b91e 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -43,3 +43,5 @@ util-obj-y +=3D qdist.o
 util-obj-y +=3D qht.o
 util-obj-y +=3D range.o
 util-obj-y +=3D systemd.o
+util-obj-y +=3D  trace.o
+util-obj-$(CONFIG_TRACE_DTRACE) +=3D trace-dtrace.o
                                                          =20
