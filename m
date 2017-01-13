Received: from eggs.gnu.org ([2001:4830:134:3::10]:44823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cS4kE-0001Nd-Ab
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cS4k9-0004bm-Dk
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:30:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cS4k9-0004bX-7V
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:30:21 -0500
Date: Fri, 13 Jan 2017 18:30:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170113182836-mutt-send-email-mst@kernel.org>
References: <1484109132-3331-1-git-send-email-jasowang@redhat.com>
	<20170112161056-mutt-send-email-mst@kernel.org>
	<f4528c3e-4648-e9ef-0e01-b5cce3ede31b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4528c3e-4648-e9ef-0e01-b5cce3ede31b@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 net-next] vhost_net: device IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, cornelia.huck@de.ibm.com, wexu@redhat.com, vkaplans@redhat.com, pbonzini@redhat.com

On Fri, Jan 13, 2017 at 10:45:09AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8812=E6=97=A5 22:17, Michael S. Tsirkin wrote:
> > On Wed, Jan 11, 2017 at 12:32:12PM +0800, Jason Wang wrote:
> > > This patches implements Device IOTLB support for vhost kernel. This=
 is
> > > done through:
> > >=20
> > > 1) switch to use dma helpers when map/unmap vrings from vhost codes
> > > 2) introduce a set of VhostOps to:
> > >     - setting up device IOTLB request callback
> > >     - processing device IOTLB request
> > >     - processing device IOTLB invalidation
> > > 2) kernel support for Device IOTLB API:
> > >=20
> > > - allow vhost-net to query the IOMMU IOTLB entry through eventfd
> > > - enable the ability for qemu to update a specified mapping of vhos=
t
> > > - through ioctl.
> > > - enable the ability to invalidate a specified range of iova for th=
e
> > >    device IOTLB of vhost through ioctl. In x86/intel_iommu case thi=
s is
> > >    triggered through iommu memory region notifier from device IOTLB
> > >    invalidation descriptor processing routine.
> > >=20
> > > With all the above, kernel vhost_net can co-operate with userspace
> > > IOMMU. For vhost-user, the support could be easily done on top by
> > > implementing the VhostOps.
> > >=20
> > > Cc: Michael S. Tsirkin<mst@redhat.com>
> > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > Applied, thanks!
> >=20
> > > ---
> > > Changes from V4:
> > > - set iotlb callback only when IOMMU_PLATFORM is negotiated (fix
> > >    vhost-user qtest failure)
> > In fact this only checks virtio_host_has_feature - which is
> > the right thing to do, we can't trust the guest.
> >=20
> > > - whitelist VIRTIO_F_IOMMU_PLATFORM instead of manually add it
> > > - keep cpu_physical_memory_map() in vhost_memory_map()
> > One further enhancement might be to detect that guest disabled
> > iommu (e.g. globally, or using iommu=3Dpt) and disable
> > the iotlb to avoid overhead for guests which use DPDK
> > for assigned devices but not for vhost.
> >=20
> >=20
>=20
> Yes, it's in my todo list.
>=20
> Thanks

Something that I just noticed is that when user requests iommu_platform
but vhost can not provide it, this patches will just let vhost continue
without.  I think that's wrong, since iommu_platform is a security
feature, when it's not supported I think we should fail init.

--=20
MST
