Received: from eggs.gnu.org ([2001:4830:134:3::10]:43266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Oc8-0005Ti-QD
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Oc7-0004BF-R7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:12:20 -0400
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-10-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0e96161d-2002-7b8c-858b-f593576aee80@redhat.com>
Date: Wed, 26 Apr 2017 10:12:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170425153858.25660-10-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1QXd8lwHAfsFRCOqoMU5qAWSNiIgH7UEo"
Subject: Re: [Qemu-devel] [PATCH v6 09/18] qcow: convert QCow to use
 QCryptoBlock for encryption
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
--1QXd8lwHAfsFRCOqoMU5qAWSNiIgH7UEo
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <0e96161d-2002-7b8c-858b-f593576aee80@redhat.com>
Subject: Re: [PATCH v6 09/18] qcow: convert QCow to use QCryptoBlock for
 encryption
References: <20170425153858.25660-1-berrange@redhat.com>
 <20170425153858.25660-10-berrange@redhat.com>
In-Reply-To: <20170425153858.25660-10-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 10:38 AM, Daniel P. Berrange wrote:
> This converts the qcow driver to make use of the QCryptoBlock
> APIs for encrypting image content. This is only wired up to
> permit use of the legacy QCow encryption format. Users who wish
> to have the strong LUKS format should switch to qcow2 instead.
>=20
> With this change it is now required to use the QCryptoSecret
> object for providing passwords, instead of the current block
> password APIs / interactive prompting.
>=20
>   $QEMU \
>     -object secret,id=3Dsec0,filename=3D/home/berrange/encrypted.pw \
>     -drive file=3D/home/berrange/encrypted.qcow,encrypt.format=3Dqcow,\=

>            encrypt.key-secret=3Dsec0
>=20
> Likewise when creating such images
>=20
>   qemu-img create -f qcow \
>     -object secret,id=3Dsec0,filename=3D/home/berrange/encrypted.pw \
>     -o encrypt.format=3Dqcow,encrypt.key-secret=3Dsec0 \
>     /home/berrange/encrypted.qcow
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c       |  10 +++
>  block/crypto.h       |  20 ++++--
>  block/qcow.c         | 196 +++++++++++++++++++++++++------------------=
--------
>  qapi/block-core.json |  37 +++++++++-
>  4 files changed, 156 insertions(+), 107 deletions(-)
>=20


> +++ b/qapi/block-core.json
> @@ -2277,6 +2277,41 @@
>              'mode':  'Qcow2OverlapCheckMode' } }
> =20
>  ##
> +# @BlockdevQcowEncryptionFormat:
> +# @qcow: AES-CBC with plain64 initialization venctors

s/venctors/vectors/

With that fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

and it turned out much nicer than v5 !

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1QXd8lwHAfsFRCOqoMU5qAWSNiIgH7UEo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZALjKAAoJEKeha0olJ0NqyKcH/RhN7cp7aFLmRNjEOlL8qo1Y
nfRY82t3yd0OHNtgBqFyn1MDCLPgRBE4CpOM4f3jpSz9XsKsyRDRSEM/SA54UK+S
54qMfShSkxHlqYMGHYsd+cOdG+9Gt4H12Ng9GHMsMPchBDUw1QzOK9vjhlT9Ytmk
5OK5BFhhjI21KnJ++LRHQkRnnTXeJBye8XPdL/xa2YV2TAZnwUduThKh07twMe9y
On8HrHGpFl//Jj9AdahP6HrU1P/ST98hleh/IMUxD5O+0fh28p7fi3kuWxopRKWc
xLmnbYeAaoeY7/mai8nxlDwa+uxcB8OsVc/NO2yqPU1P61WzSRFbI98tKQW8WvU=
=7Pdq
-----END PGP SIGNATURE-----

--1QXd8lwHAfsFRCOqoMU5qAWSNiIgH7UEo--
