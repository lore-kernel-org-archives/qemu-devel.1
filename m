Received: from eggs.gnu.org ([2001:4830:134:3::10]:45380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkxJ0-0000An-7J
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkxIx-0000LB-5K
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:56:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dkxIw-0000KU-SR
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:56:35 -0400
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-3-git-send-email-armbru@redhat.com>
	<04558062-88d3-0bd2-06d2-ba8a5af8ba8e@redhat.com>
	<87y3q8ddbb.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b31fbbe-1d6e-09d5-6f0d-8f55af18e08f@redhat.com>
Date: Thu, 24 Aug 2017 13:56:25 -0500
MIME-Version: 1.0
In-Reply-To: <87y3q8ddbb.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SbhtpdPuLfVAOqMqw0HMBvg3A9gG7ilFS"
Subject: Re: [Qemu-devel] [PATCH 02/16] qapi: Drop superfluous
 qapi_enum_parse() parameter max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SbhtpdPuLfVAOqMqw0HMBvg3A9gG7ilFS
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <0b31fbbe-1d6e-09d5-6f0d-8f55af18e08f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/16] qapi: Drop superfluous
 qapi_enum_parse() parameter max
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
 <1503564371-26090-3-git-send-email-armbru@redhat.com>
 <04558062-88d3-0bd2-06d2-ba8a5af8ba8e@redhat.com>
 <87y3q8ddbb.fsf@dusky.pond.sub.org>
In-Reply-To: <87y3q8ddbb.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 01:35 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 08/24/2017 03:45 AM, Markus Armbruster wrote:
>>> The lookup tables have a sentinel, no need to make callers pass their=

>>> size.
>>>
>>> Fun: the header has it in the wrong position.  Good riddance.
>>>

>>> +++ b/include/qapi/util.h
>>> @@ -12,7 +12,7 @@
>>>  #define QAPI_UTIL_H
>>> =20
>>>  int qapi_enum_parse(const char * const lookup[], const char *buf,
>>> -                    int max, int def, Error **errp);
>>> +                    int def, Error **errp);
>>
>> I'm not sure what you meant by wrong position; were you thinking that
>> lookup/max should be immediately adjacent (since max is a property of
>> the lookup[] parameter), and sticking 'buf' in between the two is what=

>> meant 'max' was in the wrong position?
>=20
> Compare the declaration above with the definition below:
>=20
>     diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
>     index 46eda7d..ee7594f 100644
>     --- a/qapi/qapi-util.c
>     +++ b/qapi/qapi-util.c
>     @@ -16,7 +16,7 @@
>      #include "qapi/util.h"
>=20
>      int qapi_enum_parse(const char * const lookup[], const char *buf,
>     -                    int max, int def, Error **errp)
>     +                    int def, Error **errp)
>      {
>          int i;
>=20
> Declaration has max before def, definition has it the other way round.

Huh?  On current master (commit 248b2373), the two look like they match
to me:

$ git grep -A1 qapi_enum_parse'.*const look'
include/qapi/util.h:int qapi_enum_parse(const char * const lookup[],
const char *buf,
include/qapi/util.h-                    int max, int def, Error **errp);
--
qapi/qapi-util.c:int qapi_enum_parse(const char * const lookup[], const
char *buf,
qapi/qapi-util.c-                    int max, int def, Error **errp)


>=20
> Such errors are one reason I prefer to have documentation next to
> definitions, which are authoritative, rather than declarations, which
> may or may not match the definition.
>=20
>> The change itself is reasonable, even if the commit message needs a
>> tweak to answer my question.
>=20
> Care to suggest a wording?

At this point, I find the claim to be bogus, so I suggest you delete the
'Fun:' paragraph.

>=20
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Thanks!
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SbhtpdPuLfVAOqMqw0HMBvg3A9gG7ilFS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmfIVkACgkQp6FrSiUn
Q2p1GQf7B834xWVoK2mVFUOdOc4LGuIwoxU57LHfz4UHKM0fSXlpoJ9wXIMcpovo
j2ELYgSlgrEIQhvRXamjoBN15N+HCwElNMc2/OiO+MuOGUpCrk0mQ1VdhGP9diSt
9IKqrScKwa7PHm5gx5xXrw21u7Pj5+a7bD3eu0kaUfkb8yRb/C6omKL5mwI4yFwF
iQt/B7haOIVbBvxJLWeYLiG7YIuGrNq1vi69S/e5jgBqfkxbQtxLvB4gsl68XSen
EBSrdmBJj1i/odWojs6y40Si5LtpXoJb4UMIRlLgYp0uzROZ+SgbFjloXX0nym9I
P/ssPD78G6Y4gkuZbgju3y+O2QTARQ==
=k0t2
-----END PGP SIGNATURE-----

--SbhtpdPuLfVAOqMqw0HMBvg3A9gG7ilFS--
