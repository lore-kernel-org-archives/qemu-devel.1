Received: from eggs.gnu.org ([209.51.188.92]:36928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpHIw-00048G-6d
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpHIv-0002nA-9V
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:43:14 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d887367f-053e-6541-a6d7-cc84b23db841@redhat.com>
Date: Thu, 31 Jan 2019 12:43:08 -0600
MIME-Version: 1.0
In-Reply-To: <20190131175549.11691-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1XB9jy5kyIhlYMcsWzE4xmu9PNsnkTYem"
Subject: Re: [Qemu-devel] [RFC PATCH 01/11] qcow2: Extend spec for external
 data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1XB9jy5kyIhlYMcsWzE4xmu9PNsnkTYem
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <d887367f-053e-6541-a6d7-cc84b23db841@redhat.com>
Subject: Re: [RFC PATCH 01/11] qcow2: Extend spec for external data files
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-2-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/31/19 11:55 AM, Kevin Wolf wrote:
> This adds external data file to the qcow2 spec as a new incompatible
> feature.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  docs/interop/qcow2.txt | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20

> @@ -148,6 +158,7 @@ be stored. Each extension has a structure like the =
following:
>                          0x6803f857 - Feature name table
>                          0x23852875 - Bitmaps extension
>                          0x0537be77 - Full disk encryption header point=
er
> +                        0x44415441 - External data file name
>                          other      - Unknown header extension, can be =
safely
>                                       ignored

Missing a section describing the new header.

> =20
> @@ -450,8 +461,10 @@ Standard Cluster Descriptor:
>           1 -  8:    Reserved (set to 0)
> =20
>           9 - 55:    Bits 9-55 of host cluster offset. Must be aligned =
to a
> -                    cluster boundary. If the offset is 0, the cluster =
is
> -                    unallocated.
> +                    cluster boundary. If the offset is 0 and bit 63 is=
 clear,
> +                    the cluster is unallocated. The offset may only be=
 0 with
> +                    bit 63 set (indicating a host cluster offset of 0)=
 when an
> +                    external data file is used.

Does that mean that the value 0x00000000 is invalid for external data
files, and that 0x00000001 is special-cased to mean read the contents of
the external file (and NOT that the cluster reads as all zeroes)?  Is
bit 0 allowed to be set for any other clusters when there is an external
data file?  And if so, are we requiring that it only be set when the
external file is known to read as zero, or can we run into the situation
where qcow2 says the cluster reads as 0 but the host file contains
garbage?  Should the external file header contain a flag that states
whether writes to the image should wipe vs. leave unchanged a cluster in
the external file when the qcow2 metadata prefers to grab that cluster's
contents as all-0s or by reading from the backing file?  There are
security vs. speed implications - security insists on wiping the host
file to NOT leave stale data, but that slows things down compared to
just leaving garbage if the qcow2 metadata can effectively ignore those
parts of the external file - hence a knob may be worth exposing?

Should we preserve the meaning of bit 0 SOLELY for its 'reads-as-zeroes'
meaning, and instead make bit 1 (currently reserved) as the special
marker that MUST be set for clusters read from the external file,
keeping the two ideas orthogonal?

Worth a mention on the reftable section that when an external file is
used, metadata clusters (in the qcow2 file) are still refcounted (and
thus, offsets in the refcount table point to the qcow2 file, not the
external file)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--1XB9jy5kyIhlYMcsWzE4xmu9PNsnkTYem
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxTQbwACgkQp6FrSiUn
Q2rmegf+Oxd/9/tB4db32PdsofmPPLyL2dhuuvd3BX8bzAgCikIiUpuEAggi+TFs
VzGZu+4hxh5VlmYg3GG9lwgPcsEloqLhVpIk6C/6svLbCsc9YpIxBmFIMb/W1MnC
7BkRgmrRt0DkKLZdIvGqoVPJSNBWaWUOeWwOUNSwyZ7eiVewgjFFgufijTjtgpE3
ihDhfcL7bnDhevhU0Xy3w02qxHAj8BQn9AysJDHCbvoZSDuyXcKoxF8Xl+L0HtPv
/Keyrv9UgjDPznQmy8kwAZoPqA6bmX44mhs3G23Jg4tTmiBwmTIazF1ZlD1wXtzP
n5VRgDeZV/MqlkmSdfxk1Y+AOAzejQ==
=niXR
-----END PGP SIGNATURE-----

--1XB9jy5kyIhlYMcsWzE4xmu9PNsnkTYem--
