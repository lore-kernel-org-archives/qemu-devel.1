Received: from eggs.gnu.org ([2001:4830:134:3::10]:33367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePVj9-0006Ik-Ku
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePVj6-0000AB-HG
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:47:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePVj6-00008V-8O
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:47:12 -0500
Date: Thu, 14 Dec 2017 15:46:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214154656.GR14433@stefanha-x1.localdomain>
References: <CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<20171213165142-mutt-send-email-mst@kernel.org>
	<CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
	<825b8205-0b88-a198-b77d-63c8f2563c2e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MRBOAUz+O/XNC2GI"
Content-Disposition: inline
In-Reply-To: <825b8205-0b88-a198-b77d-63c8f2563c2e@redhat.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] [PATCH v3 0/7]
 Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>


--MRBOAUz+O/XNC2GI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 10:50:11PM +0100, Maxime Coquelin wrote:
> On 12/13/2017 09:08 PM, Stefan Hajnoczi wrote:
> > On Wed, Dec 13, 2017 at 3:01 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > > On Wed, Dec 13, 2017 at 12:35:21PM +0000, Stefan Hajnoczi wrote:
> > > > I'm not saying that DPDK should use libvhost-user.  I'm saying that=
 it's
> > > > easy to add vfio vhost-pci support (for the PCI adapter I described=
) to
> > > > DPDK.  This patch series would require writing a completely new sla=
ve
> > > > for vhost-pci because the device interface is so different from
> > > > vhost-user.
> > >=20
> > > The main question is how appropriate is the vhost user protocol
> > > for passing to guests. And I am not sure at this point.
> > >=20
> > > Someone should go over vhost user messages and see whether they are s=
afe
> > > to pass to guest. If most are then we can try the transparent approac=
h.
> > > If most aren't then we can't and might as well use the proposed proto=
col
> > > which at least has code behind it.
> >=20
> > I have done that:
> >=20
> ...
> >   * VHOST_USER_SET_MEM_TABLE
> >=20
> >     Set up BARs before sending a VHOST_USER_SET_MEM_TABLE to the guest.
>=20
> It would require to filter out userspace_addr from the payload not to
> leak other QEMU process VAs to the guest.

QEMU's vhost-user master implementation is insecure because it leaks
QEMU process VAs.  This also affects vhost-user host processes, not just
vhost-pci.

The QEMU vhost-user master could send an post-IOMMU guest physical
addresses whereever the vhost-user protocol specification says "user
address".  That way no address space information is leaked although it
does leak IOMMU mappings.

If we want to hide the IOMMU mappings too then we need another logical
address space (kind a randomized ramaddr_t).

Anyway, my point is that the current vhost-user master implementation is
insecure and should be fixed.  vhost-pci doesn't need to worry about
this issue.

Stefan

--MRBOAUz+O/XNC2GI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMpzwAAoJEJykq7OBq3PIS34IAMaqFN+TNSd9mYxrYGxkSQOW
qQ4mfGkto/oEUIuvt+mnt0ACBLq8oElAjlO8FJzonRJit1OGb5wC1udjdySWkkQN
aeHrwwhkkwIQHLuK68C8zF/FSDqimRi6/H+pqPMjeEW7TADkFyIoQ9ins8YdtfyW
1M2b0wS0dfZOzj4Vut81O4dMKi4mWVQ5M6w56gWrvEw0umC4CMlYjODaOs9Xjc9A
9Oq5sXMj4RT9Z3wg5LQ0tD+UL5S5Bxj6gQHCUdENiJtuGKIWsZKZmwFWv/8D3qzU
y/C2gpRRGAIuZAKGt5/m2hOE1K2CJAsg7jRlCVhupCruiLw/hiTq049GjeHIW2g=
=IykU
-----END PGP SIGNATURE-----

--MRBOAUz+O/XNC2GI--
