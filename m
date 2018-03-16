Received: from eggs.gnu.org ([2001:4830:134:3::10]:39073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ckoenig.leichtzumerken@gmail.com>)
	id 1ewoVa-0001LQ-Vd
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ckoenig.leichtzumerken@gmail.com>)
	id 1ewoVY-00024Z-No
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:30:55 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ckoenig.leichtzumerken@gmail.com>)
	id 1ewoVY-0001o7-Cn
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:30:52 -0400
Received: by mail-wr0-x243.google.com with SMTP id k3so11534717wrg.6
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 05:30:50 -0700 (PDT)
Reply-To: christian.koenig@amd.com
References: <20180316074650.5415-1-kraxel@redhat.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7547e99b-0e3c-264e-e52b-40ad5d52b49a@gmail.com>
Date: Fri, 16 Mar 2018 13:30:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180316074650.5415-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, qemu-devel@nongnu.org, open list <linux-kernel@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Shuah Khan <shuah@kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

Am 16.03.2018 um 08:46 schrieb Gerd Hoffmann:
> A driver to let userspace turn iovecs into dma-bufs.
>
> Use case:  Allows qemu create dmabufs for the vga framebuffer or
> virtio-gpu ressources.  Then they can be passed around to display
> those guest things on the host.  To spice client for classic full
> framebuffer display, and hopefully some day to wayland server for
> seamless guest window display.
>
> Those dma-bufs are accounted against user's shm mlock bucket as the
> pages are effectively locked in memory.

Sorry to disappoint you, but we have investigated the same idea for 
userptr use quite extensively and found that whole approach doesn't work.

