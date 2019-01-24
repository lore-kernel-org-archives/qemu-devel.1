Received: from eggs.gnu.org ([209.51.188.92]:48648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmjH8-0004Zs-UC
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmjH5-0002qh-3i
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:58:49 -0500
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
	<6325d205-774f-865b-1351-8a7e675bebf7@virtuozzo.com>
	<20190124101559.GC4601@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <414cac93-6a32-3d17-67ec-bb02cdab068e@redhat.com>
Date: Thu, 24 Jan 2019 11:58:16 -0600
MIME-Version: 1.0
In-Reply-To: <20190124101559.GC4601@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MCmvIMMOPW6j1Ue83IOTcK723v3SzRmqs"
Subject: Re: [Qemu-devel] [Qemu-block] Aborts in iotest 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Luiz Capitulino <lcapitulino@redhat.com>, dgilbert@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MCmvIMMOPW6j1Ue83IOTcK723v3SzRmqs
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Luiz Capitulino <lcapitulino@redhat.com>, dgilbert@redhat.com,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <414cac93-6a32-3d17-67ec-bb02cdab068e@redhat.com>
Subject: Re: [Qemu-block] Aborts in iotest 169
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
 <6325d205-774f-865b-1351-8a7e675bebf7@virtuozzo.com>
 <20190124101559.GC4601@localhost.localdomain>
In-Reply-To: <20190124101559.GC4601@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/24/19 4:15 AM, Kevin Wolf wrote:

>> But how to fix Qemu not to crash? May be, forbid some transitions (FIN=
ISH_MIGRATE -> RUNNING),
>>   or at least error-out qmp_cont if runstate is  FINISH_MIGRATE?
>=20

> I wonder whether the QAPI schema should have a field 'run-states' for
> commands, and by default we would only include states where the VM has
> ownership of its resources (e.g. images are activated) and which are no=
t
> temporary states that are automatically left, like finish-migrate.

We already have 'allow-oob' and 'allow-preconfig' flags on a per-command
basis; you're basically proposing that we extend this mechanism for
marking other attributes of commands,...

>=20
> Then the default for commands is to be rejected in "unusual" runstates
> where we're not expecting user intervention, and we must explicitly
> allow them if they are okay, in fact.
>=20
> Instead of listing every obscure runstate, maybe we should really use
> categories of runstates instead:
>=20
> 1. Running
> 2. Paused, owns all resources (like disk images)
> 3. Paused, doesn't own some resources (source VM after migration
>    completes, destination before migration completes)
> 4. Paused temporarily for internal reasons (e.g. finish-migrate,
>    restore-vm, save-vm)
>=20
> Most commands should be okay with 1 and 2, but possibly not 3, and
> almost never 4.

=2E..then enforcing that commands are only executed according to the
attributes they have (where the default attributes match categories 1
and 2, and commands have to opt-in if they are safe to run in category 3
or 4 just like they have to opt-in for preconfig or oob usage).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--MCmvIMMOPW6j1Ue83IOTcK723v3SzRmqs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxJ/LgACgkQp6FrSiUn
Q2qj6Af/ehcYVNLuUXD8LBu2A1n2YZMxD0RElFRcCt/8r3Ceix86UqNdICMHmHfk
cIZ8weR2fzQTWE4myGBzCEUPYOedtyEQbqgcOyVJcyjJ2Y00EwRiaFmK2Jb6nGj/
kgg1yrr7K7pilvAoZ8qWUum/gFegMvaUINaJ4jRdijB+cLAu585cXvrSK+h1V9sA
JaQmJ8YnSYnrgAM9zOJcvVRpImDEOvDyb33tqHHh4dqy5p3cgjUSDS6XWm3ByPxu
PRZK/HZdlDUitQqRzhux9awnbz3ZwumpSL+UDJqQUcgDRc7ZZ6dQTT/sWutrOQ8D
bYxM864evJvPpgHp+hXpJW2hU0lpzQ==
=1sjM
-----END PGP SIGNATURE-----

--MCmvIMMOPW6j1Ue83IOTcK723v3SzRmqs--
