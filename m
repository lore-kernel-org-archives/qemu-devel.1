Received: from eggs.gnu.org ([2001:4830:134:3::10]:54039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkdEG-0002IH-RQ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 17:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkdEF-0003Q8-Nl
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 17:30:24 -0400
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-9-eblake@redhat.com>
	<e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
	<da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
	<c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
	<5d84655b-d82a-956a-f434-023961b23552@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ffb6aab-09a0-7136-946f-f68f7478c0f7@redhat.com>
Date: Wed, 23 Aug 2017 16:30:12 -0500
MIME-Version: 1.0
In-Reply-To: <5d84655b-d82a-956a-f434-023961b23552@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9igb4DuhFCfOCjVjvPkPkHfD3G52MvQsG"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 08/13] tests: Rely more on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9igb4DuhFCfOCjVjvPkPkHfD3G52MvQsG
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>
Message-ID: <2ffb6aab-09a0-7136-946f-f68f7478c0f7@redhat.com>
Subject: Re: [Qemu-block] [PATCH v5 08/13] tests: Rely more on global_qtest
References: <20170818211542.5380-1-eblake@redhat.com>
 <20170818211542.5380-9-eblake@redhat.com>
 <e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
 <da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
 <c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
 <5d84655b-d82a-956a-f434-023961b23552@redhat.com>
In-Reply-To: <5d84655b-d82a-956a-f434-023961b23552@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 03:02 PM, Paolo Bonzini wrote:
> On 23/08/2017 21:26, Eric Blake wrote:
>>> I agree with using the short form where possible, but I disagree on
>>> removing the long forms.  Rather, global_qtest in my opinion should h=
ave
>>> been static (though I'm not proposing that you do this); inlining the=

>>> wrappers is not needed for performance.
>> But no one outside of libqtest.c is using the long form.  Maintaining =
a
>> long form that isn't used is counter-productive, if the short form is
>> good enough for everything we need.
>=20
> Well, whatever is assigning to global_qtest should be using the long fo=
rm.

Question - what about going the other way, and switching ALL callers to
always use the explicit form?  I'd really like to maintain only one
form, but if we think maintaining the explicit form is better, then I'd
rather see:

s =3D qtest_init(...);
qmp(s, "{'execute':'foo'}");

than:

qtest_init(...); // implicitly sets global_test
qmp("{'execute':'foo'}"); // implicitly uses global_test

and not the existing:

qtest_init(...);
qtest_qmp(global_test, "{'execute':'foo'}");

Then, in combination with my other series to make qmp() more friendly,
it would look like:

s =3D qtest_init(...);
qmp(s, "foo");

Or, put another way, I'd rather have the short name irq_intercept_in()
than the long name qtest_irq_intercept_in(); but as long as we maintain
only ONE set of names, then I'm okay having that one set always be
explicit about passing QTestState *s as a parameter and completely
getting rid of the global_test variable (rather than making it static).

But whatever we decide, we'll want to stick to it, and it may require a
respin - so let's get a consensus before I do any more churn on this seri=
es.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9igb4DuhFCfOCjVjvPkPkHfD3G52MvQsG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmd8+QACgkQp6FrSiUn
Q2raMQgAmS5twm6lPx/7bFJMHU+Jl9/ji9hrr+8Qw560PPm/+MlqjUXzrvob3vd6
sNY+zWBcuY38hVHAad5rTVa2xrp3YbqR3w6XgZlPE/20hJrGdMaTwy2eG/xGd3op
QiekJc+SHTLvmEtpsPLCTFZFJBGqfn+fCAD3YnJwXCmw0IDFtJfUamh12eZFHjQ5
WmcozsBGD5HYVXRFw/c+gt90hYqy4/vMpaCbuX5PkWs7v6cyessh61WFpxsAeAYu
PUK6flsQZPfTFGwdIx72zS6wcapmQr9bX3p1Y0Th5ftlXZQ8UU+VfoJ8LxL5+N5o
3IKTfw5hWXmXyH4pGNmiSWs6pM74og==
=+79j
-----END PGP SIGNATURE-----

--9igb4DuhFCfOCjVjvPkPkHfD3G52MvQsG--
