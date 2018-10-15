Received: from eggs.gnu.org ([2001:4830:134:3::10]:35321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC5t7-0005Sy-61
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC5t6-0004KR-HF
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:38:37 -0400
References: <20181011105802.22665-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cfedbf5d-1399-6d21-b686-1dedfaf5f7d9@redhat.com>
Date: Mon, 15 Oct 2018 18:38:14 +0200
MIME-Version: 1.0
In-Reply-To: <20181011105802.22665-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q8Trdq5OnG84U0OruZfmOarqdVigr7tig"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Get the request alignment for
 encrypted images from QCryptoBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q8Trdq5OnG84U0OruZfmOarqdVigr7tig
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <cfedbf5d-1399-6d21-b686-1dedfaf5f7d9@redhat.com>
Subject: Re: [PATCH] qcow2: Get the request alignment for encrypted images
 from QCryptoBlock
References: <20181011105802.22665-1-berto@igalia.com>
In-Reply-To: <20181011105802.22665-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.10.18 12:58, Alberto Garcia wrote:
> This doesn't have any practical effect at the moment because the
> values of BDRV_SECTOR_SIZE, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE and
> QCRYPTO_BLOCK_QCOW_SECTOR_SIZE are all the same (512 bytes), but
> future encryption methods could have different requirements.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This breaks non-LUKS encryption:

$ ./qemu-img create -f qcow2 -o encryption=3Don,encrypt.key-secret=3Dsecr=
et
--object secret,id=3Dsecret,data=3Dfoo foo.qcow2 64M
Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3Don
encrypt.key-secret=3Dsecret cluster_size=3D65536 lazy_refcounts=3Doff
refcount_bits=3D16
qemu-img: block.c:1248: bdrv_open_driver: Assertion
`is_power_of_2(bs->bl.request_alignment)' failed.
[1]    13589 abort (core dumped)  ./qemu-img create -f qcow2 -o
encryption=3Don,encrypt.key-secret=3Dsecret --objec

(As seen in iotests 049, 087, 134, and 158.)

Max


--q8Trdq5OnG84U0OruZfmOarqdVigr7tig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvEwnYACgkQ9AfbAGHV
z0AVYwgAupwa687g4VA1bKdNS4k7a+LlW+W+X/KReEgcXb6jmlq5xE2XGg5d71tp
FYx7RoISqbd/p8gk2wTBTQsfjUeeGw/VXy4f3mZ0pEkdc95w/PdTQmzu8DwdZX+/
8IIRTIwnJ8AyfGLtGobirnauR29DmARwWvsz8jqZskNFlo1nKXyLcQSana37aXEi
aIZV5f00+MrBw07t07/tZ+k/Qkg49/dFP0bGw2kR1MUxfJTVV5711456lqylgiG7
oWMnKTE7PNVTU6wdD03BkXTFfkCGSYBKWTLViqVshh5TRaExMUJS4/XqQoMGEZsp
Mf0f+MI7GDjr/72WzM/7xf1EfGQTIA==
=iFNr
-----END PGP SIGNATURE-----

--q8Trdq5OnG84U0OruZfmOarqdVigr7tig--
