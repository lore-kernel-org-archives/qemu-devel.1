Received: from eggs.gnu.org ([2001:4830:134:3::10]:48978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMDqn-0006x2-UM
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMDqi-0006E5-4k
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:10:05 -0500
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181109221213.7310-3-crosa@redhat.com>
	<a6993de7-340f-848a-809b-2d07e2923fc7@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <f34f4adc-419a-953f-58d2-2df8f853d4f2@redhat.com>
Date: Mon, 12 Nov 2018 10:04:36 -0500
MIME-Version: 1.0
In-Reply-To: <a6993de7-340f-848a-809b-2d07e2923fc7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] qemu-img: consider a zero number
 of I/O requests an invalid count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 11/12/18 9:38 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/11/18 23:12, Cleber Rosa wrote:
>> It's debatable whether it makes sense to consider the bench command
>> successful when no I/O requests will be performed.=C2=A0 This changes =
the
>> behavior to consider a zero count of I/O requests an invalid value.
>> While at it, avoid using signed types for number of I/O requests.
>>
>> The image file used, is a simple raw image with 1K size.=C2=A0 There's=
 a
>> obvious trade off between creating and reusing those images.=C2=A0 Thi=
s is
>> an experiment in sharing those among tests.=C2=A0 It was created using=
:
>>
>> =C2=A0 mkdir -p tests/data/images/empty
>> =C2=A0 cd tests/data/images/empty
>> =C2=A0 qemu-img create raw 1K
>>
>> This relies on the Test's "get_data()", which by default looks for
>> data files on sources that map to various levels of specificity of a
>> test: file, test and additionally with variant and a symlink.
>>
>> One other possibility with regards to in-tree images, is to extend the
>> Test's "get_data()" API (which is extensible by design) and make the
>> common images directory a "source".=C2=A0 The resulting API usage woul=
d be
>> similar to:
>>
>> =C2=A0=C2=A0=C2=A0 self.get_data("empty/raw", source=3D"common_images"=
)
>>
>> or simply:
>>
>> =C2=A0=C2=A0=C2=A0 self.get_data("empty/raw")
>>
>> To look for "empty/raw" in any of the available sources.=C2=A0 That wo=
uld
>> make the symlink unnecessary.
>>
>> Reference:
>> https://avocado-framework.readthedocs.io/en/65.0/api/core/avocado.core=
.html#avocado.core.test.TestData
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>> =C2=A0 qemu-img.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 8 ++---
>> =C2=A0 tests/acceptance/qemu_img_bench.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 34 ++++++++++++++++++++
>> =C2=A0 tests/acceptance/qemu_img_bench.py.data/img |=C2=A0=C2=A0 1 +
>> =C2=A0 tests/data/images/empty/raw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Bin 0 -> 1=
024 bytes
>> =C2=A0 4 files changed, 39 insertions(+), 4 deletions(-)
>> =C2=A0 create mode 100644 tests/acceptance/qemu_img_bench.py
>> =C2=A0 create mode 120000 tests/acceptance/qemu_img_bench.py.data/img
>> =C2=A0 create mode 100644 tests/data/images/empty/raw
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 4c96db7ba4..7ffcdd1589 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -3960,7 +3960,7 @@ typedef struct BenchData {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int bufsize;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int step;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nrreq;
>> -=C2=A0=C2=A0=C2=A0 int n;
>> +=C2=A0=C2=A0=C2=A0 unsigned int n;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int flush_interval;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool drain_on_flush;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *buf;
>> @@ -4051,7 +4051,7 @@ static int img_bench(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool quiet =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool image_opts =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool is_write =3D false;
>> -=C2=A0=C2=A0=C2=A0 int count =3D 75000;
>> +=C2=A0=C2=A0=C2=A0 unsigned int count =3D 75000;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int depth =3D 64;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t bufsize =3D 4096;
>> @@ -4098,7 +4098,7 @@ static int img_bench(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned long res;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res >
>> INT_MAX) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res >
>> UINT_MAX || res <=3D 0) {
>=20
> res is unsigned so can't be < 0.
>=20

Right, that should have been obvious to me.

Thanks!
- Cleber.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Invalid request count specif=
ied");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> @@ -4248,7 +4248,7 @@ static int img_bench(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .flush_interval=
 =3D flush_interval,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .drain_on_flush=
 =3D drain_on_flush,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> -=C2=A0=C2=A0=C2=A0 printf("Sending %d %s requests, %d bytes each, %d =
in parallel "
>> +=C2=A0=C2=A0=C2=A0 printf("Sending %u %s requests, %d bytes each, %d =
in parallel "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "(starting at offset %" PRId64 ", step size %d)\n",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 data.n, data.write ? "write" : "read", data.bufsize,
>> data.nrreq,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 data.offset, data.step);
>> diff --git a/tests/acceptance/qemu_img_bench.py
>> b/tests/acceptance/qemu_img_bench.py
>> new file mode 100644
>> index 0000000000..327524ad8f
>> --- /dev/null
>> +++ b/tests/acceptance/qemu_img_bench.py
>> @@ -0,0 +1,34 @@
>> +# Test for the basic qemu-img bench command
>> +#
>> +# Copyright (c) 2018 Red Hat, Inc.
>> +#
>> +# Author:
>> +#=C2=A0 Cleber Rosa <crosa@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.=C2=A0 See the COPYING file in the top-level directory.
>> +
>> +import os
>> +
>> +from avocado_qemu import QemuImgTest
>> +from avocado.utils import process
>> +
>> +
>> +class Bench(QemuImgTest):
>> +=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0 Runs the qemu-img tool with the bench command and =
different
>> +=C2=A0=C2=A0=C2=A0 options and verifies the expected outcome.
>> +
>> +=C2=A0=C2=A0=C2=A0 :avocado: enable
>> +=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0 def check_invalid_count(self, count):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D "%s bench -c %d %s=
" % (self.qemu_img_bin, count,
>> self.get_data("img"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D process.run(cmd=
, ignore_status=3DTrue)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(1, result=
.exit_status)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn(b"Invalid re=
quest count", result.stderr)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_zero_count(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.check_invalid_count(0=
)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_negative_count(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.check_invalid_count(-=
1)
>> diff --git a/tests/acceptance/qemu_img_bench.py.data/img
>> b/tests/acceptance/qemu_img_bench.py.data/img
>> new file mode 120000
>> index 0000000000..6d01ef2e85
>> --- /dev/null
>> +++ b/tests/acceptance/qemu_img_bench.py.data/img
>> @@ -0,0 +1 @@
>> +../../data/images/empty/raw
>> \ No newline at end of file
>> diff --git a/tests/data/images/empty/raw b/tests/data/images/empty/raw
>> new file mode 100644
>> index
>> 0000000000000000000000000000000000000000..06d7405020018ddf3cacee90fd4a=
f10487da3d20
>>
>> GIT binary patch
>> literal 1024
>> ScmZQz7zLvtFd70QH3R?z00031
>>
>> literal 0
>> HcmV?d00001
>>
