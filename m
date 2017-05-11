Received: from eggs.gnu.org ([2001:4830:134:3::10]:44515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1d8vnN-0000vC-H9
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1d8vnK-0000dW-0H
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:38:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riel@redhat.com>) id 1d8vnJ-0000d9-Po
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:38:45 -0400
Message-ID: <1494538720.20270.35.camel@redhat.com>
From: Rik van Riel <riel@redhat.com>
Date: Thu, 11 May 2017 17:38:40 -0400
In-Reply-To: <20170511181703.GC8701@stefanha-x1.localdomain>
References: <1494431760-6455-1-git-send-email-pagupta@redhat.com>
	<20170511181703.GC8701@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-i3zATagNHReA2Kg5+gJj"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] KVM "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Pankaj Gupta <pagupta@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>, Dan Williams <dan.j.williams@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>


--=-i3zATagNHReA2Kg5+gJj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2017-05-11 at 14:17 -0400, Stefan Hajnoczi wrote:
> On Wed, May 10, 2017 at 09:26:00PM +0530, Pankaj Gupta wrote:
> > * For live migration use case, if host side backing file is=C2=A0
> > =C2=A0 shared storage, we need to flush the page cache for the disk=C2=
=A0
> > =C2=A0 image at the destination (new fadvise interface,
> > FADV_INVALIDATE_CACHE?)=C2=A0
> > =C2=A0 before starting execution of the guest on the destination host.
>=20
> Good point.=C2=A0=C2=A0QEMU currently only supports live migration with
> O_DIRECT.
> I think the problem was that userspace cannot guarantee consistency
> in
> the general case.=C2=A0=C2=A0If you find a solution to this problem for f=
ake
> NVDIMM then maybe the QEMU block layer can also begin supporting live
> migration with buffered I/O.

I'll be happy to work with you on that, independently
of Pankaj's project.

It looks like the fadvise system call could be extended
pretty easily with an FADV_INVALIDATE_CACHE command, the
other side of which can simply hook into the existing
page cache invalidation code in the kernel.

Qemu will need to know whether the invalidation succeeded,
but that is something we can test for pretty easily before
returning to userspace.

--=20
All rights reversed
--=-i3zATagNHReA2Kg5+gJj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJZFNnhAAoJEM553pKExN6D6MoIAKpuU/XNG0H3D6KuKHTkSwb3
SxnHpE/KCtquxfKS6pUMHHvxKPXOURzZ/rAwR4t1xGoE3t5y+gH6NHrg9qti+i/U
aHYoLQmUAs5CPMMgYEJH62dUBK8rw5yl1E3V0jxHo+4WQhb21v8aXHhUilg2m+uf
BT+TfUGV/SjaXca6d/r9VkDuI5pNkH8o2CMDlHMvWR8wVwrw2T8BUzmdHMzlEVpt
4Yooi+E6+HCtSQ0q/TYsXNwxTCi6jQQEcXDWZoIzTCNwe5t6tTgRBLjoKvE0Fzvi
ig6np5bS+TjRPvmWAigEFDZpKF6JwzO6LebVCEwVEzDWdIOr/9jHeGiaox2qXdw=
=C3g1
-----END PGP SIGNATURE-----

--=-i3zATagNHReA2Kg5+gJj--
