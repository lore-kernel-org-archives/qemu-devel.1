Received: from eggs.gnu.org ([2001:4830:134:3::10]:59045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYYoF-0007ir-Ez
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYYoE-0003mW-B1
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:21:39 -0400
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
	<20170721140155.GQ17693@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
Date: Fri, 21 Jul 2017 10:21:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170721140155.GQ17693@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NrTCXAKsaIrRIHCdEcgqRrN0ilAWddRDu"
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NrTCXAKsaIrRIHCdEcgqRrN0ilAWddRDu
From: Cleber Rosa <crosa@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
References: <20170721034730.25612-1-crosa@redhat.com>
 <20170721123325.GC18014@stefanha-x1.localdomain>
 <20170721140155.GQ17693@redhat.com>
In-Reply-To: <20170721140155.GQ17693@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/21/2017 10:01 AM, Daniel P. Berrange wrote:
> On Fri, Jul 21, 2017 at 01:33:25PM +0100, Stefan Hajnoczi wrote:
>> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
>>> This is a follow up to a previous discussion about reported failures =
when
>>> running some qemu-iotests.  Turns out the failures were due to missin=
g
>>> libraries, which in turn, reflected on the host build configuration.
>>>
>>> This series introduces a tool that can check both host and target lev=
el
>>> build configurations.  On top of that, it adds a function to to be us=
ed
>>> on qemu-iotests.  Finally, as an example, it sets a test to be skippe=
d
>>> if the required feature is not enable on the host build configuration=
=2E
>>>
>>> Cleber Rosa (3):
>>>   scripts: introduce buildconf.py
>>>   qemu-iotests: add _require_feature() function
>>>   qemu-iotests: require CONFIG_LINUX_AIO for test 087
>>>
>>>  scripts/buildconf.py         | 278 +++++++++++++++++++++++++++++++++=
++++++++++
>>>  tests/qemu-iotests/087       |   1 +
>>>  tests/qemu-iotests/check     |   2 +
>>>  tests/qemu-iotests/common.rc |   7 ++
>>>  4 files changed, 288 insertions(+)
>>>
>>
>> It should be possible to run iotests against any
>> qemu/qemu-img/qemu-io/qemu-nbd binaries - even if no build root is
>> available.
>=20
> For sake of argument, two options for non-buildroot scenario
>=20
>  - assume all features are present, so we're no worse than we are today=
=2E
>  - install config.h (or same data in a structured format) to
>    /usr/share/qemu so its available for query
>=20
> Downside of 2 of course is that other non-iotests apps might start
> to depend on it
>=20

Actually, I see #2 as a worthy goal.  Not in the strict sense of the
implementation you suggested, but as a way for *any code* (including
non-iotests) to have a baseline to work with.

>> How about invoking qemu-img and tools to determine their capabilities?=

>>
>> At the beginning of ./check, query the qemu/qemu-img/qemu-io/qemu-nbd
>> binaries for specific features.  This produces a set of available
>> features and tests can say:
>>
>>   _supported_feature aio_native
>>
>> This feature can be checked by opening an image file:
>>
>>   qemu-io --format raw --nocache --native-aio --cmd quit test.img
>=20
> I think this is useful as a general approach, because there are bound
> to be a number of features which are available at compile time, but
> cannot actually be used at runtime. eg not every filesystem supports
> O_DIRECT, even if we've built support for it.
>=20

I strongly believe this kind of ad hoc check has value, it complements
what is being proposed here, but doesn't replace it at all.  Using the
previous example, suppose a test is being written to test aio in various
filesystems.  It'd be extremely useful to rely on the information that
qemu-io itself has been built with native aio support.  With that
information as a safe baseline, and run time information about the
filesystem it's operating on, a much cleaner expected outcome can be
defined.

Without the static capabilities defined, the dynamic check would be
influenced by the run time environment.  It would really mean "qemu-io
running on this environment (filesystem?) can do native aio".  Again,
that's not the best type of information to depend on when writing tests.

> Regards,
> Daniel
>=20

Regards!

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--NrTCXAKsaIrRIHCdEcgqRrN0ilAWddRDu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZcg3kAAoJEGV+jTOl8gnz9T8P/R96MmK7V/5aB3/5pgyi7+zS
i6uC/E9ob7EQaUFOnlmlnvNQTYfKGhMtx/gtXJImv6OZU0fGBbIeEkNQqGg8LWGB
Dqxk+79WThF1XNAuVXQtq3p1I6RpoW/+iZd7yC2YPNOmPox2cpYAkEdWHNSk7egs
pfjmv61tkWdOzlGi4DU2k3vj4U6k6RsMrQ1Ij0smTIotGNuEU17Bh6nF0e73FDgN
eL1ETy+cVOX4PpMX1x3YHrHbaiAfqQzPGHSOGVQy3Al2Lyii9sq4s98f1T/JnXuo
Hofoj+oUpZSnEAjynL8NBM2wJI6J14LG9kxPZawypk3Acqa/wGAW8H9ftYBAR6DN
CKZR70LVOBoBnKaDbxXYJZ7bcteIItmsVTwGdG6E9JHN9OaFazKGxcY1F5sZZJvy
NcYS47uOAPa56wX/shdGn/PaZy/3BqJWcSRVu40HYNvTx8YoW+M2QGUYdZwjqOLy
8lWDJk0MUNYs/Ap/W5u2JaxM8OsA/RUCy7Lkj+qBAnnkhI3yu6gkmNjxHZq7fZbm
mlcqErUny9yzR1cjbXATYD6+8p0Yqs4IQxCtay8VRpAuahpKrJsXcA75m0nrWNcC
s9zkgDjINPm8QyatGIjK/iGrYQ0Lb508j1NS5hG7g8ywyFmOZsC2j2W8SLrIvC6U
k9ZnVrWjofxDlmVtnhFV
=4hGW
-----END PGP SIGNATURE-----

--NrTCXAKsaIrRIHCdEcgqRrN0ilAWddRDu--
