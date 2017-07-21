Received: from eggs.gnu.org ([2001:4830:134:3::10]:46645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYYJ9-000546-Bd
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYYJ8-0001pf-8B
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:49:31 -0400
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <f263a454-9dca-ecba-89b8-d09bee6b79ec@redhat.com>
Date: Fri, 21 Jul 2017 09:49:11 -0400
MIME-Version: 1.0
In-Reply-To: <20170721123325.GC18014@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="77oMtAGsj83PNlWvkPLkefVGXDBCXtRRK"
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--77oMtAGsj83PNlWvkPLkefVGXDBCXtRRK
From: Cleber Rosa <crosa@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <f263a454-9dca-ecba-89b8-d09bee6b79ec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
References: <20170721034730.25612-1-crosa@redhat.com>
 <20170721123325.GC18014@stefanha-x1.localdomain>
In-Reply-To: <20170721123325.GC18014@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 07/21/2017 08:33 AM, Stefan Hajnoczi wrote:
> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
>> This is a follow up to a previous discussion about reported failures w=
hen
>> running some qemu-iotests.  Turns out the failures were due to missing=

>> libraries, which in turn, reflected on the host build configuration.
>>
>> This series introduces a tool that can check both host and target leve=
l
>> build configurations.  On top of that, it adds a function to to be use=
d
>> on qemu-iotests.  Finally, as an example, it sets a test to be skipped=

>> if the required feature is not enable on the host build configuration.=

>>
>> Cleber Rosa (3):
>>   scripts: introduce buildconf.py
>>   qemu-iotests: add _require_feature() function
>>   qemu-iotests: require CONFIG_LINUX_AIO for test 087
>>
>>  scripts/buildconf.py         | 278 ++++++++++++++++++++++++++++++++++=
+++++++++
>>  tests/qemu-iotests/087       |   1 +
>>  tests/qemu-iotests/check     |   2 +
>>  tests/qemu-iotests/common.rc |   7 ++
>>  4 files changed, 288 insertions(+)
>>
>=20
> It should be possible to run iotests against any
> qemu/qemu-img/qemu-io/qemu-nbd binaries - even if no build root is
> available.
>=20

Yes, I actually overlooked that point.

> How about invoking qemu-img and tools to determine their capabilities?
>=20

Can capabilities be consistently queried?  I would love to not count on
a build root if the same information can be consistently queried from
the binaries themselves.

> At the beginning of ./check, query the qemu/qemu-img/qemu-io/qemu-nbd
> binaries for specific features.  This produces a set of available
> features and tests can say:
>=20

Which would be another ad-hoc thing, limited to qemu-iotests.  From a
test writer perspective, QEMU lacks is a uniform way to introspect its
capabilities.

>   _supported_feature aio_native
>=20
> This feature can be checked by opening an image file:
>=20
>   qemu-io --format raw --nocache --native-aio --cmd quit test.img
>=20

While the solution I proposed is not cheap in terms of what it runs to
query capabilities (runs make on every query), it was cheap to write, it
sets a universal standard, and it's mostly maintenance free.  A key
point is that all build configuration (capabilities?) is predictable and
available across all subsystems and all targets.

Being honest, I think your suggestion is terribly expensive in the long
run.  In the best case scenario, it requires one explicit check to be
written for each capability, which at some point, may start to look like
a test itself.  The capability naming and behavior will probably end up
becoming inconsistent.

I feel a lot more safe relying on a "capability statement" to write the
foundation of tests, than to write a number of custom "capability checks"=
=2E

But I agree that the build root requirement is an issue.

Is embedding the configured capabilities in the binary themselves
acceptable?  Something like an standard option such as
`-query-capabilities` or `-debug-build-info` that would basically list
the content of "config-host.h" and similar files?

Thanks for reviewing the idea and pointing out this important limitation!=


--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--77oMtAGsj83PNlWvkPLkefVGXDBCXtRRK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZcgZaAAoJEGV+jTOl8gnz92IP+wbJhXirpONHKmC7IDuPRC5k
4QRDbuIXHB9MvV/op/DBYYtX+UHIFhMpi4KWsuUx/RLJAPn8woJR+yBaaC/1l9ju
OUjuB2YT+Gi4YMk9xMoj0RUohGpoUBf2c3qYGAakAOoSqf493Ki3oPhL0s8G3y5l
Xg1vtnAbjTerHqKI1+y+JV8pnIm6dxRQIBKwd5R3JaAACTE94y2eyzb3be30PrQ3
a7457OG4pNY3R3D2AFNfFNwPDrt6jg7QkSDT5/OhYcu1vOYy+hAf+sMYulipnnY/
UPhjDzvs1TJKey/Ztcb6eFBjgApdTLcGbXX7iUVJMJ6pE56DvwrnguFiUxq2VH7H
nmONgpGrQw4DNJvV+jFUznRM/c4OV8HQ0bJ8GnkwYEe8+BN2LGqdNnpsqOFUv6Jk
+yrz74Gtf6Gb91Zevj+m2iz/gtygJoKO19Pjv4rQfMQ/E58mUgyTZ3UEqPmRw4/J
Nb9DG/bFy/H8qRt1nQQw6ck0W9KGn/V0g9NnNvpgr/arrqOdApmqOBAXGcsWploP
tHW1VP4L5xPCO77GaHVvSbCl0fYwbOkMEMi/mjIYllgwADtdFhhSsm3WZw9rKzwu
CMLKRfv5N+ZGeq3GlR4ZsQhzVwbJ9/8QwNINIdmx0gE9FE+5X64JAvC39//mkopM
Y2Zdo2QOwk5MPb7XMAUI
=9lse
-----END PGP SIGNATURE-----

--77oMtAGsj83PNlWvkPLkefVGXDBCXtRRK--
