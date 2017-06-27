Received: from eggs.gnu.org ([2001:4830:134:3::10]:46385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPpvr-0006Hj-Of
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPpvq-0002kT-Hl
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:49:27 -0400
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
	<1498566850-7934-2-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cfd60a29-6b27-7065-0fc7-30a82b01eadb@redhat.com>
Date: Tue, 27 Jun 2017 07:49:17 -0500
MIME-Version: 1.0
In-Reply-To: <1498566850-7934-2-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LHKqEtGgqepH14VKWJCBNAmqV9leWXDPG"
Subject: Re: [Qemu-devel] [PATCH 1/4] block/qcow2: add compression_algorithm
 create option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LHKqEtGgqepH14VKWJCBNAmqV9leWXDPG
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com
Message-ID: <cfd60a29-6b27-7065-0fc7-30a82b01eadb@redhat.com>
Subject: Re: [PATCH 1/4] block/qcow2: add compression_algorithm create option
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
 <1498566850-7934-2-git-send-email-pl@kamp.de>
In-Reply-To: <1498566850-7934-2-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/27/2017 07:34 AM, Peter Lieven wrote:
> this patch adds a new compression_algorithm option when creating qcow2 =
images.
> The current default for the compresison algorithm is zlib and zlib will=
 be

s/compresison/compression/

> used when this option is omitted (like before).
>=20
> If the option is specified e.g. with:
>=20
>  qemu-img create -f qcow2 -o compression_algorithm=3Dzlib image.qcow2 1=
G
>=20
> then a new compression algorithm header extension is added and an incom=
patible
> feature bit is set. This means that if the header is present it must be=
 parsed
> by Qemu on qcow2_open and it must be validated if the specified compres=
sion
> algorithm is supported by the current build of Qemu.
>=20
> This means if the compression_algorithm option is specified Qemu prior =
to this
> commit will not be able to open the created image.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/qcow2.c             | 93 +++++++++++++++++++++++++++++++++++++++=
+++++---
>  block/qcow2.h             | 20 +++++++---
>  docs/interop/qcow2.txt    |  8 +++-

Focusing on just the spec change first:

> +++ b/docs/interop/qcow2.txt
> @@ -85,7 +85,11 @@ in the description of a field.
>                                  be written to (unless for regaining
>                                  consistency).
> =20
> -                    Bits 2-63:  Reserved (set to 0)
> +                    Bit 2:      Compress algorithm bit.  If this bit i=
s set then
> +                                the compress algorithm extension must =
be parsed
> +                                and checked for compatiblity.

s/compatiblity/compatibility/

> +
> +                    Bits 3-63:  Reserved (set to 0)
> =20
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation =
can
> @@ -135,6 +139,8 @@ be stored. Each extension has a structure like the =
following:
>                          0xE2792ACA - Backing file format name
>                          0x6803f857 - Feature name table
>                          0x23852875 - Bitmaps extension
> +                        0xC0318300 - Compression Algorithm
> +                        0xC03183xx - Reserved for compression algorith=
m params

s/params/parameters/

You have now introduced 256 different reserved headers, without
documenting any of their formats.  You absolutely MUST include a
documentation of how the new 0xC0318300 header is laid out (see, for
example, our section on "Bitmaps extension"), along with text mentioning
that the new header MUST be present if incompatible-feature bit is set
and MUST be absent otherwise.  But I also think that with a bit of
proper design work, you only need ONE header for all possible algorithm
parameters, rather than burning an additional 255 unspecified
reservations.  That is, make sure your new header includes a common
prefix including a length field and the algorightm in use, and then the
length covers a variable-length suffix that can be parsed in a
per-algorithm-specific manner for whatever additional parameters are
needed for that algorithm.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LHKqEtGgqepH14VKWJCBNAmqV9leWXDPG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUlRNAAoJEKeha0olJ0NqiOgH+gI8CCaWl0xRSLCp1zXxRDqL
GiGff7Vs+/WcwVRMu523m16uOkNThiMrUyFZ1/Gp7hdkbmVzxPJ3eOp11Lt4gdoI
FDLO0h9Igx6GQCfoF+h2K+xKeBwVXbc1SFPmlD8wUKN9sgWDliUjK1u0A5397Mz+
9Epu7YyFefGRLhIkXtZFAmLL6hR1KjpzRN0KBKy7Cwp7l3h9i/pQEJ2D8J67Qqz1
ydq4CRe3N2VZL/QLkvbpfVD5uYP/alPPjVHMEWP7uYCbY4AWgaHAUwB7q7gKsC+W
Vf1U8ukd0/T43f0dLi6VTasiMi7hraWxMl4Jcf8Dh3M0lgT4dPoehJxCri+hYd8=
=sZ96
-----END PGP SIGNATURE-----

--LHKqEtGgqepH14VKWJCBNAmqV9leWXDPG--
