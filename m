Received: from eggs.gnu.org ([2001:4830:134:3::10]:35155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ey0c4-0001dX-M4
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ey0c3-0003oM-Gq
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:38:32 -0400
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-3-mreitz@redhat.com>
	<c8a20a6d-039f-544a-3b58-098f6be19ecf@redhat.com>
	<afd63f12-6b1c-1981-ac3a-52d108725e2d@redhat.com>
	<24d6fa65-3570-4eff-fce4-23a5b0a5a2f8@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <68fe9eb3-18b2-3226-ea78-4c4e1389765f@redhat.com>
Date: Mon, 19 Mar 2018 20:38:14 +0100
MIME-Version: 1.0
In-Reply-To: <24d6fa65-3570-4eff-fce4-23a5b0a5a2f8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T3RV0vmMJL4RuWWfX5lMLmteNGKmjTaD5"
Subject: Re: [Qemu-devel] [PATCH v3 2/7] qapi: Add qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T3RV0vmMJL4RuWWfX5lMLmteNGKmjTaD5
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <68fe9eb3-18b2-3226-ea78-4c4e1389765f@redhat.com>
Subject: Re: [PATCH v3 2/7] qapi: Add qobject_to()
References: <20180224154033.29559-1-mreitz@redhat.com>
 <20180224154033.29559-3-mreitz@redhat.com>
 <c8a20a6d-039f-544a-3b58-098f6be19ecf@redhat.com>
 <afd63f12-6b1c-1981-ac3a-52d108725e2d@redhat.com>
 <24d6fa65-3570-4eff-fce4-23a5b0a5a2f8@redhat.com>
In-Reply-To: <24d6fa65-3570-4eff-fce4-23a5b0a5a2f8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-19 20:36, Eric Blake wrote:
> On 02/26/2018 05:58 AM, Max Reitz wrote:
>> On 2018-02-24 21:57, Eric Blake wrote:
>>> On 02/24/2018 09:40 AM, Max Reitz wrote:
>>>> This is a dynamic casting macro that, given a QObject type, returns =
an
>>>> object as that type or NULL if the object is of a different type (or=

>>>> NULL itself).
>>>>
>=20
>>>> +#define qobject_to(obj, type) \
>>>> +=C2=A0=C2=A0=C2=A0 container_of(qobject_check_type(obj, glue(QTYPE_=
CAST_TO_, type))
>>>> ?: \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QOBJECT((type *)NULL)=
, \
>>>
>>> I guess the third (second?) branch of the ternary is written this way=
,
>>> rather than the simpler 'NULL', to ensure that 'type' is still someth=
ing
>>> that can have the QOBJECT() macro applied to it?=C2=A0 Should be okay=
=2E
>>
>> It's written this way because of the container_of() around it.=C2=A0 W=
e want
>> the whole expression to return NULL then, and without the QOBJECT()
>> around it, it would only return NULL if offsetof(type, base) =3D=3D 0 =
(which
>> it is not necessarily).
>>
>> OTOH, container_of(&((type *)NULL)->base, type, base) is by definition=

>> NULL.
>>
>> (QOBJECT(x) is &(x)->base)
>=20
> Well, clang's ubsan griped:
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05143.html
>=20
> Practically, all of our qtypes have 'base' at offset 0, which means
> (QObject*)addr and (QString*)addr are the same address, even when addr
> is NULL.=C2=A0 But neither QOBJECT() nor container_of() are currently f=
it to
> run on a NULL pointer, since the 'base' member need not be at offset 0,=

> at which point, we'd be converting away from the NULL pointer on the
> &(x)->base conversion, and then back to the NULL pointer on the
> container_of() conversion.=C2=A0 So at the end of the day, we get the r=
ight
> results, but we relied on undefined behavior in the interim.
>=20
> So here's what I'm squashing in, if you like it (and remembering that I=

> already swapped argument order to be qobject_to(type, obj) in my pendin=
g
> pull requests):
>=20
> diff --git i/include/qapi/qmp/qobject.h w/include/qapi/qmp/qobject.h
> index ea9702270e7..e6ce9347ab8 100644
> --- i/include/qapi/qmp/qobject.h
> +++ w/include/qapi/qmp/qobject.h
> @@ -62,9 +62,8 @@ QEMU_BUILD_BUG_MSG(QTYPE__MAX !=3D 7,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "The QTYPE_CAST_TO_* list need=
s to be extended");
>=20
> =C2=A0#define qobject_to(type, obj) \
> -=C2=A0=C2=A0=C2=A0 container_of(qobject_check_type(obj, glue(QTYPE_CAS=
T_TO_, type)) ?: \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QOBJECT((type *)NULL), \=

> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 type, base)
> +=C2=A0=C2=A0=C2=A0 ({ QObject *_tmp =3D qobject_check_type(obj, glue(Q=
TYPE_CAST_TO_,
> type)); \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _tmp ? container_of(_tmp, t=
ype, base) : (type *)NULL; })
>=20
> =C2=A0/* Initialize an object to default values */
> =C2=A0static inline void qobject_init(QObject *obj, QType type)

Yes, that looks good.  Thanks!

Max


--T3RV0vmMJL4RuWWfX5lMLmteNGKmjTaD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqwEaYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQ60H/30znxJeLGEXTDmRlKZEgm2J+eWOrapq
7s9ExFhMKmaBwKm4cNnlD2Mp28aNGMzNZalPz9PAzRcyBglI2iZvtlJV6sIGa0/Y
By1LYimzvPqlbxzfc6JL3G2tvSlaCfnYDhgRucpczuQTPyRLCcq0BavZcejrV1x3
YECjcOVOenDGPfIn0njj8O5xtBl/k+5PrlLJzAbunmRORUf/1z4qKvXx+t5h/pur
mfpoZnNBeAeW4L+kYxGmvePfIH75d+BOzengNnSWWw2ytMs4aqD1uauIheeoflho
LbgsaubR/kdfWMTtvrdHZUupf+OqHHr9JZvghv4J6T/XyGKzwlBV32U=
=gXPU
-----END PGP SIGNATURE-----

--T3RV0vmMJL4RuWWfX5lMLmteNGKmjTaD5--
