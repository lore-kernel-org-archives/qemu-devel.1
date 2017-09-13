Received: from eggs.gnu.org ([2001:4830:134:3::10]:49257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds41v-00068G-6p
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds41s-0004Kg-35
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds41r-0004Jx-Tn
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0744281DF6
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:32:19 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 11:32:14 +0200
Message-Id: <20170913093215.10043-4-kraxel@redhat.com>
In-Reply-To: <20170913093215.10043-1-kraxel@redhat.com>
References: <20170913093215.10043-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] usb: drop HOST_USB
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

Nowdays we use libusb for usb-host, so we don't have different code
for linux vs. bsd any more.  So there is little reason to have the
HOST_USB variable, we can just write things directly into the Makefile
and avoid a pointless indirection.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20170908111217.21985-2-kraxel@redhat.com
---
 configure            | 7 -------
 hw/usb/Makefile.objs | 6 +++++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index fd7e3a5e81..5367260c80 100755
--- a/configure
+++ b/configure
@@ -5967,13 +5967,6 @@ if test "$live_block_migration" = "yes" ; then
   echo "CONFIG_LIVE_BLOCK_MIGRATION=y" >> $config_host_mak
 fi
 
-# USB host support
-if test "$libusb" = "yes"; then
-  echo "HOST_USB=libusb legacy" >> $config_host_mak
-else
-  echo "HOST_USB=stub" >> $config_host_mak
-fi
-
 # TPM passthrough support?
 if test "$tpm" = "yes"; then
   echo 'CONFIG_TPM=$(CONFIG_SOFTMMU)' >> $config_host_mak
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 97f1c4561a..a43ebbc17f 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -38,7 +38,11 @@ endif
 common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
 
 # usb pass-through
-common-obj-y += $(patsubst %,host-%.o,$(HOST_USB))
+ifeq ($(CONFIG_LIBUSB),y)
+common-obj-y += host-libusb.o host-legacy.o
+else
+common-obj-y += host-stub.o
+endif
 
 ifeq ($(CONFIG_USB_LIBUSB),y)
 common-obj-$(CONFIG_XEN) += xen-usb.o
-- 
2.9.3
