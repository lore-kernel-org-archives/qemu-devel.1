Received: from eggs.gnu.org ([2001:4830:134:3::10]:47686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7nzB-0001Jy-GK
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7nz7-0007pz-4W
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:06:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1d7nz6-0007pb-R3
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:06:17 -0400
References: <20170508141536.20690-1-stefanha@redhat.com>
	<20170508141536.20690-5-stefanha@redhat.com>
	<68fd3173-ae56-50ed-4cfc-f9c19904aa30@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1e61d40a-95f9-f90e-aac2-7897267a5d53@redhat.com>
Date: Mon, 8 May 2017 21:06:08 +0200
MIME-Version: 1.0
In-Reply-To: <68fd3173-ae56-50ed-4cfc-f9c19904aa30@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GLftErm3JUI5G6gvoF3917TjnECuMlLBI"
Subject: Re: [Qemu-devel] [PATCH v6 4/9] qcow2: make refcount size
 calculation conservative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GLftErm3JUI5G6gvoF3917TjnECuMlLBI
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <1e61d40a-95f9-f90e-aac2-7897267a5d53@redhat.com>
Subject: Re: [PATCH v6 4/9] qcow2: make refcount size calculation conservative
References: <20170508141536.20690-1-stefanha@redhat.com>
 <20170508141536.20690-5-stefanha@redhat.com>
 <68fd3173-ae56-50ed-4cfc-f9c19904aa30@redhat.com>
In-Reply-To: <68fd3173-ae56-50ed-4cfc-f9c19904aa30@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.2017 17:00, Eric Blake wrote:
> On 05/08/2017 09:15 AM, Stefan Hajnoczi wrote:
>> The refcount metadata size calculation is inaccurate and can produce
>> numbers that are too small.  This is bad because we should calculate a=

>> conservative number - one that is guaranteed to be large enough.
>>
>> This patch switches the approach to a fixed point calculation because
>> the existing equation is hard to solve when inaccuracies are taken car=
e
>> of.
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/qcow2.c | 82 ++++++++++++++++++++++++++++++--------------------=
---------
>>  1 file changed, 42 insertions(+), 40 deletions(-)
>>
>=20
>> -    nrefblocke =3D (aligned_total_size + meta_size + cluster_size)
>> -        / (cluster_size - rces - rces * sizeof(uint64_t)
>> -                / cluster_size);
>> -    meta_size +=3D DIV_ROUND_UP(nrefblocke, refblock_size) * cluster_=
size;
>> -
>> -    /* total size of refcount tables */
>> -    nreftablee =3D nrefblocke / refblock_size;
>> -    nreftablee =3D align_offset(nreftablee, cluster_size / sizeof(uin=
t64_t));
>> -    meta_size +=3D nreftablee * sizeof(uint64_t);
>> +    /* total size of refcount table and blocks */
>> +    meta_size +=3D qcow2_refcount_metadata_size(
>> +            (meta_size + aligned_total_size) / cluster_size,
>=20
> How does this interact with Max's patch which avoids truncating divisio=
n
> in favor of rounding up?
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00690.html

=46rom a quick glance, it looks like it just reimplements everything in a=

(hopefully) more understandable and "generous" way (which is good). So
the only interaction is that the code that's removed/replaced is a bit
different (which implies a rebase conflict, but one that should be
resolved pretty easily).

Max


--GLftErm3JUI5G6gvoF3917TjnECuMlLBI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQwaASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Axg4IAKuzcPX9ALASEwczBEcLwyMecj786mQh
qW6DOVXM/mTlBYUv75/14gWN9MP2gpycOBdhUKeXbrK9NIwoU9e7FWH+gZCZYGXY
cvpbFQL+KgVQmZbOSzpdPbaEM689CFAHGyisJY47wsiQB7n0ASTTRLgATfkLEWsE
ZZovGYSHuwfgrc9gAPagUHCtvISX8JQcoNy0olGxj/9z0bn+HoxAkd0bz3jHrYmA
wJnQF1gqhnRr8jdg7J+LPugdjs3/H4pu+XlvbDdrPNBPNJ0yzVXJTEXqDJ/DQUft
479nCprMQqlkdb95UNPeS3TNG+4gw2zm6AvD1idThw+kL1M230Yh8+o=
=R9mu
-----END PGP SIGNATURE-----

--GLftErm3JUI5G6gvoF3917TjnECuMlLBI--