The pages backing a DMA-buf are not allowed to move (at least not 
without a patch set I'm currently working on), but for certain MM 
operations to work correctly you must be able to modify the page tables 
entries and move the pages backing them around.

For example try to use fork() with some copy on write pages with this 
approach. You will find that you have only two options to correctly 
handle this.

Either you access memory which could no longer belong to your process, 
which in turn is major security no-go.

Or you use a MM notifier, but without being able to unmap DMA-bufs that 
won't work and you will certainly create a deadlock.

Even with the patch set I'm currently working on the MM notifier 
approach is a real beast to get right.

Regards,
Christian.

>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   include/uapi/linux/udmabuf.h                      |  23 ++
>   drivers/dma-buf/udmabuf.c                         | 261 ++++++++++++++++++++++
>   tools/testing/selftests/drivers/dma-buf/udmabuf.c |  69 ++++++
>   drivers/dma-buf/Kconfig                           |   7 +
>   drivers/dma-buf/Makefile                          |   1 +
>   tools/testing/selftests/drivers/dma-buf/Makefile  |   5 +
>   6 files changed, 366 insertions(+)
>   create mode 100644 include/uapi/linux/udmabuf.h
>   create mode 100644 drivers/dma-buf/udmabuf.c
>   create mode 100644 tools/testing/selftests/drivers/dma-buf/udmabuf.c
>   create mode 100644 tools/testing/selftests/drivers/dma-buf/Makefile
>
> diff --git a/include/uapi/linux/udmabuf.h b/include/uapi/linux/udmabuf.h
> new file mode 100644
> index 0000000000..54ceba203a
> --- /dev/null
> +++ b/include/uapi/linux/udmabuf.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_UDMABUF_H
> +#define _UAPI_LINUX_UDMABUF_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +struct udmabuf_iovec {
> +	__u64 base;
> +	__u64 len;
> +};
> +
> +#define UDMABUF_FLAGS_CLOEXEC	0x01
> +
> +struct udmabuf_create {
> +	__u32 flags;
> +	__u32 niov;
> +	struct udmabuf_iovec iovs[];
> +};
> +
> +#define UDMABUF_CREATE _IOW(0x42, 0x23, struct udmabuf_create)
> +
> +#endif /* _UAPI_LINUX_UDMABUF_H */
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> new file mode 100644
> index 0000000000..664ab4ee4e
> --- /dev/null
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -0,0 +1,261 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/miscdevice.h>
> +#include <linux/dma-buf.h>
> +#include <linux/highmem.h>
> +#include <linux/cred.h>
> +
> +#include <uapi/linux/udmabuf.h>
> +
> +struct udmabuf {
> +	u32 pagecount;
> +	struct page **pages;
> +	struct user_struct *owner;
> +};
> +
> +static int udmabuf_vm_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct udmabuf *ubuf = vma->vm_private_data;
> +
> +	if (WARN_ON(vmf->pgoff >= ubuf->pagecount))
> +		return VM_FAULT_SIGBUS;
> +
> +	vmf->page = ubuf->pages[vmf->pgoff];
> +	get_page(vmf->page);
> +	return 0;
> +}
> +
> +static const struct vm_operations_struct udmabuf_vm_ops = {
> +	.fault = udmabuf_vm_fault,
> +};
> +
> +static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
> +{
> +	struct udmabuf *ubuf = buf->priv;
> +
> +	if ((vma->vm_flags & VM_SHARED) == 0)
> +		return -EINVAL;
> +
> +	vma->vm_ops = &udmabuf_vm_ops;
> +	vma->vm_private_data = ubuf;
> +	return 0;
> +}
> +
> +static struct sg_table *map_udmabuf(struct dma_buf_attachment *at,
> +				    enum dma_data_direction direction)
> +{
> +	struct udmabuf *ubuf = at->dmabuf->priv;
> +	struct sg_table *sg;
> +
> +	sg = kzalloc(sizeof(*sg), GFP_KERNEL);
> +	if (!sg)
> +		goto err1;
> +	if (sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount,
> +				      0, ubuf->pagecount << PAGE_SHIFT,
> +				      GFP_KERNEL) < 0)
> +		goto err2;
> +	if (!dma_map_sg(at->dev, sg->sgl, sg->nents, direction))
> +		goto err3;
> +
> +	return sg;
> +
> +err3:
> +	sg_free_table(sg);
> +err2:
> +	kfree(sg);
> +err1:
> +	return ERR_PTR(-ENOMEM);
> +}
> +
> +static void unmap_udmabuf(struct dma_buf_attachment *at,
> +			  struct sg_table *sg,
> +			  enum dma_data_direction direction)
> +{
> +	sg_free_table(sg);
> +	kfree(sg);
> +}
> +
> +static void release_udmabuf(struct dma_buf *buf)
> +{
> +	struct udmabuf *ubuf = buf->priv;
> +	pgoff_t pg;
> +
> +	for (pg = 0; pg < ubuf->pagecount; pg++)
> +		put_page(ubuf->pages[pg]);
> +	user_shm_unlock(ubuf->pagecount << PAGE_SHIFT, ubuf->owner);
> +	free_uid(ubuf->owner);
> +	kfree(ubuf->pages);
> +	kfree(ubuf);
> +}
> +
> +static void *kmap_atomic_udmabuf(struct dma_buf *buf, unsigned long page_num)
> +{
> +	struct udmabuf *ubuf = buf->priv;
> +	struct page *page = ubuf->pages[page_num];
> +
> +	return kmap_atomic(page);
> +}
> +
> +static void *kmap_udmabuf(struct dma_buf *buf, unsigned long page_num)
> +{
> +	struct udmabuf *ubuf = buf->priv;
> +	struct page *page = ubuf->pages[page_num];
> +
> +	return kmap(page);
> +}
> +
> +static struct dma_buf_ops udmabuf_ops = {
> +	.map_dma_buf	  = map_udmabuf,
> +	.unmap_dma_buf	  = unmap_udmabuf,
> +	.release	  = release_udmabuf,
> +	.map_atomic	  = kmap_atomic_udmabuf,
> +	.map		  = kmap_udmabuf,
> +	.mmap		  = mmap_udmabuf,
> +};
> +
> +static long udmabuf_ioctl_create(struct file *filp, unsigned long arg)
> +{
> +	struct udmabuf_create create;
> +	struct udmabuf_iovec *iovs;
> +	struct udmabuf *ubuf;
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct dma_buf *buf;
> +	pgoff_t pgoff, pgcnt;
> +	u32 iov, flags;
> +	int ret;
> +
> +	if (copy_from_user(&create, (void __user *)arg,
> +			   sizeof(struct udmabuf_create)))
> +		return -EFAULT;
> +
> +	iovs = kmalloc_array(create.niov, sizeof(struct udmabuf_iovec),
> +			     GFP_KERNEL);
> +	if (!iovs)
> +		return -ENOMEM;
> +
> +	arg += offsetof(struct udmabuf_create, iovs);
> +	ret = -EFAULT;
> +	if (copy_from_user(iovs, (void __user *)arg,
> +			   create.niov * sizeof(struct udmabuf_iovec)))
> +		goto err_free_iovs;
> +
> +	ubuf = kzalloc(sizeof(struct udmabuf), GFP_KERNEL);
> +	if (!ubuf)
> +		goto err_free_iovs;
> +
> +	ret = -EINVAL;
> +	for (iov = 0; iov < create.niov; iov++) {
> +		if (!IS_ALIGNED(iovs[iov].base, PAGE_SIZE))
> +			goto err_free_buf;
> +		if (!IS_ALIGNED(iovs[iov].len, PAGE_SIZE))
> +			goto err_free_buf;
> +		ubuf->pagecount += iovs[iov].len >> PAGE_SHIFT;
> +	}
> +
> +	/* this effectively mlocks the pages so account it accordingly */
> +	ret = -ENOMEM;
> +	ubuf->owner = current_user();
> +	if (!user_shm_lock(ubuf->pagecount << PAGE_SHIFT, ubuf->owner))
> +		goto err_free_buf;
> +
> +	ubuf->pages = kmalloc_array(ubuf->pagecount, sizeof(struct page*),
> +				    GFP_KERNEL);
> +	if (!ubuf->pages)
> +		goto err_shm_unlock;
> +
> +	pgoff = 0;
> +	for (iov = 0; iov < create.niov; iov++) {
> +		pgcnt = iovs[iov].len >> PAGE_SHIFT;
> +		while (pgcnt > 0) {
> +			ret = get_user_pages_fast(iovs[iov].base, pgcnt,
> +						  true, /* write */
> +						  ubuf->pages + pgoff);
> +			if (ret < 0)
> +				goto err_put_pages;
> +			pgoff += ret;
> +			pgcnt -= ret;
> +		}
> +	}
> +
> +	exp_info.ops  = &udmabuf_ops;
> +	exp_info.size = ubuf->pagecount << PAGE_SHIFT;
> +	exp_info.priv = ubuf;
> +
> +	buf = dma_buf_export(&exp_info);
> +	if (IS_ERR(buf)) {
> +		ret = PTR_ERR(buf);
> +		goto err_put_pages;
> +	}
> +
> +	flags = 0;
> +	if (create.flags & UDMABUF_FLAGS_CLOEXEC)
> +		flags |= O_CLOEXEC;
> +
> +	kfree(iovs);
> +	return dma_buf_fd(buf, flags);
> +
> +err_put_pages:
> +	while (pgoff > 0)
> +		put_page(ubuf->pages[--pgoff]);
> +err_shm_unlock:
> +	user_shm_unlock(ubuf->pagecount << PAGE_SHIFT, ubuf->owner);
> +err_free_buf:
> +	free_uid(ubuf->owner);
> +	kfree(ubuf->pages);
> +	kfree(ubuf);
> +err_free_iovs:
> +	kfree(iovs);
> +	return ret;
> +}
> +
> +static long udmabuf_ioctl(struct file *filp, unsigned int ioctl,
> +				  unsigned long arg)
> +{
> +	long ret;
> +
> +	switch (ioctl) {
> +	case UDMABUF_CREATE:
> +		ret = udmabuf_ioctl_create(filp, arg);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static const struct file_operations udmabuf_fops = {
> +	.owner		= THIS_MODULE,
> +	.unlocked_ioctl = udmabuf_ioctl,
> +};
> +
> +static struct miscdevice udmabuf_misc = {
> +	.minor          = MISC_DYNAMIC_MINOR,
> +	.name           = "udmabuf",
> +	.fops           = &udmabuf_fops,
> +};
> +
> +static int __init udmabuf_dev_init(void)
> +{
> +	return misc_register(&udmabuf_misc);
> +}
> +
> +static void __exit udmabuf_dev_exit(void)
> +{
> +	misc_deregister(&udmabuf_misc);
> +}
> +
> +module_init(udmabuf_dev_init)
> +module_exit(udmabuf_dev_exit)
> +
> +MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> new file mode 100644
> index 0000000000..3472c8ee49
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> @@ -0,0 +1,69 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <malloc.h>
> +
> +#include <sys/ioctl.h>
> +#include <linux/udmabuf.h>
> +
> +#define TEST_PREFIX	"drivers/dma-buf/udmabuf"
> +#define NUM_PAGES       4
> +
> +int main(int argc, char *argv[])
> +{
> +	struct udmabuf_create *create;
> +	void *mem;
> +	int dev, fd;
> +
> +	dev = open("/dev/udmabuf", O_RDWR);
> +	if (dev < 0) {
> +		printf("%s: [skip]\n", TEST_PREFIX);
> +		exit(77);
> +	}
> +
> +	mem = memalign(getpagesize(), getpagesize() * NUM_PAGES);
> +	if (mem == NULL) {
> +		printf("%s: [FAIL]\n", TEST_PREFIX);
> +		exit (1);
> +	}
> +
> +	create = malloc(sizeof(struct udmabuf_create) +
> +			sizeof(struct udmabuf_iovec));
> +	create->flags = 0;
> +	create->niov  = 1;
> +
> +	/* should fail (base not page aligned) */
> +	create->iovs[0].base = (intptr_t)mem + getpagesize()/2;
> +	create->iovs[0].len  = getpagesize();
> +	fd = ioctl(dev, UDMABUF_CREATE, create);
> +	if (fd >= 0) {
> +		printf("%s: [FAIL]\n", TEST_PREFIX);
> +		exit(1);
> +	}
> +
> +	/* should fail (size not multiple of page) */
> +	create->iovs[0].base = (intptr_t)mem;
> +	create->iovs[0].len  = getpagesize()/2;
> +	fd = ioctl(dev, UDMABUF_CREATE, create);
> +	if (fd >= 0) {
> +		printf("%s: [FAIL]\n", TEST_PREFIX);
> +		exit(1);
> +	}
> +
> +	/* should work */
> +	create->iovs[0].base = (intptr_t)mem;
> +	create->iovs[0].len  = getpagesize() * NUM_PAGES;
> +	fd = ioctl(dev, UDMABUF_CREATE, create);
> +	if (fd < 0) {
> +		printf("%s: [FAIL]\n", TEST_PREFIX);
> +		exit(1);
> +	}
> +	close(fd);
> +
> +	fprintf(stderr, "%s: ok\n", TEST_PREFIX);
> +	close(dev);
> +	return 0;
> +}
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index ed3b785bae..19be3ec62d 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -30,4 +30,11 @@ config SW_SYNC
>   	  WARNING: improper use of this can result in deadlocking kernel
>   	  drivers from userspace. Intended for test and debug only.
>   
> +config UDMABUF
> +	bool "userspace dmabuf misc driver"
> +	default n
> +	depends on DMA_SHARED_BUFFER
> +	---help---
> +	  A driver to let userspace turn iovs into dma-bufs.
> +
>   endmenu
> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
> index c33bf88631..0913a6ccab 100644
> --- a/drivers/dma-buf/Makefile
> +++ b/drivers/dma-buf/Makefile
> @@ -1,3 +1,4 @@
>   obj-y := dma-buf.o dma-fence.o dma-fence-array.o reservation.o seqno-fence.o
>   obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
>   obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
> +obj-$(CONFIG_UDMABUF)		+= udmabuf.o
> diff --git a/tools/testing/selftests/drivers/dma-buf/Makefile b/tools/testing/selftests/drivers/dma-buf/Makefile
> new file mode 100644
> index 0000000000..4154c3d7aa
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/dma-buf/Makefile
> @@ -0,0 +1,5 @@
> +CFLAGS += -I../../../../../usr/include/
> +
> +TEST_GEN_PROGS := udmabuf
> +
> +include ../../lib.mk
