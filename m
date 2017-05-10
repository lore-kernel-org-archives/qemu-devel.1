Received: from eggs.gnu.org ([2001:4830:134:3::10]:32936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8UYT-00051j-7r
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8UYS-0000TU-EF
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:33:37 -0400
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510143205.32013-2-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0198479d-dbb2-427b-56bf-4f0e97e33386@redhat.com>
Date: Wed, 10 May 2017 18:33:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170510143205.32013-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rHtobFMs8THieiOmgbPIjEFvjCsJGhst4"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/7] curl: strengthen
 assertion in curl_clean_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rHtobFMs8THieiOmgbPIjEFvjCsJGhst4
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com
Message-ID: <0198479d-dbb2-427b-56bf-4f0e97e33386@redhat.com>
Subject: Re: [Qemu-block] [PATCH 1/7] curl: strengthen assertion in
 curl_clean_state
References: <20170510143205.32013-1-pbonzini@redhat.com>
 <20170510143205.32013-2-pbonzini@redhat.com>
In-Reply-To: <20170510143205.32013-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.05.2017 16:31, Paolo Bonzini wrote:
> curl_clean_state should only be called after all AIOCBs have been
> completed.  This is not so obvious for the call from curl_detach_aio_co=
ntext,
> so assert that.
>=20
> Cc: qemu-stable@nongnu.org
> Cc: jcody@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/block/curl.c b/block/curl.c
> index 2708d57c2f..25a301e7b4 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -532,6 +532,11 @@ static CURLState *curl_init_state(BlockDriverState=
 *bs, BDRVCURLState *s)
> =20
>  static void curl_clean_state(CURLState *s)
>  {
> +    int j;
> +    for (j=3D0; j<CURL_NUM_ACB; j++) {

See checkpatch output, but apart from that:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +        assert(!s->acb[j]);
> +    }
> +
>      if (s->s->multi)
>          curl_multi_remove_handle(s->s->multi, s->curl);
> =20
>=20



--rHtobFMs8THieiOmgbPIjEFvjCsJGhst4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkTQNUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7qgIAMQIQJzRfXeoOVN3Sjm7Fvsjm+NdJuzB
gr4kh1I54UP8Qzpum8qzh84s+6xnexoLRlguvDasSyge7SxtRVIxyXoOk8VWw8TY
wMRPKMIn4EAKWozMakfrtbxeiQXpeJik27vQ2O7kFOqQjnovSqZEjfvVFFiLjz2j
CmRKXy/iC/lwdJX7ZDb/iUcGMXsJbcc/VVv/gRSsM/Ed2KyahSg7ahl+ehfNAB6o
yTaRbRsOvU+Q0kSMQrDr7QQ9K3fKAdCauWQrjm5yHru7C5m6QpKqvDjR/LzWRXCG
ySSsDYLLS4i6NYY5Nv5iUEhvo2y6lq0nX0P3Qp3HhqAgqag85rYlHzA=
=Qq6i
-----END PGP SIGNATURE-----

--rHtobFMs8THieiOmgbPIjEFvjCsJGhst4--
