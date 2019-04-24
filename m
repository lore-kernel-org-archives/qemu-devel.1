Received: from eggs.gnu.org ([209.51.188.92]:42781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJH9I-0004O7-Kk
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJH9H-0002G1-2K
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:37:16 -0400
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-3-thuth@redhat.com>
	<20190424112537.GF31388@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c2202c0c-e504-7678-d1f3-6afc67bd2164@redhat.com>
Date: Wed, 24 Apr 2019 14:37:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190424112537.GF31388@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] tests/qemu-iotests/group: Introduce a
 new "ci" group for CI pipelines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>

On 24/04/2019 13.25, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 24, 2019 at 12:37:43PM +0200, Thomas Huth wrote:
>> Tests in this group are supposed to run in every possible QEMU configu=
ration.
>> That means they should run with every QEMU binary (also non-x86), with=
out
>> dependencies on an optional features, they must work at least with the=
 qcow2
>> image format and be able to run on all kind of host filesystems and us=
ers
>> (i.e. also as "nobody" or "root").
>>
>> The initial list has been created as a subset of the "quick" group, wh=
ere
>> I've disabled all tests that are failing with qemu-system-aarch64 or
>> qemu-system-tricore or in one of our CI pipelines.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qemu-iotests/group | 194 ++++++++++++++++++++------------------=
-
>>  1 file changed, 102 insertions(+), 92 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index bae7718380..2ed42dcc14 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -4,63 +4,73 @@
>>  # - do not start group names with a digit
>>  #
>> =20
>> +#
>> +# Some notes about the groups:
>> +# - Tests in the "quick" group should finish within some few seconds
>> +# - Tests in the "ci" group are suitable for running in CI systems. T=
hat
>> +#   means they should run with every QEMU binary (also non-x86), with
>> +#   every QEMU configuration (i.e. no dependency on an optional featu=
re),
>> +#   at least with the qcow2 image format and all kind of host filesys=
tems
>> +#   and users (i.e. also as "nobody" or "root").
>=20
> No dependancy on optional features feels a bit restrictive from my POV.
>=20
> We have quite alot of testing coverage of stuff that depends on the
> crypto libraries that is important for us to run in "CI". This includes
> LUKS block drivers, qcow2 with LUKS,  NBD with TLS. Personally I expect
> all of those to be tested by CI systems.
>=20
> IOW for a "CI" group, the bar should be higher than "no optional featur=
es"

Ok, I think I just did not write it properly. What I meant was: the test
should not *fail* because of a missing feature (what some tests are
unfortunately doing). It's fine if the test detects the missing feature
and then marks the test as *skip*.

> Since we control the env used for CI via Docker or VM images, we can en=
sure
> that they're populated with a set of packages that maximises our covera=
ge.
> All our platforms support gnutls for example, which gets us all the cry=
pto
> bits we need.
>=20
> The problem of course is the desire to put this into "make check" by de=
fault
> which developers can run in any configuration.
>=20
> I think this is a sign that we need two distinct groupings.
>=20
> Stuff run by a generic "make check" /should not/ depend on optional fea=
tures,
>=20
> Stuff run by an automated CI system /should/ depend on optional feature=
s.=20

I think adding two new groups is not really needed here.
First, we already have the "quick" group that should contain most of the
tests with optional features. Second, just make sure that tests that
depend on optional features and still should be included in all CI
pipelines can detect the availability of the feature properly and report
"skip" if the feature is not available.

 Thomas
