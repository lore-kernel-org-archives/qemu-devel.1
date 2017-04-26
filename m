Received: from eggs.gnu.org ([2001:4830:134:3::10]:53836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3R1H-0008K6-6H
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3R1G-00071Z-22
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:46:27 -0400
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-14-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3f9f0dd-8925-4528-807e-3cf97a199298@redhat.com>
Date: Wed, 26 Apr 2017 12:46:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170425153858.25660-14-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OqkgFDcVQPBM6hx1gspqWeLrP2oPnnA1w"
Subject: Re: [Qemu-devel] [PATCH v6 13/18] qcow2: add support for LUKS
 encryption format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OqkgFDcVQPBM6hx1gspqWeLrP2oPnnA1w
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <b3f9f0dd-8925-4528-807e-3cf97a199298@redhat.com>
Subject: Re: [PATCH v6 13/18] qcow2: add support for LUKS encryption format
References: <20170425153858.25660-1-berrange@redhat.com>
 <20170425153858.25660-14-berrange@redhat.com>
In-Reply-To: <20170425153858.25660-14-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 10:38 AM, Daniel P. Berrange wrote:
> This adds support for using LUKS as an encryption format
> with the qcow2 file, using the new encrypt.format parameter
> to request "luks" format. e.g.
>=20
>   # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encrypt.-format=3Dluks,encrypt.key-secret=3Dsec0 \

s/encrypt.-format/encrypt.format/

>        test.qcow2 10G
>=20

>=20
> Aside from all the cryptographic differences implied by
> use of the LUKS format, there is one further key difference
> between the use of legacy AES and LUKS encryption in qcow2.
> For LUKS, the initialiazation vectors are generated using
> the host physical sector as the input, rather than the
> guest virtual sector. This guarantees unique initialization
> vectors for all sectors when qcow2 internal snapshots are
> used, thus giving stronger protection against watermarking
> attacks.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> @@ -165,6 +246,47 @@ static int qcow2_read_extensions(BlockDriverState =
*bs, uint64_t start_offset,
>              }
>              break;
> =20
> +        case QCOW2_EXT_MAGIC_CRYPTO_HEADER: {
> +            unsigned int cflags =3D 0;
> +            if (s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
> +                error_setg(errp, "CRYPTO header extension only "
> +                           "expected with LUKS encryption method");
> +                return -EINVAL;
> +            }
> +            if (ext.len !=3D sizeof(Qcow2CryptoHeaderExtension)) {
> +                error_setg(errp, "CRYPTO header extension size %u, "
> +                           "but expected size %zu", ext.len,
> +                           sizeof(Qcow2CryptoHeaderExtension));
> +                return -EINVAL;
> +            }
> +
> +            ret =3D bdrv_pread(bs->file, offset, &s->crypto_header, ex=
t.len);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret,
> +                                 "Unable to read CRYPTO header extensi=
on");
> +                return ret;
> +            }
> +            be64_to_cpus(&s->crypto_header.offset);
> +            be64_to_cpus(&s->crypto_header.length);
> +
> +            if ((s->crypto_header.offset % s->cluster_size) !=3D 0) {
> +                error_setg(errp, "Encryption header offset '%" PRIu64 =
"' is "
> +                           "not a multiple of cluster size '%u'",
> +                           s->crypto_header.offset, s->cluster_size);
> +                return -EINVAL;
> +            }

Do we need to sanity check that crypto_header.length is not bogus?

> +
> +            if (flags & BDRV_O_NO_IO) {
> +                cflags |=3D QCRYPTO_BLOCK_OPEN_NO_IO;
> +            }
> +            s->crypto =3D qcrypto_block_open(s->crypto_opts,
> +                                           qcow2_crypto_hdr_read_func,=

> +                                           bs, cflags, errp);
> +            if (!s->crypto) {
> +                return -EINVAL;
> +            }
> +        }   break;
> +
>          default:
>              /* unknown magic - save it in case we need to rewrite the =
header */
>              {
> @@ -464,7 +586,8 @@ static QemuOptsList qcow2_runtime_opts =3D {
>              .type =3D QEMU_OPT_NUMBER,
>              .help =3D "Clean unused cache entries after this time (in =
seconds)",
>          },
> -        BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("encrypt."),
> +        BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",
> +            "ID of secret providing qcow AES key or LUKS passphrase"),=


s/qcow/qcow2/ ?

Minor enough that I'm okay giving:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OqkgFDcVQPBM6hx1gspqWeLrP2oPnnA1w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZANzqAAoJEKeha0olJ0NqWo4H+QHDzdlJmOTib85bFshrqF47
GGdzoNSURYVd475Wu0vRg5L8D/TwrFJmc3w3wbFsy1Yo3587f7gUTBINcteDWrdS
WiZaq+3/MyhLlFqupz7UP/Zdx054nk4KdZ1Enc9pTW1pYkDzuDXU+dVgRFZHW+9S
hd/Y7f8+z9DDTm66ESlXq0PiKREzg/9AZMPXfY6drkehU84FmWLL4Q2N9Wl7vPte
97Fjun4N72hiIW5JMBIH2TjC7KOCeJRSzndylke2CIjrUKUsNCkfEfdAg5gF8HJB
xsDmQBCvMj6qHVxgCNiXfqWX9zr1u6H7iLauC2E0gkO7QJT/FSe6EFmpjC9XMy4=
=SLZe
-----END PGP SIGNATURE-----

--OqkgFDcVQPBM6hx1gspqWeLrP2oPnnA1w--
