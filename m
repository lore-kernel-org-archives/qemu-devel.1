Received: from eggs.gnu.org ([2001:4830:134:3::10]:54978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1elnDm-0003HH-4D
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 21:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1elnDi-0006o0-6N
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 21:54:58 -0500
Received: from [45.249.212.255] (port=47695 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1elnDh-0006nQ-Qz
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 21:54:54 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Wed, 14 Feb 2018 02:54:39 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB94B8D@DGGEMM505-MBS.china.huawei.com>
References: <cover.1516538887.git.arei.gonglei@huawei.com>
	<0468514c9952e09a93038a70c16e0cc7f283b1c9.1516538887.git.arei.gonglei@huawei.com>
	<20180213184248-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180213184248-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 2/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Wednesday, February 14, 2018 12:44 AM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; Huangweidong (C)
> <weidong.huang@huawei.com>; stefanha@redhat.com; pasic@linux.vnet.ibm.com=
;
> longpeng <longpeng2@huawei.com>; xin.zeng@intel.com; roy.fan.zhang@intel.=
com;
> Gonglei (Arei) <arei.gonglei@huawei.com>; wangxin (U)
> <wangxinxin.wang@huawei.com>
> Subject: Re: [PATCH v6 2/4] cryptodev: add vhost support
>=20
> On Sun, Jan 21, 2018 at 08:54:48PM +0800, Jay Zhou wrote:
> > diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs index
> > 765d363..c65dca2 100644
> > --- a/hw/virtio/Makefile.objs
> > +++ b/hw/virtio/Makefile.objs
> > @@ -7,7 +7,7 @@ common-obj-y +=3D virtio-mmio.o  obj-y +=3D virtio.o
> > virtio-balloon.o
> >  obj-$(CONFIG_LINUX) +=3D vhost.o vhost-backend.o vhost-user.o
> >  obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o -obj-y +=3D virtio-crypto=
.o
> > +obj-$(CONFIG_LINUX) +=3D virtio-crypto.o
> >  obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-crypto-pci.o  endif
> >
>=20
> This disables virtio crypto completely on non-Linux, which is not nice. W=
e
> should not break working configs.

So If I understand correctly, the virtio crypto device should be compiled i=
n
unconditionally, which is like this:

    obj-y +=3D virtio-crypto.o

>=20
> In particular this causes test failures on non-Linux hosts. Peter Maydell=
 was
> kind enough to debug this and reported this backtrace:
>=20
> gdb --args ./aarch64-softmmu/qemu-system-aarch64 -device virtio-crypto-pc=
i -
> machine virt [...]
> #0  0x00007f7ff450e6fa in _lwp_kill () from /usr/lib/libc.so.12
> #1  0x00007f7ff450e385 in abort () from /usr/lib/libc.so.12
> #2  0x00007f7ff5c65da2 in g_assertion_message () from /usr/pkg/lib/libgli=
b-
> 2.0.so.0
> #3  0x00007f7ff5c65e11 in g_assertion_message_expr () from
> /usr/pkg/lib/libglib-2.0.so.0
> #4  0x000000000074dc16 in object_initialize_with_type
> (data=3Ddata@entry=3D0x7f7ff33a2170, size=3D<optimized out>, type=3D0x0)
>     at /root/qemu/qom/object.c:372
> #5  0x000000000074de33 in object_initialize (data=3Ddata@entry=3D0x7f7ff3=
3a2170,
> size=3D<optimized out>, typename=3D<optimized out>)
>     at /root/qemu/qom/object.c:392
> #6  0x00000000004d2293 in virtio_instance_init_common
> (proxy_obj=3D0x7f7ff339a000, data=3D0x7f7ff33a2170, vdev_size=3D<optimize=
d out>,
>     vdev_name=3D<optimized out>) at /root/qemu/hw/virtio/virtio.c:2232
> #7  0x000000000074db0d in object_initialize_with_type
> (data=3Ddata@entry=3D0x7f7ff339a000, size=3D33664, type=3Dtype@entry=3D0x=
7f7ff7b79a80)
>     at /root/qemu/qom/object.c:384
> #8  0x000000000074dc66 in object_new_with_type (type=3D0x7f7ff7b79a80) at
> /root/qemu/qom/object.c:492
> #9  0x000000000074deb9 in object_new (typename=3Dtypename@entry=3D0x7f7ff=
7b454e0
> "virtio-crypto-pci") at /root/qemu/qom/object.c:502
> #10 0x00000000005924d6 in qdev_device_add (opts=3D0x7f7ff7b4c070,
> errp=3Derrp@entry=3D0x7f7fffffda10) at /root/qemu/qdev-monitor.c:615
> #11 0x0000000000594d31 in device_init_func (opaque=3D<optimized out>,
> opts=3D<optimized out>, errp=3D<optimized out>) at /root/qemu/vl.c:2373
> #12 0x0000000000826e56 in qemu_opts_foreach (list=3D<optimized out>,
> func=3Dfunc@entry=3D0x594d0c <device_init_func>, opaque=3Dopaque@entry=3D=
0x0,
>     errp=3Derrp@entry=3D0x0) at /root/qemu/util/qemu-option.c:1073
> #13 0x00000000008b723d in main (argc=3D<optimized out>, argv=3D<optimized=
 out>,
> envp=3D<optimized out>) at /root/qemu/vl.c:4642
>=20
>=20
> He explained:
>=20
>=20
> <pm215> ... this is almost certainly the classic "device A depends on dev=
ice
> B, device B is conditionally compiled but device A isn't"
> <pm215> the type that is missing is virtio-crypto-device <pm215> virtio-
> crypto.o is built only if CONFIG_LINUX, but virtio-crypto-pci is in virti=
o-
> crypto-pci.c which is built if CONFIG_VIRTIO_PCI

Okay, I see. Thanks for Peter's help.

Regards,
Jay

>=20
>=20
> --
> MST
