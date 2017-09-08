Received: from eggs.gnu.org ([2001:4830:134:3::10]:42194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1N-00005U-Sd
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1J-0005BH-80
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG1J-0005Ac-20
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:17 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:55:02 +0800
Message-Id: <20170908095506.13594-35-famz@redhat.com>
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/38] buildsys: Move libcacard cflags/libs to
 per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170907082918.7299-8-famz@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure            | 4 ++--
 hw/usb/Makefile.objs | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 385ed51a18..e430df0582 100755
--- a/configure
+++ b/configure
@@ -4241,8 +4241,6 @@ if test "$smartcard" !=3D "no"; then
     if $pkg_config libcacard; then
         libcacard_cflags=3D$($pkg_config --cflags libcacard)
         libcacard_libs=3D$($pkg_config --libs libcacard)
-        QEMU_CFLAGS=3D"$QEMU_CFLAGS $libcacard_cflags"
-        libs_softmmu=3D"$libs_softmmu $libcacard_libs"
         smartcard=3D"yes"
     else
         if test "$smartcard" =3D "yes"; then
@@ -5830,6 +5828,8 @@ fi
=20
 if test "$smartcard" =3D "yes" ; then
   echo "CONFIG_SMARTCARD=3Dy" >> $config_host_mak
+  echo "SMARTCARD_CFLAGS=3D$libcacard_cflags" >> $config_host_mak
+  echo "SMARTCARD_LIBS=3D$libcacard_libs" >> $config_host_mak
 fi
=20
 if test "$libusb" =3D "yes" ; then
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 97f1c4561a..795ff25a5e 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -26,8 +26,10 @@ common-obj-$(CONFIG_USB_BLUETOOTH)    +=3D dev-bluetoo=
th.o
=20
 ifeq ($(CONFIG_USB_SMARTCARD),y)
 common-obj-y                          +=3D dev-smartcard-reader.o
-common-obj-$(CONFIG_SMARTCARD)        +=3D ccid-card-passthru.o
-common-obj-$(CONFIG_SMARTCARD)        +=3D ccid-card-emulated.o
+common-obj-$(CONFIG_SMARTCARD)        +=3D smartcard.mo
+smartcard.mo-objs :=3D ccid-card-passthru.o ccid-card-emulated.o
+smartcard.mo-cflags :=3D $(SMARTCARD_CFLAGS)
+smartcard.mo-libs :=3D $(SMARTCARD_LIBS)
 endif
=20
 ifeq ($(CONFIG_POSIX),y)
--=20
2.13.5
