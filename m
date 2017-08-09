Received: from eggs.gnu.org ([2001:4830:134:3::10]:51977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfQvY-0004cr-NZ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfQvU-0002Nl-3A
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:21:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfQvT-0002N6-Ox
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:21:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D2B71FF108
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 13:21:30 +0000 (UTC)
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-7-eblake@redhat.com>
	<87y3qtun3n.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f30cf8ad-ebb4-27af-8bd7-82ba51f0ae63@redhat.com>
Date: Wed, 9 Aug 2017 08:21:28 -0500
MIME-Version: 1.0
In-Reply-To: <87y3qtun3n.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3Id6QjHgRAhuGlDkfj0wT5hrNbGAgRrFT"
Subject: Re: [Qemu-devel] [PATCH v4 06/22] qobject: Perform %% interpolation
 in qobject_from_jsonf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3Id6QjHgRAhuGlDkfj0wT5hrNbGAgRrFT
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <f30cf8ad-ebb4-27af-8bd7-82ba51f0ae63@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 06/22] qobject: Perform %% interpolation
 in qobject_from_jsonf()
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-7-eblake@redhat.com> <87y3qtun3n.fsf@dusky.pond.sub.org>
In-Reply-To: <87y3qtun3n.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 04:06 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> We want -Wformat to catch blatant programming errors in format
>> strings that we pass to qobject_from_jsonf().  But if someone
>> were to pass a JSON string "'%s'" as the format string, gcc would
>> insist that it be paired with a char* argument, even though our
>> lexer does not recognize % sequences inside a JSON string.  You can
>> bypass -Wformat checking by passing the Unicode escape \u0025 for
>> %, but who wants to remember to type that?  So the solution is that
>> anywhere we are relying on -Wformat checking, the caller should
>> pass the usual printf %% escape sequence where a literal % is
>> wanted on output.
>>

>> +    bool double_quote =3D *ptr++ =3D=3D '"';
>>
>>      str =3D qstring_new();
>> -    while (*ptr &&=20
>> -           ((double_quote && *ptr !=3D '"') || (!double_quote && *ptr=
 !=3D '\''))) {
>> +    while (*ptr && *ptr !=3D "'\""[double_quote]) {
>=20
> Simpler:
>=20
>        bool quote =3D *ptr++;
>=20
> and then
>=20
>        while (*ptr && *ptr !=3D quote) {

Well, 'char quote' rather than 'bool quote', but yes, I like it.

>=20
> Have you considered splitting the patch into one to simplify, and one t=
o
> implement %%?

Will split.

>> @@ -455,13 +452,15 @@ static QObject *parse_escape(JSONParserContext *=
ctxt, va_list *ap)
>>  {
>>      JSONToken *token;
>>
>> -    if (ap =3D=3D NULL) {
>> -        return NULL;
>> -    }
>> -
>>      token =3D parser_context_pop_token(ctxt);
>>      assert(token && token->type =3D=3D JSON_ESCAPE);
>>
>> +    if (ap =3D=3D NULL) {
>> +        parse_error(ctxt, token, "escape parsing for '%s' not request=
ed",
>> +                    token->str);
>> +        return NULL;
>> +    }
>> +
>=20
> When I manage to fat-finger a '%' into my QMP input, I now get this
> error message instead of "Invalid JSON syntax".  Makes me go "what is
> escape parsing, and how do I request it?"  Not an improvement, I'm
> afraid.

Pre-patch, I see:

$ qemu-kvm -nodefaults -nographic -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 9, "major": 2},
"package": "(qemu-2.10.0-0.1.rc1.fc26)"}, "capabilities": []}}
{'execute':%s}
{"error": {"class": "GenericError", "desc": "JSON parse error, Missing
value in dict"}}
{'execute':%%}
{"error": {"class": "GenericError", "desc": "Invalid JSON syntax"}}
{"error": {"class": "GenericError", "desc": "JSON parse error, expecting
value"}}

I find it odd that NOT calling parse_error() but still returning NULL
changes the behavior on what error message eventually gets emitted; but
I also agree that the QMP case should drive what error message (if any)
is needed in parse_escape().  I'll play with it some more (the parser's
error handling is weird).


>> +    /* In vararg form, %% must occur in strings */
>> +    /* qobject_from_jsonf("%%"); */
>> +    /* qobject_from_jsonf("{%%}"); */
>> +
>> +    /* In vararg form, strings must not use % except for %% */
>> +    /* qobject_from_jsonf("'%s'", "unpaired"); */
>=20
> Could use g_test_trap_subprocess().  Not sure it's worth the bother.

I don't know - this is one case where proving we abort on invalid usage
might actually be a good validation of the contract.

>=20
> I hate code in comments.  Better:
>=20
>        /* The following intentionally cause assertion failures */
>    #if 0
>        /* In vararg form, %% must occur in strings */
>        qobject_from_jsonf("%%");

If I don't use the g_test_trap_subprocess() trick, then I can override
checkpatch's complaints about #if 0.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3Id6QjHgRAhuGlDkfj0wT5hrNbGAgRrFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLDFgACgkQp6FrSiUn
Q2qoPwf/W0hXfqO/N+zeTJrG6heFJIEmA2KQX8sr5BeaSmo1UwmEGh9FBEqvV+7H
5V+qBXk/WpeJw8M8ff2HMuku66wJhW9o6bJFy71tXOMzHaKfxR1o/tWIusLaE3+e
HfqYRe9xyuAW6VYsrCivr3BXzgeBUwMIlB8vQF38A37I6hrXcC1oVbmuWwknFjnm
l/o51GmXGymsU9Bf8PyFG9D2Tz8snB3E6uKzG6IcZczLJsXd8hS7s3cax4AZrYat
YNr0VeuJ+Rzq3v1FutzZJcNg/shFUS8eX8b6mcFvImInO9VgU0JBOuvlpv36D5Gf
WeCw6NY+sNwfa4rNaNPo7q89j9X1bg==
=baGU
-----END PGP SIGNATURE-----

--3Id6QjHgRAhuGlDkfj0wT5hrNbGAgRrFT--
