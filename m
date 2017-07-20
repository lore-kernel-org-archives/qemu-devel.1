Received: from eggs.gnu.org ([2001:4830:134:3::10]:41232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYDsH-0000Co-I6
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYDsD-00077B-GY
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:00:25 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-9-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6c67ca5d-56be-548b-8854-5891818c4217@redhat.com>
Date: Thu, 20 Jul 2017 11:00:01 -0500
MIME-Version: 1.0
In-Reply-To: <1500560441-5670-9-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gDppo2HblXKlcCLXC0HPeUeMFQcT7Dge1"
Subject: Re: [Qemu-devel] [PATCH V4 08/10] block/qcow2: start using the
 compress format extension
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
--gDppo2HblXKlcCLXC0HPeUeMFQcT7Dge1
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <6c67ca5d-56be-548b-8854-5891818c4217@redhat.com>
Subject: Re: [PATCH V4 08/10] block/qcow2: start using the compress format
 extension
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
 <1500560441-5670-9-git-send-email-pl@kamp.de>
In-Reply-To: <1500560441-5670-9-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 09:20 AM, Peter Lieven wrote:
> we now pass the parameters to the zlib compressor if the
> extension is present and use the old default values if
> the extension is absent.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/qcow2-cluster.c | 58 ++++++++++++++++++++++++++++++-------------=
--------
>  block/qcow2.c         | 57 +++++++++++++++++++++++++++----------------=
-------
>  2 files changed, 65 insertions(+), 50 deletions(-)

>  static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
> -                             const uint8_t *buf, int buf_size)
> +                             const uint8_t *buf, int buf_size,
> +                             int compress_format)
>  {

> -
> -    ret =3D inflateInit2(strm, -12);

The old code initializes with 12,


> +    switch (compress_format) {
> +    case QCOW2_COMPRESS_FORMAT_ZLIB:
> +    case -1: {

What is case -1 supposed to be? When the compression format was not
specified?  Again, I'd really like there a way to encode the default
(when no format is encoded in the qcow2 file) to be representable
alongside the new code, and then we just special-case writing the
compression format to the file to omit the extension header if the user
requested parameters that match the old default.

> +        z_stream z_strm =3D {};
> +
> +        z_strm.next_in =3D (uint8_t *)buf;
> +        z_strm.avail_in =3D buf_size;
> +        z_strm.next_out =3D out_buf;
> +        z_strm.avail_out =3D out_buf_size;
> +
> +        ret =3D inflateInit2(&z_strm, -15);

The new code is now unconditionally initializing with -15 instead of
-12.  Does that matter, or does decompression work regardless of window
size used at creation, as long as the initialized size at decompression
is at least as large?  On the other hand, I guess that means if someone
compresses with a large window, and then I initialize the decompressor
with a small window, my decompression will fail?  That's why knowing the
minimum window size should be part of the spec, whether or not we make
it a tunable.

> +++ b/block/qcow2.c
> @@ -3391,9 +3391,10 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs=
, uint64_t offset,
>      BDRVQcow2State *s =3D bs->opaque;
>      QEMUIOVector hd_qiov;
>      struct iovec iov;
> -    z_stream strm;
> -    int ret, out_len;
> -    uint8_t *buf, *out_buf, *local_buf =3D NULL;
> +    z_stream z_strm =3D {};
> +    int z_windowBits =3D -15, z_level =3D Z_DEFAULT_COMPRESSION;
> +    int ret, out_len =3D 0;
> +    uint8_t *buf, *out_buf =3D NULL, *local_buf =3D NULL;
>      uint64_t cluster_offset;
> =20
>      if (bytes =3D=3D 0) {
> @@ -3418,34 +3419,38 @@ qcow2_co_pwritev_compressed(BlockDriverState *b=
s, uint64_t offset,
>          buf =3D qiov->iov[0].iov_base;
>      }
> =20
> -    out_buf =3D g_malloc(s->cluster_size);
> +    switch (s->compress_format) {
> +    case -1:
> +        z_windowBits =3D -12;
> +    case QCOW2_COMPRESS_FORMAT_ZLIB:
> +        out_buf =3D g_malloc(s->cluster_size);
> +        if (s->compress_level > 0) {
> +            z_level =3D s->compress_level;
> +        }

And this is where I wonder if z_windowBits should be explicitly encoded
in the qcow2 format, rather than just magic numbers we use under the
hood, so that someone else trying to reimplement things will create
compatible files.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gDppo2HblXKlcCLXC0HPeUeMFQcT7Dge1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllw04EACgkQp6FrSiUn
Q2qWiAf/cH+IFqd6JZ8l+iqZUgJDmV4GkoXw6eWLtU2FtJzvrT1qwVxOBH/5T3Ko
NPtNPB9jrS3+eOyKWI4w45iD0mcxuvRwzqg+xnbsr8z8LrStEpewmXyOneB++Iuj
cTVHl3j59jpcBkjfz40n5wUMU9mcyAlKzWzRJKH9DtWxQ9L38rHY+nJmROsOdQH+
8Mo7SkZpppJ8DAX+x/kLK16n4OowA+xCu5lSgzsOS3BFC7GTAPeI6y1LactuFP4w
DG5Np+SRXIwXBP1rH5cyuLakXOS0ZWWpwVAuoqvM08P92fWzb6n26nLGpw23cPJQ
85NHzkSUQO6z/trBgLXA3qIVO+BopQ==
=qE+2
-----END PGP SIGNATURE-----

--gDppo2HblXKlcCLXC0HPeUeMFQcT7Dge1--
