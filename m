Received: from eggs.gnu.org ([2001:4830:134:3::10]:52638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7pwQ-0004qR-ID
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7pwM-000801-CL
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:11:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7pwM-0007zj-3t
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:11:34 -0400
References: <alpine.DEB.2.10.1705081334150.24729@sstabellini-ThinkPad-X260>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f0bf90b-a706-01c8-cad1-6dea6620deef@redhat.com>
Date: Mon, 8 May 2017 16:11:30 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1705081334150.24729@sstabellini-ThinkPad-X260>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0wrl2I62axX5rCCecxecReCHJVo05LHa1"
Subject: Re: [Qemu-devel] [PATCH] Fix issues affecting Xen 9pfs discovered
 by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, anthony.perard@citrix.com
Cc: xen-devel@lists.xensource.com, aneesh.kumar@linux.vnet.ibm.com, qemu-devel@nongnu.org, groug@kaod.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0wrl2I62axX5rCCecxecReCHJVo05LHa1
From: Eric Blake <eblake@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>, anthony.perard@citrix.com
Cc: xen-devel@lists.xensource.com, aneesh.kumar@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org
Message-ID: <1f0bf90b-a706-01c8-cad1-6dea6620deef@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Fix issues affecting Xen 9pfs discovered by
 Coverity
References: <alpine.DEB.2.10.1705081334150.24729@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1705081334150.24729@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 03:45 PM, Stefano Stabellini wrote:
> Fix two resource leaks on error paths, discovered by Coverity.
> Check for errors returned by fcntl, also found by Coverity.
>=20
> CID:1374836
> CID:1374831
>=20

> @@ -378,7 +380,10 @@ static int xen_9pfs_connect(struct XenDevice *xend=
ev)
>          if (xen_9pdev->rings[i].evtchndev =3D=3D NULL) {
>              goto out;
>          }
> -        fcntl(xenevtchn_fd(xen_9pdev->rings[i].evtchndev), F_SETFD, FD=
_CLOEXEC);
> +        if (fcntl(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
> +                  F_SETFD, FD_CLOEXEC) =3D=3D -1) {
> +            goto out;

Directly calling fcntl(F_SETFD) without first reading fcntl(F_GETFD) is
(theoretically) incorrect.  Better might be using qemu_set_cloexec()
instead of open-coding something.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0wrl2I62axX5rCCecxecReCHJVo05LHa1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEN8CAAoJEKeha0olJ0NqTB8H/1JgGZ2smxjJVtOdw0DQcMwG
nlkechOKjB3urHR4uNnorZDTGsOgroswYzvWhubriVm5y49kasHoy8JHnVWiZTxT
3MQuSFargA4yQeDDk6ieYB/2PQ7uvdFL8x76W/QfKnroth7jPkDaILZHPo7Qf4in
clrSO/KxsoIPKIluXM4pYXbp3gppmOd2wysPYS0qwCCXg5d/hbA79M/D37hs7ocu
BQzhl3oKxTKPgAg2jcSB+TRxkDvAhBGxJd+JTXkbvQZSP1gzdl+NQQIEHmw8uDev
QIisyxkxrxF9kSZWhtDwqstoCCMgTjobKhllOQEflaQIqi49tlOJ5mQ7Zi1wFCE=
=7BsU
-----END PGP SIGNATURE-----

--0wrl2I62axX5rCCecxecReCHJVo05LHa1--
