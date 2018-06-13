Received: from eggs.gnu.org ([2001:4830:134:3::10]:40950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fT6P0-00082X-Ui
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fT6Ou-0004lx-By
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:05:34 -0400
References: <20180611205203.2624-1-mreitz@redhat.com>
	<20180611205203.2624-2-mreitz@redhat.com>
	<87efhct4bp.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8bf670bb-33ac-3243-ef67-718004ab4467@redhat.com>
Date: Wed, 13 Jun 2018 16:05:18 +0200
MIME-Version: 1.0
In-Reply-To: <87efhct4bp.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DhuvhljXjX5PTgwi76zqEuWewIRp2YtTV"
Subject: Re: [Qemu-devel] [PATCH v2 01/10] qapi: Add default-variant for
 flat unions
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
--DhuvhljXjX5PTgwi76zqEuWewIRp2YtTV
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <8bf670bb-33ac-3243-ef67-718004ab4467@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/10] qapi: Add default-variant for flat
 unions
References: <20180611205203.2624-1-mreitz@redhat.com>
 <20180611205203.2624-2-mreitz@redhat.com> <87efhct4bp.fsf@dusky.pond.sub.org>
In-Reply-To: <87efhct4bp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-12 17:25, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> This patch allows specifying a discriminator that is an optional membe=
r
>> of the base struct.  In such a case, a default value must be provided
>> that is used when no value is given.
>=20
> Hmm.  Can you explain why you need this feature?

Define "need".

Most block drivers support exactly the same syntax with -drive and with
-blockdev.  Type confusion occurs, but at least the options are the same.=


One notable example is rbd's =3Dkeyvalue-pairs, but we all probably agree=

on the fact that it's just broken and we don't have to care too much.

The other case I noticed (and so far the only other case I know of
besides =3Dkeyvalue-pairs) is qcow(2) encryption.  The qcow(2) driver
allows you to specify different parameters under @encrypt depending on
the encryption format, so that naturally becomes a flat union with
encrypt.format being the discriminator.

Now when opening a qcow(2) file, the header already gives you the
encryption format (always qcow AES for qcow v1, qcow AES or LUKS for
qcow2), so the user technically doesn't need to specify it.  And that is
what the qcow(2) driver allows on the command line: The user does not
need to specify the format as it can be inferred from the header, and
the union is interpreted accordingly.  Of course, that doesn't fly with
-blockdev.

Now luckily both AES and LUKS only allow you to specify a key-secret
option.  Therefore, with an optional discriminator, we can define a
default variant that just has this key-secret option.  This is what this
patch is needed for.  It allows full compatibility to the current
interface, although it means we'll have to watch out when adding
encryption options in the future.

