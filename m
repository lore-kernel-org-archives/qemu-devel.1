Received: from eggs.gnu.org ([2001:4830:134:3::10]:42218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1P-00007A-OO
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1L-0005Cp-62
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG1K-0005CG-W8
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:55:03 +0800
Message-Id: <20170908095506.13594-36-famz@redhat.com>
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/38] buildsys: Move libusb cflags/libs to per
 object
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
Message-Id: <20170907082918.7299-9-famz@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure            | 4 ++--
 hw/usb/Makefile.objs | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index e430df0582..18368670b1 100755
--- a/configure
+++ b/configure
@@ -4256,8 +4256,6 @@ if test "$libusb" !=3D "no" ; then
         libusb=3D"yes"
         libusb_cflags=3D$($pkg_config --cflags libusb-1.0)
         libusb_libs=3D$($pkg_config --libs libusb-1.0)
-        QEMU_CFLAGS=3D"$QEMU_CFLAGS $libusb_cflags"
-        libs_softmmu=3D"$libs_softmmu $libusb_libs"
     else
         if test "$libusb" =3D "yes"; then
             feature_not_found "libusb" "Install libusb devel >=3D 1.0.13=
"
@@ -5834,6 +5832,8 @@ fi
=20
 if test "$libusb" =3D "yes" ; then
   echo "CONFIG_USB_LIBUSB=3Dy" >> $config_host_mak
+  echo "LIBUSB_CFLAGS=3D$libusb_cflags" >> $config_host_mak
+  echo "LIBUSB_LIBS=3D$libusb_libs" >> $config_host_mak
 fi
=20
 if test "$usb_redir" =3D "yes" ; then
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 795ff25a5e..9ce9eadb47 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -42,6 +42,11 @@ common-obj-$(CONFIG_USB_REDIR) +=3D redirect.o quirks.=
o
 # usb pass-through
 common-obj-y +=3D $(patsubst %,host-%.o,$(HOST_USB))
=20
+host-libusb.o-cflags :=3D $(LIBUSB_CFLAGS)
+host-libusb.o-libs :=3D $(LIBUSB_LIBS)
+
 ifeq ($(CONFIG_USB_LIBUSB),y)
 common-obj-$(CONFIG_XEN) +=3D xen-usb.o
+xen-usb.o-cflags :=3D $(LIBUSB_CFLAGS)
+xen-usb.o-libs :=3D $(LIBUSB_LIBS)
 endif
--=20
2.13.5
