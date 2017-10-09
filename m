Received: from eggs.gnu.org ([2001:4830:134:3::10]:33106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cQ2-0004aF-M0
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cPy-0005oB-2S
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:04:46 -0400
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-32-f4bug@amsat.org>
	<87r2ucrcsi.fsf@dusky.pond.sub.org> <20171009081101.GA2374@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9b0931d-0f17-8977-f115-0f30df39b7fb@redhat.com>
Date: Mon, 9 Oct 2017 13:04:35 -0500
MIME-Version: 1.0
In-Reply-To: <20171009081101.GA2374@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ck2wkndEoD4V5aS0iQ8LPeFJDLcT3gUGR"
Subject: Re: [Qemu-devel] [PATCH 31/88] QMP: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ck2wkndEoD4V5aS0iQ8LPeFJDLcT3gUGR
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu trival <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org
Message-ID: <f9b0931d-0f17-8977-f115-0f30df39b7fb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 31/88] QMP: use g_new() family of functions
References: <20171006235023.11952-1-f4bug@amsat.org>
 <20171006235023.11952-32-f4bug@amsat.org> <87r2ucrcsi.fsf@dusky.pond.sub.org>
 <20171009081101.GA2374@work-vm>
In-Reply-To: <20171009081101.GA2374@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/09/2017 03:11 AM, Dr. David Alan Gilbert wrote:

>>> =20
>>> -    info =3D g_malloc0(sizeof(*info));
>>> +    info =3D g_new0(CommandInfoList, 1);
>>>      info->value =3D g_malloc0(sizeof(*info->value));
>>>      info->value->name =3D g_strdup(cmd->name);
>>>      info->next =3D *list;
>>
>> I'm not convinced rewriting
>>
>>        LHS =3D g_malloc(sizeof(*LHS));
>>
>> to
>>
>>        LHS =3D g_new(T, 1);
>>
>> where T is the type of LHS is worth the trouble.  The code before the
>> rewrite is pretty idiomatic.  There's no possibility of integer overfl=
ow
>> g_new() could avoid.  The types are obviously correct, so the addition=
al
>> type checking is quite unlikely to catch anything.  That leaves the
>> consistency argument.  I'm willing to hear it, but I feel it should be=

>> heard in a patch series that does nothing else.
>=20
> The 'obviously correct' is the dodgy part of the argument here.
> How many bugs do we right that are obviously wrong?
>=20
> t.c:13:20: warning: initialization from incompatible pointer type [-Win=
compatible-pointer-types]
>      struct c *pc =3D g_new(struct b, 1);
>=20
> seems good to me.

Yes, that's a GOOD warning, and it proves that we DO get type safety
when we convert:

LHS =3D g_malloc(sizeof(type))

into

LHS =3D g_new(type, 1)

but that's not what Markus was pointing out.  When we already have the
correctly-typed object on the right hand side, as in:

LHS =3D g_malloc(sizeof(*LHS))

then the compiler will always give us the correct type of LHS, whereas wi=
th:

LHS =3D g_new(type, 1)

we have to manually update the line if the type of LHS changes.

Thus, converting malloc(sizeof(type)) into new(type, 1) is a no-brainer,
but converting malloc(sizeof(*expr)) needs justification.  I'm not
necessarily opposed to the conversion (if our justification is
consistency, and where HACKING documents our style and where we have
scripts that let us easily preserve our style), but I'm not sure I see
the requisite justification in the current iteration of this series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ck2wkndEoD4V5aS0iQ8LPeFJDLcT3gUGR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnbujMACgkQp6FrSiUn
Q2ow7gf9Fv6yFtt5x9PvY5Ktggr0Wk/q8VrXKPV8yA13kw2OX3q6Yrqzi7diaXH8
i1ndCy4s9HlUlI1S+Fi0Hpo9hT1hd3SFkvmv+EGAoCT5rMXzqvjTGwagZsljTLN6
hd54ddphZObnn5qFekjK3CiJqFivYFDDwXU5ehd8JkaCoVhaBhR0BDVf7veqbQkK
P+l3MECYD30mNPN88GyuilUWI6IqRxYeCnPQOdo7Dgrxn3s342OxwIYvhDKxlRO0
zjKW2HPqGVkn5kGr7XkdddZ2+6sdlkLyK+PC757MGFlZ1acKoN/RoPhd4A58m150
DA/cFDgBXIs9Wu70iX9kpXKuf/RJeQ==
=4R8q
-----END PGP SIGNATURE-----

--ck2wkndEoD4V5aS0iQ8LPeFJDLcT3gUGR--
