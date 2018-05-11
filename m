Received: from eggs.gnu.org ([2001:4830:134:3::10]:33753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHFoF-0006o2-Q1
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHFoE-0006KU-Qs
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:42:39 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-8-mreitz@redhat.com>
	<e0cb86f1-ac04-f7cd-bd19-77abeeb5636a@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <51b724fd-ed60-1021-cf26-729e6a0f7590@redhat.com>
Date: Fri, 11 May 2018 23:42:33 +0200
MIME-Version: 1.0
In-Reply-To: <e0cb86f1-ac04-f7cd-bd19-77abeeb5636a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="z8zEwCWOBVCs1KYe9GpQ6F3BKfgSQQvAW"
Subject: Re: [Qemu-devel] [PATCH 07/13] qdict: Add
 qdict_stringify_for_keyval()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z8zEwCWOBVCs1KYe9GpQ6F3BKfgSQQvAW
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <51b724fd-ed60-1021-cf26-729e6a0f7590@redhat.com>
Subject: Re: [PATCH 07/13] qdict: Add qdict_stringify_for_keyval()
References: <20180509165530.29561-1-mreitz@redhat.com>
 <20180509165530.29561-8-mreitz@redhat.com>
 <e0cb86f1-ac04-f7cd-bd19-77abeeb5636a@redhat.com>
In-Reply-To: <e0cb86f1-ac04-f7cd-bd19-77abeeb5636a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-11 20:39, Eric Blake wrote:
> On 05/09/2018 11:55 AM, Max Reitz wrote:
>> The purpose of this function is to prepare a QDict for consumption by
>> the keyval visitor, which only accepts strings and QNull.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 include/block/qdict.h |=C2=A0 2 ++
>> =C2=A0 qobject/qdict.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 57
>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 2 files changed, 59 insertions(+)
>>
>=20
>> +/**
>> + * Convert all values in a QDict so it can be consumed by the keyval
>> + * input visitor.=C2=A0 QNull values are left as-is, all other values=
 are
>> + * converted to strings.
>> + *
>> + * @qdict must be flattened, i.e. it may not contain any nested QDict=
s
>> + * or QLists.
>=20
> Maybe s/flattened/flattened already/
>=20
> or would it be worth letting this function PERFORM the flattening step
> automatically?

Possibly, but I don't think it would be any more efficient, so I'd
rather leave it up to the caller to do it explicitly than to do it here
and maybe surprise someone.

(Indeed I personally prefer to be surprised by an abort() than by some
unintended data change.)

Max

>> + */
>> +void qdict_stringify_for_keyval(QDict *qdict)
>> +{
>> +=C2=A0=C2=A0=C2=A0 const QDictEntry *e;
>> +
>> +=C2=A0=C2=A0=C2=A0 for (e =3D qdict_first(qdict); e; e =3D qdict_next=
(qdict, e)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QString *new_value =3D NUL=
L;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (qobject_type(e->va=
lue)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QTYPE_QNULL:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 leave as-is */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QTYPE_QNUM: {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch=
ar *str =3D qnum_to_string(qobject_to(QNum, e->value));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ne=
w_value =3D qstring_from_str(str);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_=
free(str);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QTYPE_QSTRING:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 leave as-is */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QTYPE_QDICT:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QTYPE_QLIST:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 @qdict must be flattened */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab=
ort();
>=20
> Matches your documentation about requiring it to be already flattened.
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QTYPE_QBOOL:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (qbool_get_bool(qobject_to(QBool, e->value))) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 new_value =3D qstring_from_str("on");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 new_value =3D qstring_from_str("off");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QTYPE_NONE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QTYPE__MAX:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab=
ort();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (new_value) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QD=
ictEntry *mut_e =3D (QDictEntry *)e;
>=20
> A bit of a shame that you have to cast away const. It took me a couple
> reads to figure out this meant 'mutable_e'.=C2=A0 But in the end, the c=
ode
> looks correct.
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qo=
bject_unref(mut_e->value);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mu=
t_e->value =3D QOBJECT(new_value);
>=20
> If we're okay requiring the caller to pre-flatten before calling this,
> instead of offering to do it here,
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20



--z8zEwCWOBVCs1KYe9GpQ6F3BKfgSQQvAW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2DkkACgkQ9AfbAGHV
z0Ba5wgAmzFs4pUIiykDXcOFfG3eFEJmkQErScAREsH2ALy9n7x87uLOwhqK7pD1
1FuA5IZqOQsZS/vUWdhUq+szTLdVS1UbNQuFbOO4urfynO9tXQnYEnrCydsnY+VE
G2NIpfvJO6p8PDHmRXqdBOP7DgoHfgEisfLVv6VMxXXskSadBAQ5v+LN8SXFZQJf
UylReuDMryYTCyjyAyVkXAaU65hPjrAPu60tqhMY2jR1hGU6F+sHBZ3WV+cC7mXY
DpOU6rxJTsk7NcXxdUJLELOsMCAyMr7RMhfYoOav8+F0dn4VSLyThmWsYup0h4Ai
YHtkb4C8+siXvVWkEQFTMwNE+ZVWYg==
=AdOn
-----END PGP SIGNATURE-----

--z8zEwCWOBVCs1KYe9GpQ6F3BKfgSQQvAW--
