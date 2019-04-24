Received: from eggs.gnu.org ([209.51.188.92]:47300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJFiP-0008HY-Tx
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJFdT-0005p6-R5
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:00:21 -0400
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-6-thuth@redhat.com>
	<20190424104855.GE31388@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d9137693-7727-5f2c-04f3-b1eafd70f056@redhat.com>
Date: Wed, 24 Apr 2019 12:59:59 +0200
MIME-Version: 1.0
In-Reply-To: <20190424104855.GE31388@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
 check" again
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

On 24/04/2019 12.48, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 24, 2019 at 12:37:46PM +0200, Thomas Huth wrote:
>> People often forget to run the iotests before submitting patches or
>> pull requests - this is likely due to the fact that we do not run the
>> tests during our mandatory "make check" tests yet. Now that we've got
>> a new "ci" group of iotests that should be fine to run in every enviro=
n-
>> ment, it should be OK to enable the iotests during "make check" again.
>> Thus we now run the "ci" tests by default from the qemu-iotests-quick.=
sh
>> script, and only use the former "quick" group (that contains some test=
s
>> that are failing in some environments) when the user decided to run
>> "make check SPEED=3Dthorough" or something similar.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/Makefile.include      |  2 +-
>>  tests/qemu-iotests-quick.sh | 17 ++++++++++++++++-
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>=20
>> diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick.sh
>> index 0e554bb972..416b3fc48b 100755
>> --- a/tests/qemu-iotests-quick.sh
>> +++ b/tests/qemu-iotests-quick.sh
>=20
> s/-quick//  perhaps, since it no longer only runs the "quick" tests.
>=20
>> @@ -1,8 +1,23 @@
>>  #!/bin/sh
>> =20
>> +# Honor the SPEED environment variable, just like we do it for the qt=
ests.
>> +# The default is to run all tests that still work fine in a CI enviro=
nments,
>> +# but if the user set SPEED=3Dslow or SPEED=3Dthorough, we also run a=
ll other
>> +# tests that are still marked as "quick"
>> +if [ "$SPEED" =3D "slow" -o "$SPEED" =3D "thorough" ]; then
>> +    group=3Dquick
>=20
> When user asks for "slow" tests we run the "quick" tests, which
> presumably implies...
>=20
>> +else
>> +    group=3Dci
>=20
> ..."ci" is quicker than the "quick"  tests !
>=20
> Confused ? We certainly try to ensure that you will be :-)

... and there is also tests/check-block.sh (which is not used by "make
check-block", by the way, but still talks about "make check-block"),
which is even slower than the "ci" and "quick" group...

I guess that could be cleaned up, too (why do we need two scripts?) ...
just not sure how the final result should look like and if it should be
part of this patch series or rather something separate. Max, Kevin, what
do you think?

Maybe we should merge the two scripts, and depending on the SPEED
variable, we run:

 quick =3D> "ci" group
 thorough =3D> "quick" group
 slow =3D> old behaviour of the check-block.sh script

?

 Thomas
