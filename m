Received: from eggs.gnu.org ([2001:4830:134:3::10]:42161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1da2zY-0003Sa-C7
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1da2zX-0002ww-D2
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:47:28 -0400
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
	<20170721140155.GQ17693@redhat.com>
	<bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
	<20170725154921.GS23343@stefanha-x1.localdomain>
	<547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
	<20170725162405.GT26394@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <b0b6a212-2be4-dfb2-3c99-615555efbb60@redhat.com>
Date: Tue, 25 Jul 2017 12:47:11 -0400
MIME-Version: 1.0
In-Reply-To: <20170725162405.GT26394@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FH97MlbokmIHEjbjcwSJqp1Men26hPNc6"
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FH97MlbokmIHEjbjcwSJqp1Men26hPNc6
From: Cleber Rosa <crosa@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <b0b6a212-2be4-dfb2-3c99-615555efbb60@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
References: <20170721034730.25612-1-crosa@redhat.com>
 <20170721123325.GC18014@stefanha-x1.localdomain>
 <20170721140155.GQ17693@redhat.com>
 <bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
 <20170725154921.GS23343@stefanha-x1.localdomain>
 <547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
 <20170725162405.GT26394@redhat.com>
In-Reply-To: <20170725162405.GT26394@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/25/2017 12:24 PM, Daniel P. Berrange wrote:
>>
>> OK, let's abstract a bit more.  Let's take this part of your statement=
:
>>
>>  "if qemu-io in this environment cannot do aio=3Dnative"
>>
>> Let's call that a feature check.  Depending on how the *feature check*=

>> is written, a negative result may hide a test failure, because it woul=
d
>> now be skipped.
>>
>> Suppose that a feature check for "SDL display" is such that you run
>> "qemu -display sdl".  A *feature failure* here (SDL init is broken), o=
r
>> an environment issue (DISPLAY=3D), will cause a SDL test skip.
>=20
> You could have a way to statically define what features any given run
> of the test suite should enable, then report failure if they were not
> detected.
>=20

You hit a key point here: statically define(d).  As a said before,
feature statements are a safer place upon which to base tests.  Ad hoc
checks, as suggested by Stefan, are definitely not.

> This is a similar situation to that seen with configure scripts. If inv=
oked
> with no --enable-xxx flags, it will probe for features & enable them if=

> found.  This means you can accidentally build without expected features=
 if
> you have a missing -devel package, or a header/library is broken in som=
e
> way. This is why configure prints a summary of which features it actual=
ly
> found. It is also why when building binary packages like RPMs, it is co=
mmon
> to explicitly give --enable-xxx flags for all features you expect to se=
e.
> Automatic enablement is none the less still useful for people in genera=
l.
>=20
> So if we applied this kind of approach for testing, then any automated
> test systems at least, ought to provide a fixed list of features they
> expect to be present for tests. So if any features accidentally broke
> the tests would error.
>=20
> Regards,
> Daniel
>=20

Right.  The key question here seems to be the distance of the "fixed
list of features" from the test itself.  For instance, think of this
workflow/approach:

 1) ./scripts/configured-features-to-feature-list.sh > ~/feature_list
 2) tweak feature_list
 3) ./rpm -e SDL-devel
 4) ./configure  --enable-sdl
 5) ./make
 6) ./scripts/run-test-suite.sh --only-features=3D~/feature_list

This would only run tests that are expected to PASS within the given
feature list.  The test runner (run-test-suite.sh) would select only
tests that match the features given.  No SKIPs would be expected as the
outcome of *any test*.

The other approach is to let the feature match to the test, and SKIPs
would then be OK.  The downside to this is that a "--enable-xxx" with
missing "-devel" package, as you exemplified, would not show up as ERRORs=
=2E

Makes sense?

Regards!

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--FH97MlbokmIHEjbjcwSJqp1Men26hPNc6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZd3YPAAoJEGV+jTOl8gnzyYcP/iVc6kDu8wVOjTpZPUz1lnWw
v6fzqiDX78Lf6kUjumQA6B24YMyvt427xOSlQRjJWaE6fOYangTx0MurmqVT6fzp
Sa3nitue6vKXfpvCHt7InV2zmAZSHuKtVE2Fl+y0SAOLAu1S3B8o3VKhm/FWtvOw
UYlIkLAw0F9O75Aqrato3SJUAm4702v2smuMHo59NY1pCoZyCiguP529EDuRxWrD
2pm+Z2O/9CsBnhzvgfGGsJ91+AF4dH+FtzpFFmMqGbwmnjHll8SZG0UCpPO/Cm8/
BVFawYRU+H+eUk+PiDgDhnR3uyvkeD4OR2jYVSBONo7qq1unar8MQ0ue0w5ki+LM
ZCLcYXYLYdk0u6x9BdYL/Lg67K1UfAVf42R6E4vX4Jo/auHNaSo1FBpPAh6V/LVN
SK/6HFV4i8fdCuQUQ/QmYL6COYLIxaVKz18ykJ6vVOK+Mq2WbCHB/jmz6KHwLrJa
eOfKp3wDtphCOLrIs4Q9AEzOOyjkgyFpDR7WBOGi6/ktZVvS9m+zQM0/icCvBYVO
dvaXgdurSUtaWoxmlZNf+D1Np2iwWGqNg67MfChByX6Rgj/1LPC+1jCa0UP4Po+9
mhWYZLyJwBTiEmmJmcmn07F7/E/3a+56hzGoAryAytsOd9Nw9wBGmcNU9rKoJbz1
EPLiP0GcWgvNR48nfWNu
=zU6r
-----END PGP SIGNATURE-----

--FH97MlbokmIHEjbjcwSJqp1Men26hPNc6--
