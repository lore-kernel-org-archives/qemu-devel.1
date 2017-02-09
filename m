Received: from eggs.gnu.org ([2001:4830:134:3::10]:60507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbcbA-0001Bp-6G
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 19:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbcb9-0008PJ-7s
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 19:28:32 -0500
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-14-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6eab90c0-0a2b-c002-17a0-6ef7378a6794@redhat.com>
Date: Thu, 9 Feb 2017 01:28:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170126101827.22378-14-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pxgROuv2e1jdTVUg65x5r996Oav8Pe5he"
Subject: Re: [Qemu-devel] [PATCH v3 13/18] qcow2: add support for LUKS
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pxgROuv2e1jdTVUg65x5r996Oav8Pe5he
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6eab90c0-0a2b-c002-17a0-6ef7378a6794@redhat.com>
Subject: Re: [PATCH v3 13/18] qcow2: add support for LUKS encryption format
References: <20170126101827.22378-1-berrange@redhat.com>
 <20170126101827.22378-14-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-14-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 26.01.2017 11:18, Daniel P. Berrange wrote:
> This adds support for using LUKS as an encryption format
> with the qcow2 file. The use of the existing 'encryption=3Don'
> parameter is replaced by a new parameter 'encryption-format'
> which takes the values 'aes' or 'luks'. e.g.
>=20
>   # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encryption-format=3Dluks,luks-key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
> results in the creation of an image using the LUKS format.
> Use of the legacy 'encryption=3Don' parameter still results
> in creation of the old qcow2 AES format, and is equivalent
> to the new 'encryption-format=3Daes'. e.g. the following are
> equivalent:
>=20
>   # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encryption=3Don,aes-key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
>  # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encryption-format=3Daes,aes-key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
> With the LUKS format it is necessary to store the LUKS
> partition header and key material in the QCow2 file. This
> data can be many MB in size, so cannot go into the QCow2
> header region directly. Thus the spec defines a FDE
> (Full Disk Encryption) header extension that specifies
> the offset of a set of clusters to hold the FDE headers,
> as well as the length of that region. The LUKS header is
> thus stored in these extra allocated clusters before the
> main image payload.
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
>  block/qcow2-cluster.c      |   4 +-
>  block/qcow2-refcount.c     |  10 ++
>  block/qcow2.c              | 284 +++++++++++++++++++++++++++++++++++++=
++------
>  block/qcow2.h              |   9 ++
>  include/block/block_int.h  |   1 +
>  qapi/block-core.json       |  11 +-
>  qemu-img.c                 |   4 +-
>  tests/qemu-iotests/082.out | 270 +++++++++++++++++++++++++++++++++++++=
-----
>  8 files changed, 527 insertions(+), 66 deletions(-)
>=20

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 4943942..d15c6a9 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2327,9 +2327,15 @@
>  #                         caches. The interval is in seconds. The defa=
ult value
>  #                         is 0 and it disables this feature (since 2.5=
)
>  # @aes-key-secret:        #optional the ID of a QCryptoSecret object p=
roviding
> -#                         the AES decryption key (since 2.9). Mandator=
y for
> +#                         the AES decryption key (since 2.9). Mandator=
y for AES
>  #                         encrypted images, except when doing a metada=
ta-only
>  #                         probe of the image.
> +#                         the AES decryption key (since 2.9) Mandatory=
 except
> +#                         when doing a metadata-only probe of the imag=
e.

I think these two lines should be omitted (rebase artifact?).

With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +# @luks-key-secret:       #optional the ID of a QCryptoSecret object p=
roviding
> +#                         the LUKS keyslot passphrase (since 2.9). Man=
datory for
> +#                         LUKS encrypted images, except when doing a m=
etadata-
> +#                         only probe of the image.
>  #
>  # Since: 1.7
>  ##

[...]


--pxgROuv2e1jdTVUg65x5r996Oav8Pe5he
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibt6YSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyFsIAIUlujMEW0VGNESxRSjmAzitPfgXy4/d
aXn5jHi3aKPD1zWp3/8sSFt4PHHIohSlgTLnWTs/V2NCYnMXJXQuxJhJ9ybyHpew
BDNYqHIyRrViCmYJOU8/b/h/Es1eH7YG6L5Np4DlJWEDUWl7xEQ2Nnc18dlbBn0r
ue4LqJsiQ0y06HPyazK7wlWH8q8LMt8a2ciS/m4gOiMkIDs+XsLGft0dIKy9BIJ3
0pqTTgggDrmIbjgUajfaez4HM/VRlsbAkY+QMDGEp8/bXrCN//TS/D1DgK9wf8d6
4q2Tog+MwqwDhM/5RL/T19c4pK+e5bEXu7DJRTPjKEVFAymB+7alUyE=
=ZS/T
-----END PGP SIGNATURE-----

--pxgROuv2e1jdTVUg65x5r996Oav8Pe5he--
