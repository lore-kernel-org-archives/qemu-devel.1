Received: from eggs.gnu.org ([2001:4830:134:3::10]:54561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcFVX-0006gS-EI
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcFVW-0003w1-C1
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:33:35 -0400
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-10-eblake@redhat.com>
	<20170728130538.GQ12364@stefanha-x1.localdomain>
	<3c27944c-bb18-a501-39b5-139059a4aa85@redhat.com>
	<307cae51-da45-4968-f6c9-4fa1ad4b22f8@redhat.com>
	<878tj5awtc.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e063a047-d587-9d05-842d-acea8cd8ecde@redhat.com>
Date: Mon, 31 Jul 2017 13:33:24 -0500
MIME-Version: 1.0
In-Reply-To: <878tj5awtc.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="buww42L24t9nB2FBtH23SbG4GoH29FTpX"
Subject: Re: [Qemu-devel] [PATCH v3 09/12] tests/libqos/pci: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, stefanha@redhat.com, qemu-devel@nongnu.org, "open list:virtio-blk" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--buww42L24t9nB2FBtH23SbG4GoH29FTpX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org, "open list:virtio-blk" <qemu-block@nongnu.org>
Message-ID: <e063a047-d587-9d05-842d-acea8cd8ecde@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/12] tests/libqos/pci: Clean up string
 interpolation into QMP input
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-10-eblake@redhat.com>
 <20170728130538.GQ12364@stefanha-x1.localdomain>
 <3c27944c-bb18-a501-39b5-139059a4aa85@redhat.com>
 <307cae51-da45-4968-f6c9-4fa1ad4b22f8@redhat.com>
 <878tj5awtc.fsf@dusky.pond.sub.org>
In-Reply-To: <878tj5awtc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 02:29 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 07/28/2017 11:35 AM, Eric Blake wrote:
>>>>> +    QObject *extra_args =3D qobject_from_jsonf("{ 'shm': '%s', 'si=
ze': '1M' }",
>>>>> +                                             tmpshm);
>>>>
>>
>>> Passing '%s' through qobject_from_jsonf() is generally wrong (it woul=
d
>>> produce ''...'' instead of the intended '...').
>>>
>>> Looks like something to fix on the next round.
>>>
>>
>> What's scary is that the testsuite didn't start failing.  That's not
>> good; we'll want to figure out why the bug didn't impact the test.
>=20
> Good idea.

The intended result: the created QDict would include
"shm":"/qtest-11387-3641365368" (or comparable string).  The actual
result: the created QDict includes "shm":"%s" - a literal 2-character
string, because the lexer does not do interpolation inside strings.  And
apparently, naming your ivshmem shared memory a literal "%s" (rather
than a name beginning with "/") is not a semantic error, so the test pass=
es.

In other words, qobject_from_jsonf() does NOT do % interpolation of
anything embedded inside '', and basically blindly ignores the tmpshm
vararg.  It would be neat if we could make qobject_from_jsonf() detect a
mismatch in varargs, even though we don't (can't) require a NULL
sentinel (we're limited to fitting in with -Wformat paradigms already).
So while we can't flag it at compile time, I do think we can flag it at
runtime: if, in qobject_from_jsonf() (but NOT in qobject_from_json()),
we reject any JSON string from the lexer that contains "%" but not "%%",
we will have caught all the places where gcc paired a % sequence with a
vararg parameter even though our lexer did not make the same pairing.
If we WANT a literal % in a string (rare, probably only in the
testsuite), we write it as %% and then qobject_from_jsonf() interpolates
it.  Then, since bare % is NOT valid JSON, we don't have to enhance the
lexer to recognize anything new; our changes are limited to
documentation and the vararg parser.  It still means we only get a
runtime, rather than a compile-time, detection of misuse of % passed to
the format argument, but it should be an easy enough proof of concept
that such a runtime failure would have been enough to make ivshmem-test
fail and flag the error during 'make check' rather than escaping review.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--buww42L24t9nB2FBtH23SbG4GoH29FTpX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/d/QACgkQp6FrSiUn
Q2rcQgf+OJbWrT8Sl7piUzGWdrM3hPyA7FPWEhEeIdnOngizeoR37yAJzxHUq/Tf
fp5QMlHrUAc2lxOX7Yw6deU2zbmY9wqc6eDbdVJJZfK8ch9nvvpF6I6l1xdH/MDp
j0jdmotR+p7WjH63JHlTtH7tg2zpV5mJin90uMw9tek57HVeiDyXfdVZj2f4u0PZ
Y0KIwinpvaYJLjsAZs7+2WE43TzKsMBU24BA4en64sNsiJIDOvQhgBQtRb46UpUR
eX2H4ztf20zEf4cXsb99eWMQTPg6SV0TJ3BT3cwYIwlv/s8mdoof5FTyATAMETrf
jYMetSFCwP7+w8GELNyo9pzOq4DtxQ==
=dHLv
-----END PGP SIGNATURE-----

--buww42L24t9nB2FBtH23SbG4GoH29FTpX--
