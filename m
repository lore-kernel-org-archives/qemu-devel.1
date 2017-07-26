Received: from eggs.gnu.org ([2001:4830:134:3::10]:52905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1daB0x-0007X2-Pa
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1daB0t-0003I7-Qo
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:21:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1daB0t-0003Gi-Gl
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:21:23 -0400
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
	<20170717103308.GI7163@stefanha-x1.localdomain>
	<8760epr9vw.fsf@dusky.pond.sub.org>
	<20170721153331.GL18014@stefanha-x1.localdomain>
	<026a093f-1f79-4af9-a5c9-d540342b472e@redhat.com>
	<8760eiuxu5.fsf@dusky.pond.sub.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <9d4a3015-a3d2-e9d5-2254-0bcb77b37161@redhat.com>
Date: Tue, 25 Jul 2017 21:21:13 -0400
MIME-Version: 1.0
In-Reply-To: <8760eiuxu5.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UMCgWHnApOqvBMR9sTnTbiwhHcQWpd4Qb"
Subject: Re: [Qemu-devel] Improving QMP test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <cleber@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UMCgWHnApOqvBMR9sTnTbiwhHcQWpd4Qb
From: Cleber Rosa <crosa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?=
 <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <cleber@redhat.com>
Message-ID: <9d4a3015-a3d2-e9d5-2254-0bcb77b37161@redhat.com>
Subject: Re: [Qemu-devel] Improving QMP test coverage
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
 <20170717103308.GI7163@stefanha-x1.localdomain>
 <8760epr9vw.fsf@dusky.pond.sub.org>
 <20170721153331.GL18014@stefanha-x1.localdomain>
 <026a093f-1f79-4af9-a5c9-d540342b472e@redhat.com>
 <8760eiuxu5.fsf@dusky.pond.sub.org>
In-Reply-To: <8760eiuxu5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 07/24/2017 02:56 AM, Markus Armbruster wrote:
> Test code language is orthogonal to verification method (with code
> vs. with diff).  Except verifying with shell code would be obviously
> nuts[*].
>=20
> The existing iotests written in Python verify with code, and the ones
> written in shell verify with diff.  Doesn't mean that we have to port
> from Python to shell to gain "verify with diff".
>=20

The fact that they are still subject to "verify with diff" is
interesting.  IMO, exit status makes a lot more sense.

I only raised this point, and gave my opinion, because:

1) Shell based tests *with* output check has a lot of use cases and
proven value
2) Python based tests *without* output check also have use cases and valu=
e

To me, this shows that language flexibility is a must, and output check
can be an unnecessary burden.  If at all possible, it should be optional.=


Implementation-wise, this seems pretty simple.  Tests based on any
language can communicate the basic success/failure by exit status code
and/or by recorded output.  If the ".out" file exists, let's use it, if
not, fallback to exit status (or the other way around, as long as it's
predictable).  For instance, the current implementation of
iotests.main() discards the exit status that could be one of the
PASS/FAIL criteria.

> I don't doubt that featureful test frameworks like Avocado provide
> adequate tools to debug tests.  The lure of the shell is its perceived
> simplicity: everybody knows (well, should know) how to write and debug
> simple shell scripts.  Of course, the simplicity evaporates when the
> scripts grow beyond "simple".  Scare quotes, because what's simple for
> Alice may not be so simple for Bob.
>=20

Agreed.  That's why I avoided "simple" and "complex" in my previous
messages.  A statement such as "tool XYZ usually scales better" has
bigger chances of being agreed upon by both Alice and Bob.

>> BTW, I'll defer the discussion of using an external tool to check the
>> output and determine test success/failure, because it is IMO a
>> complementary topic, and I believe I understand its use cases.
>=20
> Yes.  Regardless, I want to tell you *now* how tired of writing code to=

> verify test output I am.  Even of reading it.  Output text is easier to=

> read than code that tries to verify output text.  Diffs are easier to
> read than stack backtraces.
>=20

Point taken.  And truth be told: the current shell based qemu-iotests
excel at this, with its simple and effective "run_qemu <<<QMP_INPUT"
pattern.  The cons are:

1) Some use cases do not fall so nicely in this pattern, and end up
requiring workarounds (such as filters)

2) The expected output is not readily accessible

Considering that for the specific case of tests targeting QMP, most of
the action comes down to the message exchanges (commands sent, response
received), how would you feel about a descriptive approach to the
communication?  Something along these lines:

