Received: from eggs.gnu.org ([2001:4830:134:3::10]:54876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddiKa-0005uS-4h
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddiKZ-000840-3b
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:32:20 -0400
References: <20170804151013.13057-1-den@openvz.org>
	<20170804151013.13057-4-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d3c51c4e-ba65-1d1e-dbce-dbc15fff3522@redhat.com>
Date: Fri, 4 Aug 2017 14:32:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151013.13057-4-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x7KWfDqGSrvJ2aHdfPHkBUj7UA1VFKRPG"
Subject: Re: [Qemu-devel] [PATCH 3/3] parallels: drop check that
 bdrv_truncate() is working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x7KWfDqGSrvJ2aHdfPHkBUj7UA1VFKRPG
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <d3c51c4e-ba65-1d1e-dbce-dbc15fff3522@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] parallels: drop check that
 bdrv_truncate() is working
References: <20170804151013.13057-1-den@openvz.org>
 <20170804151013.13057-4-den@openvz.org>
In-Reply-To: <20170804151013.13057-4-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:10 AM, Denis V. Lunev wrote:
> This would be actually strange and error prone. If truncate() nowadays
> will fail, there is something fatally wrong. Let's check for that durin=
g
> the actual work.
>=20
> The only fallback case is when the file is not zero initialized. In thi=
s
> case we should switch to preallocation via fallocate().

I got confused by the commit message.  Here's my attempt an an
alternative, to see if I'm understanding the point of this patch:

The code was trying to truncate a file to its current length, as an
optimization to help decide whether an alternative prealloc mode was
useful.  But it forgot to check whether bdrv_getlength() succeeded, and
dealing with that failure just complicates what was supposed to be a
no-op probe for optimizing later operation.  We will still properly fail
later when an actual truncation attempt is made and the device can't
support it.  So when deciding how to set prealloc_mode while opening the
device, all we really need is to check just the one condition that
matters - knowing whether the device is zero initialized.

>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/parallels.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

The code change makes sense at first glance, but I'm a bit reluctant to
give R-b, since the commit message threw me off and I'm not familiar
with the parallels code in the first place.

>=20
> diff --git a/block/parallels.c b/block/parallels.c
> index 6794e53c0b..e1e06d23cc 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -703,9 +703,7 @@ static int parallels_open(BlockDriverState *bs, QDi=
ct *options, int flags,
>          goto fail_options;
>      }
> =20
> -    if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs) =
||
> -            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs),
> -                          PREALLOC_MODE_OFF, NULL) !=3D 0) {
> +    if (!bdrv_has_zero_init(bs->file->bs)) {
>          s->prealloc_mode =3D PRL_PREALLOC_MODE_FALLOCATE;
>      }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--x7KWfDqGSrvJ2aHdfPHkBUj7UA1VFKRPG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEy7cACgkQp6FrSiUn
Q2pPCAf+Lsj3q7+TT5KrerA/feC6xqHjAsOe6PdTyLbXizkRXsDhVPom6Ge5WzRz
1JuZZYZ0d4flfSc+I9S4lZa5NOpAwyn2d7U2MV3T5LhuZISlLAaXhYSHEYn3MDBI
hKBqzAjp0hg39WPS7wBSEWcOhMkBSp834Dldksro1TLJKw11mmHzrxS8Q0T2W7nb
w5OmgGkwv1Ts3UBTMnAqWj6n+CgU/eGsFOSuIM4Lv+aFJdujImr+2oQkExgcGeoM
F5FTNJkSYeLzOBAWFB5lWAllkyF7VO3WLr7plsEPjmoQED/lhtPfz4o1tB2J+zt6
V897NCMwPeaIGfc+Oo0DZkf3BfeJlw==
=h1XW
-----END PGP SIGNATURE-----

--x7KWfDqGSrvJ2aHdfPHkBUj7UA1VFKRPG--
