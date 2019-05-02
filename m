Received: from eggs.gnu.org ([209.51.188.92]:58758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM4X3-00042n-JZ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM4Wv-0004zU-1B
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:45:17 -0400
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-8-thuth@redhat.com>
	<87sgty5dxt.fsf@zen.linaroharston>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <84804a36-849d-88ea-e300-7c3c6891ae98@redhat.com>
Date: Thu, 2 May 2019 07:44:21 +0200
MIME-Version: 1.0
In-Reply-To: <87sgty5dxt.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/8] tests/qemu-iotests/group: Re-use
 the "auto" group for tests that can always run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 01/05/2019 18.37, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> Currently, all tests are in the "auto" group. This is a little bit poi=
ntless.
>> OTOH, we need a group for the tests that we can automatically run duri=
ng
>> "make check" each time, too. Tests in this new group are supposed to r=
un
>> with every possible QEMU configuration, for example they must run with=
 every
>> QEMU binary (also non-x86), without failing when an optional features
>> is
>=20
> I'm curious as to what tests fail on non-x86? I was under the naive
> impression that at least for Linux all the file-system relevant bits
> where fairly uniformly implemented.
>=20
>> missing (but reporting "skip" is ok), and be able to run on all kind o=
f host
>> filesystems and users (i.e. also as "nobody" or "root").
>> So let's use the "auto" group for this class of tests now. The initial
>> list has been determined by running the iotests with non-x86 QEMU targ=
ets
>> and with our CI pipelines on Gitlab, Cirrus-CI and Travis (i.e. includ=
ing
>> macOS and FreeBSD).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
>=20
>=20
>> ---
>>  tests/qemu-iotests/group | 169 +++++++++++++++++++++-----------------=
-
>>  1 file changed, 91 insertions(+), 78 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index bae7718380..4d0b6ae256 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -1,8 +1,21 @@
>>  #
>>  # QA groups control file
>>  # Defines test groups
>> +#
>> +# Some notes about the groups:
>> +#
>>  # - do not start group names with a digit
>>  #
>> +# - quick : Tests in this group should finish within some few seconds=
.
>> +#
>> +# - img : Tests in this group can be used to excercise the qemu-img t=
ool.
>> +#
>> +# - auto : Tests in this group are used during "make check" and shoul=
d be
>> +#   runnable in any case. That means they should run with every QEMU =
binary
>> +#   (also non-x86), with every QEMU configuration (i.e. must not fail=
 if
>> +#   an optional feature is not compiled in - but reporting a "skip" i=
s ok),
>> +#   and work all kind of host filesystems and users (e.g. "nobody" or=
 "root").
>> +#
>>
>>  #
>>  # test-group association ... one line per test
>> @@ -32,11 +45,11 @@
>>  023 rw auto
>>  024 rw backing auto quick
>>  025 rw auto quick
>> -026 rw blkdbg auto
>> +026 rw blkdbg
>>  027 rw auto quick
>>  028 rw backing auto quick
>=20
> 028 failed on an armhf host for me.
>=20
>>  029 rw auto quick
>> -030 rw auto backing
>> +030 rw backing
> <snip>
>> +245 rw
>> +246 rw quick
>>  247 rw auto quick
>=20
> And 247

Ok, thanks, I'll remove them in v3. (We still can investigate and enable
them later if we care).

 Thomas
