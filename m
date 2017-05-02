Received: from eggs.gnu.org ([2001:4830:134:3::10]:45453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5XDy-0005d3-CH
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5XDt-0003Py-H0
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:48:14 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d5XDt-0003PZ-7Y
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:48:09 -0400
Received: by mail-wm0-x22c.google.com with SMTP id u65so111457623wmu.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 05:48:09 -0700 (PDT)
Date: Tue, 2 May 2017 13:48:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502124804.GB22502@stefanha-x1.localdomain>
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
	<20170419095748.GE3343@stefanha-x1.localdomain>
	<58F73F22.50108@intel.com>
	<CAJSP0QWUFNH4ac7-1H5PSp_psByCvXH7gq_vzuqmXRmzXGo_ww@mail.gmail.com>
	<58F84C5C.5050701@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <58F84C5C.5050701@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 01:51:24PM +0800, Wei Wang wrote:
> On 04/19/2017 11:24 PM, Stefan Hajnoczi wrote:
> > On Wed, Apr 19, 2017 at 11:42 AM, Wei Wang <wei.w.wang@intel.com> wrote:
> > > On 04/19/2017 05:57 PM, Stefan Hajnoczi wrote:
> > > > On Wed, Apr 19, 2017 at 06:38:11AM +0000, Wang, Wei W wrote:
> > > > > We made some design changes to the original vhost-pci design, and=
 want to
> > > > > open
> > > > > a discussion about the latest design (labelled 2.0) and its exten=
sion
> > > > > (2.1).
> > > > > 2.0 design: One VM shares the entire memory of another VM
> > > > > 2.1 design: One VM uses an intermediate memory shared with anothe=
r VM for
> > > > >                        packet transmission.
> > > > Hi,
> > > > Can you talk a bit about the motivation for the 2.x design and major
> > > > changes compared to 1.x?
> > >=20
> > > 1.x refers to the design we presented at KVM Form before. The major
> > > change includes:
> > > 1) inter-VM notification support
> > > 2) TX engine and RX engine, which is the structure built in the drive=
r. From
> > > the device point of view, the local rings of the engines need to be
> > > registered.
> > It would be great to support any virtio device type.
>=20
> Yes, the current design already supports the creation of devices of
> different types.
> The support is added to the vhost-user protocol and the vhost-user slave.
> Once the slave handler receives the request to create the device (with
> the specified device type), the remaining process (e.g. device realize)
> is device specific.
> This part remains the same as presented before
> (i.e.Page 12 @ http://www.linux-kvm.org/images/5/55/02x07A-Wei_Wang-Desig=
n_of-Vhost-pci.pdf).
> >=20
> > The use case I'm thinking of is networking and storage appliances in
> > cloud environments (e.g. OpenStack).  vhost-user doesn't fit nicely
> > because users may not be allowed to run host userspace processes.  VMs
> > are first-class objects in compute clouds.  It would be natural to
> > deploy networking and storage appliances as VMs using vhost-pci.
> >=20
> > In order to achieve this vhost-pci needs to be a virtio transport and
> > not a virtio-net-specific PCI device.  It would extend the VIRTIO 1.x
> > spec alongside virtio-pci, virtio-mmio, and virtio-ccw.
>=20
> Actually it is designed as a device under virtio-pci transport. I'm
> not sure about the value of having a new transport.
>=20
> > When you say TX and RX I'm not sure if the design only supports
> > virtio-net devices?
>=20
> Current design focuses on the vhost-pci-net device. That's the
> reason that we have TX/RX here. As mention above, when the
> slave invokes the device creation function, the execution
> goes to each device specific code.
>=20
> The TX/RX is the design after the device creation, so it is specific
> to vhost-pci-net. For the future vhost-pci-blk, that design can
> have its own request queue.

Here is my understanding based on your vhost-pci GitHub repo:

VM1 sees a normal virtio-net-pci device.  VM1 QEMU is invoked with a
vhost-user netdev.

VM2 sees a hotplugged vhost-pci-net virtio-pci device once VM1
initializes the device and a message is sent over vhost-user.

There is no integration with Linux drivers/vhost/ code for VM2.  Instead
you are writing a 3rd virtio-net driver specifically for vhost-pci.  Not
sure if it's possible to reuse drivers/vhost/ cleanly but that would be
nicer than implementing virtio-net again.

Is the VM1 vhost-user netdev a normal vhost-user device or does it know
about vhost-pci?

It's hard to study code changes in your vhost-pci repo because
everything (QEMU + Linux + your changes) was committed in a single
commit.  Please keep your changes in separate commits so it's easy to
find them.

Stefan

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCIAEAAoJEJykq7OBq3PIn9AIAL/pCPeS94MFAdUfMiNKLtMK
33dfri99Nd0LAOm6n7D+gJjYdyhsEvOf5SIScHiSqsiuPQabcy8a/3Dznxx7ncKf
C40awBPirBVKbyG5dg9ievmANrIdm9aeP4NVe+9kzpxXqUnjyCp4JEk36CSGYcgz
3Ny1diIhaWooC3Lrx6Gwuoxbh9rglAgAUEMRzaTXYwv83kiK6yqhaqyrcEvYROWO
4fr8lfAbkp3i2ZhMKJq8IzPxViIsDKGWp9wcu6mniWGv4ddfJqQIV509tR464BFV
AGxKYvIWyQ67W5rPhbUoCV5+D6+ycEdXIdgBCHHOGRg0GXF/NPppN5hjWA+54qg=
=Bf6r
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
