Received: from eggs.gnu.org ([2001:4830:134:3::10]:46429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eldgt-00005q-Je
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eldgs-00085Z-Lp
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:44:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eldgs-00085T-Es
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:44:22 -0500
Date: Tue, 13 Feb 2018 18:44:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180213184248-mutt-send-email-mst@kernel.org>
References: <cover.1516538887.git.arei.gonglei@huawei.com>
	<0468514c9952e09a93038a70c16e0cc7f283b1c9.1516538887.git.arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0468514c9952e09a93038a70c16e0cc7f283b1c9.1516538887.git.arei.gonglei@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, xin.zeng@intel.com, roy.fan.zhang@intel.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com

On Sun, Jan 21, 2018 at 08:54:48PM +0800, Jay Zhou wrote:
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 765d363..c65dca2 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -7,7 +7,7 @@ common-obj-y += virtio-mmio.o
>  obj-y += virtio.o virtio-balloon.o 
>  obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
> -obj-y += virtio-crypto.o
> +obj-$(CONFIG_LINUX) += virtio-crypto.o
>  obj-$(CONFIG_VIRTIO_PCI) += virtio-crypto-pci.o
>  endif
>  

This disables virtio crypto completely on non-Linux, which is not
nice. We should not break working configs.

In particular this causes test failures on non-Linux
hosts. Peter Maydell was kind enough to debug this and reported
this backtrace:

gdb --args ./aarch64-softmmu/qemu-system-aarch64 -device virtio-crypto-pci -machine virt
[...]
#0  0x00007f7ff450e6fa in _lwp_kill () from /usr/lib/libc.so.12
#1  0x00007f7ff450e385 in abort () from /usr/lib/libc.so.12
#2  0x00007f7ff5c65da2 in g_assertion_message () from /usr/pkg/lib/libglib-2.0.so.0
#3  0x00007f7ff5c65e11 in g_assertion_message_expr () from /usr/pkg/lib/libglib-2.0.so.0
#4  0x000000000074dc16 in object_initialize_with_type (data=data@entry=0x7f7ff33a2170, size=<optimized out>, type=0x0)
    at /root/qemu/qom/object.c:372
#5  0x000000000074de33 in object_initialize (data=data@entry=0x7f7ff33a2170, size=<optimized out>, typename=<optimized out>)
    at /root/qemu/qom/object.c:392
#6  0x00000000004d2293 in virtio_instance_init_common (proxy_obj=0x7f7ff339a000, data=0x7f7ff33a2170, vdev_size=<optimized out>, 
    vdev_name=<optimized out>) at /root/qemu/hw/virtio/virtio.c:2232
#7  0x000000000074db0d in object_initialize_with_type (data=data@entry=0x7f7ff339a000, size=33664, type=type@entry=0x7f7ff7b79a80)
    at /root/qemu/qom/object.c:384
#8  0x000000000074dc66 in object_new_with_type (type=0x7f7ff7b79a80) at /root/qemu/qom/object.c:492
#9  0x000000000074deb9 in object_new (typename=typename@entry=0x7f7ff7b454e0 "virtio-crypto-pci") at /root/qemu/qom/object.c:502
#10 0x00000000005924d6 in qdev_device_add (opts=0x7f7ff7b4c070, errp=errp@entry=0x7f7fffffda10) at /root/qemu/qdev-monitor.c:615
#11 0x0000000000594d31 in device_init_func (opaque=<optimized out>, opts=<optimized out>, errp=<optimized out>) at /root/qemu/vl.c:2373
#12 0x0000000000826e56 in qemu_opts_foreach (list=<optimized out>, func=func@entry=0x594d0c <device_init_func>, opaque=opaque@entry=0x0, 
    errp=errp@entry=0x0) at /root/qemu/util/qemu-option.c:1073
#13 0x00000000008b723d in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /root/qemu/vl.c:4642


He explained:


<pm215> ... this is almost certainly the classic "device A depends on device B, device B is conditionally compiled but device A isn't"
<pm215> the type that is missing is virtio-crypto-device
<pm215> virtio-crypto.o is built only if CONFIG_LINUX, but virtio-crypto-pci is in virtio-crypto-pci.c which is built if CONFIG_VIRTIO_PCI


-- 
MST
