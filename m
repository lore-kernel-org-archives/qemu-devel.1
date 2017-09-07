Received: from eggs.gnu.org ([2001:4830:134:3::10]:35541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsC3-00074q-Gg
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsC2-0001qI-L9
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsC2-0001qA-Ep
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8161C61473
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:29:45 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:29:17 +0800
Message-Id: <20170907082918.7299-9-famz@redhat.com>
In-Reply-To: <20170907082918.7299-1-famz@redhat.com>
References: <20170907082918.7299-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 8/9] buildsys: Move libusb cflags/libs to per
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure            | 4 ++--
 hw/usb/Makefile.objs | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 85fef3d16f..bee1302155 100755
--- a/configure
+++ b/configure
@@ -4252,8 +4252,6 @@ if test "$libusb" != "no" ; then
         libusb="yes"
         libusb_cflags=$($pkg_config --cflags libusb-1.0)
         libusb_libs=$($pkg_config --libs libusb-1.0)
-        QEMU_CFLAGS="$QEMU_CFLAGS $libusb_cflags"
-        libs_softmmu="$libs_softmmu $libusb_libs"
     else
         if test "$libusb" = "yes"; then
             feature_not_found "libusb" "Install libusb devel >= 1.0.13"
@@ -5835,6 +5833,8 @@ fi
 
 if test "$libusb" = "yes" ; then
   echo "CONFIG_USB_LIBUSB=y" >> $config_host_mak
+  echo "LIBUSB_CFLAGS=$libusb_cflags" >> $config_host_mak
+  echo "LIBUSB_LIBS=$libusb_libs" >> $config_host_mak
 fi
 
 if test "$usb_redir" = "yes" ; then
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 795ff25a5e..9ce9eadb47 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -42,6 +42,11 @@ common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
 # usb pass-through
 common-obj-y += $(patsubst %,host-%.o,$(HOST_USB))
 
+host-libusb.o-cflags := $(LIBUSB_CFLAGS)
+host-libusb.o-libs := $(LIBUSB_LIBS)
+
 ifeq ($(CONFIG_USB_LIBUSB),y)
 common-obj-$(CONFIG_XEN) += xen-usb.o
+xen-usb.o-cflags := $(LIBUSB_CFLAGS)
+xen-usb.o-libs := $(LIBUSB_LIBS)
 endif
-- 
2.13.5
