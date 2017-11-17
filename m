Received: from eggs.gnu.org ([2001:4830:134:3::10]:35798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFYKy-0005Jk-3P
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFYKu-0001JI-Vp
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:33:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eFYKu-0001Gp-Lk
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:33:04 -0500
Date: Fri, 17 Nov 2017 06:32:58 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171117063024-mutt-send-email-mst@kernel.org>
References: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
	<cd39d029-48f9-20d6-cc19-ff87a45240ab@redhat.com>
	<CACnE9pzm5zabq=nJhqB4LHzSXk2vDGiAN5SbJco3ZfGkfRbW-g@mail.gmail.com>
	<5A0D27D8.6050506@huawei.com>
	<2e0ddd76-3903-d715-9a86-73f1286322e7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA46E2A6@DGGEMA505-MBS.china.huawei.com>
	<6aaaca2b-81ef-a1c1-4745-830d008b3770@redhat.com>
	<5A0D5B1B.3080708@huawei.com>
	<55f2edb1-1fe3-d03f-7f4f-418a3b15997a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55f2edb1-1fe3-d03f-7f4f-418a3b15997a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Question] why need to start all queues in
 vhost_net_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Longpeng (Mike)" <longpeng2@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wangjing (King, Euler)" <king.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng.mike@gmail.com>

On Thu, Nov 16, 2017 at 08:04:34PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B411=E6=9C=8816=E6=97=A5 17:32, Longpeng (Mike) wrote:
> > Hi Jason,
> >=20
> > On 2017/11/16 17:13, Jason Wang wrote:
> >=20
> > >=20
> > > On 2017=E5=B9=B411=E6=9C=8816=E6=97=A5 17:01, Gonglei (Arei) wrote:
> > > > No, Windows guest + vhost-user/DPDK.
> > > >=20
> > > > BTW pls see virtio spec in :
> > > >=20
> > > > "If VIRTIO_NET_F_MQ is negotiated, each of receiveq1. . .receiveq=
N that will
> > > > be used SHOULD be populated
> > > > with receive buffers."
> > > >=20
> > > > It is not mandatory that all queues must be initialized.
> > > I think not, since it said we should fill receive buffers for each =
queue which
> > > means we should initialize all queues. May Michael can clarify on t=
his.
> > >=20
> >=20
> > I think this doesn't matter, but QEMU should consider this scenario..=
.
> >=20
> > For example, if one queues isn't initialized (Windows guest), the vri=
ng.avail=3D0,
> > so vq->desc_phys=3D0, then vq->desc=3D'a avail HVA'(which is the star=
t addr of pc.ram).
> >=20
> >      vq->desc_size =3D s =3D l =3D virtio_queue_get_desc_size(vdev, i=
dx);
> >      vq->desc_phys =3D a =3D virtio_queue_get_desc_addr(vdev, idx);
> >      vq->desc =3D vhost_memory_map(dev, a, &l, 0);
> >      if (!vq->desc || l !=3D s) {
> >          r =3D -ENOMEM;
> >          goto fail_alloc_desc;
> >      }
> >      .....
> >      r =3D vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log=
_enabled);
> >      if (r < 0) {
> >          r =3D -errno;
> >          goto fail_alloc;
> >      }
> >=20
> > Then the HVA is send to the vhost-user.
> >=20
> > I think this is wrong, because the '0' here means guest driver doesn'=
t init this
> > queues, it should not be used to calculate the HVA for this vq.
>=20
> Yes, workaround is not hard if windows driver won't use the left 3 queu=
es
> any more. But we should have a complete solution. The main problem is w=
hen
> vhost need to be started. For legacy device, there's no easy way to det=
ect
> whether or not a specific virtqueue is ready to be used. For modern dev=
ice,
> we can probably do this through queue_enable (but this is not implement=
ed in
> current code).
>=20
> Thanks

What isn't implemented?

Spec is quite explicit:


Client must only process each ring when it is started.

Client must only pass data between the ring and the
backend, when the ring is enabled.

and later:


Client must start ring upon receiving a kick (that is, detecting that fil=
e
descriptor is readable) on the descriptor specified by
VHOST_USER_SET_VRING_KICK, and stop ring upon receiving
VHOST_USER_GET_VRING_BASE.


Does someone kick unused rings? What entity does this?




> >=20
> > > Thanks
> > >=20
> > > > Thanks,
> > > > -Gonglei
> > > >=20
> > >=20
> > >=20
> > >=20
> > > .
> > >=20
> >=20
