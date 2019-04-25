Received: from eggs.gnu.org ([209.51.188.92]:44329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJZ3P-0003WY-At
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJZ3N-0007OB-VS
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:44:23 -0400
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-3-thuth@redhat.com>
	<20190424112537.GF31388@redhat.com>
	<c2202c0c-e504-7678-d1f3-6afc67bd2164@redhat.com>
	<20190424125046.GJ31388@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <19e0671e-bb83-8696-0111-804612fa1d12@redhat.com>
Date: Thu, 25 Apr 2019 09:44:07 +0200
MIME-Version: 1.0
In-Reply-To: <20190424125046.GJ31388@redhat.com>
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

On 24/04/2019 14.50, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 24, 2019 at 02:37:02PM +0200, Thomas Huth wrote:
>> On 24/04/2019 13.25, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Apr 24, 2019 at 12:37:43PM +0200, Thomas Huth wrote:
>>>> Tests in this group are supposed to run in every possible QEMU confi=
guration.
>>>> That means they should run with every QEMU binary (also non-x86), wi=
thout
>>>> dependencies on an optional features, they must work at least with t=
he qcow2
>>>> image format and be able to run on all kind of host filesystems and =
users
>>>> (i.e. also as "nobody" or "root").
>>>>
>>>> The initial list has been created as a subset of the "quick" group, =
where
>>>> I've disabled all tests that are failing with qemu-system-aarch64 or
>>>> qemu-system-tricore or in one of our CI pipelines.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/group | 194 ++++++++++++++++++++----------------=
---
>>>>  1 file changed, 102 insertions(+), 92 deletions(-)
>>>>
>>>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>>>> index bae7718380..2ed42dcc14 100644
>>>> --- a/tests/qemu-iotests/group
>>>> +++ b/tests/qemu-iotests/group
>>>> @@ -4,63 +4,73 @@
>>>>  # - do not start group names with a digit
>>>>  #
>>>> =20
>>>> +#
>>>> +# Some notes about the groups:
>>>> +# - Tests in the "quick" group should finish within some few second=
s
>>>> +# - Tests in the "ci" group are suitable for running in CI systems.=
 That
>>>> +#   means they should run with every QEMU binary (also non-x86), wi=
th
>>>> +#   every QEMU configuration (i.e. no dependency on an optional fea=
ture),
>>>> +#   at least with the qcow2 image format and all kind of host files=
ystems
>>>> +#   and users (i.e. also as "nobody" or "root").
>>>
>>> No dependancy on optional features feels a bit restrictive from my PO=
V.
>>>
>>> We have quite alot of testing coverage of stuff that depends on the
>>> crypto libraries that is important for us to run in "CI". This includ=
es
>>> LUKS block drivers, qcow2 with LUKS,  NBD with TLS. Personally I expe=
ct
>>> all of those to be tested by CI systems.
>>>
>>> IOW for a "CI" group, the bar should be higher than "no optional feat=
ures"
>>
>> Ok, I think I just did not write it properly. What I meant was: the te=
st
>> should not *fail* because of a missing feature (what some tests are
>> unfortunately doing). It's fine if the test detects the missing featur=
e
>> and then marks the test as *skip*.
>=20
> Ok, this brings back the topic I don't think we ever resolved around ho=
w
> to best "detect" features in the iotests. eg if we want to know whether
> we can use TLS features, how do we decide this ?
>=20
> One option is to do a dummy launch of QEMU using TLS & check if it fail=
s,
> but that's kind of fragile for CI. A genuine bug in QEMU might cause th=
is
> dummy launch to fail, and thus mistakenly skip all the tests instead of
> failing.

Maybe we need a "--dump-features" option for QEMU (or a QMP command)?
(somewhat similar to "gcc -dumpspecs" for example?)

 Thomas
