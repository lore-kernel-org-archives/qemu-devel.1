Received: from eggs.gnu.org ([2001:4830:134:3::10]:33296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjtOq-0004c5-SE
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjtOm-0007Af-IR
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:02:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjtOm-00079b-9F
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:01:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C8B9C0567B5
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 20:01:56 +0000 (UTC)
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-26-git-send-email-armbru@redhat.com>
	<82622f99-91d8-7ae0-2a38-53b49e200f72@redhat.com>
	<87zih2i1hn.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c88da759-43c8-483e-1c22-e6b82d1848e7@redhat.com>
Date: Fri, 3 Mar 2017 14:01:53 -0600
MIME-Version: 1.0
In-Reply-To: <87zih2i1hn.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JR0SQL0vr6M0GbWj0mbXCCTgBhrHUEbvx"
Subject: Re: [Qemu-devel] [PATCH v4 25/28] qapi: Make input visitors detect
 unvisited list tails
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
--JR0SQL0vr6M0GbWj0mbXCCTgBhrHUEbvx
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <c88da759-43c8-483e-1c22-e6b82d1848e7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 25/28] qapi: Make input visitors detect
 unvisited list tails
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
 <1488544368-30622-26-git-send-email-armbru@redhat.com>
 <82622f99-91d8-7ae0-2a38-53b49e200f72@redhat.com>
 <87zih2i1hn.fsf@dusky.pond.sub.org>
In-Reply-To: <87zih2i1hn.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 01:50 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 03/03/2017 06:32 AM, Markus Armbruster wrote:
>>> Fix the design flaw demonstrated in the previous commit: new method
>>> check_list() lets input visitors report that unvisited input remains
>>> for a list, exactly like check_struct() lets them report that
>>> unvisited input remains for a struct or union.
>>>
>>> Implement the method for the qobject input visitor (straightforward),=

>>> and the string input visitor (less so, due to the magic list syntax
>>> there).  The opts visitor's list magic is even more impenetrable, and=

>>> all I can do there today is a stub with a FIXME comment.  No worse
>>> than before.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>
>> Didn't I already review this one?
>>
>> Ah, there's my R-b:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg07614.html
>=20

>>>=20
>>> --- a/qapi/qobject-input-visitor.c
>>> +++ b/qapi/qobject-input-visitor.c
>>> @@ -51,7 +51,8 @@ static QObjectInputVisitor *to_qiv(Visitor *v)
>>>      return container_of(v, QObjectInputVisitor, visitor);
>>>  }
>>> =20
>>> -static const char *full_name(QObjectInputVisitor *qiv, const char *n=
ame)
>>> +static const char *full_name_nth(QObjectInputVisitor *qiv, const cha=
r *name,
>>> +                                 int n)
>>>  {

No function comment, so the _nth and int n are guesses on their meaning..=
=2E


>> If I'm reading this right, your use of n-- in the loop followed by the=

>> post-condition is to assert that QSLIST_FOREACH() iterated n times, bu=
t
>> lets see what callers pass for n:
>=20
> At least @n times.

Ah, as in 'use first available result' or 'iterate at least once', based
on our callers, but could also mean 'iterate at least twice' for a
caller that passes 2.


>> the other passes 1.  No other calls.  Did we really need an integer,
>> where we use n--, or would a bool have done as well?
>=20
> Since I actually use only 0 and 1, a bool would do, but would it make
> the code simpler?

I don't know that a bool would be any simpler,

>=20
>> At any rate, since I've already reviewed it once, you can add R-b, but=

>> we may want a followup to make it less confusing.
>=20
> Would renaming the function to full_name_but_n() help?

Or even keep the name unchanged, but add function comments describing
what 'n' means.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JR0SQL0vr6M0GbWj0mbXCCTgBhrHUEbvx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYucuxAAoJEKeha0olJ0NqztQH/3lHbAnWF3KN3JoLu1/DlouP
fe5F5iZZsu59y1exn9exW4jBl9YYA2E4yS/9A84/Z3pht0Y/7/g/zTOsP/BbovfC
PFwLC+QNvn7oHMv+HwQFNFQB9R0A0FZUXtgfCIHkpiGfRvkltjlJtbIDp38bj0Bx
T1MlE86Q0QjHiWGKF7u6zJaYytH9NQtU49aLRQYMSaxV+JWa21aunsqBbkms8tG7
OqcRWST7CPDWBAn+OU3vICmYVeZ4CH9yRbcM+oGEqWgYXOyY95IvvraTDE55MASq
qpXXyjQIc92I6MWbS1mf5SaVaHg9WM6ji0Zg1O+lAYLgI9kOTqpzLhw/ls8s8EI=
=+MA7
-----END PGP SIGNATURE-----

--JR0SQL0vr6M0GbWj0mbXCCTgBhrHUEbvx--
