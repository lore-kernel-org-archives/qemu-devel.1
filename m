Received: from eggs.gnu.org ([2001:4830:134:3::10]:45446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwCal-0002GJ-7m
	for Qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwCag-0002gh-Ff
	for Qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:57:11 -0400
References: <13fddf65-e573-cf01-593d-6b02a3071721@redhat.com>
	<20170403152443.GA20459@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed9025da-bed9-5220-70b6-ef7cfc00d4a2@redhat.com>
Date: Thu, 6 Apr 2017 13:57:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170403152443.GA20459@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fEwaCBHrDbGJrhaI6n3nuVPDJjhn4KxMx"
Subject: Re: [Qemu-devel] help debugging throttle crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fEwaCBHrDbGJrhaI6n3nuVPDJjhn4KxMx
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ed9025da-bed9-5220-70b6-ef7cfc00d4a2@redhat.com>
Subject: Re: help debugging throttle crash
References: <13fddf65-e573-cf01-593d-6b02a3071721@redhat.com>
 <20170403152443.GA20459@igalia.com>
In-Reply-To: <20170403152443.GA20459@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2017 10:24 AM, Alberto Garcia wrote:
> On Mon, Apr 03, 2017 at 09:07:02AM -0500, Eric Blake wrote:
>=20
>> At this point, it looks like no one is calling
>> throttle_group_unregister_blk() as a result of the 'device_del',
>> which leaves stale memory around
>=20
> I see, I can also reproduce this very easily.
>=20
> I wonder if it's not enough to simply disable I/O limits when a
> BlockBackend is deleted?

Seems to pass my testing. Do you want to submit it as a formal patch, or
shall I?

>=20
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -230,6 +230,9 @@ static void blk_delete(BlockBackend *blk)
>      assert(!blk->refcnt);
>      assert(!blk->name);
>      assert(!blk->dev);
> +    if (blk->public.throttle_state) {
> +        blk_io_limits_disable(blk);
> +    }
>      if (blk->root) {
>          blk_remove_bs(blk);
>      }
>=20
> Berto
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fEwaCBHrDbGJrhaI6n3nuVPDJjhn4KxMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5o9+AAoJEKeha0olJ0NqtioH/iKr4OTUmXSIcv4/yTYL4F9/
dKthJdDUAf/zVJ/jLhr36N2yVZdx36HQ17R+eHrtfiNBSTxE5pamsHqG8eJbAP2D
h6sp96va71dEqK+HQFYJPx2ClcWNxXLSxwQnEHokGGtdkpWKNx4wVGJJmlqXOfB7
UWepGIEYWqpvNUMZhebCUSwe4OfUbLI4wZMN2Mj8Hq6I4iyBqZuS9MHtvqLtgKTK
4VLWn9d/0ao7Sp41TH5GECgwESuhB2nIX3skixkydj+ibu0SAPqlcbivBuoSfNTm
/fks+d4Rafc/2BVeDzGH6nJfZ23c2go/8hEu4coYBR+27cfHoZ5s04FWCNBrdOs=
=sF68
-----END PGP SIGNATURE-----

--fEwaCBHrDbGJrhaI6n3nuVPDJjhn4KxMx--
