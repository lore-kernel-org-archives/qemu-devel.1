Received: from eggs.gnu.org ([2001:4830:134:3::10]:35903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1edfMG-0004H8-Nb
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1edfMF-0000gD-Lt
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:54:08 -0500
References: <20180120154412.9990-1-mreitz@redhat.com>
	<20180120154412.9990-2-mreitz@redhat.com>
	<39ad6e43-024c-6384-d014-e0b8f83ed3a7@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <db14dd01-2a01-8ab3-d4b6-bf1a46425eef@redhat.com>
Date: Mon, 22 Jan 2018 17:53:58 +0100
MIME-Version: 1.0
In-Reply-To: <39ad6e43-024c-6384-d014-e0b8f83ed3a7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xiktfVjtnitHckWVsztuVntFGTxnIKDUT"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qapi: Add qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xiktfVjtnitHckWVsztuVntFGTxnIKDUT
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <db14dd01-2a01-8ab3-d4b6-bf1a46425eef@redhat.com>
Subject: Re: [PATCH v2 1/6] qapi: Add qobject_to()
References: <20180120154412.9990-1-mreitz@redhat.com>
 <20180120154412.9990-2-mreitz@redhat.com>
 <39ad6e43-024c-6384-d014-e0b8f83ed3a7@redhat.com>
In-Reply-To: <39ad6e43-024c-6384-d014-e0b8f83ed3a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-22 16:33, Eric Blake wrote:
> On 01/20/2018 09:44 AM, Max Reitz wrote:
>> This is a dynamic casting macro that, given a QObject type, returns an=

>> object as that type or NULL if the object is of a different type (or
>> NULL itself).
>>
>> The macro uses lower-case letters because:
>> 1. There does not seem to be a hard rule on whether qemu macros have t=
o
>>    be upper-cased,
>> 2. The current situation in qapi/qmp is inconsistent (compare e.g.
>>    QINCREF() vs. qdict_put()),
>> 3. qobject_to() will evaluate its @obj parameter only once, thus it is=

>>    generally not important to the caller whether it is a macro or not,=

>> 4. I prefer it aesthetically.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> You're more than welcome to convince me to call it QOBJECT_TO()!
>=20
> I can live with the lower-case version; especially with your good list
> of reasons for it ;)
>=20
>> ---
>>  include/qapi/qmp/qobject.h | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
>> index 38ac68845c..1211989ca0 100644
>> --- a/include/qapi/qmp/qobject.h
>> +++ b/include/qapi/qmp/qobject.h
>> @@ -50,6 +50,24 @@ struct QObject {
>>  #define QDECREF(obj)              \
>>      qobject_decref(obj ? QOBJECT(obj) : NULL)
>> =20
>> +/* Required for qobject_to() */
>> +#define QTYPE_CAST_TO_QNull     QTYPE_QNULL
>> +#define QTYPE_CAST_TO_QNum      QTYPE_QNUM
>> +#define QTYPE_CAST_TO_QString   QTYPE_QSTRING
>> +#define QTYPE_CAST_TO_QDict     QTYPE_QDICT
>> +#define QTYPE_CAST_TO_QList     QTYPE_QLIST
>> +#define QTYPE_CAST_TO_QBool     QTYPE_QBOOL
>> +
>> +#ifdef CONFIG_STATIC_ASSERT
>> +_Static_assert(QTYPE__MAX =3D=3D 7,
>> +               "The QTYPE_CAST_TO_* list needs to be extended");
>> +#endif
>=20
> Why not use QEMU_BUILD_BUG_ON() instead of _Static_assert?  That way,
> this check will break the build even on older compilers that lack
> _Static_assert but where we still know how to trigger a build failure.

One reason would be because _Static_assert() allows me to give a nice
warning message -- I could add a comment above the QEMU_BUILD_BUG_ON()
line and hope for the best, but still, I like that better.

The other is that I assumed most people would be using C11 compilers
now, so the omission would be spotted sufficiently early.
"Sufficiently" because it's actually not that bad for this list to be
incomplete.  The worst is that you can't use qobject_to() for your
desired target type, but that's hardly catastrophic.

I could add an #else branch with QEMU_BUILD_BUG_ON().  Or I could add a
QEMU_BUILD_BUG_MSG() macro that takes a message (which is omitted if you
don't have _Static_assert() but would still make for a nice comment).  I
guess the latter would be a nice idea in general...?

Max

>> +
>> +#define qobject_to(obj, type) \
>> +    container_of(qobject_check_type(obj, glue(QTYPE_CAST_TO_, type)) =
?: \
>> +                     QOBJECT((type *)NULL), \
>> +                 type, base)
>=20
> Slick!
>=20



--xiktfVjtnitHckWVsztuVntFGTxnIKDUT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpmFyYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A3/YH/j95CvvxgDTv6lfGDnpbCQ1juhEciB+L
gzOD9TiTw6L9TdSyq4ntWjEDTHTCpHdTDO0HDtxB1ChoQvLGCfczsEkEVlfH+1P1
hOcnlwbQYVI01Ed7EQeGROdDm2DFb3GiVcEtv4ryAxEYM5tHKcS/dX3Q6R7HffPG
kCxFTvucUQBoTNXRQDZYkGhrUGQh1iyIx60/AkursynY8LzjS/0XUzQTMZ9ztNwP
Tj8UKMlIYZLGNpDqPAlPO8H+U3MCXEwNe3jHBirXZrstFIyKY6xt8s+oKs2opndc
Jj9OY/7zTpxZA9V1lSTPjwQnnytmTtEAduMH55ae4Gjkr6xQ5JVyrjM=
=SxS+
-----END PGP SIGNATURE-----

--xiktfVjtnitHckWVsztuVntFGTxnIKDUT--
