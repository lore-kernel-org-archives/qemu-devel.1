Received: from eggs.gnu.org ([2001:4830:134:3::10]:35546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbARJ-0000yP-N1
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbARF-0007wP-5c
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:56:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dbARE-0007vv-SL
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:56:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4CA773A76
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 18:56:39 +0000 (UTC)
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-2-eblake@redhat.com>
	<877eysl99h.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92504554-2354-6bbe-5c38-9521369d7f32@redhat.com>
Date: Fri, 28 Jul 2017 13:56:36 -0500
MIME-Version: 1.0
In-Reply-To: <877eysl99h.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dgX0gA8LpPBijIAmCgpibvFcKg8DQVhLG"
Subject: Re: [Qemu-devel] [PATCH v3 01/12] qobject: Accept "%"PRId64 in
 qobject_from_jsonf()
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
--dgX0gA8LpPBijIAmCgpibvFcKg8DQVhLG
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <92504554-2354-6bbe-5c38-9521369d7f32@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/12] qobject: Accept "%"PRId64 in
 qobject_from_jsonf()
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-2-eblake@redhat.com> <877eysl99h.fsf@dusky.pond.sub.org>
In-Reply-To: <877eysl99h.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 01:13 PM, Markus Armbruster wrote:

>> Finally, update configure to barf on any libc that uses yet
>> another form of PRId64 that we have not yet coded for, so that we
>> can once again update json-lexer.c to cater to those quirks (my
>> guess? we might see %jd next) (on the bright side, json-parser.c
>> should no longer need updates).  Yes, the only way I could find
>> to quickly learn what spelling is preferred when cross-compiling
>> is to grep a compiled binary; C does not make it easy to turn a
>> string constant into an integer constant, let alone make
>> preprocessor decisions; and even parsing '$CC -E' output is
>> fragile, since 64-bit glibc pre-processes as "l" "d" rather than
>> "ld", and newer gcc splits macro expansions across multiple lines.
>> I'm assuming that 'strings' is portable enough during configure;
>> if that assumption fails in some constrained docker environment,
>> an easy hack is to add this to configure:
>>   strings () { tr -d '\0' < "$1"; }
>>

>> +# Sanity check that we can parse PRId64 and friends in json-lexer.c
>> +# (Sadly, the "easiest" way to do this is to grep the compiled binary=
,
>> +# since we can't control whether the preprocessor would output "ld" v=
s.
>> +# "l" "d", nor even portably ensure it fits output on the same line a=
s
>> +# a witness marker.)
>> +cat > $TMPC <<EOF
>> +#include <inttypes.h>
>> +int main(void) {
>> +    static const char findme[] =3D "\nUnLiKeLyToClAsH_" PRId64 "\n";
>> +    return !findme[0];
>> +}
>> +EOF
>> +if ! compile_prog "$CFLAGS" "$LIBS" ; then
>=20
> Would compile_object suffice?
>=20

Probably.  It's one less step, although I'd have to make sure that
compile_object has a sane counterpart to compile_prog's $TMPE,...

>> +    error_exit "can't determine value of PRId64"
>> +fi
>> +nl=3D'
>> +'
>> +case $(strings $TMPE | grep ^UnLiKeLyToClAsH) in

since we have to grep something, after all.


>> +++ b/qobject/json-lexer.c
>> @@ -29,9 +29,11 @@
>>   *
>>   * '([^\\']|\\[\"'\\/bfnrt]|\\u[0-9a-fA-F]{4})*'
>>   *
>> - * Extension for vararg handling in JSON construction:
>> + * Extension for vararg handling in JSON construction [this lexer
>> + * actually accepts multiple forms of PRId64, but parse_escape() late=
r
>> + * filters to only parse the current platform's spelling]:
>=20
> I'd stick to (parenthesis) instead of [square brackets] here.

Sure.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dgX0gA8LpPBijIAmCgpibvFcKg8DQVhLG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7iOQACgkQp6FrSiUn
Q2o1RQgAojKl6Yi038l+HDQAQyit/LJb30nYg+vOPVPD8sKtoQuiorfA/FsZ3qRu
ninDuLrfD/LfXwxYAB1LpPlgpmGXQHkg+t6DUS8R9lgSEs/alweqWi24NywTuwYG
pwjdVcTuVft7T8UMcGhRhT4Q0CfV7DfhoNrKZaFpufUdTc4pwce8LQbplzlL57K9
bDdiwvcwoSOLs8sx3skaFaUTv8xVQ6fUZT1L5d69+MZ1a9iNTkISpccybERGKEMf
kUlDtmmWWVaiWUY2keoIGz+qbwaO3JFGuA6V4Tw8P+yrWtnHoIsI/PfGhORFY9Bk
mjSjVUp+cPffm9CFrjVs/rUzM+Cwng==
=0fIM
-----END PGP SIGNATURE-----

--dgX0gA8LpPBijIAmCgpibvFcKg8DQVhLG--
