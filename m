Received: from eggs.gnu.org ([2001:4830:134:3::10]:37234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eSfVB-0006z2-7K
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 03:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eSfV8-0004Ne-4w
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 03:49:53 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2300 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eSfV7-0004M2-O9
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 03:49:50 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Sat, 23 Dec 2017 08:49:34 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB1976C@DGGEMM505-MBS.china.huawei.com>
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



[...]

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

If a vhost device has been already added successfully, i.e. its memory
Listener has been registered, i.e.
hdev->vhost_ops->vhost_set_used_memslots() has been called(used_memslots
is updated here),
then if we hotplug another same backend type vhost device,
hdev->vhost_ops->vhost_get_used_memslots() will not be 0(
used_memslots is the same for the same type backend vhost device), so it wi=
ll
not always be false.

Regards,
Jay
