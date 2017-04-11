Received: from eggs.gnu.org ([2001:4830:134:3::10]:53605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andr2000@gmail.com>) id 1cxsDP-0001SC-Qu
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andr2000@gmail.com>) id 1cxsDL-00066i-PD
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:35:59 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:32886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andr2000@gmail.com>) id 1cxsDL-000622-Ij
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:35:55 -0400
Received: by mail-wr0-x243.google.com with SMTP id l28so7497799wre.0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 02:35:54 -0700 (PDT)
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Date: Tue, 11 Apr 2017 12:35:46 +0300
Message-Id: <1491903346-16075-1-git-send-email-andr2000@gmail.com>
Subject: [Qemu-devel] [Xen-devel][PATCH] configure: introduce
 --enable-xen-fb-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: joculator@gmail.com, al1img@gmail.com, vlad.babchuk@gmail.com, andrii.anisov@gmail.com, olekstysh@gmail.com, andr2000@gmail.com, sstabellini@kernel.org, anthony.perard@citrix.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

For some use cases when Xen framebuffer/input backend
is not a part of Qemu it is required to disable it,
because of conflicting access to input/display devices.
Introduce additional configuration option for explicit
input/display control.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 configure                 | 18 ++++++++++++++++++
 hw/display/Makefile.objs  |  2 +-
 hw/xen/xen_backend.c      |  2 ++
 hw/xenpv/xen_machine_pv.c |  4 ++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 476210b1b93f..b805cb908f03 100755
--- a/configure
+++ b/configure
@@ -220,6 +220,7 @@ xen=""
 xen_ctrl_version=""
 xen_pv_domain_build="no"
 xen_pci_passthrough=""
+xen_fb_backend=""
 linux_aio=""
 cap_ng=""
 attr=""
@@ -909,6 +910,10 @@ for opt do
   ;;
   --enable-xen-pv-domain-build) xen_pv_domain_build="yes"
   ;;
+  --disable-xen-fb-backend) xen_fb_backend="no"
+  ;;
+  --enable-xen-fb-backend) xen_fb_backend="yes"
+  ;;
   --disable-brlapi) brlapi="no"
   ;;
   --enable-brlapi) brlapi="yes"
@@ -1368,6 +1373,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   virtfs          VirtFS
   xen             xen backend driver support
   xen-pci-passthrough
+  xen-fb-backend  framebuffer/input backend support
   brlapi          BrlAPI (Braile)
   curl            curl connectivity
   fdt             fdt device tree
@@ -2213,6 +2219,15 @@ if test "$xen_pv_domain_build" = "yes" &&
 	       "which requires Xen support."
 fi
 
+if test "$xen_fb_backend" != "no"; then
+   if test "$xen" = "yes"; then
+     xen_fb_backend=yes
+   else
+     error_exit "User requested feature Xen framebufer backend support" \
+                " but this feature requires Xen support."
+   fi
+fi
+
 ##########################################
 # Sparse probe
 if test "$sparse" != "no" ; then
@@ -5444,6 +5459,9 @@ if test "$xen" = "yes" ; then
   if test "$xen_pv_domain_build" = "yes" ; then
     echo "CONFIG_XEN_PV_DOMAIN_BUILD=y" >> $config_host_mak
   fi
+  if test "$xen_fb_backend" = "yes" ; then
+    echo "CONFIG_XEN_FB_BACKEND=y" >> $config_host_mak
+  fi
 fi
 if test "$linux_aio" = "yes" ; then
   echo "CONFIG_LINUX_AIO=y" >> $config_host_mak
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 063889beaf4a..f5ec97ed4f48 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -5,7 +5,7 @@ common-obj-$(CONFIG_JAZZ_LED) += jazz_led.o
 common-obj-$(CONFIG_PL110) += pl110.o
 common-obj-$(CONFIG_SSD0303) += ssd0303.o
 common-obj-$(CONFIG_SSD0323) += ssd0323.o
-common-obj-$(CONFIG_XEN_BACKEND) += xenfb.o
+common-obj-$(CONFIG_XEN_FB_BACKEND) += xenfb.o
 
 common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
 common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index d1190041ae12..5146cbba6ca5 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -582,7 +582,9 @@ void xen_be_register_common(void)
     xen_set_dynamic_sysbus();
 
     xen_be_register("console", &xen_console_ops);
+#ifdef CONFIG_XEN_FB_BACKEND
     xen_be_register("vkbd", &xen_kbdmouse_ops);
+#endif
     xen_be_register("qdisk", &xen_blkdev_ops);
 #ifdef CONFIG_USB_LIBUSB
     xen_be_register("qusb", &xen_usb_ops);
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 79aef4ecc37b..b731344c3f0a 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -68,7 +68,9 @@ static void xen_init_pv(MachineState *machine)
     }
 
     xen_be_register_common();
+#ifdef CONFIG_XEN_FB_BACKEND
     xen_be_register("vfb", &xen_framebuffer_ops);
+#endif
     xen_be_register("qnic", &xen_netdev_ops);
 
     /* configure framebuffer */
@@ -95,8 +97,10 @@ static void xen_init_pv(MachineState *machine)
     /* config cleanup hook */
     atexit(xen_config_cleanup);
 
+#ifdef CONFIG_XEN_FB_BACKEND
     /* setup framebuffer */
     xen_init_display(xen_domid);
+#endif
 }
 
 static void xenpv_machine_init(MachineClass *mc)
-- 
2.7.4
