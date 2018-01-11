Received: from eggs.gnu.org ([2001:4830:134:3::10]:58602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZehs-0007al-Pb
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZehp-0006k8-L4
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:23:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eZehp-0006i2-Aq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:23:49 -0500
Date: Thu, 11 Jan 2018 15:23:45 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180111152345.GA7353@stefanha-x1.localdomain>
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: wei.w.wang@intel.com, qemu-devel@nongnu.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2018 at 06:57:03PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B401=E6=9C=8811=E6=97=A5 00:14, Stefan Hajnoczi wrote:
> > Hi Wei,
> > I wanted to summarize the differences between the vhost-pci and
> > virtio-vhost-user approaches because previous discussions may have been
> > confusing.
> >=20
> > vhost-pci defines a new virtio device type for each vhost device type
> > (net, scsi, blk).  It therefore requires a virtio device driver for each
> > device type inside the slave VM.
> >=20
> > Adding a new device type requires:
> > 1. Defining a new virtio device type in the VIRTIO specification.
> > 3. Implementing a new QEMU device model.
> > 2. Implementing a new virtio driver.
> >=20
> > virtio-vhost-user is a single virtio device that acts as a vhost-user
> > protocol transport for any vhost device type.  It requires one virtio
> > driver inside the slave VM and device types are implemented using
> > existing vhost-user slave libraries (librte_vhost in DPDK and
> > libvhost-user in QEMU).
> >=20
> > Adding a new device type to virtio-vhost-user involves:
> > 1. Adding any new vhost-user protocol messages to the QEMU
> >     virtio-vhost-user device model.
> > 2. Adding any new vhost-user protocol messages to the vhost-user slave
> >     library.
> > 3. Implementing the new device slave.
> >=20
> > The simplest case is when no new vhost-user protocol messages are
> > required for the new device.  Then all that's needed for
> > virtio-vhost-user is a device slave implementation (#3).  That slave
> > implementation will also work with AF_UNIX because the vhost-user slave
> > library hides the transport (AF_UNIX vs virtio-vhost-user).  Even
> > better, if another person has already implemented that device slave to
> > use with AF_UNIX then no new code is needed for virtio-vhost-user
> > support at all!
> >=20
> > If you compare this to vhost-pci, it would be necessary to design a new
> > virtio device, implement it in QEMU, and implement the virtio driver.
> > Much of virtio driver is more or less the same thing as the vhost-user
> > device slave but it cannot be reused because the vhost-user protocol
> > isn't being used by the virtio device.  The result is a lot of
> > duplication in DPDK and other codebases that implement vhost-user
> > slaves.
> >=20
> > The way that vhost-pci is designed means that anyone wishing to support
> > a new device type has to become a virtio device designer.  They need to
> > map vhost-user protocol concepts to a new virtio device type.  This will
> > be time-consuming for everyone involved (e.g. the developer, the VIRTIO
> > community, etc).
> >=20
> > The virtio-vhost-user approach stays at the vhost-user protocol level as
> > much as possible.  This way there are fewer concepts that need to be
> > mapped by people adding new device types.  As a result, it will allow
> > virtio-vhost-user to keep up with AF_UNIX vhost-user and grow because
> > it's easier to work with.
> >=20
> > What do you think?
> >=20
> > Stefan
>=20
> So a question is what's the motivation here?
>=20
> Form what I'm understanding, vhost-pci tries to build a scalable V2V priv=
ate
> datapath. But according to what you describe here, virito-vhost-user tries
> to make it possible to implement the device inside another VM. I understa=
nd
> the goal of vhost-pci could be done on top, but it looks to me it would t=
hen
> rather similar to the design of Xen driver domain. So I can not figure out
> how it can be done in a high performance way.

vhost-pci and virtio-vhost-user both have the same goal.  They allow
a VM to implement a vhost device (net, scsi, blk, etc).  This allows
software defined network or storage appliances running inside a VM to
provide I/O services to other VMs.  To the other VMs the devices look
like regular virtio devices.

I'm not sure I understand your reference to the Xen driver domain or
performance.  Both vhost-pci and virtio-vhost-user work using shared
memory access to the guest RAM of the other VM.  Therefore they can poll
virtqueues and avoid vmexit.  They do also support cross-VM interrupts,
thanks to QEMU setting up irqfd/ioeventfd appropriately on the host.

Stefan

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaV4GAAAoJEJykq7OBq3PIH+8H/R931waPY7zS1Bz8l4Xd/xVO
krSr8Ww8enVGLlypHj0TPHJUx3N4WawaPvTBMbagveSSdD42GO4FH6XslV3NXeTv
ddhLwO3SZB3gvnO89z/Fyxegye4HigXYjRmOA3I4OP5n1NqMA1sNJ8cC7oRXtPJg
F2vno1TJaLsEhJ6r2cT/Tv9IGiYUe+8YiMtA5MtI+Eh6ODTKcsaJSiEhDn//oK1R
cg0iTsF9lBWMZmv4K40lSOiXp0pUqyqC6L84t9/i5isj/TuP2qUtFv6qZi1q2yO2
9fSdNG07GHUekC4STRyQGtKTNbSdkiBzbHSaaRDnM/28oj4MA9G3tsrw0CUClzk=
=KI4S
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
