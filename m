Received: from eggs.gnu.org ([209.51.188.92]:51028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsD6X-00006i-LB
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsD6W-0003Nv-Dc
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:50:33 -0500
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-2-mreitz@redhat.com>
	<87mun8jddk.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4f75a6e9-5f5b-9161-cbb0-91c8034a7abc@redhat.com>
Date: Fri, 8 Feb 2019 19:21:46 +0100
MIME-Version: 1.0
In-Reply-To: <87mun8jddk.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Taf9dARQg57mzYBC0vZCiDQw7M70Lo0IT"
Subject: Re: [Qemu-devel] [PATCH v3 1/8] qapi: Add default-variant for flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Taf9dARQg57mzYBC0vZCiDQw7M70Lo0IT
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <4f75a6e9-5f5b-9161-cbb0-91c8034a7abc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] qapi: Add default-variant for flat
 unions
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-2-mreitz@redhat.com>
 <87mun8jddk.fsf@dusky.pond.sub.org>
In-Reply-To: <87mun8jddk.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.02.19 07:56, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> This patch allows specifying a discriminator that is an optional membe=
r
>> of the base struct.  In such a case, a default value must be provided
>> that is used when no value is given.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qapi/introspect.json           |  8 +++++
>>  scripts/qapi/common.py         | 58 ++++++++++++++++++++++++++++-----=
-
>>  scripts/qapi/doc.py            | 10 ++++--
>>  scripts/qapi/introspect.py     | 10 ++++--
>>  scripts/qapi/visit.py          | 13 ++++++++
>>  tests/qapi-schema/test-qapi.py |  2 ++
>>  6 files changed, 86 insertions(+), 15 deletions(-)
>>
>> diff --git a/qapi/introspect.json b/qapi/introspect.json
>> index 3d22166b2b..e4740aa7a0 100644
>> --- a/qapi/introspect.json
>> +++ b/qapi/introspect.json
>> @@ -168,6 +168,13 @@
>>  # @tag: the name of the member serving as type tag.
>>  #       An element of @members with this name must exist.
>>  #
>> +# @default-variant: if the @tag element of @members is optional, this=

>> +#                   is the default value for choosing a variant.  Its=

>> +#                   value will be a valid value for @tag.
>> +#                   Present exactly when @tag is present and the
>> +#                   associated element of @members is optional.
>> +#                   (Since: 4.0)
>> +#
>>  # @variants: variant members, i.e. additional members that
>>  #            depend on the type tag's value.  Present exactly when
>>  #            @tag is present.  The variants are in no particular orde=
r,
>> @@ -181,6 +188,7 @@
>>  { 'struct': 'SchemaInfoObject',
>>    'data': { 'members': [ 'SchemaInfoObjectMember' ],
>>              '*tag': 'str',
>> +            '*default-variant': 'str',
>>              '*variants': [ 'SchemaInfoObjectVariant' ] } }
>> =20
>>  ##
>=20
> I'm afraid this could become awkward later on.  Let me explain.
>=20
> In many programming languages, absent optional arguments / members
> default to a default value specified in the declaration.  Simple.
>=20
> In others, 'absent' is effectively an additional value.  The code
> consuming the argument / member can interpret 'absent' however it wants=
=2E
> It may eliminate the additional value by mapping it to a default value,=

> but it can also interpret 'absent' unlike any value.  If there's more
> than one consumer, their interpretations need not be consistent.  The
> declaration provides no clue on semantics of 'absent'.
>=20
> QAPI is in the latter camp.  I trust you can already sense how much I
> like that.
>=20
> Now you want to permit optional variant discriminators.  As per general=

> rule, their interpretation is left to the code consuming it.  One
> instance of such code is the generated union visitor, which needs to
> decide which variant to visit.  Your default-variant tells it which
> variant to visit.  Other code interpreting the discriminator better be
> consistent with that, but that's the other code's problem.  Hmm.
>=20
> If I could go back in time, I'd flip QAPI to "'absent' defaults to a
> default value".  Lacking a time machine, we're stuck with cases of
> "'absent' means something you can't express with a value" and "'absent'=

> means different things in different contexts" that have been enshrined
> in external interfaces.  Is there anything we could do to improve
> matters for saner cases?
>=20
> I think there is: we could provide for an *optional* default value.  If=

> the schema specifies it, that's what 'absent' means.  If it doesn't, al=
l
> bets are off, just like they are now.
>=20
> Say we do that (for what it's worth, introspect.json is already prepare=
d
> for it).

If somebody(tm) does that, great. :-)

> How would it play with your default-variant?
>=20
> If an optional discriminator specifies a default value, then that's the=

> default variant.  But wait, if there's also a default-variant, *that's*=

> the default variant!  Awkward clash.  To resolve it, we could either
> forbid combining the two, or rule default-variant overrides the default=
=2E
> Feels needlessly complicated.

I agree on the needless, not so sure about the complicated.  (Other than
it being double the work, but, well, the default-variant work is already
right here.)

> Could we get away with "if you want a default variant, the discriminato=
r
> must specify a default"?

I think so, yes.  I agree that it'd be the better solution.  But to be
honest I'd really rather not delve any deeper into the QAPI dungeon than
I've done in this series so far...

Max


--Taf9dARQg57mzYBC0vZCiDQw7M70Lo0IT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxdyLoACgkQ9AfbAGHV
z0CrEwf8DsHY6uAdQHLDhU1BKwEQ1aW1E0bzxQNjtEFFEixzrLi5NLBy3INR71hC
pRufF1EvLRI53UBHSrN4Fy4ndOCw0J6KpykJQxiAA6fd0VKejmuDbSWQc1RjnDBt
E3ST1LkWejXXJuBJolhZ4sHV2B+nMA/xw86hYGDD7KE4Mc4znRelSku7NVM9NMLC
Rq8QVKXOl8cCXT+oCyRul6YvhG1yZ3LamRTJPLWRTg3nZ9x8iAn424mLaOgHpdTb
pemwNjSrWqoniKk2NJF91jnmrtc5MT883ao939KK/ELlak8U19jJ9pwjXqc99ip+
7awiA9RYUvYzjO6NEq4EmS961RB9CQ==
=azVk
-----END PGP SIGNATURE-----

--Taf9dARQg57mzYBC0vZCiDQw7M70Lo0IT--
