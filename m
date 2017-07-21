Received: from eggs.gnu.org ([2001:4830:134:3::10]:56421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYeDh-0003jA-CV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 16:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYeDc-000893-ML
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 16:08:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYeDc-00087X-CV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 16:08:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2C8A13513A
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 20:08:10 +0000 (UTC)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-5-git-send-email-armbru@redhat.com>
	<295a3dcc-5165-cc23-26a2-ffb4d8ccb144@redhat.com>
	<87tw25ag8p.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <500db1a0-e7f5-0413-950a-4c9bfbceba06@redhat.com>
Date: Fri, 21 Jul 2017 15:08:09 -0500
MIME-Version: 1.0
In-Reply-To: <87tw25ag8p.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Sp6BN90mwF3XNCa8vRq0ScQWoQBlihCbJ"
Subject: Re: [Qemu-devel] [PATCH 4/9] tests: Clean up string interpolation
 into QMP input (simple cases)
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
--Sp6BN90mwF3XNCa8vRq0ScQWoQBlihCbJ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <500db1a0-e7f5-0413-950a-4c9bfbceba06@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] tests: Clean up string interpolation
 into QMP input (simple cases)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
 <1500645206-13559-5-git-send-email-armbru@redhat.com>
 <295a3dcc-5165-cc23-26a2-ffb4d8ccb144@redhat.com>
 <87tw25ag8p.fsf@dusky.pond.sub.org>
In-Reply-To: <87tw25ag8p.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 11:48 AM, Markus Armbruster wrote:
> I forgot that PRId64 expands into non-standard crap on some systems.
>=20
> Options:
>=20
> 1. Outlaw use of PRI macros, limit integer length modifiers for
>    conversion specifiers "d" and "u" to "l" and "ll".  When PRI macros
>    creep in, the build breaks on hosts where they expand to anything
>    else (hopefully, our CI will catch that).  Interpolating int64_t
>    values become a bit awkward.
>=20
>    Required work: fix my patches not to use PRId64, drop support for
>    length modifier "I64" from parse_escape().

Yuck.  (But motivation for my earlier series to nuke qobject_from_jsonf()=
)

>=20
> 2. Support PRId64 and PRIu64, whatever their actual value may be.
>=20
>    a. Support all possible values.  This is what we've tried before.
>       Nasty: fails only at run-time on hosts with sufficiently creative=

>       values.
>=20
>       Required work: add support for length modifier "q", to unbreak
>       MacOS.
>=20
>       Optional work: try to turn the run-time failure into a compile-
>       time failure, ideally in configure.

Accepts garbage (although -Wformat detection will help avoid the worst
of it).  You can't check string equality in the preprocessor, and you
can't do things like "case PRId64[0]: case 'l':" to force compilation
errors due to duplicate labels, but we CAN limit ourselves to the
preprocessor and grep that output to see what PRId64 expands to.  I'll
see if I can come up with a configure check.  Still, it may be easier to
just fail configure and tell people to report the bug on their odd libc,
at which point we update json-lexer.c and configure, than it is to try
and reuse configure results in json-lexer.c (since the PRId64 string is
not a constant width, it gets hard to code an exact value into our lexer
state machine, but easier to code every reported value).

>=20
>    b. Support exactly the host's PRId64 and PRIu64 values.
>=20
>       Work required: replace support of "I64d" and "I64u" by support of=

>       PRId64 and PRIu64.  Easy enough in parse_escape(), but not in
>       json-lexer.c.  We could perhaps have the lexer accept the shortes=
t
>       string that's followed by a conversion specifier as length
>       modifier, then reject invalid length modifiers in a semantic
>       action.

Interesting idea. I'm playing with it...

>=20
>    Optional work: try to simplify code that currently works around
>    unavailability of PRId64 and PRIu64.
>=20
> Preferences?
>=20
> I like 2b, but I'm not sure I'll like the code implementing it.  One wa=
y
> to find out...

In the lexer, widen the state machine to accept up to three unknown
characters between % and d.  Hmm, there's also the possibility of
int64_t being mapped to %jd, in addition to our known culprits of %ld,
%lld, %I64d, and %qd.

>=20
>> Overall, I like the patch, but we need to fix the problems for the nex=
t
>> round of this series.
>=20
> Yes. =20

At this point, I think I'll spin the next round. But it's not longer a
2.10 priority, so it may be a few days.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Sp6BN90mwF3XNCa8vRq0ScQWoQBlihCbJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyXykACgkQp6FrSiUn
Q2q+1ggAh9YWPO+xb27/iLFD+OV1gBAwbBcLnVcsbuX9UDxPda5zYa259puzsw6G
MXn0UuXFlYwBzAvVrOnsIhA35V7uNv9JuLuHtFNQdUfo7SMoMFgem69gD/ieIzm5
WFzq/yCC8udVixw9tDUZg8/XfF62zTkJzdAnkZgsdRy+ourWv5ODgV9PI1hMxlxe
loI93HoV2MXTZ6ssGIoTr8c9+TMekwFfBABJbgbd4VpGXDweXstqulWVMYdgXsjU
VHyTY4Vp3Gb/lznsqCIZ7Yf4eSoKrOlm2K3riGdF35cxjTs8YBzNr8wtnYZ8Tua5
QAQzd1Gf32IyUc1/C9DTxljmtjkxmQ==
=jtbn
-----END PGP SIGNATURE-----

--Sp6BN90mwF3XNCa8vRq0ScQWoQBlihCbJ--
