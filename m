Received: from eggs.gnu.org ([2001:4830:134:3::10]:60333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eWjtU-0003xm-7h
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 09:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eWjtP-0004ks-Mz
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 09:19:48 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2304 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eWjtP-0004gq-17
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 09:19:43 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Wed, 3 Jan 2018 14:19:29 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB22000@DGGEMM505-MBS.china.huawei.com>
References: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
	<1513327555-17520-3-git-send-email-jianjay.zhou@huawei.com>
	<20171222194855.6d1139f1@igors-macbook-pro.local>
	<20171222231342-mutt-send-email-mst@kernel.org>
	<20171228122916.667bcb4e@igors-macbook-pro.local>
In-Reply-To: <20171228122916.667bcb4e@igors-macbook-pro.local>
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
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liuzhe (Cloud Open Labs, NFV)" <gary.liuzhe@huawei.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Thursday, December 28, 2017 7:29 PM
> To: Michael S. Tsirkin <mst@redhat.com>
> Cc: Huangweidong (C) <weidong.huang@huawei.com>; wangxin (U)
> <wangxinxin.wang@huawei.com>; qemu-devel@nongnu.org; Liuzhe (Cloud Open
> Labs, NFV) <gary.liuzhe@huawei.com>; dgilbert@redhat.com; Gonglei (Arei)
> <arei.gonglei@huawei.com>; Zhoujian (jay) <jianjay.zhou@huawei.com>
> Subject: Re: [Qemu-devel] [PATCH v2 2/2] vhost: double check used memslot=
s
> number
>=20
> On Fri, 22 Dec 2017 23:15:09 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Fri, Dec 22, 2017 at 07:48:55PM +0100, Igor Mammedov wrote:
> > > On Fri, 15 Dec 2017 16:45:55 +0800
> > > Jay Zhou <jianjay.zhou@huawei.com> wrote:
> > >
> > > > If the VM already has N(N>8) available memory slots for vhost
> > > > user, the VM will be crashed in vhost_user_set_mem_table if we try
> > > > to hotplug the first vhost user NIC.
> > > > This patch checks if memslots number exceeded or not after
> > > > updating vhost_user_used_memslots.
> > > Can't understand commit message, pls rephrase (what is being fixed,
> > > and how it's fixed) also include reproducing steps for crash and
> > > maybe describe call flow/backtrace that triggers crash.
> > >
> > > PS:
> > > I wasn't able to reproduce crash
> > >
> > > >
> > > > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > > > ---
> > > >  hw/virtio/vhost.c | 27 +++++++++++++++++++++++----
> > > >  1 file changed, 23 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c index
> > > > 59a32e9..e45f5e2 100644
> > > > --- a/hw/virtio/vhost.c
> > > > +++ b/hw/virtio/vhost.c
> > > > @@ -1234,6 +1234,18 @@ static void vhost_virtqueue_cleanup(struct
> vhost_virtqueue *vq)
> > > >      event_notifier_cleanup(&vq->masked_notifier);
> > > >  }
> > > >
> > > > +static bool vhost_dev_used_memslots_is_exceeded(struct vhost_dev
> > > > +*hdev) {
> > > > +    if (hdev->vhost_ops->vhost_get_used_memslots() >
> > > > +        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> > > > +        error_report("vhost backend memory slots limit is less"
> > > > +                " than current number of present memory slots");
> > > > +        return true;
> > > > +    }
> > > > +
> > > > +    return false;
> > > > +}
> > > > +
> > > >  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> > > >                     VhostBackendType backend_type, uint32_t
> > > > busyloop_timeout)  { @@ -1252,10 +1264,7 @@ int
> > > > vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> > > >          goto fail;
> > > >      }
> > > >
> > > > -    if (hdev->vhost_ops->vhost_get_used_memslots() >
> > > > -        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> > > > -        error_report("vhost backend memory slots limit is less"
> > > > -                " than current number of present memory slots");
> > > > +    if (vhost_dev_used_memslots_is_exceeded(hdev)) {
> > > why do you keep this check?
> > > it seems always be false
> > >
> > >
> > >
> > > >          r =3D -1;
> > > >          goto fail;
> > > >      }
> > > > @@ -1341,6 +1350,16 @@ int vhost_dev_init(struct vhost_dev *hdev,
> void *opaque,
> > > >      hdev->memory_changed =3D false;
> > > >      memory_listener_register(&hdev->memory_listener,
> &address_space_memory);
> > > >      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
> > > > +
> > > > +    if (vhost_dev_used_memslots_is_exceeded(hdev)) {
> > > > +        r =3D -1;
> > > > +        if (busyloop_timeout) {
> > > > +            goto fail_busyloop;
> > > > +        } else {
> > > > +            goto fail;
> > > > +        }
> > > > +    }
> > > seem to be right thing to do, since after registering listener for
> > > the first time used_memslots will be updated to actual value.
> > >
> > >
> > > I did some testing and without this hunk/patch
> > >
> > > on 'device_add  virtio-net-pci,netdev=3Dnet0' qemu prints:
> > >
> > > qemu-system-x86_64: vhost_set_mem_table failed: Argument list too
> > > long (7)
> > > qemu-system-x86_64: unable to start vhost net: 7: falling back on
> > > userspace virtio

Error code 7 is E2BIG, which means

    	if (mem.nregions > max_mem_regions)
		return -E2BIG;

happened in the kernel.

> > >
> > > and network is operational in guest, but with this patch
> > >
> > > "netdev_add ...,vhost-on" prints:
> > >
> > > vhost backend memory slots limit is less than current number of
> > > present memory slots vhost-net requested but could not be
> > > initialized
> > >
> > > and following "device_add  virtio-net-pci,netdev=3Dnet0" prints:
> > >
> > > TUNSETOFFLOAD ioctl() failed: Bad file descriptor TUNSETOFFLOAD
> > > ioctl() failed: Bad file descriptor
> > >
> > > adapter is still hot-plugged but guest networking is broken (can't
> > > get IP address via DHCP)
> > >
> > > so patch seems introduces a regression or something broken elsewhere
> > > and this exposes issue, not sure what qemu reaction should be in
> > > this case  i.e. when netdev_add fails
> > >     1: should we fail followed up device_add or
> > >     2: make it fall back to userspace virtio
> > >
> > > I'd go for #2,
> > > Michael what's your take on it?
> >
> > OK but there's a vhost force flag, if that is set we definitely should
> > fail device_add.
> >
> > Also, hotplug can follow device_add, should be handled similarly.
> I was testing with vhost-kernel (as it doesn't need extra environment to
> setup) and it's able to fallback to virtio transport.
>=20
> However in case of vhost-user, is there even an option to fallback to?

Using error code(which do it like vhost-kernel) instead of asserting in
vhost_user_set_mem_table(), I have tested:
"netdev_add vhost-user,chardev=3Dcharnet0,id=3Dhostnet0" is successful,
following "device_add virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,bus=3Dpci.=
0" prints:

"qemu-system-x86_64: vhost_set_mem_table failed: Interrupted system call (4=
)
qemu-system-x86_64: unable to start vhost net: 4: falling back on userspace=
 virtio"

or

"qemu-system-x86_64: vhost_set_mem_table failed: Resource temporarily unava=
ilable (11)
qemu-system-x86_64: unable to start vhost net: 11: falling back on userspac=
e virtio"

adapter is still hot-plugged but guest networking is broken (can't get IP
address via DHCP), does this mean make no sense for vhost-user to fallback
to?

> Perhaps our only choice here is to fail backend creation cleanly, so no
> one would be able to add a frontend refering to non existing backend.

Not sure what to do.

>=20
>=20
> PS:
> even if we have to fail on error for vhost-user, this patch shouldn't
> change current vhost-kernel behavior (fallback should still work)

Does it mean vhost-kernel don't need to care about the value of used_memslo=
ts
(because it's able to fall back to userspace virtio)?

Is it enough to use error code in vhost_user_set_mem_table() and
vhost_kernel_set_mem_table()?
  1. If yes, how about removing the check of used_memslots totally?
  2. If no, is it enough to check used_memslots for vhost-user only after
    memory listener is registered?


Regards,
Jay

>=20
> >
> > > > +
> > > >      return 0;
> > > >
> > > >  fail_busyloop:
> >
