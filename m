Received: from eggs.gnu.org ([2001:4830:134:3::10]:54142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnZp6-0000Qi-Ao
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnZp5-0004rF-95
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:56:20 -0400
Received: from mail.kernel.org ([198.145.29.136]:46916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cnZp5-0004qH-2G
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:56:19 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon, 13 Mar 2017 16:56:00 -0700
Message-Id: <1489449360-14411-9-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1489449360-14411-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH v2 9/9] xen/9pfs: build and register Xen 9pfs
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org, anthony.perard@citrix.com, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, jgross@suse.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
CC: anthony.perard@citrix.com
CC: jgross@suse.com
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/Makefile.objs        | 1 +
 hw/xen/xen_backend.c         | 3 +++
 include/hw/xen/xen_backend.h | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index da0ae0c..673f9f9 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -5,5 +5,6 @@ common-obj-y += coth.o cofs.o codir.o cofile.o
 common-obj-y += coxattr.o 9p-synth.o
 common-obj-$(CONFIG_OPEN_BY_HANDLE) +=  9p-handle.o
 common-obj-y += 9p-proxy.o
+common-obj-$(CONFIG_XEN_BACKEND) += xen-9p-backend.o
 
 obj-y += virtio-9p-device.o
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 6c21c37..fe737e9 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -585,6 +585,9 @@ void xen_be_register_common(void)
     xen_be_register("console", &xen_console_ops);
     xen_be_register("vkbd", &xen_kbdmouse_ops);
     xen_be_register("qdisk", &xen_blkdev_ops);
+#ifdef CONFIG_VIRTFS
+    xen_be_register("9pfs", &xen_9pfs_ops);
+#endif
 #ifdef CONFIG_USB_LIBUSB
     xen_be_register("qusb", &xen_usb_ops);
 #endif
diff --git a/include/hw/xen/xen_backend.h b/include/hw/xen/xen_backend.h
index 4f4799a..7b72f1a 100644
--- a/include/hw/xen/xen_backend.h
+++ b/include/hw/xen/xen_backend.h
@@ -49,6 +49,9 @@ extern struct XenDevOps xen_console_ops;      /* xen_console.c     */
 extern struct XenDevOps xen_kbdmouse_ops;     /* xen_framebuffer.c */
 extern struct XenDevOps xen_framebuffer_ops;  /* xen_framebuffer.c */
 extern struct XenDevOps xen_blkdev_ops;       /* xen_disk.c        */
+#ifdef CONFIG_VIRTFS
+extern struct XenDevOps xen_9pfs_ops;       /* xen-9p-backend.c        */
+#endif
 extern struct XenDevOps xen_netdev_ops;       /* xen_nic.c         */
 #ifdef CONFIG_USB_LIBUSB
 extern struct XenDevOps xen_usb_ops;          /* xen-usb.c         */
-- 
1.9.1
