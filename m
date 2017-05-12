Received: from eggs.gnu.org ([2001:4830:134:3::10]:35551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d9EZ5-0001Pw-AZ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d9EZ4-0004yb-5A
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:41:19 -0400
References: <20170509094837.22852-1-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <13946c13-8d93-8832-d509-bf8f7be3f419@redhat.com>
Date: Fri, 12 May 2017 19:41:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170509094837.22852-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EwWJx0buol9loANrhcWkEqm2Qw2ucOap7"
Subject: Re: [Qemu-devel] [PATCH v8 0/4] Improve convert and dd commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EwWJx0buol9loANrhcWkEqm2Qw2ucOap7
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <13946c13-8d93-8832-d509-bf8f7be3f419@redhat.com>
Subject: Re: [PATCH v8 0/4] Improve convert and dd commands
References: <20170509094837.22852-1-berrange@redhat.com>
In-Reply-To: <20170509094837.22852-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-09 11:48, Daniel P. Berrange wrote:
> Update to
>=20
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05699.ht=
ml
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00728.ht=
ml
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04391.ht=
ml
>   v4: https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02153.ht=
ml
>   v5: https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04109.ht=
ml
>   v6: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00215.ht=
ml
>=20
> This series is in response to Max pointing out that you cannot
> use 'convert' for an encrypted target image.
>=20
> The 'convert' and 'dd' commands need to first create the image
> and then open it. The bdrv_create() method takes a set of options
> for creating the image, which let us provide a key-secret for the
> encryption key. When the commands then open the new image, they
> don't provide any options, so the image is unable to be opened
> due to lack of encryption key. It is also not possible to use
> the --image-opts argument to provide structured options in the
> target image name - it must be a plain filename to satisfy the
> bdrv_create() API contract.
>=20
> This series addresses these problems to some extent
>=20
>  - Adds a new --target-image-opts flag which is used to say
>    that the target filename is using structured options.
>    It is *only* permitted to use this when -n is also set.
>    ie the target image must be pre-created so convert/dd
>    don't need to run bdrv_create().
>=20
>  - When --target-image-opts is not used, add special case
>    code that identifies options passed to bdrv_create()
>    named "*key-secret" and adds them to the options used
>    to open the new image
>=20
> In future it is desirable to make --target-image-opts work even when -n=
 is
> *not* given. This requires considerable work to create a new bdrv_creat=
e()
> API impl.
>=20
> The first patch fixes a bug in the 'dd' command while the second adds s=
upport
> for the missing '--object' arg to 'dd', allowing it to reference secret=
s when
> opening files.  The last two patches implement the new features describ=
ed above
> for the 'convert' command.
>=20
> NB v8 is based against git master once more, since the img_convert chan=
ges
> previously in block-next have now merged.

Changes from the previous version look good, but unfortunately here's
the "but": The image locking series has brought even more changes to
qemu-img. :-(

I tried resolving them, but the following backport-diff didn't look like
I should proceed:

001/4:[----] [-C] 'qemu-img: add support for --object with 'dd' command'
002/4:[0004] [FC] 'qemu-img: fix --image-opts usage with dd command'
003/4:[0015] [FC] 'qemu-img: introduce --target-image-opts for 'convert'
command'
004/4:[0024] [FC] 'qemu-img: copy *key-secret opts when opening newly
created files'

The fun is increased by the fact that the locking series has
(inadvertently) removed the -B documentation from convert, so there is
another conflict looming in the future...

(Or you just inadvertently add it back. Then we'd have resolved the
issue altogether...)

Max


--EwWJx0buol9loANrhcWkEqm2Qw2ucOap7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZFfOvEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCCx
B/40mhFBF3z6OU3BgLsJ6IDIb0PDDbzvgIJngJ/ou3/CtBGeCGsqu2NPAqUSa0Ip
J6KsMa1GpCTbsvfBxzTjLho32Wy7XWvUma4PU3vDY8iz4ablkIDKliEpV7xaxfVt
LLMnS02oYlTFZozIU/hRVGlDwTV3cioDWqrSdMWWi5LvHJYvVTemAxC5Yam2eJeB
kLOVbdPUI+TUcf7cQzWeQjMIQUSM+L2xVXFqBIKIKVIzLMLxGEMzQIiD+DKkJIXN
ZL4K8yNjNoVQpOEuhsslLo0X+qE06a+OoesAQkAJyXZYReIjr8uaMo7DvbAqCmxd
lydLLizD9Y06Mg0f1L7KyRN9
=Ib+C
-----END PGP SIGNATURE-----

--EwWJx0buol9loANrhcWkEqm2Qw2ucOap7--
