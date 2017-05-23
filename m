Received: from eggs.gnu.org ([2001:4830:134:3::10]:43462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDDN6-0004nn-VQ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDDN2-0003dJ-VA
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDDN2-0003d5-LT
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:13:20 -0400
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149554996230.23396.14573553304393992709.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5222368e-d0de-457b-7f07-5f104860ec56@redhat.com>
Date: Tue, 23 May 2017 12:13:17 -0500
MIME-Version: 1.0
In-Reply-To: <149554996230.23396.14573553304393992709.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="unJQIfWAth8dbIC7JIV6bdr5PH8btlEKo"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] 9pfs: local: metadata file for the
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
Cc: Leo Gaspard <leo@gaspard.io>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--unJQIfWAth8dbIC7JIV6bdr5PH8btlEKo
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Leo Gaspard <leo@gaspard.io>
Message-ID: <5222368e-d0de-457b-7f07-5f104860ec56@redhat.com>
Subject: Re: [PATCH v2 4/4] 9pfs: local: metadata file for the VirtFS root
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <149554996230.23396.14573553304393992709.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <149554996230.23396.14573553304393992709.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 09:32 AM, Greg Kurz wrote:
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
efers
> to the virtfs root.
>=20
> As for the metadata directory, we don't want the client to see this fil=
e.
> The current code only cares for readdir() but there are many other plac=
es
> to fix actually. The filtering logic is hence put in a separate functio=
n.
>=20
> @@ -478,7 +504,8 @@ static off_t local_telldir(FsContext *ctx, V9fsFidO=
penState *fs)
> =20
>  static bool local_is_mapped_file_metadata(FsContext *fs_ctx, const cha=
r *name)
>  {
> -    return !strcmp(name, VIRTFS_META_DIR);
> +    return
> +        !strcmp(name, VIRTFS_META_DIR) || !strcmp(name, VIRTFS_META_RO=
OT_FILE);

We have to block VIRTFS_META_DIR at any depth in the hierarchy, but
can/should we change the blocking of VIRTFS_META_ROOT_FILE to only
happen at the root directory, rather than at all directories?  On the
other hand, if you can simultaneously map /path/to/a for one mount
point, and /path/to/a/b for another, then the root file for B is visible
at a lower depth than the root file for A, and blocking the metafile
name everywhere means that the mount A can't influence the behavior on
the mount for B.

Not tested, but looks sane, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--unJQIfWAth8dbIC7JIV6bdr5PH8btlEKo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJG2tAAoJEKeha0olJ0NqmHYIAKvOpr73eJI6AI4DW0Jjyli9
0rnn2i7QPYQeIke8CQp9kZDKbF9XzrQJDQZmeLZOI1dx+owS5nN7K6wqvSwKsfH2
6lfVat6GdKf5rxWZHmr5/rNTGr6KShj4BGe66UD8/T69OY3FQJA3ca83vJpilPU+
pKxkIGto+wQh6plR0uyMd89947smHPQrWtmcGGOEYYO6+l5wLKJD0Q++K2HTNd71
DG9ALD2QnFt9EhoZZwb8elIwKmd8csXg/n9BWq4QhtwDuktHvvDXXfLCJwk99vuP
5npfCy2oOidePGbFEEee+i5o6Ua5SwaDYOvURpW0ZV8MzCZmqNlGrmWWX9GCwvo=
=pHZA
-----END PGP SIGNATURE-----

--unJQIfWAth8dbIC7JIV6bdr5PH8btlEKo--
