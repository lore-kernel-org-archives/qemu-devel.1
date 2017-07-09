Received: from eggs.gnu.org ([2001:4830:134:3::10]:51812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUG8A-0005M9-4u
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUG88-0006LB-OA
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:36:26 -0400
References: <20170705190404.22449-1-mreitz@redhat.com>
	<20170705190404.22449-3-mreitz@redhat.com>
	<87poddk583.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6a1740fd-2a8c-f338-6ce1-e0f4bbade407@redhat.com>
Date: Sun, 9 Jul 2017 19:36:12 +0200
MIME-Version: 1.0
In-Reply-To: <87poddk583.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8LaS78NhVaS6OnLAgpU9vvS5FXh9wiPHT"
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8LaS78NhVaS6OnLAgpU9vvS5FXh9wiPHT
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <6a1740fd-2a8c-f338-6ce1-e0f4bbade407@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qapi: Add qobject_is_equal()
References: <20170705190404.22449-1-mreitz@redhat.com>
 <20170705190404.22449-3-mreitz@redhat.com>
 <87poddk583.fsf@dusky.pond.sub.org>
In-Reply-To: <87poddk583.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-06 16:30, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> This generic function (along with its implementations for different
>> types) determines whether two QObjects are equal.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> Markus also proposed just reporting two values as unequal if they have=
 a
>> different internal representation (i.e. a different QNum kind).
>>
>> I don't like this very much, because I feel like QInt and QFloat have
>> been unified for a reason: Outside of these classes, nobody should car=
e
>> about the exact internal representation.  In JSON, there is no
>> difference anyway.  We probably want to use integers as long as we can=

>> and doubles whenever we cannot.
>=20
> You're right in that JSON has no notion of integer and floating-point,
> only "number".  RFC 4627 is famously useless[1] on what exactly a numbe=
r
> ought to be, and its successor RFC 7159 could then (due to wildly
> varying existing practice) merely state that a number is what the
> implementation makes it to be, and advises "good interoperability can b=
e
> achieved" by making it double".  Pffft.
>=20
> For us, being able to represent 64 bit integers is more important than
> interoperating with crappy JSON implementations, so we made it the unio=
n
> of int64_t, uint64_t and double[2].
>=20
> You make a fair point when you say that nothing outside QNum should car=
e
> about the exact internal representation.  Trouble is that unless I'm
> mistaken, your idea of "care" doesn't match the existing code's idea.

I disagree that it doesn't match the existing code's idea.  I think the
existing code doesn't match its idea, but mine does.

> Let i42 =3D qnum_from_int(42)
>     u42 =3D qnum_from_uint(42)
>     d42 =3D qnum_from_double(42)
>=20
> Then
>=20
>     qnum_is_equal(i42, u42) yields true, I think.
>     qnum_is_equal(i42, d42) yields true, I think.
>     qnum_get_int(i42) yields 42.
>     qnum_get_int(u42) yields 42.
>     qnum_get_int(d42) fails its assertion.
>=20
> Failing an assertion qualifies as "care", doesn't it?

It doesn't convert the value?  That's definitely not what I would have
thought and it doesn't make a lot of sense to me.  I call that a bug. :-)=


=46rom the other side we see that qnum_get_double() on all of this would
yield 42.0 without failing.  So why is it that qnum_get_int() doesn't?
Because there are doubles you cannot reasonably convert to integers, I
presume, whereas the other way around the worst that can happen is that
you lose some precision.

But that has no implication on qnum_is_equal().  If the double cannot be
converted to an integer because it is out of bounds, the values just are
not equal.  Simple.

So since qnum_get_double() does a conversion, I very much think that the
reason qnum_get_int() doesn't is mostly "because sometimes it's not
reasonably possible" and very much not because it is not intended to.

>> In any case, I feel like the class should hide the different internal
>> representations from the user.  This necessitates being able to compar=
e
>> floating point values against integers.  Since apparently the main use=

>> of QObject is to parse and emit JSON (and represent such objects
>> internally), we also have to agree that JSON doesn't make a difference=
:
>> 42 is just the same as 42.0.
>=20
> The JSON RFC is mum on that.
>=20
> In *our* implementation of JSON, 42 and 42.0 have always been very much=

> *not* the same.  Proof:
>=20
>     -> { "execute": "migrate_set_speed", "arguments": { "value": 42 } }=

>     <- {"return": {}}
>     -> { "execute": "migrate_set_speed", "arguments": { "value": 42.0 }=
 }
>     <- {"error": {"class": "GenericError", "desc": "Invalid parameter t=
ype for 'value', expected: integer"}}
>=20
> This is because migrate_set_speed argument value is 'int', and 42.0 is
> not a valid 'int' value.

Well, that's a bug, too.  It's nice that we accept things that aren't
quite valid JSON (I'm looking at you, single quote), but we should
accept things that are valid JSON.

> Note that 42 *is* a valid 'number' value.  migrate_set_downtime argumen=
t
> value is 'number':
>=20
>     -> { "execute": "migrate_set_downtime", "arguments": { "value": 42 =
} }
>     <- {"return": {}}
>     -> { "execute": "migrate_set_downtime", "arguments": { "value": 42.=
0 } }
>     <- {"return": {}}
>=20
> Don't blame me for the parts of QMP I inherited :)

I sure don't.  But I am willing to start a discussion by calling that a
bug. ;-)

QNum has only been introduced recently.  Before, we had a hard split of
QInt and QFloat.  So I'm not surprised that we haven't fixed everything y=
et.

OTOH the introduction of QNum to me signals that we do want to fix this
eventually.

>> Finally, I think it's rather pointless not to consider 42u and 42 the
>> same value.  But since unsigned/signed are two different kinds of QNum=
s
>> already, we cannot consider them equal without considering 42.0 equal,=

>> too.
>=20
> Non sequitur.
>=20
>> Because of this, I have decided to continue to compare QNum values eve=
n
>> if they are of a different kind.
>=20
> I think comparing signed and unsigned integer QNums is fair and
> consistent with how the rest of our code works.

I don't see how. doubles can represent different numbers than integers
can. Signed integers can represent different numbers than unsigned can.

Sure, signed/unsigned makes less of a difference than having an exponent
does.  But I don't agree we should make a difference when the only
reason not to seems to be "qemu currently likes to make a difference in
its interface, for historical reasons mainly" and "Do you really want to
write this equality function?  It seems hard to get right".

For the record, I could have lived with the old separation into QInt and
QFloat.  But now we do have a common QNum and I think the idea behind is
is to have a uniform opaque interface.

> Comparing integer and floating QNums isn't.  It's also a can of worms.
> Are you sure we *need* to open that can *now*?

Sure?  No.  Do I want to?  I guess so.

> Are you sure a simple, stupid eql-like comparison won't do *for now*?
> YAGNI!

But I want it.  I think the current behavior your demonstrated above is
a bug and I don't really want to continue to follow it.

All you have really convinced me to do is to add another patch which
smacks a warning on qnum_get_int(), and maybe even a TODO that it should
convert doubles to integers *if possible*.

(And the "if possible" just means that you cannot convert values which
are out of bounds or NaN.  Fractional parts may not even matter much --
I mean, we do happily convert integers to doubles and rounding that way
is implementation-defined.)

Max

> [1] Standard reply to criticism of JSON: could be worse, could be XML.
>=20
> [2] Union of int64_t and double until recently, plus bugs that could be=

> abused to "tunnel" uint64_t values.  Some of the bugs have to remain fo=
r
> backward compatibility.


--8LaS78NhVaS6OnLAgpU9vvS5FXh9wiPHT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZYmmNEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQONh
CACZbX/LNVW3V9CGLH8mohs+DTOC43fPR2vm7lptbxmMMRmqxxHtxvLlH4qjAwv1
YBztcaH46uEmQJ35Xdfbpjbc6y9NBD7Ztsf2d6z3hcuHeBXNhZMipXFskmPsolUs
Ookei+NqwtBTZCXKFHATOzjjytxOcTNUy7+oy0airghPEUrzkuyG18KJvI+RfWrV
/9NzapCDyRC89e8cMKNml1k6+KeZZHnTWMJ6MGTC+rVwA8H1n5XuFnx7as3ce/Ir
cebSOJ1+w5LeD3Ti5roqziyFASRaMiOBiI91oV7oVgZFooJLmjH1Ub8XaoRcyqo2
0X8SQlahdhJqP06rrEBwjrw+
=0fLC
-----END PGP SIGNATURE-----

--8LaS78NhVaS6OnLAgpU9vvS5FXh9wiPHT--
