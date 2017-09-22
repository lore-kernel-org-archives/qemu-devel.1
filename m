Received: from eggs.gnu.org ([2001:4830:134:3::10]:37776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgU-0008CG-6t
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgT-000116-7Q
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIgT-00010q-1h
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:40 +0800
Message-Id: <20170922074659.30097-18-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/36] buildsys: Move libcacard cflags/libs to
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
index fd544e7b55..c5d5f02c08 100755
--- a/configure
+++ b/configure
@@ -4206,8 +4206,6 @@ if test "$smartcard" !=3D "no"; then
     if $pkg_config libcacard; then
         libcacard_cflags=3D$($pkg_config --cflags libcacard)
         libcacard_libs=3D$($pkg_config --libs libcacard)
-        QEMU_CFLAGS=3D"$QEMU_CFLAGS $libcacard_cflags"
-        libs_softmmu=3D"$libs_softmmu $libcacard_libs"
         smartcard=3D"yes"
     else
         if test "$smartcard" =3D "yes"; then
@@ -5785,6 +5783,8 @@ fi
=20
 if test "$smartcard" =3D "yes" ; then
   echo "CONFIG_SMARTCARD=3Dy" >> $config_host_mak
+  echo "SMARTCARD_CFLAGS=3D$libcacard_cflags" >> $config_host_mak
+  echo "SMARTCARD_LIBS=3D$libcacard_libs" >> $config_host_mak
 fi
=20
 if test "$libusb" =3D "yes" ; then
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 757e365562..9aceb6cc3d 100644
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
