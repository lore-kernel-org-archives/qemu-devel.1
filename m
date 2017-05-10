Received: from eggs.gnu.org ([2001:4830:134:3::10]:36613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8WPo-0000MJ-DF
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8WPn-0001wp-Fu
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:32:48 -0400
References: <20170510173945.11819-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b827fdb5-2385-6e21-ec06-0787b0a756af@redhat.com>
Date: Wed, 10 May 2017 13:32:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170510173945.11819-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ptd09JUxmu9SEt9gUtL060jmc9d9NWH9u"
Subject: Re: [Qemu-devel] [PATCH] blockdev: use drained_begin/end for
 qmp_block_resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ptd09JUxmu9SEt9gUtL060jmc9d9NWH9u
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <b827fdb5-2385-6e21-ec06-0787b0a756af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blockdev: use drained_begin/end for
 qmp_block_resize
References: <20170510173945.11819-1-jsnow@redhat.com>
In-Reply-To: <20170510173945.11819-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/10/2017 12:39 PM, John Snow wrote:
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1447551
>=20
> If one tries to issue a block_resize while a guest is busy
> accessing the disk, it is possible that qemu may deadlock
> when invoking aio_poll from both the main loop and the iothread.
>=20
> Replace another instance of bdrv_drain_all that doesn't
> quite belong.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/blockdev.c b/blockdev.c
> index 0b38c3d..9ff06f3 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2923,10 +2923,9 @@ void qmp_block_resize(bool has_device, const cha=
r *device,
>          goto out;
>      }
> =20
> -    /* complete all in-flight operations before resizing the device */=

> -    bdrv_drain_all();
> -
> +    bdrv_drained_begin(bs);
>      ret =3D blk_truncate(blk, size, errp);
> +    bdrv_drained_end(bs);
> =20
>  out:
>      blk_unref(blk);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ptd09JUxmu9SEt9gUtL060jmc9d9NWH9u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZE1zEAAoJEKeha0olJ0NqtgYH/jfhGpFzmSz4lhf+Fg6iIm5W
t6dHq0aiS8ABxFM3ZMKyW+JD90Iwg/sHDYrNJFXJHrskWIGy/DOQI/O/a6uMDsqA
hkRFMuVcnt14RH/qDRVf7tk5XsjlJ770Wo0XKRsC07Ak7BNJIUuiuZEQHKju4MyH
AKJFlTZqHxgXEx8bk9Kx7fJn9jDG2n/fvu8SSGpsplvcTFTo5xOh43SJdVvICeg8
1K/jPT7vnD30yagRsS/CZOa4UT1XYmCMEmuEFTYHItBKhclLQLojpA4p/slzopiC
U80pdL06n2EMwLnbip+bDDNLJCqtICD3qTG4QicOMMsCmBOcN2NrjpfNKfGYmfk=
=kr1f
-----END PGP SIGNATURE-----

--ptd09JUxmu9SEt9gUtL060jmc9d9NWH9u--
