Received: from eggs.gnu.org ([2001:4830:134:3::10]:40514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6glF-0001Qf-LC
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6glB-0002k9-M4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:11:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6glB-0002k1-Ct
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:11:17 -0400
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399504988.29022.13818395938763860712.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f21803c-7b62-0090-3035-0e48622a46e4@redhat.com>
Date: Fri, 5 May 2017 12:11:14 -0500
MIME-Version: 1.0
In-Reply-To: <149399504988.29022.13818395938763860712.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C6m2Q6UDNeFwibt7q3Dth8gI6EPN53GpH"
Subject: Re: [Qemu-devel] [PATCH 4/5] 9pfs: local: metadata file for the
 VirtFS root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C6m2Q6UDNeFwibt7q3Dth8gI6EPN53GpH
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>
Message-ID: <2f21803c-7b62-0090-3035-0e48622a46e4@redhat.com>
Subject: Re: [PATCH 4/5] 9pfs: local: metadata file for the VirtFS root
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
 <149399504988.29022.13818395938763860712.stgit@bahia.lan>
In-Reply-To: <149399504988.29022.13818395938763860712.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 09:37 AM, Greg Kurz wrote:
> When using the mapped-file security, credentials are stored in a metada=
ta
> directory located in the parent directory. This is okay for all paths w=
ith
> the notable exception of the root path, since we don't want and probabl=
y
> can't create a metadata directory above the virtfs directory on the hos=
t.
>=20
> This patch introduces a dedicated metadata file, sitting in the virtfs =
root
> for this purpose. It relies on the fact that the "." name necessarily r=
efer

s/refer/refers/

> to the virtfs root.
>=20
> As for the metadata directory, we don't want the client to see this fil=
e.
> The current code only cares for readdir() but there are many other plac=
es
> to fix actually. The filtering logic is hence put in a separate functio=
n.
>=20
> Before:
>=20
> # ls -ld
> drwxr-xr-x. 3 greg greg 4096 May  5 12:49 .
> # chown root.root .
> chown: changing ownership of '.': Is a directory
> # ls -ld
> drwxr-xr-x. 3 greg greg 4096 May  5 12:49 .
>=20
> After:
>=20
> # ls -ld
> drwxr-xr-x. 3 greg greg 4096 May  5 12:49 .
> # chown bin.bin .
> # ls -ld
> drwxr-xr-x. 3 root root 4096 May  5 12:50 .

Huh? How does chown bin.bin result in root.root? Copy-and-paste error?

>=20
> and from the host:
>=20
> ls -al .virtfs_metadata_root
> -rwx------. 1 greg greg 26 May  5 12:50 .virtfs_metadata_root
> $ cat .virtfs_metadata_root
> virtfs.uid=3D0
> virtfs.gid=3D0

So what happens if the guest tries to manipulate
=2E/.virtfs_metadata_root? I know you are filtering it so that readdir()
and such can't see it, but do you have sane errors for the guest's
attempt to circumvent those hidden names?

>=20
> Reported-by: L=C3=A9o Gaspard <leo@gaspard.io>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   88 ++++++++++++++++++++++++++++++++++++--------=
--------
>  1 file changed, 61 insertions(+), 27 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--C6m2Q6UDNeFwibt7q3Dth8gI6EPN53GpH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDLIyAAoJEKeha0olJ0Nqsf0IAJXod2NjFumOLD8MtmpQGcaM
0vFxyHI82K+08rf7OaaTKxeuvo9GO1Nxn2RK9fuYypQ0E9l7uXb+T5G5Py7HbVZg
jEsbFH+t7Swc/XwAcxjunwExypSJQZUr1UtfWSuaOu/DbwRYyLqDuivspM59DHU8
PCUSDY4uQtuFaHykvR5kiWmnmT0qz6oIIB0R0ZTqiQDQUOljVpBcQJTatSEUC/wc
OlnP0aMUywKXF0LL94mgTdT1d0EgUIs/5Pm84xO7xxP5f5lILRiuECuVdkDLEVrB
y1my7apm1GU4ExqkZmKls6zQ07Dl8b5JIYmH7zbr/MYg9SHToTaudt/BElZ7GQ8=
=40eJ
-----END PGP SIGNATURE-----

--C6m2Q6UDNeFwibt7q3Dth8gI6EPN53GpH--
