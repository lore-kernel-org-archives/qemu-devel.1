Received: from eggs.gnu.org ([2001:4830:134:3::10]:41181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePXNF-0001lV-9r
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePXNB-00030p-1i
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:32:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePXNA-0002zk-PW
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:32:40 -0500
Date: Thu, 14 Dec 2017 17:32:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214173231.GS14433@stefanha-x1.localdomain>
References: <20171207213420-mutt-send-email-mst@kernel.org>
	<5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<5A3211CC.60607@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lx/R+CYDdR/AN/7"
Content-Disposition: inline
In-Reply-To: <5A3211CC.60607@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>


--0lx/R+CYDdR/AN/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 01:53:16PM +0800, Wei Wang wrote:
> On 12/13/2017 08:35 PM, Stefan Hajnoczi wrote:
> > On Wed, Dec 13, 2017 at 04:11:45PM +0800, Wei Wang wrote:
> >=20
> > I think the current approach is fine for a prototype but is not suitable
> > for wider use by the community because it:
> > 1. Does not scale to multiple device types (net, scsi, blk, etc)
> > 2. Does not scale as the vhost-user protocol changes
> > 3. It is hard to make slaves run in both host userspace and the guest
> >=20
> > It would be good to solve these problems so that vhost-pci can become
> > successful.  It's very hard to fix these things after the code is merged
> > because guests will depend on the device interface.
> >=20
> > Here are the points in detail (in order of importance):
> >=20
> > 1. Does not scale to multiple device types (net, scsi, blk, etc)
> >=20
> > vhost-user is being applied to new device types beyond virtio-net.
> > There will be demand for supporting other device types besides
> > virtio-net with vhost-pci.
> >=20
> > This patch series requires defining a new virtio device type for each
> > vhost-user device type.  It is a lot of work to design a new virtio
> > device.  Additionally, the new virtio device type should become part of
> > the VIRTIO standard, which can also take some time and requires writing
> > a standards document.
> >=20
> > 2. Does not scale as the vhost-user protocol changes
> >=20
> > When the vhost-user protocol changes it will be necessary to update the
> > vhost-pci device interface to reflect those changes.  Each protocol
> > change requires thinking how the virtio devices need to look in order to
> > support the new behavior.  Changes to the vhost-user protocol will
> > result in changes to the VIRTIO specification for the vhost-pci virtio
> > devices.
> >=20
> > 3. It is hard to make slaves run in both host userspace and the guest
> >=20
> > If a vhost-user slave wishes to support running in host userspace and
> > the guest then not much code can be shared between these two modes since
> > the interfaces are so different.
> >=20
> > How would you solve these issues?
>=20
> 1st one: I think we can factor out a common vhost-pci device layer in QEM=
U.
> Specific devices (net, scsi etc) emulation comes on top of it. The
> vhost-user protocol sets up VhostPCIDev only. So we will have something l=
ike
> this:
>=20
> struct VhostPCINet {
>     struct VhostPCIDev vp_dev;
>     u8 mac[8];
>     ....
> }

Defining VhostPCIDev is an important step to making it easy to implement
other device types.  I'm interested is seeing how this would look either
in code or in a more detailed outline.

I wonder what the device-specific parts will be.  This patch series does
not implement a fully functional vhost-user-net device so I'm not sure.

> 2nd one: I think we need to view it the other way around: If there is a
> demand to change the protocol, then where is the demand from? I think mos=
tly
> it is because there is some new features from the device/driver. That is,=
 we
> first have already thought about how the virtio device looks like with the
> new feature, then we add the support to the protocol.

The vhost-user protocol will change when people using host userspace
slaves decide to change it.  They may not know or care about vhost-pci,
so the virtio changes will be an afterthought that falls on whoever
wants to support vhost-pci.

This is why I think it makes a lot more sense to stick to the vhost-user
protocol as the vhost-pci slave interface instead of inventing a new
interface on top of it.

> I'm not sure how would
> it cause not scaling well, and how using another GuestSlave-to-QemuMaster
> changes the story (we will also need to patch the GuestSlave inside the VM
> to support the vhost-user negotiation of the new feature), in comparison =
to
> the standard virtio feature negotiation.

Plus the VIRTIO specification needs to be updated.

And if the vhost-user protocol change affects all device types then it
may be necessary to change multiple virtio devices!  This is O(1) vs
O(N).

> 3rd one: I'm not able to solve this one, as discussed, there are too many
> differences and it's too complex. I prefer the direction of simply gating
> the vhost-user protocol and deliver to the guest what it should see (just
> what this patch series shows). You would need to solve this issue to show
> this direction is simpler :)

#3 is nice to have but not critical.

In the approach I suggested it would be done by implementing vfio
vhost-pci for libvhost-user or DPDK.

Stefan

--0lx/R+CYDdR/AN/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMrWvAAoJEJykq7OBq3PIv48H/jOzaStbyYG1k4Njb8V1S+SK
gSOoPEJ002X83bh3bJnBvhggAtVr/LoFh6IMA0ZC715jPoEqUb8X595XBEI99seH
Mw+t1FblHM0pbuRV6XUw3FUrSXqvSc90Ykrpze1LJqjFGaaf2wGdmUQs4w8o6a14
jkglQNuwRqY6JkE8Bak9EP8suSgj8uMXpCN6XghtYbn0GvvWYhNM4mTxL615oxhd
5OEPNWygsGWwzVcUz+kTaZUP7hgCT/qmXV2mcka2DcUtHcL7i0VEHFPdiwxgUQds
boE8UZuLHg/tvlhidIf8r8y1uJPl5Ml6+PPJICoM6ZINT701+jDF4xSv2rYvD8U=
=vE9x
-----END PGP SIGNATURE-----

--0lx/R+CYDdR/AN/7--
