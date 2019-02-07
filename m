Received: from eggs.gnu.org ([209.51.188.92]:56876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grkFn-0001JX-Ih
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grkFh-0008Rm-5X
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:02:09 -0500
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-2-mreitz@redhat.com>
	<87mun8jddk.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <041a22c8-ae8d-2a25-736d-2ef4e3dc2f8b@redhat.com>
Date: Thu, 7 Feb 2019 08:01:50 -0600
MIME-Version: 1.0
In-Reply-To: <87mun8jddk.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kbZZNk5EwamoO1OV9OcGhjcml3FIQ9jTr"
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
To: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kbZZNk5EwamoO1OV9OcGhjcml3FIQ9jTr
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <041a22c8-ae8d-2a25-736d-2ef4e3dc2f8b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] qapi: Add default-variant for flat
 unions
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-2-mreitz@redhat.com>
 <87mun8jddk.fsf@dusky.pond.sub.org>
In-Reply-To: <87mun8jddk.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 12:56 AM, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> This patch allows specifying a discriminator that is an optional membe=
r
>> of the base struct.  In such a case, a default value must be provided
>> that is used when no value is given.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---

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

And we already have the planned syntax, thanks to our recent work on
adding conditionals - where we now have:

{ '*field': 'mytype' }

we can also do long-hand:

{ { 'name': '*field', 'type': 'mytype' } }

which also lends itself well to declaring a default:

{ { 'name': '*field', 'type': 'mytype', 'default': 'xyz' } }

>=20
> Say we do that (for what it's worth, introspect.json is already prepare=
d
> for it).  How would it play with your default-variant?
>=20
> If an optional discriminator specifies a default value, then that's the=

> default variant.  But wait, if there's also a default-variant, *that's*=

> the default variant!  Awkward clash.  To resolve it, we could either
> forbid combining the two, or rule default-variant overrides the default=
=2E
> Feels needlessly complicated.
>=20
> Could we get away with "if you want a default variant, the discriminato=
r
> must specify a default"?

I like the idea. It means finally biting the bullet and implementing
default values, but we've known we've wanted them for a while (as
evidenced by the existing introspection output, and by the syntax that
we have ready to put into use for it).

It means that representing the default variant in a union now depends on
the base class declaring a default for the optional parameter (that is,
an optional parameter can only be used as discriminator if it has a
declared default), and gives us variable defaults in more uses than just
unions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--kbZZNk5EwamoO1OV9OcGhjcml3FIQ9jTr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcOk4ACgkQp6FrSiUn
Q2rMxQf8DYdmZry6VzJ2FE9HtzsbHdHlvkyemIuFAO0p44vaTW4IYEnHzI1/9Xk+
Q6BDpaBd62kwYXPUDH9GAjJuDSX8wPLfNeMGjakXH8kKecuElhR/SBYNlrnAeAPZ
fE+KxUxMAqBMHzh3KUdmp4W5NILL2harI+XMsEYUrASiWP/KcjlQY5iTpJ+FEjZ9
egEupfhDiu1+oj2+P2s6Y374V9qTRNHW6cJzQfpVICszbp2zynToUGwXJiM5cfGJ
/T8ryt9VBtxipoKoId4QjlekAPXhuL5NKZ8ovx/SKFnlK5WoVSNdbOhsjYQdaLio
0/TsL6kmscNkiii82ADaG3G2X2MbIg==
=yftR
-----END PGP SIGNATURE-----

--kbZZNk5EwamoO1OV9OcGhjcml3FIQ9jTr--
