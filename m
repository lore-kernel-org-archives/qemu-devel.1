Received: from eggs.gnu.org ([2001:4830:134:3::10]:34294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7qmB-0004n9-JC
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7qm8-0002AG-D3
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:05:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7qm8-0002A8-3L
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:05:04 -0400
References: <alpine.DEB.2.10.1705081334150.24729@sstabellini-ThinkPad-X260>
	<1f0bf90b-a706-01c8-cad1-6dea6620deef@redhat.com>
	<alpine.DEB.2.10.1705081454510.24729@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1705081459030.24729@sstabellini-ThinkPad-X260>
From: Eric Blake <eblake@redhat.com>
Message-ID: <356752db-bd70-a908-141e-eec99f4c15e2@redhat.com>
Date: Mon, 8 May 2017 17:05:01 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1705081459030.24729@sstabellini-ThinkPad-X260>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gjiOIWEhbDnMrvrswwQKPE39C1tk9Kl7N"
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
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: anthony.perard@citrix.com, xen-devel@lists.xensource.com, aneesh.kumar@linux.vnet.ibm.com, qemu-devel@nongnu.org, groug@kaod.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gjiOIWEhbDnMrvrswwQKPE39C1tk9Kl7N
From: Eric Blake <eblake@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: anthony.perard@citrix.com, xen-devel@lists.xensource.com,
 aneesh.kumar@linux.vnet.ibm.com, qemu-devel@nongnu.org, groug@kaod.org
Message-ID: <356752db-bd70-a908-141e-eec99f4c15e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Fix issues affecting Xen 9pfs discovered by
 Coverity
References: <alpine.DEB.2.10.1705081334150.24729@sstabellini-ThinkPad-X260>
 <1f0bf90b-a706-01c8-cad1-6dea6620deef@redhat.com>
 <alpine.DEB.2.10.1705081454510.24729@sstabellini-ThinkPad-X260>
 <alpine.DEB.2.10.1705081459030.24729@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1705081459030.24729@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 05:00 PM, Stefano Stabellini wrote:

>>> Directly calling fcntl(F_SETFD) without first reading fcntl(F_GETFD) =
is
>>> (theoretically) incorrect.  Better might be using qemu_set_cloexec()
>>> instead of open-coding something.
>>
>> Makes sense but the unchecked return of fcntl, discovered by Coverity,=

>> would remain unfixed by calling qemu_set_cloexec here. I don't think I=

>> am up for fixing all the call sites of qemu_set_cloexec.
>>
>> I am going to drop this change, and resend this patch was only the oth=
er
>> two fixes, fixing 1374836 only.
>=20
> Unless you would be fine with:
>=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 4d9189e..16894ad 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -182,7 +182,9 @@ void qemu_set_cloexec(int fd)
>  {
>      int f;
>      f =3D fcntl(fd, F_GETFD);
> -    fcntl(fd, F_SETFD, f | FD_CLOEXEC);
> +    assert(f !=3D -1);
> +    f =3D fcntl(fd, F_SETFD, f | FD_CLOEXEC);
> +    assert(f !=3D -1);

Seems reasonable to me, but I don't know if anyone else would object.

Changes semantics if someone ever calls qemu_set_cloexec(-1) (previously
it would ignore the EBADF failures, now it will abort) - such callers
are arguably broken, so that's okay by me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gjiOIWEhbDnMrvrswwQKPE39C1tk9Kl7N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEOuNAAoJEKeha0olJ0NqcLQH/RafKZ5gkrROCygz3mcGUN6E
vOffrprotbepD4fnloyqRmkdjpsXjeWY4/pohqGfDOGr+JzuGB4z44tYsi2Ty3hP
R3ywaotARt3Al7akkM7GkpnSkNj4fU7ur+IBsrH35NBvmA2l3jjav3DmphO8zBEf
jh+dYvy2OkVgM9Yc6IWfa0EhQpJXkv6+0sV/YRxP7TA7Fa0Y8Kbq5vf2IX873K4x
/ztYt/zgEloXAhcjOfAGUAJyR8edNfOkVZiuiJE3ueLefXhvic/H+gaFPMBdtf4S
outoELbjZGZ0BxToT72HiGVNDzpA/Tj2MF2o3ewGID5eva6tWqnshItyjEjiRPE=
=9aJj
-----END PGP SIGNATURE-----

--gjiOIWEhbDnMrvrswwQKPE39C1tk9Kl7N--
