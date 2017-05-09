Received: from eggs.gnu.org ([2001:4830:134:3::10]:36619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8A4C-0001HL-Cs
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8A47-0003ac-MS
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:41:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8A47-0003ZW-Cf
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:40:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00D5BC05AA42
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 18:40:54 +0000 (UTC)
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53e35958-82ee-5d90-6c55-7a126dc9108f@redhat.com>
Date: Tue, 9 May 2017 13:40:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170509173559.31598-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lLsvX7dgB9TabHHr3m5wEQN1ftwmk59GS"
Subject: Re: [Qemu-devel] [PATCH 01/17] qdev: remove PropertyInfo.qtype field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lLsvX7dgB9TabHHr3m5wEQN1ftwmk59GS
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <53e35958-82ee-5d90-6c55-7a126dc9108f@redhat.com>
Subject: Re: [PATCH 01/17] qdev: remove PropertyInfo.qtype field
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
 <20170509173559.31598-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 12:35 PM, Marc-Andr=C3=A9 Lureau wrote:
> Remove dependency on qapi qtype, replace a field by a few helper
> functions to determine the default value type (introduced in commit
> 4f2d3d7).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/qdev-core.h       |  1 -
>  include/hw/qdev-properties.h |  5 -----
>  hw/core/qdev.c               | 32 ++++++++++++++++++++++++++------
>  3 files changed, 26 insertions(+), 12 deletions(-)
>=20

> +++ b/hw/core/qdev.c
> @@ -755,6 +755,30 @@ static void qdev_property_add_legacy(DeviceState *=
dev, Property *prop,
>      g_free(name);
>  }
> =20
> +static bool prop_info_is_bool(const PropertyInfo *info)
> +{
> +    return info =3D=3D &qdev_prop_bit
> +        || info =3D=3D &qdev_prop_bit64
> +        || info =3D=3D &qdev_prop_bool;
> +}

I guess we can expand these helpers if we add more property types later.

> +
> +static bool prop_info_is_int(const PropertyInfo *info)
> +{
> +    return info =3D=3D &qdev_prop_uint8
> +        || info =3D=3D &qdev_prop_uint16
> +        || info =3D=3D &qdev_prop_uint32
> +        || info =3D=3D &qdev_prop_int32
> +        || info =3D=3D &qdev_prop_uint64

Interesting dissimilarity between existing types, but not the fault of
your patch.

> +        || info =3D=3D &qdev_prop_size
> +        || info =3D=3D &qdev_prop_pci_devfn

Okay so far.

> +        || info =3D=3D &qdev_prop_on_off_auto
> +        || info =3D=3D &qdev_prop_losttickpolicy
> +        || info =3D=3D &qdev_prop_blockdev_on_error
> +        || info =3D=3D &qdev_prop_bios_chs_trans

Aren't these four enums rather than ints?

> +        || info =3D=3D &qdev_prop_blocksize
> +        || info =3D=3D &qdev_prop_arraylen;
> +}
> +

> @@ -794,16 +818,12 @@ void qdev_property_add_static(DeviceState *dev, P=
roperty *prop,
>                                      prop->info->description,
>                                      &error_abort);
> =20
> -    if (prop->qtype =3D=3D QTYPE_NONE) {
> -        return;
> -    }
> -
> -    if (prop->qtype =3D=3D QTYPE_QBOOL) {
> +    if (prop_info_is_bool(prop->info)) {
>          object_property_set_bool(obj, prop->defval, prop->name, &error=
_abort);
>      } else if (prop->info->enum_table) {
>          object_property_set_str(obj, prop->info->enum_table[prop->defv=
al],
>                                  prop->name, &error_abort);
> -    } else if (prop->qtype =3D=3D QTYPE_QINT) {
> +    } else if (prop_info_is_int(prop->info)) {
>          object_property_set_int(obj, prop->defval, prop->name, &error_=
abort);

So enum_table has priority over prop_info_is_int(), in which case, the
four types I pointed out as being enums will still use set_str() rather
than set_int().

I'm not necessarily sold on this patch - previously, the type was local
to the declaration of the struct (you could tell by reading
qdev_prop_bit that it was a boolean type); now the type is remote (you
have to hunt elsewhere to see how the property is categorized).  I'm not
rejecting it (I see how getting rid of a dependency on QType makes it
easier for the rest of the series to change QType underpinnings), but
wonder if that is a strong enough justification.

But if we DO keep it, you'll want a v2 that cleans up the
prop_info_is_int() impedance mismatch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lLsvX7dgB9TabHHr3m5wEQN1ftwmk59GS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEg0xAAoJEKeha0olJ0NqZroH/2/tfXqpLEzJyRafG5/hfaAp
WKvZI8MY5P0dgrTzKCtf25BU869AHStNaH8TmBOMHu1U88M0D2o7tuGEzwWDLfIx
rsfBoWxzO8jyN7mosXLkz0yH0/2junRiTbRmYS/gnpp+u0HN/lluPi/wwZBRCBwJ
aTiva4W70u0pwhlsEnGZQwGUzPwMjW+Oo4CfJ8+Kxz2QCbyttBpYwgfMOWC8atnR
3gun4ytUHMHE9Q/hx21sOqd7bZOpHFGGmXkq75hxy9xm1ZLhsM4JvkoAncBixYOu
yuHjkY8j7+aRgCfMcOCFCTOWPBDDa6Ce74cL9f028VxfDORmiBgUBG/mc6vxI9E=
=qMwK
-----END PGP SIGNATURE-----

--lLsvX7dgB9TabHHr3m5wEQN1ftwmk59GS--
