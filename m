Received: from eggs.gnu.org ([2001:4830:134:3::10]:46261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6GjN-0001W6-2g
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6GjJ-0001fJ-T5
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:23:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6GjJ-0001f4-J0
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:23:37 -0400
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-3-ehabkost@redhat.com>
	<87y3udsz3k.fsf@dusky.pond.sub.org>
	<20170503183037.GV3482@thinpad.lan.raisama.net>
	<87vaphm4fs.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0778f9a5-d974-9beb-ae94-b8e46de7b75d@redhat.com>
Date: Thu, 4 May 2017 08:23:33 -0500
MIME-Version: 1.0
In-Reply-To: <87vaphm4fs.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PQWgvRWIovabSkEhOkWdb5ICBg2QH4PwE"
Subject: Re: [Qemu-devel] [PATCH 2/4] string-input-visitor: Support
 alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PQWgvRWIovabSkEhOkWdb5ICBg2QH4PwE
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <0778f9a5-d974-9beb-ae94-b8e46de7b75d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] string-input-visitor: Support alternate
 types
References: <20170502203115.22233-1-ehabkost@redhat.com>
 <20170502203115.22233-3-ehabkost@redhat.com>
 <87y3udsz3k.fsf@dusky.pond.sub.org>
 <20170503183037.GV3482@thinpad.lan.raisama.net>
 <87vaphm4fs.fsf@dusky.pond.sub.org>
In-Reply-To: <87vaphm4fs.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 03:06 AM, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
>> On Wed, May 03, 2017 at 06:07:43PM +0200, Markus Armbruster wrote:
>>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>>
>>>> When parsing alternates from a string, there are some limitations in=

>>>> what we can do, but it is a valid use case in some situations. We ca=
n
>>>> support booleans, integer types, and enums.
>=20
> By the way, the same restrictions apply to the "keyval" variant of the
> QObject input visitor.  It's a known problem stated here:
>=20
>     Message-ID: <8737exuz6u.fsf@dusky.pond.sub.org>
>     https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00046.html=

>=20
> However, I failed to document it properly in the source.
>=20

>>> Begs the question what happens when you violate these restrictions.
>>
>> Right now, we don't detect those cases and behavior is undefined.
>> I think it will be a good idea to give start_alternate() enough
>> information to detect those cases (by adding a 'const char *const
>> enum_table[]' parameter).
>=20
> Alternate types that won't work with the string input visitor can be
> detected at compile time (by qapi.py), but not their actual use.  Pity.=

>=20
> Do we actually use alternates that violate the restrictions?  If not, w=
e
> could simply restrict alternates so they work with *all* visitors.  If
> we ever run into an actual need for alternates that don't, we'll be no
> worse off than now.
>=20
> Let's review existing alternates outside tests:
>=20
> * Qcow2OverlapChecks: struct + enum
> * BlockdevRef: struct + str
> * GuestFileWhence: int + enum (all enum members start with a letter)
>=20
> Restricting alternates looks practical to me.  Eric, what do you think?=


As in: we forbid the combination of a scalar (whether 'int', 'number',
'bool', and perhaps 'null') with a plain 'str' (since there's no way to
tell whether '1' should parse as an integer or the string "1"); and
combining a scalar with an 'enum' requires that all enum members be
distinct from what could otherwise be parsed as a scalar?  I can live
with such a restriction.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PQWgvRWIovabSkEhOkWdb5ICBg2QH4PwE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCytVAAoJEKeha0olJ0NqdOQIAIh8Cv7gLl+wixnqjmANYtP3
u6uIEuVGMC0j24PMgfk170g+lHhh0MbN9X85vMMSLEbkPFhiXheETXKVg10C7Z9a
RJeM1xPq84fb87+FF7vMdmS1SLJBG9rrhuXMTMq7hTVkSVuPjg2WKXByVBM9htbh
VfadWASSca7ZXQTGzaSZ0aV5jOi7WKj7/b4pEOHPI0WijYq2KUHUdKfpSIuMvfKb
DtfpF9o3/TMw9fGYyA2hFt0MU5TFIXm47Ih7QcIsJnJwku+Vk6DX813bA0WP0DHH
8daLLZEG04/iwctVJnmw5cSmillsBRfqtmdPJKpURduObCnNq8sm8MaYYthRyqM=
=RpVu
-----END PGP SIGNATURE-----

--PQWgvRWIovabSkEhOkWdb5ICBg2QH4PwE--
