Received: from eggs.gnu.org ([2001:4830:134:3::10]:49404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr3Yq-0006mK-K5
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr3Ym-00004v-7S
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:17:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr3Yl-0008VV-UO
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:17:52 -0400
References: <1490275739-14940-1-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <377732f8-b41f-5ca8-d418-26d524ba4ea9@redhat.com>
Date: Thu, 23 Mar 2017 09:17:42 -0500
MIME-Version: 1.0
In-Reply-To: <1490275739-14940-1-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5f9KXwsWiisdCU4PpckCfITlqc5xivF6H"
Subject: Re: [Qemu-devel] [RFC 1/1] qcow2: add ZSTD compression feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5f9KXwsWiisdCU4PpckCfITlqc5xivF6H
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <377732f8-b41f-5ca8-d418-26d524ba4ea9@redhat.com>
Subject: Re: [Qemu-devel] [RFC 1/1] qcow2: add ZSTD compression feature
References: <1490275739-14940-1-git-send-email-den@openvz.org>
In-Reply-To: <1490275739-14940-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 08:28 AM, Denis V. Lunev wrote:
> ZSDT compression algorithm consumes 3-5 times less CPU power with a

s/ZSDT/ZSTD/

> comparable comression ratio with zlib. It would be wise to use it for

s/comression/compression/

> data compression f.e. for backups.
>=20
> The patch adds incompatible ZSDT feature into QCOW2 header that indicat=
es
> that compressed clusters must be decoded using ZSTD.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <famz@redhat.com>
> ---
> Actually this is very straightforward. May be we should implement 2 sta=
ge
> scheme, i.e. add bit that indicates presence of the "compression
> extension", which will actually define the compression algorithm. Thoug=
h
> at my opinion we will not have too many compression algorithms and prop=
osed
> one tier scheme is good enough.

I wouldn't bet on NEVER changing compression algorithms again, and while
I suspect that we won't necessarily run out of bits, it's safer to not
require burning another bit every time we change our minds.  Having a
two-level scheme means we only have to burn 1 bit for the use of a
compression extension header, where we can then flip algorithms in the
extension header without having to burn a top-level incompatible feature
bit every time.

>=20
>  docs/specs/qcow2.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/specs/qcow2.txt b/docs/specs/qcow2.txt
> index 80cdfd0..eb5c41b 100644
> --- a/docs/specs/qcow2.txt
> +++ b/docs/specs/qcow2.txt
> @@ -85,7 +85,10 @@ in the description of a field.
>                                  be written to (unless for regaining
>                                  consistency).
> =20
> -                    Bits 2-63:  Reserved (set to 0)
> +                    Bits 2:     ZSDT compression bit. ZSDT algorithm i=
s used

s/ZSDT/ZSTD/

Another reason I think you should add a compression extension header:
compression algorithms are probably best treated as mutually-exclusive
(the entire image should be compressed with exactly one compressor).
Even if we only ever add one more type (say 'xz') in addition to the
existing gzip and your proposed zstd, then we do NOT want someone
specifying both xz and zstd at the same time.  Having a single
incompatible feature bit that states that a compression header must be
present and honored to understand the image, where the compression
header then chooses exactly one compression algorithm, seems safer than
having two separate incompatible feature bits for two opposing algorithms=
=2E

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5f9KXwsWiisdCU4PpckCfITlqc5xivF6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY09kGAAoJEKeha0olJ0NqqHgIAIGkLgoAJqG+hYsLRk0ZGMLG
p12mgWx9Xw2kFB79FllHtPMCOiyvKevcR0FDsho/j/iXulFdppP3MoMxDcBW3cqI
iR+MZJa+GPxonvuqopqo8mV/XhnQtMRtZlq7zmM2uU4TiQneArIB7gD6KpwxSz9o
BZApdM1vwxGR2e2kTzBFclNv9ivUq7Hq3wyrbfmVqLMV11kukJkMRW/AJ0Qi7/SL
o2KOkjiwXxb+BYUHMbW/+7vlfaN+xFX+7Dx7hQUMdKQ3cjfvdYSUGLmrmSKiSqE1
wDRwEJn83DwCRkq7pygu/6OiFuX9dhKqXjSSexeiSvR7dfuSQa/sDS5zlGu3AJA=
=qm72
-----END PGP SIGNATURE-----

--5f9KXwsWiisdCU4PpckCfITlqc5xivF6H--
