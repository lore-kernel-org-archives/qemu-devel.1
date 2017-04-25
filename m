Received: from eggs.gnu.org ([2001:4830:134:3::10]:52348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d35JW-000896-6P
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d35JS-0005sm-Vz
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:35:50 -0400
Received: from mail.kernel.org ([198.145.29.136]:50310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d35JS-0005sK-Pm
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:35:46 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 25 Apr 2017 11:35:09 -0700
Message-Id: <1493145313-31311-17-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1493145313-31311-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1704251134220.2875@sstabellini-ThinkPad-X260>
	<1493145313-31311-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH 17/21] xen/9pfs: build and register Xen 9pfs
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@gmail.com, sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, jgross@suse.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

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
index 32197e6..cab5e94 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -5,5 +5,6 @@ common-obj-y += coth.o cofs.o codir.o cofile.o
 common-obj-y += coxattr.o 9p-synth.o
 common-obj-$(CONFIG_OPEN_BY_HANDLE) +=  9p-handle.o
 common-obj-y += 9p-proxy.o
+common-obj-$(CONFIG_XEN) += xen-9p-backend.o
 
 obj-y += virtio-9p-device.o
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index d34c49e..c85f163 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -583,6 +583,9 @@ void xen_be_register_common(void)
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
index 30811a1..852c2ea 100644
--- a/include/hw/xen/xen_backend.h
+++ b/include/hw/xen/xen_backend.h
@@ -47,6 +47,9 @@ extern struct XenDevOps xen_console_ops;      /* xen_console.c     */
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
