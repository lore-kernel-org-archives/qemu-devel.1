Received: from eggs.gnu.org ([2001:4830:134:3::10]:37306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYmk-0002h9-23
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYmg-0001XC-6k
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:01:10 -0400
Date: Fri, 3 Nov 2017 10:01:02 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103100102.GE5078@stefanha-x1.localdomain>
References: <20171102120223.GI32533@redhat.com> <20171103060046.GB18539@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline
In-Reply-To: <20171103060046.GB18539@lemon>
Subject: Re: [Qemu-devel] [Qemu-block]  RFC: use case for adding QMP,
 block jobs & multiple exports to qemu-nbd ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2017 at 02:00:46PM +0800, Fam Zheng wrote:
> On Thu, 11/02 12:02, Daniel P. Berrange wrote:
> > One alternative approach to doing this would be to suggest that we shou=
ld
> > instead just spawn qemu-system-x86_64 with '--machine none' and use that
> > as a replacement for qemu-nbd, since it already has a built-in NBD serv=
er
> > which can do many exports at once and arbitrary block jobs.
>=20
> Here is a crazy idea from KVM Forum discussions that may relate, so menti=
on it
> here: we could move the QEMU block layer to a separate program and guest =
can use
> vhost-user-{blk,scsi} for I/O. It is something like this:
>=20
>=20
>    master-disk1.qcow2  (qemu-nbd)
>           ^
>           |  backing
>           |
>    cache-disk1.qcow2   (qemu-vhost)     <-------------.
>           ^                                           |
>           |  backing                                  |  backing
>           |                                           |
>           +-  vm-a-disk1.qcow2   (qemu-vhost)         +-  vm-a-disk2.qcow=
2   (qemu-vhost)
>                     ^                                             ^
>                     |  vhost-user-blk                             |  vhos=
t-user-blk
>                     |                                             |
>                     +- VM-1 (qemu-system-XXX)                     +- VM-2=
 (qemu-system-XXX)
>=20
>=20
> So on the compute node, there will be N qemu-system-XXX processes (where =
N is
> the number of VMs) and 1 qemu-vhost process.
>=20
> The hypothetical qemu-vhost program needs to support QMP as well and it r=
uns the
> COR/mirroring jobs from master disk to cache disk, just like what you pro=
pose to
> do with the extended qemu-nbd. The only difference is replacing the local=
 NBD
> with vhost-user, which is more efficient.

The vhost-user part can be added later.  I think the first step is
whether to add a QMP interface to qemu-nbd or use -machine none.

Stefan

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/D5eAAoJEJykq7OBq3PIJAIIAKlLmp4giV506YgnqfcrbZxR
tuDrlmQtQH4zGjiCWzhw2xRpiGTqqOrXA0+ZJLchXCeB6/RXW3iYopS9GhHIA/Py
Zjtr+0vz8VqhomKvuAWcLBhvpAwh5cU2Ph7Be/aH6n/n9W4fg17ix9LocPEQCFzJ
7ZPSt+rrLV0gM4rwyNHkfunLWIDrI08p8Na54xSSdEVpoQpzg8NujWGZ0EDtUZGp
hJ43QmeXAu043iGCVU5RH9l6A6V4ETs/PdrCES2xt1+dHSoCDY4Mxi/ARP+Cj2z8
/aq8x+O3i3SbvvHoPb2+D+/zqCWMuBC/6nV12pup+QVam0S15HUsxx38J0WZZ6c=
=LbUP
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--