"""
-> { "execute": "change",
     "arguments": { "device": "ide1-cd0",
                    "target": "/srv/images/Fedora-12-x86_64-DVD.iso" } }
<- { "return": {} }
"""

If this looks familiar, that's because it is a snippet from the
qapi-schema.json file.  It's documentation, so it should mean that's
easy to read, *but*, there's no reason this can not be treated as code to=
o.

This approach is similar to Python's doctest[1], in which a docstring
contains snippets of Python code to be evaluated, and the expected
outcome.  Example:

def factorial(n):
    """Return the factorial of n, an exact integer >=3D 0.

    If the result is small enough to fit in an int, return an int.
    Else return a long.

    >>> [factorial(n) for n in range(6)]
    [1, 1, 2, 6, 24, 120]
    """

The lines that match the interpreter input will be evaluated, and the
subsequent lines are the expected output.

I don't think all QMP tests can be modeled like this, inside literal
strings, but having blocks that can be used when it makes sense seems
logical to me.  Pseudo code:

test_change() {

  init_qemu()
  failUnless(fileExists('/srv/images/Fedora-12-x86_64-DVD.iso'))

  qmp("""
-> { "execute": "change",
     "arguments": { "device": "ide1-cd0",
                    "target": "/srv/images/Fedora-12-x86_64-DVD.iso" } }
<- { "return": {} }
""")

  check_qemu_has_fd_open_for_iso()
}

IMO, the qmp() function can provide similar quality of readability to dif=
f.

How does it sound?  As with previous interactions, if people see value
in this, I can certainly follow up with a PoC.

>> [1] -
>> http://avocado-framework.readthedocs.io/en/52.0/api/utils/avocado.util=
s.html#avocado.utils.process.run
>> [2] -
>> http://avocado-framework.readthedocs.io/en/52.0/WritingTests.html#adva=
nced-logging-capabilities
>> [3] - https://www.youtube.com/watch?v=3DhtUbOsh8MZI
>=20
> [*] Very many nutty things are more obviously nuts in shell.  It's an
> advantage of sorts ;)
>=20

We all know a number of amazing software that gets written using the
most improbable tools and languages.  It makes the world a much more
interesting place!

[1] - https://docs.python.org/2/library/doctest.html

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--UMCgWHnApOqvBMR9sTnTbiwhHcQWpd4Qb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZd+6JAAoJEGV+jTOl8gnzHYwP/A0Nt0OyflgIE9jjvqOEoN7Y
cbBR5lywbBtDpI/XF+2BKpQDASjUGu8Ua8jRxQv+NXN95vdWQTQ11JSKwnsgsg+Z
SzQ6svzvr3YA3q6xTwTy8yrE2aEAzUTztVhsJ6mPej/hytbIXqlQZBKL1OMy6A3f
ehMjLYI81jl2nOQUzqAdj2Kn8D0y8kNhGfHk2Q3vfwy2sVhvWxKuZZyFSyDmoIrv
U0+AGCczAOvEwrFfOkFU2UyZcuVevGxd/aJDh/9rSeRwJKipJ64TTiH2pOJ09AjZ
nP5vpCIZBq+vmCI3Wp0RynSWB1Ns+HJChhwwiSD45giN/6jKEeVXtEk4ScoiwoZU
JaX5CxJ0t7AiEQMdGQCyj5jwMCoqc9A8MYtxIvuEh8xsdLF8+QBBzHSr2Gv10374
+N+ZS7QQ45I9EM7zu1tIUpBwlYVFgxFRy/nbpLKvPnXPurO1zfcxxfvQNgMS3egO
hBdoTcWlRQaI2K6iCHHtJ93wnXw/Hx5icRusgdusdXHoLvujtQq0mw/NuHi+bjSJ
u1BAtg1F4ZCJQBouw1WqI8apnMF8GzGLYAdAcZ7DR/hf+/lfpLyl8rqkO4SLuRtw
ek6ix71tiLfQsG9Ovevwl+YgwHsLono12jjP9aYLyGw58mzvCDWA9LNjrLG7i8a+
yBfrzYdJ6vplG8LxVh+t
=m8hT
-----END PGP SIGNATURE-----

--UMCgWHnApOqvBMR9sTnTbiwhHcQWpd4Qb--
