Received: from eggs.gnu.org ([209.51.188.92]:38503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWyd-0004ey-Vd
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWyc-0004Yy-VX
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:26:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkWyc-0004QM-L0
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:26:38 -0500
References: <20190118132750.25932-1-peter.maydell@linaro.org>
	<64316a28-affa-11ca-2d25-5a34a7787a4a@redhat.com>
	<CAFEAcA_SQ_zMeGxoTb4sYchv_7K=eNTV5XCUTjSp1mz7-igzng@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1ea9ac6-37b3-5c74-fb54-16ad12e1582e@redhat.com>
Date: Fri, 18 Jan 2019 10:26:31 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_SQ_zMeGxoTb4sYchv_7K=eNTV5XCUTjSp1mz7-igzng@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2i6CaWdVT0YVS2OMiiWTAwLDMGnOWbUYR"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Don't spuriously warn about
 /** comment starters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Reported-by : Thomas Huth" <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2i6CaWdVT0YVS2OMiiWTAwLDMGnOWbUYR
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Reported-by : Thomas Huth" <thuth@redhat.com>,
 "patches@linaro.org" <patches@linaro.org>
Message-ID: <d1ea9ac6-37b3-5c74-fb54-16ad12e1582e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Don't spuriously warn about /**
 comment starters
References: <20190118132750.25932-1-peter.maydell@linaro.org>
 <64316a28-affa-11ca-2d25-5a34a7787a4a@redhat.com>
 <CAFEAcA_SQ_zMeGxoTb4sYchv_7K=eNTV5XCUTjSp1mz7-igzng@mail.gmail.com>
In-Reply-To: <CAFEAcA_SQ_zMeGxoTb4sYchv_7K=eNTV5XCUTjSp1mz7-igzng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 10:08 AM, Peter Maydell wrote:

>>> The sequence "/\*\*?" was intended to match either "/*" or "/**",
>>> but Perl's semantics for '?' allow it to backtrack and try the
>>> "matches 0 chars" option if the "matches 1 char" choice leads to
>>> a failure of the rest of the regex to match.  Switch to "/\*\*?+"
>>> which uses what perlre(1) calls the "possessive" quantifier form:
>>> this means that if it matches the "/**" string it will not later
>>> backtrack to matching just the "/*" prefix.
>>
>> Just wondering if "/\*{1,2}" would also work (it may have to be spelle=
d
>> "/\*\{1,2}" - I never remember which flavors of regex have which
>> extensions without rereading docs)
>=20
> Oh yes, that would probably be the less perl-specific way
> to write it.

Except it would probably fail in the same way as the non-greedy \*? -
when \*{2} can't satisfy the regex, the engine will retry with \*{1} and
then see the second * as noise.


>>>               # Block comments use /* on a line of its own
>>>               if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&      #inline=
 /*...*/
>>> -                 $rawline =3D~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /*=
 or /** non-blank
>>> +                 $rawline =3D~ m@^\+.*/\*\*?+[ \t]*.+[ \t]*$@) { # /=
* or /** non-blank
>>
>> Hmm - Isn't "[ \t]*.+[ \t]*$" the same as ".+$?"
>=20
> (do you mean '$?"' at the end of your sentence, or '$" ?' ?)

Serves me right for adding "" after the fact.  You are correct, intended
punctuation should be ".+$"? (the 3-character regex, concluded by asking
a question if the 3-character form is the same as the 15-character
form), and where I should have gone further and asked if it was the same
as "." (since who cares whether there are more than one extra characters
between there and the end of the line - once we've found any character
at all, we've already found enough to flag the line).

>=20
> I'm not sure exactly what I was aiming for with that
> part of the regex when I wrote it. The comment suggests
> that I was looking for "non-blank", ie I didn't want to
> fire on /* or /** followed by just trailing whitespace.
> The regex as written is clearly not actually doing that,
> though...

Trailing whitespace is generally a problem anyways, though :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2i6CaWdVT0YVS2OMiiWTAwLDMGnOWbUYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxB/jcACgkQp6FrSiUn
Q2oROgf+JQsRDKX7c8lsJZGliSj2xGH3vYlP8NeYfvivFztQVGM606ZAjyZLbZg4
FLkl3f67XY4Sk9nMn1VV6glfRJO06anG/NhKTAwriryuxZm6Gl5CosJYgwo28UnA
HVp0w388jezgsdXfj0Xodab6dKEe8RBt5g42J7BDZoHFplbYH6GBZkwgeyn7qbzt
0S8rrxXF/UsKuBl2/z0gnF+4ncPzEFcM9pTYzMUMnoK66FzeybX0J11kkfJZrdgG
WrSJsR4SzzhKFoiN5LI5ZxajkJnluitoDW5ZoZgeimPfQELaFE/4X1tpWGnDAa1T
yYY3dbs6Ltkun/jdMRtEQlXgQax8Cw==
=RLKQ
-----END PGP SIGNATURE-----

--2i6CaWdVT0YVS2OMiiWTAwLDMGnOWbUYR--
