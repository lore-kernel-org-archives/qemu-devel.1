Received: from eggs.gnu.org ([2001:4830:134:3::10]:60373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eSf9n-00030Z-Ju
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 03:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eSf9j-0001Ao-5c
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 03:27:47 -0500
Received: from [45.249.212.255] (port=45827 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eSf9i-00019S-Fr
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 03:27:43 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Sat, 23 Dec 2017 08:27:25 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB19758@DGGEMM505-MBS.china.huawei.com>
References: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
	<1513327555-17520-3-git-send-email-jianjay.zhou@huawei.com>
	<20171222194855.6d1139f1@igors-macbook-pro.local>
In-Reply-To: <20171222194855.6d1139f1@igors-macbook-pro.local>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vhost: double check used memslots
 number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Gonglei
	(Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Liuzhe (Cloud Open Labs, NFV)" <gary.liuzhe@huawei.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Saturday, December 23, 2017 2:49 AM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: qemu-devel@nongnu.org; mst@redhat.com; Huangweidong (C)
> <weidong.huang@huawei.com>; Gonglei (Arei) <arei.gonglei@huawei.com>;
> wangxin (U) <wangxinxin.wang@huawei.com>; Liuzhe (Cloud Open Labs, NFV)
> <gary.liuzhe@huawei.com>; dgilbert@redhat.com
> Subject: Re: [PATCH v2 2/2] vhost: double check used memslots number
>=20
> On Fri, 15 Dec 2017 16:45:55 +0800
> Jay Zhou <jianjay.zhou@huawei.com> wrote:
>=20
> > If the VM already has N(N>8) available memory slots for vhost user,
> > the VM will be crashed in vhost_user_set_mem_table if we try to
> > hotplug the first vhost user NIC.
> > This patch checks if memslots number exceeded or not after updating
> > vhost_user_used_memslots.
> Can't understand commit message, pls rephrase (what is being fixed, and
> how it's fixed) also include reproducing steps for crash and maybe
> describe call flow/backtrace that triggers crash.

Sorry about my pool english

>=20
> PS:
> I wasn't able to reproduce crash

Steps to reproduce:
(1) start up a VM successfully without any vhost device
(2) hotplug 8 DIMM memory successfully
(3) hotplug a vhost-user NIC, the VM crashed, it asserted
    at the line
        assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
    in vhost_user_set_mem_table()

Regards,
Jay

> >
> > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > ---
> >  hw/virtio/vhost.c | 27 +++++++++++++++++++++++----
> >  1 file changed, 23 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c index
> > 59a32e9..e45f5e2 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -1234,6 +1234,18 @@ static void vhost_virtqueue_cleanup(struct
> vhost_virtqueue *vq)
> >      event_notifier_cleanup(&vq->masked_notifier);
> >  }
> >
> > +static bool vhost_dev_used_memslots_is_exceeded(struct vhost_dev
> > +*hdev) {
> > +    if (hdev->vhost_ops->vhost_get_used_memslots() >
> > +        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> > +        error_report("vhost backend memory slots limit is less"
> > +                " than current number of present memory slots");
> > +        return true;
> > +    }
> > +
> > +    return false;
> > +}
> > +
> >  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> >                     VhostBackendType backend_type, uint32_t
> > busyloop_timeout)  { @@ -1252,10 +1264,7 @@ int vhost_dev_init(struct
> > vhost_dev *hdev, void *opaque,
> >          goto fail;
> >      }
> >
> > -    if (hdev->vhost_ops->vhost_get_used_memslots() >
> > -        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> > -        error_report("vhost backend memory slots limit is less"
> > -                " than current number of present memory slots");
> > +    if (vhost_dev_used_memslots_is_exceeded(hdev)) {
> why do you keep this check?
> it seems always be false
>=20
>=20
>=20
> >          r =3D -1;
> >          goto fail;
> >      }
> > @@ -1341,6 +1350,16 @@ int vhost_dev_init(struct vhost_dev *hdev, void
> *opaque,
> >      hdev->memory_changed =3D false;
> >      memory_listener_register(&hdev->memory_listener,
> &address_space_memory);
> >      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
> > +
> > +    if (vhost_dev_used_memslots_is_exceeded(hdev)) {
> > +        r =3D -1;
> > +        if (busyloop_timeout) {
> > +            goto fail_busyloop;
> > +        } else {
> > +            goto fail;
> > +        }
> > +    }
> seem to be right thing to do, since after registering listener for the
> first time used_memslots will be updated to actual value.
>=20
>=20
> I did some testing and without this hunk/patch
>=20
> on 'device_add  virtio-net-pci,netdev=3Dnet0' qemu prints:
>=20
> qemu-system-x86_64: vhost_set_mem_table failed: Argument list too long (7=
)
> qemu-system-x86_64: unable to start vhost net: 7: falling back on
> userspace virtio
>=20
> and network is operational in guest, but with this patch
>=20
> "netdev_add ...,vhost-on" prints:
>=20
> vhost backend memory slots limit is less than current number of present
> memory slots vhost-net requested but could not be initialized
>=20
> and following "device_add  virtio-net-pci,netdev=3Dnet0" prints:
>=20
> TUNSETOFFLOAD ioctl() failed: Bad file descriptor TUNSETOFFLOAD ioctl()
> failed: Bad file descriptor
>=20
> adapter is still hot-plugged but guest networking is broken (can't get IP
> address via DHCP)
>=20
> so patch seems introduces a regression or something broken elsewhere and
> this exposes issue, not sure what qemu reaction should be in this case
> i.e. when netdev_add fails
>     1: should we fail followed up device_add or
>     2: make it fall back to userspace virtio
>=20
> I'd go for #2,
> Michael what's your take on it?
>=20
> > +
> >      return 0;
> >
> >  fail_busyloop:
