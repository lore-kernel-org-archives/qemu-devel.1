Received: from eggs.gnu.org ([2001:4830:134:3::10]:39777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHU2-0007NF-Kk
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHTx-0000ly-VC
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:02:18 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-4-mreitz@redhat.com>
	<abd5ed7a-d5ee-028c-1cd5-208161f88beb@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fb3756be-e002-8b47-921f-80a5ce332721@redhat.com>
Date: Mon, 26 Feb 2018 13:01:59 +0100
MIME-Version: 1.0
In-Reply-To: <abd5ed7a-d5ee-028c-1cd5-208161f88beb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RbFacshWmVEstVn8qImcHCHUPkdKnEiXt"
Subject: Re: [Qemu-devel] [PATCH v3 3/7] qapi: Replace qobject_to_X(o) by
 qobject_to(o, X)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RbFacshWmVEstVn8qImcHCHUPkdKnEiXt
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <fb3756be-e002-8b47-921f-80a5ce332721@redhat.com>
Subject: Re: [PATCH v3 3/7] qapi: Replace qobject_to_X(o) by qobject_to(o, X)
References: <20180224154033.29559-1-mreitz@redhat.com>
 <20180224154033.29559-4-mreitz@redhat.com>
 <abd5ed7a-d5ee-028c-1cd5-208161f88beb@redhat.com>
In-Reply-To: <abd5ed7a-d5ee-028c-1cd5-208161f88beb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-24 22:04, Eric Blake wrote:
> On 02/24/2018 09:40 AM, Max Reitz wrote:
>> This patch was generated using the following Coccinelle script:
>>
>=20
>> and a bit of manual fix-up for overly long lines and three places in
>> tests/check-qjson.c that Coccinelle did not find.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
>=20
>> diff --git a/block.c b/block.c
>> index 814e5a02da..cb69fd7ae4 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -1457,7 +1457,7 @@ static QDict *parse_json_filename(const char
>> *filename, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 options =3D qobject_to_qdict(options_obj);
>> +=C2=A0=C2=A0=C2=A0 options =3D qobject_to(options_obj, QDict);
>=20
> Bikeshedding - would it read any easier as:
>=20
> options =3D qobject_to(QDict, options_obj);
>=20
> ?=C2=A0 If so, your Coccinelle script can be touched up, and patch 2/7 =
swaps
> argument order around, so it would be tolerable but still slightly
> busywork to regenerate the series.=C2=A0 But I'm not strongly attached =
to
> either order, and so I'm also willing to take this as-is (especially
> since that's less work), if no one else has a strong opinion that
> swapping order would aid legibility.

Well, same for me. :-)

In a template/generic language, we'd write the type first (e.g.
qobject_cast<QDict>(options_obj)).  But maybe we'd write the object
first, too (e.g. options_obj.cast<QDict>()).  And the current order of
the arguments follows the order in the name ("qobject" options_obj "to"
QDict).  But maybe it's more natural to read it as "qobject to" QDict
"applied to" options_obj.

I don't know either.

Max

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
>=20
>> +++ b/block/rbd.c
>> @@ -256,14 +256,14 @@ static int qemu_rbd_set_keypairs(rados_t
>> cluster, const char *keypairs_json,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!keypairs_json) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 keypairs =3D qobject_to_qlist(qobject_from_json(ke=
ypairs_json,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &error_abort));
>> +=C2=A0=C2=A0=C2=A0 keypairs =3D qobject_to(qobject_from_json(keypairs=
_json,
>> &error_abort),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 QList);
>=20
> The question about legibility gets a bit more obvious when you span lin=
es.
>=20
>> @@ -893,8 +893,9 @@ static void simple_number(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QNum *qnum;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t val;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qnum =3D
>> qobject_to_qnum(qobject_from_json(test_cases[i].encoded,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &er=
ror_abort));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qnum =3D qobject_to(qobjec=
t_from_json(test_cases[i].encoded,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &error_abort),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 QNum);
>=20



--RbFacshWmVEstVn8qImcHCHUPkdKnEiXt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqT9zcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A3v4IAKtzHsm/HlPqMUbVK2GscejA1eUpybSo
1iQd7DyhP+GXFqhCdBCl9VMCajZz+grVx2/mdag+xIadYaQveeggfKDSBXp3s1js
nVdIIlpZA/6KALBTj2ipjjOEHckYkFaixngp6hUUxAP+ZJG7r5TYeHtHTTuwXmpC
4HX7GXgLArC+/STdIRmESS3NsnJTYLUzo91M5qWQJPxlIATNVRtoW23y920JHKl1
RO3lwqRqlghBeqMqRchLEJtnJMWOcNe4wtM7z56v01MwUwfrkgENb8bdgwbneMHE
NrEncCdLI2Pm34XnShCV/EG14fo/pqj0OhW/2kUoxJ0mnTq2Wuz3dpo=
=x0SD
-----END PGP SIGNATURE-----

--RbFacshWmVEstVn8qImcHCHUPkdKnEiXt--
