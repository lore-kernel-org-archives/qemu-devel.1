Received: from eggs.gnu.org ([2001:4830:134:3::10]:45856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCk-0000h9-Ce
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCj-00018U-BB
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbCj-00017s-1o
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:49 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:01 +0400
Message-Id: <20170131162122.29408-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/41] char: move to chardev/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following commits will split char.c in several files. Let's put them
in a subdirectory.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-char.c =3D> chardev/char.c | 0
 MAINTAINERS                   | 2 +-
 Makefile.objs                 | 2 +-
 chardev/Makefile.objs         | 1 +
 tests/Makefile.include        | 8 +++++---
 5 files changed, 8 insertions(+), 5 deletions(-)
 rename qemu-char.c =3D> chardev/char.c (100%)
 create mode 100644 chardev/Makefile.objs

diff --git a/qemu-char.c b/chardev/char.c
similarity index 100%
rename from qemu-char.c
rename to chardev/char.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 5efd8cc671..497ca54627 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1196,7 +1196,7 @@ Character device backends
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
 S: Maintained
-F: qemu-char.c
+F: chardev/
 F: backends/msmouse.c
 F: backends/testdev.c
=20
diff --git a/Makefile.objs b/Makefile.objs
index 01cef866e4..cad4c54740 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -51,7 +51,7 @@ common-obj-$(CONFIG_POSIX) +=3D os-posix.o
 common-obj-$(CONFIG_LINUX) +=3D fsdev/
=20
 common-obj-y +=3D migration/
-common-obj-y +=3D qemu-char.o #aio.o
+common-obj-y +=3D chardev/ #aio.o
 common-obj-y +=3D page_cache.o
=20
 common-obj-$(CONFIG_SPICE) +=3D spice-qemu-char.o
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
new file mode 100644
index 0000000000..3fc5539518
--- /dev/null
+++ b/chardev/Makefile.objs
@@ -0,0 +1 @@
+common-obj-y +=3D char.o
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 33b4f88746..2145b9877d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -9,7 +9,7 @@ SYSEMU_TARGET_LIST :=3D $(subst -softmmu.mak,,$(notdir \
 check-unit-y =3D tests/check-qdict$(EXESUF)
 gcov-files-check-qdict-y =3D qobject/qdict.c
 check-unit-y +=3D tests/test-char$(EXESUF)
-gcov-files-check-qdict-y =3D qemu-char.c
+gcov-files-check-qdict-y =3D chardev/char.c
 check-unit-y +=3D tests/check-qfloat$(EXESUF)
 gcov-files-check-qfloat-y =3D qobject/qfloat.c
 check-unit-y +=3D tests/check-qint$(EXESUF)
@@ -510,7 +510,8 @@ tests/check-qjson$(EXESUF): tests/check-qjson.o $(tes=
t-util-obj-y)
 tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-q=
om-obj-y)
 tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom=
-obj-y)
=20
-tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $(t=
est-util-obj-y) $(qtest-obj-y) $(test-block-obj-y)
+tests/test-char$(EXESUF): tests/test-char.o chardev/char.o qemu-timer.o =
\
+	$(test-util-obj-y) $(qtest-obj-y) $(test-block-obj-y)
 tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y=
)
 tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
 tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
@@ -703,7 +704,8 @@ tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-=
test.o $(libqos-usb-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb=
-obj-y)
 tests/pc-cpu-test$(EXESUF): tests/pc-cpu-test.o
 tests/postcopy-test$(EXESUF): tests/postcopy-test.o
-tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o qemu-char.o qemu=
-timer.o $(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-=
pc-obj-y)
+tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o chardev/char.o q=
emu-timer.o \
+	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-=
y)
 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket=
_scm_helper.o
 tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
 tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test=
-block-obj-y)
--=20
2.11.0.295.gd7dffce1c.dirty
