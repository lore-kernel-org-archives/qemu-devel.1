Received: from eggs.gnu.org ([2001:4830:134:3::10]:39050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7Wl-0002Ph-GS
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7Wh-0006kP-IH
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:55:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1co7Wh-0006jx-9X
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:55:35 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6E7019C336
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 11:55:34 +0000 (UTC)
References: <20170315081641.20588-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d1e7414-1194-2d81-1058-62b6313b625e@redhat.com>
Date: Wed, 15 Mar 2017 06:55:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170315081641.20588-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mQo3CwnHfxhDe2NtOF69HXHp5I3QMIMr7"
Subject: Re: [Qemu-devel] [PATCH v2] coverity-model: model
 address_space_read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mQo3CwnHfxhDe2NtOF69HXHp5I3QMIMr7
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <7d1e7414-1194-2d81-1058-62b6313b625e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] coverity-model: model
 address_space_read/write
References: <20170315081641.20588-1-pbonzini@redhat.com>
In-Reply-To: <20170315081641.20588-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 03:16 AM, Paolo Bonzini wrote:
> Commit eb7eeb8 ("memory: split address_space_read and
> address_space_write", 2015-12-17) made address_space_rw
> dispatch to one of address_space_read or address_space_write,
> rather than vice versa.
>=20
> For callers of address_space_read and address_space_write this
> causes false positive defects when Coverity sees a length-8 write in
> address_space_read and a length-4 (e.g. int*) buffer to read into.
> As long as the size of the buffer is okay, this is a false positive.
>=20
> Reflect the code change into the model.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/coverity-model.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

> -MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs=
 attrs,
> -                             uint8_t *buf, int len, bool is_write)
> +MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
> +                               MemTxAttrs attrs,
> +                               uint8_t *buf, int len)
>  {
>      MemTxResult result;
> -
>      // TODO: investigate impact of treating reads as producing
>      // tainted data, with __coverity_tainted_data_argument__(buf).
> -    if (is_write) __bufread(buf, len); else __bufwrite(buf, len);

Old code did __bufread for reads,

> +    __bufwrite(buf, len);

but the new does __bufwrite.

> +    return result;
> +}
> =20
> +MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
> +                                MemTxAttrs attrs,
> +                                const uint8_t *buf, int len)
> +{
> +    MemTxResult result;
> +    __bufread(buf, len);

And __bufread for writes.  Did you get this backwards?

>      return result;
>  }
> =20
> +
>  /* Tainting */
> =20
>  typedef struct {} name2keysym_t;
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--mQo3CwnHfxhDe2NtOF69HXHp5I3QMIMr7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYySu0AAoJEKeha0olJ0NqQvEIAIYtS7FUMSTJu0uWZElxhhe6
QrQXhO3zDT2TuzcHQJ0AQdz9nz/7iAeDBgoIpxNiuZtqvuPBtQTvYdOAw6UQtXmU
RcIg6+GnlFWvtYYEl8KkN83GL9lqazQ1HXy045OLe3Fz7Jh5zsoiYskMiILAYTjF
pQ2cRoBQQFUKWbZ48ahX94oGBA5HE8y3ncXmlCgyrgmdd505Qfl5f9q8u9U6p2Bv
1E4tl5GsgdtH3ZfRh+KVQXef1xznqUGsJ2HQp7baqKhFEKSOHdxbtAagJnri11fh
AVyzSCxKfG3UCKsADgtjD/p9B3j4ZFdOipmedJCKun0foaYggJ18L2BwXqwJ4Gk=
=M73S
-----END PGP SIGNATURE-----

--mQo3CwnHfxhDe2NtOF69HXHp5I3QMIMr7--
