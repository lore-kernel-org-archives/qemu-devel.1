Received: from eggs.gnu.org ([2001:4830:134:3::10]:41151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFllX-0007mc-Ng
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFllT-0006EV-Nd
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFllT-0006EL-DI
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:21:07 -0400
References: <20170511191843.13784-1-ehabkost@redhat.com>
	<20170511191843.13784-3-ehabkost@redhat.com>
	<CAFEAcA-jdbDL1uuhM5W=b4qisPsvpJz7aciR8WQebVy43QuBKQ@mail.gmail.com>
	<20170530140103.GI32274@thinpad.lan.raisama.net>
	<5f082e0c-6b89-188f-19d5-dfe476c140fc@redhat.com>
	<20170530181034.GN32274@thinpad.lan.raisama.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <075c20c5-3783-ed72-dfe2-52880fec439b@redhat.com>
Date: Tue, 30 May 2017 13:21:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170530181034.GN32274@thinpad.lan.raisama.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="maEVGVqSqnil9TijdEjwDWkAahGNn5uJj"
Subject: Re: [Qemu-devel] [PULL 02/29] numa: Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, He Chen <he.chen@linux.intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--maEVGVqSqnil9TijdEjwDWkAahGNn5uJj
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, QEMU Developers
 <qemu-devel@nongnu.org>, He Chen <he.chen@linux.intel.com>
Message-ID: <075c20c5-3783-ed72-dfe2-52880fec439b@redhat.com>
Subject: Re: [Qemu-devel] [PULL 02/29] numa: Allow setting NUMA distance for
 different NUMA nodes
References: <20170511191843.13784-1-ehabkost@redhat.com>
 <20170511191843.13784-3-ehabkost@redhat.com>
 <CAFEAcA-jdbDL1uuhM5W=b4qisPsvpJz7aciR8WQebVy43QuBKQ@mail.gmail.com>
 <20170530140103.GI32274@thinpad.lan.raisama.net>
 <5f082e0c-6b89-188f-19d5-dfe476c140fc@redhat.com>
 <20170530181034.GN32274@thinpad.lan.raisama.net>
In-Reply-To: <20170530181034.GN32274@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 01:10 PM, Eduardo Habkost wrote:
> On Tue, May 30, 2017 at 10:28:21AM -0500, Eric Blake wrote:
>> On 05/30/2017 09:01 AM, Eduardo Habkost wrote:
>>
>>>> The OSX compiler is pickier about format strings than gcc,
>>>> and neither "MAX_NODES" nor "MAX(anything)" are uint16_t type.
>>>
>>> src and dst are both uint16_t, so MAX(src, dst) is also uint16_t,
>>> isn't it?  It looks like MAX_NODES is the problem.
>>
>> No. MAX() invokes arithmetic (both ?: and > operators), and arithmetic=

>> involves default promotion (anything shorter than int becomes 'int').
>=20
> Oh, I didn't know that.

And the fact that var-arg passing REQUIRES promotion means you CAN'T
tell the difference from a true uint16_t argument and an int argument
which resulted from arithmetic promotion.  Which is why Paolo has argued
that the MacOS compiler warning is bogus because it is overly picky.
But we obviously are in no position to get it changed.

>=20
>>
>>> +++ b/numa.c
>>> @@ -232,7 +232,7 @@ static void parse_numa_distance(NumaDistOptions *=
dist, Error **errp)
>>>      if (src >=3D MAX_NODES || dst >=3D MAX_NODES) {
>>>          error_setg(errp,
>>>                     "Invalid node %" PRIu16
>>> -                   ", max possible could be %" PRIu16,
>>> +                   ", max possible could be %d",
>>
>> Don't you want %u to match PRIu16, rather than %d?
>=20
> Can't this (using %u with an int argument) make more pedantic
> compilers complain?

Yes, gcc's -Wformat-signedness would (probably) flag it.  But we don't
use that.  At any rate, ALL uint16_t values are formatted identically
for both %u and %d, so as long as we have a formula for keeping picky
compilers silent, I don't care beyond that point.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--maEVGVqSqnil9TijdEjwDWkAahGNn5uJj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLbgQAAoJEKeha0olJ0NqR8sIAITQSKuAwggw95YbKXMQBvtq
AyGl7Sh/OTU6TwZyFuXUs3m3ElLhABnYM8Q7dCHGoBRMHHaS0hvv1onM1Dp3Uu2k
X4BE9kxmvA89WGViNlGxvg5FyBfim261bUWK/qqkGJJhOKsEzpcmu8wcSjcYGCws
6RoZqUD5W83puEtLlN7ilUZxdOsw+Xqk3/ENWK7j8vthhBnGR3aFWnyC/JROcU6p
IUp40Wg4zUjFtjuCPEykY9ZqRtcjv+NBQkmiS3GJncQeXX6/MLfw1yIHXQ+5uer6
2jmoX+5C99LYPxkoW2jbpqSx5YGPt4VUtIHr6nBteu6CESd4AjslLFV4CLGNLxY=
=budu
-----END PGP SIGNATURE-----

--maEVGVqSqnil9TijdEjwDWkAahGNn5uJj--
