Received: from eggs.gnu.org ([2001:4830:134:3::10]:33828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAOE-0005tA-Hq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAO9-0005BG-W3
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dbAO9-0005Af-MO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:53:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68136C0A8830
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 18:53:28 +0000 (UTC)
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-8-eblake@redhat.com>
	<87r2x0jt8s.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7175fa11-b03b-4c96-c893-47c271b0e002@redhat.com>
Date: Fri, 28 Jul 2017 13:53:24 -0500
MIME-Version: 1.0
In-Reply-To: <87r2x0jt8s.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MmHvbGGej041etDRPOuKqRj5B2UkhIckW"
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MmHvbGGej041etDRPOuKqRj5B2UkhIckW
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <7175fa11-b03b-4c96-c893-47c271b0e002@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-8-eblake@redhat.com> <87r2x0jt8s.fsf@dusky.pond.sub.org>
In-Reply-To: <87r2x0jt8s.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 01:45 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> When interpolating a QMP command from the testsuite, we have
>> a very common pattern that the command to be executed is a
>> string constant, while the arguments may need to be crafted
>> from qobject_from_jsonf() or even by hand.  Make it easier to
>> craft the arguments without having to save all the interpolation
>> to the final qmp() call, by adding new helper functions; the
>> function takes QObject instead of QDict in order to reduce the
>> number of conversions between the two.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  tests/libqtest.h | 31 +++++++++++++++++++++++++++++++
>>  tests/libqtest.c | 25 +++++++++++++++++++++++++
>>  2 files changed, 56 insertions(+)
>>
>> diff --git a/tests/libqtest.h b/tests/libqtest.h
>> index 82e89b4d4f..26930fed4d 100644
>> --- a/tests/libqtest.h
>> +++ b/tests/libqtest.h
>> @@ -68,6 +68,17 @@ void qtest_qmp_discard_response(QTestState *s, cons=
t char *fmt, ...);
>>  QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
>>
>>  /**
>> + * qtest_qmp_cmd:
>> + * @s: #QTestState instance to operate on.
>> + * @cmd: Command name to send
>> + * @args: Arguments to transfer to the command, or NULL.
>=20
> Do we really need "or NULL"?

It allows me to do:

qmp_cmd("cont", NULL)

instead of

qmp("{'execute':'cont'}")

>=20
>> + *
>> + * Sends a QMP message to QEMU and returns the response. Calling this=
 will
>> + * reduce the reference count of @args.
>=20
> Suggest "decrement".  Same for the wrappers below.

Okay.


>> +QDict *qtest_qmp_cmd(QTestState *s, const char *cmd, QObject *args)
>> +{
>> +    QDict *dict =3D qdict_new();
>> +
>> +    qdict_put_str(dict, "execute", cmd);
>> +    if (args) {
>> +        qdict_put_obj(dict, "arguments", args);
>> +    }
>> +    return qtest_qmp(s, "%p", QOBJECT(dict));
>=20
> This function should be a one-liner:
>=20
>        return qtest_qmp(s, "{'execute': %s, 'arguments': %p }", cmd, ar=
gs);
>=20
> A bit more complicated if we need to support null @args.

Well, I did use NULL args.  But it looks like this is leftovers from my
original attempt to ban qobject_from_jsonf() altogether (which we have
now swung in the opposite direction of "let's keep it and make it safer
with compiler checks"), so you are indeed right that not building a
manual QDict would be a bit nicer.

{
    if (!args) {
        args =3D qdict_new();
    }
    return qtest_qmp(s, "{'execute': %s, 'arguments': %p }", cmd, args);
}

would work, except that it slightly changes what is passed over the
wire, albeit with no semantic change (use of 'arguments':{} is optional)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MmHvbGGej041etDRPOuKqRj5B2UkhIckW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7iCUACgkQp6FrSiUn
Q2qToAgAl16YJPkXg7rVS1M+O+MshVywZgxVz769tMs5FxXkotJecf0jO7AB2Df7
lPN8djmijCnYxbvWQM9BTrw7C1T7akUpWpdpT50HLwHdLmZ8K7btDNBshWWijYZt
7T/TkrwCnz0DpXlCHJJEBjBohRXZub4aMwL1Eh1Rca7GUAhChO+MNV4nP4mNa9XF
tgb8u7s2YCegPTh6s2LZRlpFmDGxC04pTf6T4qGklm5m5b2xQByPM2Fhiz0wT1dw
wMuSV3+QtjF+lViuNJHJ1G4OoFIZic68MaogHIKhZ3R8wE0pjk8SyVvXN3MxhGCH
qDuJPOznBh6g7XNWaFOU4JZyJifcFA==
=nrw/
-----END PGP SIGNATURE-----

--MmHvbGGej041etDRPOuKqRj5B2UkhIckW--
