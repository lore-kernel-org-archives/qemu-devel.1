Received: from eggs.gnu.org ([2001:4830:134:3::10]:54982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cULAo-00054S-2e
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 17:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cULAk-0004qI-VZ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 17:27:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cULAk-0004pN-N8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 17:27:10 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94BA6C04B923
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 22:27:10 +0000 (UTC)
Date: Fri, 20 Jan 2017 00:27:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170120002554-mutt-send-email-mst@kernel.org>
References: <1484625660-3312-1-git-send-email-jasowang@redhat.com>
	<20170117164326-mutt-send-email-mst@kernel.org>
	<38dfab22-412f-94a5-4b01-351edf627027@redhat.com>
	<20170118193122-mutt-send-email-mst@kernel.org>
	<fc140450-dbd4-4a2d-578f-8226e0bd02fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc140450-dbd4-4a2d-578f-8226e0bd02fc@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: force VIRTIO_F_IOMMU_PLATFORM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 19, 2017 at 11:12:21AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8819=E6=97=A5 01:50, Michael S. Tsirkin wrote:
> > On Wed, Jan 18, 2017 at 10:42:48AM +0800, Jason Wang wrote:
> > >=20
> > > On 2017=E5=B9=B401=E6=9C=8817=E6=97=A5 22:44, Michael S. Tsirkin wr=
ote:
> > > > On Tue, Jan 17, 2017 at 12:01:00PM +0800, Jason Wang wrote:
> > > > > We allow vhost to clear VIRITO_F_IOMMU_PLATFORM which is wrong =
since
> > > > > VIRTIO_F_IOMMU_PLATFORM is mandatory for security. Fixing this =
by
> > > > > enforce it after vdc->get_features().
> > > > >=20
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >    hw/virtio/virtio-bus.c | 5 +++--
> > > > >    1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> > > > > index d31cc00..a886011 100644
> > > > > --- a/hw/virtio/virtio-bus.c
> > > > > +++ b/hw/virtio/virtio-bus.c
> > > > > @@ -47,6 +47,7 @@ void virtio_bus_device_plugged(VirtIODevice *=
vdev, Error **errp)
> > > > >        VirtioBusState *bus =3D VIRTIO_BUS(qbus);
> > > > >        VirtioBusClass *klass =3D VIRTIO_BUS_GET_CLASS(bus);
> > > > >        VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev)=
;
> > > > > +    bool has_iommu =3D virtio_host_has_feature(vdev, VIRTIO_F_=
IOMMU_PLATFORM);
> > > > >        DPRINTF("%s: plug device.\n", qbus->name);
> > > > > @@ -63,8 +64,8 @@ void virtio_bus_device_plugged(VirtIODevice *=
vdev, Error **errp)
> > > > >            klass->device_plugged(qbus->parent, errp);
> > > > >        }
> > > > > -    if (klass->get_dma_as !=3D NULL &&
> > > > > -        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)=
) {
> > > > > +    if (klass->get_dma_as !=3D NULL && has_iommu) {
> > > > > +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMM=
U_PLATFORM);
> > > > >            vdev->dma_as =3D klass->get_dma_as(qbus->parent);
> > > > >        } else {
> > > > >            vdev->dma_as =3D &address_space_memory;
> > > > I suspect that's not enough, we must also fail or disable vhost
> > > > (depending on the options), otherwise things won't work.
> > > Looks like with the patch, VIRTIO_F_IOMMU_PLATFORM will be passed t=
o
> > > vhost_set_features().
> > Okay then. Could you please test on an old host kernel and confirm
> > what happens? Pls mention this in commit log.
>=20
> Test were done before sending this patch :)
>=20
> Vhost fallback to userspace since it lacks VIRTIO_F_IOMMU_PLATFORM.
>=20
> >=20
> > > So if vhost backend does not support it, it will fall
> > > back to userspace (This may not work for vhost-user, but it's a bug=
 existed
> > > even before this patch).
> > >=20
> > > Thanks
> > I guess this is true but this suddenly makes it important to
> > fix this. So I prefer a patchset where patch 2 addresses
> > the fallback bug. In which way? Do you think we should
> > just fail if vhost doesn't work? Does this apply to both
> > userspace and kernel?
>=20
> For 1.0 devices we could do this through NEEDS_RESET, but it doesn't wo=
rk
> for legacy device. For kernel vhost, I'd prefer to keep the current
> fallback.

I'm not so sure. This has security implications, e.g. user might
expect not to be affected by a bug in qemu if specifying vhost=3Don.

> For vhost-user, it seems not easy and we could not just terminate
> qemu in this case consider this kind of failure can only be detected du=
ring
> start not init.
>=20
> Thanks

I think we should at least deny connection.

--=20
MST
