Received: from eggs.gnu.org ([2001:4830:134:3::10]:56798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW1xi-00052K-Hq
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW1xh-0001x4-97
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:52:58 -0400
References: <1500026205-15542-1-git-send-email-pl@kamp.de>
	<1500026205-15542-2-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76298257-8593-eea6-7593-9d11d002375f@redhat.com>
Date: Fri, 14 Jul 2017 09:52:40 -0500
MIME-Version: 1.0
In-Reply-To: <1500026205-15542-2-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gvLTj1i8tqRX3ALCDxwv4u5iJV54K35iT"
Subject: Re: [Qemu-devel] [PATCH V3 1/9] specs/qcow2: add compress format
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gvLTj1i8tqRX3ALCDxwv4u5iJV54K35iT
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <76298257-8593-eea6-7593-9d11d002375f@redhat.com>
Subject: Re: [PATCH V3 1/9] specs/qcow2: add compress format extension
References: <1500026205-15542-1-git-send-email-pl@kamp.de>
 <1500026205-15542-2-git-send-email-pl@kamp.de>
In-Reply-To: <1500026205-15542-2-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2017 04:56 AM, Peter Lieven wrote:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  docs/interop/qcow2.txt | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index d7fdb1f..c2d3dab 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -86,7 +86,12 @@ in the description of a field.
>                                  be written to (unless for regaining
>                                  consistency).
> =20
> -                    Bits 2-63:  Reserved (set to 0)
> +                    Bit 2:      Compress format bit.  If and only if t=
his bit
> +                                is set then the compress format extens=
ion
> +                                MUST be present and MUST be parsed and=
 checked
> +                                for compatibility.
> +
> +                    Bits 3-63:  Reserved (set to 0)
> =20
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation =
can
> @@ -137,6 +142,7 @@ be stored. Each extension has a structure like the =
following:
>                          0x6803f857 - Feature name table
>                          0x23852875 - Bitmaps extension
>                          0x0537be77 - Full disk encryption header point=
er
> +                        0xC03183A3 - Compress format extension
>                          other      - Unknown header extension, can be =
safely
>                                       ignored
> =20
> @@ -311,6 +317,33 @@ The algorithms used for encryption vary depending =
on the method
>     in the LUKS header, with the physical disk sector as the
>     input tweak.
> =20
> +
> +=3D=3D Compress format extension =3D=3D
> +
> +The compress format extension is an optional header extension. It prov=
ides
> +the ability to specify the compress algorithm and compress parameters
> +that are used for compressed clusters. This new header MUST be present=
 if
> +the incompatible-feature bit "compress format bit" is set and MUST be =
absent
> +otherwise.

Probably worth mentioning that omitting the incompatible "Compress
format bit" is the same as setting it and populating the Compress format
extension with "zlib"/0.  Don't know if that fits better here, or up
above at the incompatible feature bit section.

> +
> +The fields of the compress format extension are:
> +
> +    Byte  0 - 15:  compress_format_name (padded with zeros, but not
> +                   necessarily null terminated if it has full length).=

> +                   Valid compression format names currently are:
> +
> +                   zlib: Standard zlib deflate compression

16 bytes,

> +
> +              16:  compress_level (uint8_t)

+ 1, means you now have to pad the struct. I'd make the
compress_format_name be only 15 bits (bytes 0-14, compress_level at 15),
so that you have nice alignment without wasting padding.

> +
> +                   0 =3D default compress level (valid for all formats=
, default)
> +
> +                   Additional valid compression levels for zlib compre=
ssion:
> +
> +                   All values between 1 and 9. 1 gives best speed, 9 g=
ives best
> +                   compression.

Is there a particular value between 1 and 9 that matches the output you
get when using 0?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gvLTj1i8tqRX3ALCDxwv4u5iJV54K35iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZaNq4AAoJEKeha0olJ0Nqtb4H/1AIAWX5sqJ95EEcKXwGw0au
HfKLQBgFvu6VRnIRIqsXc/vyxo8w+aA7/8PDQ69o1FPHtz0SG6dBQPK5qJ9z9Dpz
ZzPjnTmNaJZAZaZ8bsr0OO80MbKh9ub90S/I53EcXtAijQFsizFov8a8bFmjQ5/m
SiVxo2TMnBhfbOe7R41oz90uV9gS2Ob8lbp0XgqMzjOg90EGTtnWmSVpT0+/3+CM
eX26HJ3JRg/nLib338o2Sr/08KgTeZXq97wcAwgYmc4ucRCNAucXX+/XLtklysPJ
le7TLJqGuXSfP1bMLfb5OaIleC8FG4krBseQczpUaPVJrrgtBbVgmu3onl0xkh8=
=UFlL
-----END PGP SIGNATURE-----

--gvLTj1i8tqRX3ALCDxwv4u5iJV54K35iT--
