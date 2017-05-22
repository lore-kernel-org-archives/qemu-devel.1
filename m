Received: from eggs.gnu.org ([2001:4830:134:3::10]:37892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpz6-0004at-25
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpz1-0000x3-Tl
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:15:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCpz1-0000wv-KB
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:14:59 -0400
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133148eucas1p2c04111d415b1fbd6fb702cfc2a3ed6f9@eucas1p2.samsung.com>
	<1494595886-30912-9-git-send-email-a.perevalov@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af4f91ca-0b56-b734-58b8-5b5b668d5dd4@redhat.com>
Date: Mon, 22 May 2017 11:14:54 -0500
MIME-Version: 1.0
In-Reply-To: <1494595886-30912-9-git-send-email-a.perevalov@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uNpFdk5r9Rjx14sbW6uGSjx8r9rL8aPgJ"
Subject: Re: [Qemu-devel] [PATCH V5 8/9] migration: add postcopy total
 blocktime into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uNpFdk5r9Rjx14sbW6uGSjx8r9rL8aPgJ
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <af4f91ca-0b56-b734-58b8-5b5b668d5dd4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5 8/9] migration: add postcopy total
 blocktime into query-migrate
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
 <CGME20170512133148eucas1p2c04111d415b1fbd6fb702cfc2a3ed6f9@eucas1p2.samsung.com>
 <1494595886-30912-9-git-send-email-a.perevalov@samsung.com>
In-Reply-To: <1494595886-30912-9-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 08:31 AM, Alexey Perevalov wrote:
> Postcopy total blocktime is available on destination side only.
> But query-migrate was possible only for source. This patch
> adds ability to call query-migrate on destination. To distinguish
> src/dst, state of the MigrationState is using, query-migrate prepares
> MigrationInfo for source machine only in case of migration's state is d=
ifferent
> than MIGRATION_STATUS_NONE.
>=20
> To be able to see postcopy blocktime, need to request postcopy-blocktim=
e
> capability.
>=20
> The query-migrate command will show following sample result:
> {"return":
>     "postcopy_vcpu_blocktime": [115, 100],
>     "status": "completed",
>     "postcopy_blocktime": 100
> }}
>=20
> postcopy_vcpu_blocktime contains list, where the first item is the firs=
t
> vCPU in QEMU.
>=20
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---

> +++ b/qapi-schema.json
> @@ -712,6 +712,8 @@
>  #              @status is 'failed'. Clients should not attempt to pars=
e the
>  #              error strings. (Since 2.7)
>  #
> +# @postcopy_vcpu_blocktime: list of the postcopy blocktime per vCPU (S=
ince 2.9)

You've missed 2.9; this should be 2.10.

> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationInfo',
> @@ -723,7 +725,9 @@
>             '*downtime': 'int',
>             '*setup-time': 'int',
>             '*cpu-throttle-percentage': 'int',
> -           '*error-desc': 'str'} }
> +           '*error-desc': 'str',
> +           '*postcopy_blocktime' : 'int64',
> +           '*postcopy_vcpu_blocktime': ['int64']} }

You're adding two fields, but only documented one of them
(postcopy_blocktime needs mention).

New fields should favor names with '-', not '_'; especially when part of
a struct that is already using '-' names.  So these should be
'postcopy-blocktime' and 'postcopy-vcpu-blocktime'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uNpFdk5r9Rjx14sbW6uGSjx8r9rL8aPgJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIw5+AAoJEKeha0olJ0Nq7J4IAJSFb1+DwfAMTQaes5YvjDR4
NdPVOmB2RpLctwKRr1thDboGp54ghdhPWdasxpk43dczMQXE17dwFQn24VpIA2cl
zze9ALVHfCz6BYxCg3tizRW0Km211GaE/4Rt/GuXr6PbX3iYFKFhH751bvmxmEoK
yV2K3rEFvtn+TQoUBQC/XBGCyV9DaDJVqWFU8wf5gbKtYZq6Ls4whBTQ5/OipPS6
eVc0xZiHpEh0bXfvf74JmBBP/JDQyI68osmWwY476fNv+OtlVfSQdVJwrXS9puXO
UJ3MyPROaXe2NFPxVqSF4yM/5Fo5inFkhoy0Xhw7i/78IntmsU0Ij0m7Aje7qYY=
=ZmlP
-----END PGP SIGNATURE-----

--uNpFdk5r9Rjx14sbW6uGSjx8r9rL8aPgJ--
