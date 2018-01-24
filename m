Received: from eggs.gnu.org ([2001:4830:134:3::10]:49156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eeJQM-0002zY-Ee
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 06:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eeJQJ-000182-B7
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 06:41:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eeJQJ-00017J-55
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 06:40:59 -0500
Date: Wed, 24 Jan 2018 11:40:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180124114055.GC17193@stefanha-x1.localdomain>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<5A65C652.6080307@intel.com>
	<20180123111238.GC6565@stefanha-x1.localdomain>
	<5A673369.6050408@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <5A673369.6050408@intel.com>
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 09:06:49PM +0800, Wei Wang wrote:
> On 01/23/2018 07:12 PM, Stefan Hajnoczi wrote:
> > On Mon, Jan 22, 2018 at 07:09:06PM +0800, Wei Wang wrote:
> > > On 01/19/2018 09:06 PM, Stefan Hajnoczi wrote:
> > >=20
> > >=20
> > >   - Suppose in the future there is also a kernel virtio-vhost-user dr=
iver as
> > > other PCI devices, can we unbind the kernel driver first, and then bi=
nd the
> > > device to the dpdk driver? A normal PCI device should be able to smoo=
thly
> > > switch between the kernel driver and dpdk driver.
> > It depends what you mean by "smoothly switch".
> >=20
> > If you mean whether it's possible to go from a kernel driver to
> > vfio-pci, then the answer is yes.
> >=20
> > But if the kernel driver has an established vhost-user connection then
> > it will be closed.  This is the same as reconnecting with AF_UNIX
> > vhost-user.
> >=20
>=20
> Actually not only the case of switching to testpmd after kernel establish=
es
> the connection, but also for several runs of testpmd. That is, if we run
> testpmd, then exit testpmd. I think the second run of testpmd won't work.

The vhost-user master must reconnect and initialize again (SET_FEATURES,
SET_MEM_TABLE, etc).  Is your master reconnecting after the AF_UNIX
connection is closed?

> I'm thinking about caching the received master msgs in QEMU when
> virtio_vhost_user_parse_m2s().

Why is that necessary and how does QEMU know they are still up-to-date
when a new connection is made?

> Btw, I'm trying to run the code, but couldn't bind the virito-vhost-user
> device to vfio-pci (reports Unknown device), not sure if it is because the
> device type is "Unclassified device".

You need to use the modified usertools/dpdk-devbind.py from my patch
series inside the guest.  Please see:
https://dpdk.org/ml/archives/dev/2018-January/088177.html

Stefan

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaaHDHAAoJEJykq7OBq3PI/9cH/RFXYBdZ63oy2xC6Nz9SY6R1
ot00+BxUqtytUM6LBf3/RjKBPwbyfsPEGaFJE0hNRT+EJDYBMRfQFC5zbEn//Iw/
aeuZwfZ/l8k9/4GPgK067vFEFUpxW676yUKlJOoSXUjQuXYCRWXj6iiOOXZCOZFe
6NDS+ZwDp6+jUKpIer0LjmtSUDSomy954shSsUT4ew/YrQLpvFS8dIbMAJPHbh4G
5vVn2k6FgGZwxSjanuHsCrNHIJ9LjN9J9L3ERxqAcAcGKTWQ0GgFL9PU3Sczla0G
9zZ0mV5t52+BFImbf3+ha33ebHCb4iYgArwkCuy7pWxfu6uUH7DAxdXQiBiDAL4=
=B78q
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
