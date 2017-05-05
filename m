Received: from eggs.gnu.org ([2001:4830:134:3::10]:41158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6gnm-000352-OU
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6gnk-00049n-AT
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6gnk-00048n-0i
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:13:56 -0400
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399505841.29022.17760460736155165332.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b6e4c71-8f11-a1f5-8b34-43ac68f2d503@redhat.com>
Date: Fri, 5 May 2017 12:13:52 -0500
MIME-Version: 1.0
In-Reply-To: <149399505841.29022.17760460736155165332.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WsHbtf4GPpl2XDgbIbmBJu18EW12KdwiH"
Subject: Re: [Qemu-devel] [PATCH 5/5] 9pfs: local: forbid client access to
 metadata
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
--WsHbtf4GPpl2XDgbIbmBJu18EW12KdwiH
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>
Message-ID: <2b6e4c71-8f11-a1f5-8b34-43ac68f2d503@redhat.com>
Subject: Re: [PATCH 5/5] 9pfs: local: forbid client access to metadata
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
 <149399505841.29022.17760460736155165332.stgit@bahia.lan>
In-Reply-To: <149399505841.29022.17760460736155165332.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 09:37 AM, Greg Kurz wrote:
> When using the mapped-file security mode, we shouldn't let the client
> mess with the metadata. The current code already hides it but the
> client can still access the metadata through several operations.
>=20
> This patch fixes the issue by:
> - preventing the creation of fids pointing to the metadata (name_to_pat=
h)
> - failing various operations taking a dirpath and a name arguments if
>   name is a metadata reserved name
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index b427d2928800..93cadac302c9 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -588,6 +588,11 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath=
 *dir_path,
>      int err =3D -1;
>      int dirfd;
> =20
> +    if (local_must_skip_metadata(fs_ctx, name)) {
> +        errno =3D EINVAL;
> +        return -1;
> +    }
> +

I don't know if EINVAL is the best error, but it seems reasonable enough.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WsHbtf4GPpl2XDgbIbmBJu18EW12KdwiH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDLLQAAoJEKeha0olJ0NqduoH/1NvrkIalYxOIA/fbeGsCdHo
IooANS3MpVgosyYk/kl208TSl4k887PN9jC0IoLyxCJDkA7etH0outsQQqUPFFgy
b2+SPU5mpBb83xUpDBW3shs+/O+Rgg6tppUxqA7QQO0OGOmsmwrnqCvib8iiclhm
mi22dZWIxZXQ6cnRFia0fljOCB7rYLuYQ2S4PMBgbeoOku7WDd6ewp7CEI4d9Pb+
B6qJJW13IAKBHoJMcuFSowC99rkpRfEvT7GDYomFJm1CkuqZEt9zGIvcbLkeMaP/
UQFbF2RzDMt9/tTMjCwdQ6tE4bEZBJI/2kEfPYqO2dwxR0aAawoYQ55ybCiemEU=
=ALKg
-----END PGP SIGNATURE-----

--WsHbtf4GPpl2XDgbIbmBJu18EW12KdwiH--
