Received: from eggs.gnu.org ([2001:4830:134:3::10]:54491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv4DR-0002pp-Os
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv4DQ-0002DA-FT
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:20:41 -0400
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
	<20170920135833.20472-3-pbutsykin@virtuozzo.com>
	<d64c9cdd-098b-bb41-cf80-de51c569288b@redhat.com>
	<175657ad-e6b4-0323-4f32-db9217be6bac@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e8208bb2-941b-135c-419f-72a40f1973bf@redhat.com>
Date: Thu, 21 Sep 2017 18:20:23 +0200
MIME-Version: 1.0
In-Reply-To: <175657ad-e6b4-0323-4f32-db9217be6bac@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GjHv9St3LhmJLht028Sl9gk0pL9L85DmB"
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: truncate the tail of the image
 file after shrinking the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GjHv9St3LhmJLht028Sl9gk0pL9L85DmB
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org
Message-ID: <e8208bb2-941b-135c-419f-72a40f1973bf@redhat.com>
Subject: Re: [PATCH 2/2] qcow2: truncate the tail of the image file after
 shrinking the image
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
 <20170920135833.20472-3-pbutsykin@virtuozzo.com>
 <d64c9cdd-098b-bb41-cf80-de51c569288b@redhat.com>
 <175657ad-e6b4-0323-4f32-db9217be6bac@virtuozzo.com>
In-Reply-To: <175657ad-e6b4-0323-4f32-db9217be6bac@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-21 18:16, Pavel Butsykin wrote:
> On 21.09.2017 18:28, Max Reitz wrote:
>> On 2017-09-20 15:58, Pavel Butsykin wrote:
>>> Now after shrinking the image, at the end of the image file, there
>>> might be a
>>> tail that probably will never be used. So we can find the last used
>>> cluster and
>>> cut the tail.
>>>
>>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>>> ---
>>> =C2=A0 block/qcow2-refcount.c | 21 +++++++++++++++++++++
>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 19 +++++++++++++++++++
>>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
>>> =C2=A0 3 files changed, 41 insertions(+)
>>>
>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>> index 88d5a3f1ad..5e221a166c 100644
>>> --- a/block/qcow2-refcount.c
>>> +++ b/block/qcow2-refcount.c
>>> @@ -3181,3 +3181,24 @@ out:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(reftable_tmp);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> +
>>> +int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>>> +=C2=A0=C2=A0=C2=A0 int64_t i, last_cluster, nb_clusters =3D size_to_=
clusters(s, size);
>>> +=C2=A0=C2=A0=C2=A0 uint64_t refcount;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0, last_cluster =3D 0; i < nb_clusters=
; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D qcow2_get_ref=
count(bs, i, &refcount);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
printf(stderr, "Can't get refcount for cluster %"
>>> PRId64 ": %s\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i, strerror(-ret));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (refcount > 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ast_cluster =3D i;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return last_cluster;
>>> +}
>>
>> Wouldn't it make more sense to start from the end of the image?
>=20
> If this will reduce the iterations, then yes. But it will depend on the=

> situation. If you truncate the image more than half, it can increase th=
e
> number of iterations. But intuitively it seems that to start from the
> end would be better :)

That's one thing (also, I think usually the end should coincide with
some allocated cluster, but yes, that's just intuition :-)); but also,
this would simplify things a bit because we would no longer need the
last_cluster variable (the loop would just stop at the first allocated
cluster).

Max


--GjHv9St3LhmJLht028Sl9gk0pL9L85DmB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnD5scSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A1+8IAMMqgl1+e6IOb8dW7Z1r/MWJH36OipRa
IwHtNhvWSxxHqivqXmX1+XjdJkEvZ79SIvLnU5IaeHoGwWWtqjy0K7EumqdHe2+5
oPL2NTrRzCenazA4GLeYV1g1C4kwPaMySRqaCSNCmSdbKpBnE0DhJoa+NIYkVjs5
PdtOdiEjwbsL72TqDNNyKaDiQ46l/QJPbVu6+O6GN5XnitBxR7CBi4FLzcdnGoK5
BmvoiWKOSyQZr0i38G1TxThopFvffRSi2lzDJ4WAkLG+GvjOQCiaw8QEIE+Fayhq
w7M39FOgpj+VWPlGAy/3U1gYwqJ59/xyvRC7l2b4zUhakZQPloNPG2Q=
=Rx4y
-----END PGP SIGNATURE-----

--GjHv9St3LhmJLht028Sl9gk0pL9L85DmB--