The alternative I saw was to decide that auto-detection was a bad idea
and to make encrypt.format mandatory for -drive.  Maybe I would have
taken that approach had I known how little I know about the QAPI
generator at this point.  But after I'd started, it was a challenge, so
I continued down that other path.  Anyway, the problem with this
approach would be obviously compatibility breakage, and also being a bit
cumbersome.  ("Why would you need to specify encrypt.format when it's
all in the image header anyway?")


Short answer: The current QAPI schema for qcow2 is incompatible to what
it allows with -drive, this patch allows making it compatible -- and we
need both to be compatible if we ever want BlockdevOptions throughout
the block layer.

>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qapi/introspect.json           |  8 +++++
>>  scripts/qapi/common.py         | 57 ++++++++++++++++++++++++++++-----=
-
>>  scripts/qapi/doc.py            |  8 +++--
>>  scripts/qapi/introspect.py     | 10 ++++--
>>  scripts/qapi/visit.py          | 13 ++++++++
>>  tests/qapi-schema/test-qapi.py |  2 ++
>>  6 files changed, 83 insertions(+), 15 deletions(-)
>=20
> The documentation update is in the next patch, and tests are in the
> patch after next.  I'd squash all three.

I don't mind.

(I just like to split patches in advance, because squashing is always eas=
y.)

>> diff --git a/qapi/introspect.json b/qapi/introspect.json
>> index 80a0a3e656..b43c87fe8d 100644
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
>> +#                   (Since: 3.0)
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
> Until now, the QAPI schema doesn't let you specify default values.
> Instead, code sees "absent", and does whatever needs to be done.
> Sometimes, it supplies a default value.  "Absent" is shorthand for this=

> value then.  Sometimes, it behaves differently than for any value.
> "Absent" is a distinct additional case then.  I'm not too fond of the
> latter case, but it's what we have, and it's not going away.

Just a note: In v1 of this series, it was possible to detect when the
variant was indeed absent.  Eric proposed just setting the member to the
default value when absent (because he too is not too fond of that case),
so here in v2 there is no difference between setting the value to its
default value or not specifying it.

> We've discussed extending the QAPI schema to let you specify default
> values.  Two advantages: the default value is *specified* rather than
> just documented (or not, when documentation sucks), and we can supply
> the default value in generated code.  The introspection schema is even
> prepared for this:
>=20
>     ##
>     # @SchemaInfoObjectMember:
>     #
>     # An object member.
>     #
>     # @name: the member's name, as defined in the QAPI schema.
>     #
>     # @type: the name of the member's type.
>     #
> --> # @default: default when used as command parameter.
>     #           If absent, the parameter is mandatory.
>     #           If present, the value must be null.  The parameter is
>     #           optional, and behavior when it's missing is not specifi=
ed
>     #           here.
>     #           Future extension: if present and non-null, the paramete=
r
>     #           is optional, and defaults to this value.
>     #
>     # Since: 2.5
>     ##
>=20
> The idea was to turn
>=20
>     '*name': 'type'
>=20
> into sugar for
>=20
>      'name': { 'type': 'type', 'optional': true }
>=20
> then extend it to
>=20
>      'name': { 'type': 'type', 'optional': true, 'default': JSON-VALUE =
}
>=20
> where JSON-VALUE null means behavior for "absent" is not specified.

Seems reasonable.

> Your patch adds default values in a different way, and for just for
> union tags.  For the QAPI language, that's not necessarily a deal
> breaker, as we don't need to maintain backward compatibility there.  Bu=
t
> for the introspection schema, we do.  Once we add @default-variant,
> we're stuck with it.  Even though it's redundant with
> SchemaInfoObjectMember's @default.

I too would like a general solution better.  Of course the question is
how far off such a general solution is.  It's not like I consider this
series extremely urgent, but I do have a BZ assigned for it, so take
that as you will. O:-)

So between the lines I'd like to think I can read that it would be
"fine" to add default-variant for now, but to omit it from introspection?=


Max

> I'm skipping review of the implementation for now


--DhuvhljXjX5PTgwi76zqEuWewIRp2YtTV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlshJJ4ACgkQ9AfbAGHV
z0AkDwgAl/A557mUjZtyfTKXI4pAouBJ4dnd1XuEXmPoAS8ueHgv0NZlNtCnfnH8
Slh8Vmv0qgK8egPPyatTvkjVM8bTUtc4LpTXz/Kotclq/lCX/ycrakxfYpPvW4x8
UpG9b16gMNbqYJH4+fxIwqk+/zUwV89wKl+eeNxBUEVGJDSTe/XxB1DshPRBu7tz
IsO2LCMHjHCUXdQyYrsxgPOW6i7K2B3DO2KCw43WK71ZI6H+9dV91aVGhgg6ULU2
ic8hjygHZwLONxT53cZIJoS2OJdAQp0m9KliLmciI0qnsc6bcrzbxThu8LiejxdZ
6PlXA0kDgenGTpbkYhwru0F0ERNbvA==
=E9zB
-----END PGP SIGNATURE-----

--DhuvhljXjX5PTgwi76zqEuWewIRp2YtTV--
