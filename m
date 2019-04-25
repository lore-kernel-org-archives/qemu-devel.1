Received: from eggs.gnu.org ([209.51.188.92]:49555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJbYU-00046q-UC
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJbYT-0005m9-Oz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:24:38 -0400
From: Thomas Huth <thuth@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-6-thuth@redhat.com>
	<6b284aaa-353c-92c1-b01b-21882e7ff9ef@redhat.com>
	<e8d6cbeb-b1aa-deb1-b7a7-c3c7a3906229@redhat.com>
Message-ID: <6d98dd44-158e-136b-fc0a-105a0c4a120f@redhat.com>
Date: Thu, 25 Apr 2019 12:24:24 +0200
MIME-Version: 1.0
In-Reply-To: <e8d6cbeb-b1aa-deb1-b7a7-c3c7a3906229@redhat.com>
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
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Christophe Fergeau <cfergeau@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>

On 25/04/2019 07.57, Thomas Huth wrote:
> On 24/04/2019 22.42, Wainer dos Santos Moschetta wrote:
>> Hi Thomas,
>>
>>
>> On 04/24/2019 07:37 AM, Thomas Huth wrote:
>>> People often forget to run the iotests before submitting patches or
>>> pull requests - this is likely due to the fact that we do not run the
>>> tests during our mandatory "make check" tests yet. Now that we've got
>>> a new "ci" group of iotests that should be fine to run in every envir=
on-
>>> ment, it should be OK to enable the iotests during "make check" again=
.
>>> Thus we now run the "ci" tests by default from the qemu-iotests-quick=
.sh
>>> script, and only use the former "quick" group (that contains some tes=
ts
>>> that are failing in some environments) when the user decided to run
>>> "make check SPEED=3Dthorough" or something similar.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> =C2=A0 tests/Makefile.include=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2=
 +-
>>> =C2=A0 tests/qemu-iotests-quick.sh | 17 ++++++++++++++++-
>>> =C2=A0 2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> One of Patchew's runners failed with this patch series:
>> https://patchew.org/QEMU/20190424103747.10173-1-thuth@redhat.com/
>>
>> I encountered same failures with `make check` locally on Fedora 29
>> x86_64 (pulled latest qemu, and configured with defaults and
>> x86_64-softmmu target):
>> ---
>> Not run: 233
>> Failures: 069 103 114 133 140 143 197 215 226 244
>=20
> Ok, thanks for the info. Looks like many tests are failing because qemu=
-io suddenly prints its program name in front of the error messages? E.g.=
:
>=20
> --- /tmp/qemu-test/src/tests/qemu-iotests/069.out	2019-04-24 16:52:31.0=
00000000 +0000
> +++ /tmp/qemu-test/build/tests/qemu-iotests/069.out.bad	2019-04-24 16:5=
9:13.310226424 +0000
> @@ -4,5 +4,5 @@
> =20
>  Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D131072
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D131072 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
> -can't open device TEST_DIR/t.IMGFMT: Could not open backing file: Coul=
d not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
> +qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open backing f=
ile: Could not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
>=20
> Does anybody from the block folks has a clue what might be going wrong =
here?

It's a regression in the current master branch, not caused by my series.
The iotests also fail with vanilla master, e.g. reproducible with:

 cd tests/qemu-iotests
 ./check -qcow2 069

It's caused by Christophe's commit here:

 99e98d7c9fc1a1639fad2c638733b02f4b43aebe
 qemu-io: Use error_[gs]et_progname()

Christophe, could you please have a look?

 Thanks,
  Thomas
