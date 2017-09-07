Received: from eggs.gnu.org ([2001:4830:134:3::10]:35573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsC9-00079L-2B
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsC4-0001qr-ED
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsC4-0001qe-7v
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B2B861473
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:29:47 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:29:18 +0800
Message-Id: <20170907082918.7299-10-famz@redhat.com>
In-Reply-To: <20170907082918.7299-1-famz@redhat.com>
References: <20170907082918.7299-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 9/9] buildsys: Move usb redir cflags/libs to
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
 hw/usb/Makefile.objs | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index bee1302155..763a65f156 100755
--- a/configure
+++ b/configure
@@ -4266,8 +4266,6 @@ if test "$usb_redir" != "no" ; then
         usb_redir="yes"
         usb_redir_cflags=$($pkg_config --cflags libusbredirparser-0.5)
         usb_redir_libs=$($pkg_config --libs libusbredirparser-0.5)
-        QEMU_CFLAGS="$QEMU_CFLAGS $usb_redir_cflags"
-        libs_softmmu="$libs_softmmu $usb_redir_libs"
     else
         if test "$usb_redir" = "yes"; then
             feature_not_found "usb-redir" "Install usbredir devel"
@@ -5839,6 +5837,8 @@ fi
 
 if test "$usb_redir" = "yes" ; then
   echo "CONFIG_USB_REDIR=y" >> $config_host_mak
+  echo "USB_REDIR_CFLAGS=$usb_redir_cflags" >> $config_host_mak
+  echo "USB_REDIR_LIBS=$usb_redir_libs" >> $config_host_mak
 fi
 
 if test "$opengl" = "yes" ; then
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 9ce9eadb47..92eb199697 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -38,6 +38,8 @@ endif
 
 # usb redirection
 common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
+redirect.o-cflags = $(USB_REDIR_CFLAGS)
+redirect.o-libs = $(USB_REDIR_LIBS)
 
 # usb pass-through
 common-obj-y += $(patsubst %,host-%.o,$(HOST_USB))
-- 
2.13.5
