Received: from eggs.gnu.org ([2001:4830:134:3::10]:41221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAcd-0006Rf-NJ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAcc-0006rk-Ir
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:08:27 -0400
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-9-eblake@redhat.com>
	<87k22sjsu4.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <176555af-931f-213e-c8f5-190d4e03bb13@redhat.com>
Date: Fri, 28 Jul 2017 14:08:12 -0500
MIME-Version: 1.0
In-Reply-To: <87k22sjsu4.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0HvUDrEpvtD3EcPXMcWMjh13aTJNJID2x"
Subject: Re: [Qemu-devel] [PATCH v3 08/12] qtests: convert tests to use
 qmp_cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0HvUDrEpvtD3EcPXMcWMjh13aTJNJID2x
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>,
 John Snow <jsnow@redhat.com>, stefanha@redhat.com
Message-ID: <176555af-931f-213e-c8f5-190d4e03bb13@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/12] qtests: convert tests to use
 qmp_cmd
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-9-eblake@redhat.com> <87k22sjsu4.fsf@dusky.pond.sub.org>
In-Reply-To: <87k22sjsu4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 01:53 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Now that we have the qmp_cmd() helper, we can further simplify
>> some of the tests by using it.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>>      }
>> -    resp =3D qmp("{'execute': 'qom-list-types',"
>> -               " 'arguments': %p }", args);
>> +    resp =3D qmp_cmd("qom-list-types", QOBJECT(args));
>=20
> This one's a clear win.

Well, it'd be even NICER if I could pass QDict instead of QObject around.=



>> +++ b/tests/ide-test.c
>> @@ -651,7 +651,7 @@ static void test_retry_flush(const char *machine)
>>      qmp_eventwait("STOP");
>>
>>      /* Complete the command */
>> -    qmp_discard_response("{'execute':'cont' }");
>> +    qmp_cmd_discard_response("cont", NULL);
>=20
> This one isn't.

Fair enough.

>> @@ -86,7 +87,7 @@ void set_context(QOSState *s)
>>
>>  static QDict *qmp_execute(const char *command)
>>  {
>> -    return qmp("{ 'execute': %s }", command);
>> +    return qmp_cmd(command, NULL);
>=20
> Marginal.
>=20
>>  }
>>
>>  void migrate(QOSState *from, QOSState *to, const char *uri)
>> @@ -106,7 +107,7 @@ void migrate(QOSState *from, QOSState *to, const c=
har *uri)
>>      QDECREF(rsp);
>>
>>      /* Issue the migrate command. */
>> -    rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }=
", uri);
>> +    rsp =3D qmp_cmd("migrate", qobject_from_jsonf("{ 'uri': %s }", ur=
i));
>=20
> Not a simplification.  The opposite, I'm afraid.
>=20
> I could become one if qmp_cmd() worked like this:
>=20
>        rsp =3D qmp_cmd("migrate", "{ 'uri': %s }", uri));

Oh, nice. But it makes qmp_cmd become varargs, at which point...

>=20
> Even better if qmp_cmd("cont", "") just works.  Hmm, unles gcc whines
> about the empty format string.

yeah, we'd have to figure out a way to shut up gcc when no arguments are
wanted.  Here's a compromise that does the best for all three categories
you pointed out above:

qmp_cmd("cont");
qmp_cmd_args("migrate", "{ 'uri': %s  }", uri);
qmp_cmd_dict("qom-list-types", args);

Sounds like I have a plan of attack!  Also, since I'm somewhat churning
on the stuff you did in a previous patch, should we reorder any of this
series (add the helper first, then a single fix the callers that benefit
from the helpers; instead of fixing callers twice in three patches)?

>=20
>>      g_assert(qdict_haskey(rsp, "return"));
>>      QDECREF(rsp);
>>
> [More of the same snipped...]
>=20

And, as I said in the cover letter, there's probably a lot more we could
touch in the testsuite if we like the new pattern.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0HvUDrEpvtD3EcPXMcWMjh13aTJNJID2x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7i5wACgkQp6FrSiUn
Q2p7OAf/fuJgsoJafBd3As/rxXoXBWBay6SCJiK9qMGq/MsiP81nHOE8E/ygWrIf
faN+jEV2blrEjacp93gEO6LdiSWyCBOtyGpQ8Yw+kG9GlVoIJn98yBtx7aDBkqd5
iZEFwfGy+qZD/6XCQyvHD4BBCyZR0jGp/lpQFGnO3Urcw4K3eQLHsG7sm6KEaFr+
A6FF8OFuyfr+fjbS4Mk1H0ZRS6QMJBZL7H6Lpr271u1uNzBwL6BOpMxiGeYc01Fr
BPNYmWP2Q8vY12aJ6H+JVygHmAg9LPHZhibFtXLgVddXITaVYr3WVMxBHSwelQp1
KuwZghE+MrZKKKySU9MIIBGtTon43A==
=Z1Hu
-----END PGP SIGNATURE-----

--0HvUDrEpvtD3EcPXMcWMjh13aTJNJID2x--
