Received: from eggs.gnu.org ([2001:4830:134:3::10]:35558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsC5-00076G-EW
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsC0-0001px-SP
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsC0-0001pm-M0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA46BC047B6C
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:29:43 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:29:16 +0800
Message-Id: <20170907082918.7299-8-famz@redhat.com>
In-Reply-To: <20170907082918.7299-1-famz@redhat.com>
References: <20170907082918.7299-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 7/9] buildsys: Move libcacard cflags/libs to
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure            | 4 ++--
 hw/usb/Makefile.objs | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index b1320b1994..85fef3d16f 100755
--- a/configure
+++ b/configure
@@ -4237,8 +4237,6 @@ if test "$smartcard" != "no"; then
     if $pkg_config libcacard; then
         libcacard_cflags=$($pkg_config --cflags libcacard)
         libcacard_libs=$($pkg_config --libs libcacard)
-        QEMU_CFLAGS="$QEMU_CFLAGS $libcacard_cflags"
-        libs_softmmu="$libs_softmmu $libcacard_libs"
         smartcard="yes"
     else
         if test "$smartcard" = "yes"; then
@@ -5831,6 +5829,8 @@ fi
 
 if test "$smartcard" = "yes" ; then
   echo "CONFIG_SMARTCARD=y" >> $config_host_mak
+  echo "SMARTCARD_CFLAGS=$libcacard_cflags" >> $config_host_mak
+  echo "SMARTCARD_LIBS=$libcacard_libs" >> $config_host_mak
 fi
 
 if test "$libusb" = "yes" ; then
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 97f1c4561a..795ff25a5e 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -26,8 +26,10 @@ common-obj-$(CONFIG_USB_BLUETOOTH)    += dev-bluetooth.o
 
 ifeq ($(CONFIG_USB_SMARTCARD),y)
 common-obj-y                          += dev-smartcard-reader.o
-common-obj-$(CONFIG_SMARTCARD)        += ccid-card-passthru.o
-common-obj-$(CONFIG_SMARTCARD)        += ccid-card-emulated.o
+common-obj-$(CONFIG_SMARTCARD)        += smartcard.mo
+smartcard.mo-objs := ccid-card-passthru.o ccid-card-emulated.o
+smartcard.mo-cflags := $(SMARTCARD_CFLAGS)
+smartcard.mo-libs := $(SMARTCARD_LIBS)
 endif
 
 ifeq ($(CONFIG_POSIX),y)
-- 
2.13.5
