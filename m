Received: from eggs.gnu.org ([2001:4830:134:3::10]:50511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evmAC-00014I-UR
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evmA9-0005Sh-Py
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:48:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evmA9-0005SC-K7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:48:29 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Mar 2018 16:48:26 +0100
Message-Id: <20180313154826.20436-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dri-devel@lists.freedesktop.org
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Sumit Semwal <sumit.semwal@linaro.org>, open list <linux-kernel@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING
	FRAMEWORK" <linaro-mm-sig@lists.linaro.org>

A driver to let userspace turn iovecs into dma-bufs.

Use case:  Allows qemu pass around dmabufs for the guest framebuffer.
https://www.kraxel.org/cgit/qemu/log/?h=sirius/udmabuf has an
experimental patch.

Also allows qemu to export guest virtio-gpu resources as host dmabufs.
Should be possible to use it to display guest wayland windows on the
host display server.  virtio-gpu ressources can be chunked so we will
actually need multiple iovec entries.  UNTESTED.

Want collect some feedback on the general approach with this RfC series.
Can this work?  If not, better ideas?

Question:  Must this be hooked into some kind of mlock accounting, to
limit the amout of memory userspace is allowed to pin this way?  Or will
get_user_pages_fast() handle that for me?

Known issue:  Driver API isn't complete yet.  Need add some flags, for
example to support read-only buffers.

Cc: David Airlie <airlied@linux.ie>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/udmabuf.h |  21 ++++
 drivers/dma-buf/udmabuf.c    | 250 +++++++++++++++++++++++++++++++++++++++++++
 drivers/dma-buf/Kconfig      |   7 ++
 drivers/dma-buf/Makefile     |   1 +
 4 files changed, 279 insertions(+)
 create mode 100644 include/uapi/linux/udmabuf.h
 create mode 100644 drivers/dma-buf/udmabuf.c

diff --git a/include/uapi/linux/udmabuf.h b/include/uapi/linux/udmabuf.h
new file mode 100644
index 0000000000..fd2fa441fe
--- /dev/null
+++ b/include/uapi/linux/udmabuf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_UDMABUF_H
+#define _UAPI_LINUX_UDMABUF_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+struct udmabuf_iovec {
+	__u64 base;
+	__u64 len;
+};
+
+struct udmabuf_create {
+	__u32 flags;
+	__u32 niov;
+	struct udmabuf_iovec iovs[];
+};
+
+#define UDMABUF_CREATE _IOW(0x42, 0x23, struct udmabuf_create)
+
+#endif /* _UAPI_LINUX_UDMABUF_H */
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
new file mode 100644
index 0000000000..ec012d7ac7
--- /dev/null
+++ b/drivers/dma-buf/udmabuf.c
@@ -0,0 +1,250 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/miscdevice.h>
+#include <linux/dma-buf.h>
+#include <linux/highmem.h>
+
+#include <uapi/linux/udmabuf.h>
+
+struct udmabuf {
+	u32 pagecount;
+	struct page **pages;
+};
+
+static int udmabuf_vm_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct udmabuf *ubuf = vma->vm_private_data;
+
+	if (WARN_ON(vmf->pgoff >= ubuf->pagecount))
+		return VM_FAULT_SIGBUS;
+
+	vmf->page = ubuf->pages[vmf->pgoff];
+	get_page(vmf->page);
+	return 0;
+}
+
+static const struct vm_operations_struct udmabuf_vm_ops = {
+	.fault = udmabuf_vm_fault,
+};
+
+static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
+{
+	struct udmabuf *ubuf = buf->priv;
+
+	if ((vma->vm_flags & VM_SHARED) == 0)
+		return -EINVAL;
+
+	vma->vm_ops = &udmabuf_vm_ops;
+	vma->vm_private_data = ubuf;
+	return 0;
+}
+
+static struct sg_table *map_udmabuf(struct dma_buf_attachment *at,
+				    enum dma_data_direction direction)
+{
+	struct udmabuf *ubuf = at->dmabuf->priv;
+	struct sg_table *sg;
+
+	sg = kzalloc(sizeof(*sg), GFP_KERNEL);
+	if (!sg)
+		goto err1;
+	if (sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount,
+				      0, ubuf->pagecount << PAGE_SHIFT,
+				      GFP_KERNEL) < 0)
+		goto err2;
+	if (!dma_map_sg(at->dev, sg->sgl, sg->nents, direction))
+		goto err3;
+
+	return sg;
+
+err3:
+	sg_free_table(sg);
+err2:
+	kfree(sg);
+err1:
+	return ERR_PTR(-ENOMEM);
+}
+
+static void unmap_udmabuf(struct dma_buf_attachment *at,
+			  struct sg_table *sg,
+			  enum dma_data_direction direction)
+{
+	sg_free_table(sg);
+	kfree(sg);
+}
+
+static void release_udmabuf(struct dma_buf *buf)
+{
+	struct udmabuf *ubuf = buf->priv;
+	pgoff_t pg;
+
+	for (pg = 0; pg < ubuf->pagecount; pg++)
+		put_page(ubuf->pages[pg]);
+	kfree(ubuf->pages);
+	kfree(ubuf);
+}
+
+static void *kmap_atomic_udmabuf(struct dma_buf *buf, unsigned long offset)
+{
+	struct udmabuf *ubuf = buf->priv;
+	struct page *page = ubuf->pages[offset >> PAGE_SHIFT];
+
+	return kmap_atomic(page);
+}
+
+static void *kmap_udmabuf(struct dma_buf *buf, unsigned long offset)
+{
+	struct udmabuf *ubuf = buf->priv;
+	struct page *page = ubuf->pages[offset >> PAGE_SHIFT];
+
+	return kmap(page);
+}
+
+static struct dma_buf_ops udmabuf_ops = {
+	.map_dma_buf	  = map_udmabuf,
+	.unmap_dma_buf	  = unmap_udmabuf,
+	.release	  = release_udmabuf,
+	.map_atomic	  = kmap_atomic_udmabuf,
+	.map		  = kmap_udmabuf,
+	.mmap		  = mmap_udmabuf,
+};
+
+static long udmabuf_ioctl_create(struct file *filp, unsigned long arg)
+{
+	struct udmabuf_create create;
+	struct udmabuf_iovec *iovs;
+	struct udmabuf *ubuf;
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct dma_buf *buf;
+	pgoff_t pgoff, pgcnt;
+	u32 iov;
+	int ret;
+
+	if (copy_from_user(&create, (void __user *)arg,
+			   sizeof(struct udmabuf_create)))
+		return -EFAULT;
+
+	iovs = kmalloc_array(create.niov, sizeof(struct udmabuf_iovec),
+			     GFP_KERNEL);
+	if (!iovs)
+		return -ENOMEM;
+
+	arg += offsetof(struct udmabuf_create, iovs);
+	ret = -EFAULT;
+	if (copy_from_user(iovs, (void __user *)arg,
+			   create.niov * sizeof(struct udmabuf_iovec)))
+		goto err_free_iovs;
+
+	ubuf = kzalloc(sizeof(struct udmabuf), GFP_KERNEL);
+	if (!ubuf)
+		goto err_free_iovs;
+
+	ret = -EINVAL;
+	for (iov = 0; iov < create.niov; iov++) {
+		if (!IS_ALIGNED(iovs[iov].base, PAGE_SIZE))
+			goto err_free_iovs;
+		if (!IS_ALIGNED(iovs[iov].len, PAGE_SIZE))
+			goto err_free_iovs;
+		ubuf->pagecount += iovs[iov].len >> PAGE_SHIFT;
+	}
+
+	ret = -ENOMEM;
+	ubuf->pages = kmalloc_array(ubuf->pagecount, sizeof(struct page*),
+				    GFP_KERNEL);
+	if (!ubuf->pages)
+		goto err_free_buf;
+
+	pgoff = 0;
+	for (iov = 0; iov < create.niov; iov++) {
+		pgcnt = iovs[iov].len >> PAGE_SHIFT;
+		while (pgcnt > 0) {
+			ret = get_user_pages_fast(iovs[iov].base, pgcnt,
+						  true, /* write */
+						  ubuf->pages + pgoff);
+			if (ret < 0)
+				goto err_put_pages;
+			pgoff += ret;
+			pgcnt -= ret;
+		}
+	}
+
+	exp_info.ops  = &udmabuf_ops;
+	exp_info.size = ubuf->pagecount << PAGE_SHIFT;
+	exp_info.priv = ubuf;
+
+	buf = dma_buf_export(&exp_info);
+	if (IS_ERR(buf)) {
+		ret = PTR_ERR(buf);
+		goto err_put_pages;
+	}
+
+	kfree(iovs);
+	return dma_buf_fd(buf, 0);
+
+err_put_pages:
+	while (pgoff > 0)
+		put_page(ubuf->pages[--pgoff]);
+err_free_buf:
+	kfree(ubuf->pages);
+	kfree(ubuf);
+err_free_iovs:
+	kfree(iovs);
+	return ret;
+}
+
+static long udmabuf_ioctl(struct file *filp, unsigned int ioctl,
+				  unsigned long arg)
+{
+	long ret;
+
+	switch (ioctl) {
+	case UDMABUF_CREATE:
+		ret = udmabuf_ioctl_create(filp, arg);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static const struct file_operations udmabuf_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl = udmabuf_ioctl,
+};
+
+static struct miscdevice udmabuf_misc = {
+	.minor          = MISC_DYNAMIC_MINOR,
+	.name           = "udmabuf",
+	.fops           = &udmabuf_fops,
+};
+
+static int __init udmabuf_dev_init(void)
+{
+	int ret;
+
+	ret = misc_register(&udmabuf_misc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void __exit udmabuf_dev_exit(void)
+{
+	misc_deregister(&udmabuf_misc);
+}
+
+module_init(udmabuf_dev_init)
+module_exit(udmabuf_dev_exit)
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index ed3b785bae..5876b52554 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -30,4 +30,11 @@ config SW_SYNC
 	  WARNING: improper use of this can result in deadlocking kernel
 	  drivers from userspace. Intended for test and debug only.
 
+config UDMABUF
+	tristate "userspace dmabuf misc driver"
+	default n
+	depends on DMA_SHARED_BUFFER
+	---help---
+	  A driver to let userspace turn iovs into dma-bufs.
+
 endmenu
diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
index c33bf88631..0913a6ccab 100644
--- a/drivers/dma-buf/Makefile
+++ b/drivers/dma-buf/Makefile
@@ -1,3 +1,4 @@
 obj-y := dma-buf.o dma-fence.o dma-fence-array.o reservation.o seqno-fence.o
 obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
 obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
+obj-$(CONFIG_UDMABUF)		+= udmabuf.o
-- 
2.9.3
