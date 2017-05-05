Received: from eggs.gnu.org ([2001:4830:134:3::10]:36352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6gWE-0004Ud-Un
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6gWA-0005SC-Ju
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:55:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6gWA-0005S3-BZ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:55:46 -0400
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399502436.29022.4452572475773635974.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e1843524-9ec7-2aea-4138-f3ce246f0929@redhat.com>
Date: Fri, 5 May 2017 11:55:43 -0500
MIME-Version: 1.0
In-Reply-To: <149399502436.29022.4452572475773635974.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o6gIcshxn6ubJ3hgnpcw5wqehuJX1DoqO"
Subject: Re: [Qemu-devel] [PATCH 1/5] 9pfs: check return value of
 v9fs_co_name_to_path()
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
--o6gIcshxn6ubJ3hgnpcw5wqehuJX1DoqO
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>
Message-ID: <e1843524-9ec7-2aea-4138-f3ce246f0929@redhat.com>
Subject: Re: [PATCH 1/5] 9pfs: check return value of v9fs_co_name_to_path()
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
 <149399502436.29022.4452572475773635974.stgit@bahia.lan>
In-Reply-To: <149399502436.29022.4452572475773635974.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 09:37 AM, Greg Kurz wrote:
> These v9fs_co_name_to_path() call sites have always been around. I gues=
s
> no care was taken to check the return value because the name_to_path
> operation could never fail at the time. This is no longer true: the
> handle and synth backends can already fail this operation, and so will =
the
> local backend soon.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p.c |   36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>=20

> @@ -2588,8 +2591,11 @@ static int coroutine_fn v9fs_complete_rename(V9f=
sPDU *pdu, V9fsFidState *fidp,
>          new_name =3D g_malloc0(end - old_name + name->size + 1);
>          strncat(new_name, old_name, end - old_name);
>          strncat(new_name + (end - old_name), name->data, name->size);

Ad long as you're here, you could replace this strncat mess with the
shorter:

new_name =3D g_strdup_printf("%.*s%.*s", end - old_name, old_name,
                           name->size, name->data);

(or with further simplifications if you have NUL-terminated data).  But
that can be a separate cleanup.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--o6gIcshxn6ubJ3hgnpcw5wqehuJX1DoqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDK6PAAoJEKeha0olJ0NqbJsIAJXfAbVkvYkAxJJJj6H+N4D/
s153/+EHMSCDeelY7yxyQA018d74et4x2N7qdNKJdVzz95yEcvW912RMHFyKhekG
FO5NJzZpFn/TY3LcjNvkqnDQtxae2Sdq+LcPKAsFgRsnTaE3szfOctoq84otAft3
yflTTudrK9W1x6yYB+r/6A4wy85dGxUCDsWou0w33iwdioKbJc7FWuVkZmN5Nz4D
opCbx1iwTAhcpWw4yiHUS3GCwKcnUpWeHiKuarFq0oBxpLVVp5lzlUP5tuae3+9r
fAjqWDmHwnWEhte7Pk9T1h//B2iRPEODIryoWX6Y/TSZUXsYQBDTEYys9oSaKHA=
=1XE1
-----END PGP SIGNATURE-----

--o6gIcshxn6ubJ3hgnpcw5wqehuJX1DoqO--
