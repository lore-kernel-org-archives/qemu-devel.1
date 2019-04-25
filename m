Received: from eggs.gnu.org ([209.51.188.92]:43113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJihw-0005QW-Qr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJihv-0002QT-EA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:02:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hJihv-0002QE-5K
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:02:51 -0400
References: <20190329210804.22121-1-wainersm@redhat.com>
	<5005fcec-42af-427c-4f68-8415490e9598@redhat.com>
	<5bf78706-d357-a92d-7065-46a9839c9c2f@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <8dd51a23-65a1-f567-e1cd-b0af665d22ad@redhat.com>
Date: Thu, 25 Apr 2019 15:02:41 -0300
MIME-Version: 1.0
In-Reply-To: <5bf78706-d357-a92d-7065-46a9839c9c2f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] tests/vm: Python 3,
 improve image caching, and misc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, philmd@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org

Hi Laszlo,


On 04/24/2019 06:07 AM, Laszlo Ersek wrote:
> Hello Wainer,
>
> (answering because I dislike ignoring emails without giving any feedbac=
k:)

I appreciated that! thanks!

>
> On 04/23/19 21:28, Wainer dos Santos Moschetta wrote:
>> Ping. More reviews needed.
>>
>> I've already got Philippe's reviewed-by, thanks!
> I'm going to skip this one. According to "scripts/get_maintainer.pl", a=
n
> ACK from either Alex or Fam should suffice. (They could also decide to
> queue your set with Phil's R-b, who's a designated reviewer on this top=
ic.)

Yes, that's ok.

I'm CC'ing you because the fix on patch 3/5 has origin on a discussion=20
on your series ...

[PATCH for-4.1 v3 00/12] bundle edk2 platform firmware with QEMU

... see at https://www.mail-archive.com/qemu-devel@nongnu.org/msg606796.h=
tml

Sorry, failed to explain the context when I sent this series.

Thanks!

- Wainer

>
> Thanks
> Laszlo
>
>> On 03/29/2019 06:07 PM, Wainer dos Santos Moschetta wrote:
>>> Hi all!
>>>
>>> This series bundles the support to Python3, improvement to image
>>> caching, and miscellaneous changes for the vm-test (`make vm-build-*`=
).
>>>
>>> Git tree: http://github.com/wainersm/qemu
>>> Branch: vm_test_python3_and_misc
>>> Travis: https://travis-ci.org/wainersm/qemu/builds/513220300
>>>
>>> Below you can find some general comments.
>>>
>>> Patch 01:
>>> Uses python configured at build, although vm-test can be executed fro=
m
>>> the code tree (see docs/devel/testing.rst) too. In this case $(PYTHON=
)
>>> will be empty and it picks python pointed by the script's shebang, as
>>> a result failing on Python 3 only Linux distros.
>>>
>>> Patch 02:
>>> Ported based.py to work with Python 3 (kept Python 2 compatibility).
>>> Fixed the follow errors:
>>>  =C2=A0=C2=A0 - Raising "TypeError: Unicode-objects must be encoded b=
efore
>>> hashing" exception by hashlib.sha1().
>>>  =C2=A0=C2=A0 - get_default_jobs() is used to set the vm cpus, but it=
 was
>>> returning an invalid float number.
>>>  =C2=A0=C2=A0 - On check_sha256sum(), subprocess.check_output() retur=
ns bytes so
>>> that string comparison was failing.
>>>
>>> Patch 03:
>>> Implemented a simple mechanism to detect the image file changed on
>>> http://download.patchew.org, as discussed in
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg607839.html. I
>>> didn't implement the '--force' option that Paolo suggested, because i=
t
>>> would require a major refactoring (technically the vm implementation
>>> decides whether use the cache or not). My intention is to keep the
>>> script as simple as possible, so IMO, if the image file changed on th=
e
>>> server then it should equally be updated the checksum on QEMU's side.
>>>
>>> Patch 04:
>>> Default network (NETWORK=3D1) backend is enough to have the docker-ba=
sed
>>> tests run properly. Note: `make docker-test-block@centos7` is broken
>>> inside the CentOS VM and apparently on my host (Fedora 29 x86_64) too=
.
>>>
>>> Wainer dos Santos Moschetta (5):
>>>  =C2=A0=C2=A0 tests/vm: Use python configured on build
>>>  =C2=A0=C2=A0 tests/vm: Port basevm to Python 3
>>>  =C2=A0=C2=A0 tests/vm: Detect the image changed on server
>>>  =C2=A0=C2=A0 tests/vm: Fix build-centos docker-based tests run
>>>  =C2=A0=C2=A0 tests/vm: Add missing variables on help
>>>
>>>  =C2=A0 tests/vm/Makefile.include | 12 ++++++++----
>>>  =C2=A0 tests/vm/basevm.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 39 ++++++++++++++++++++++++++++++++++-----
>>>  =C2=A0 tests/vm/centos=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 +++---
>>>  =C2=A0 3 files changed, 45 insertions(+), 12 deletions(-)
>>>
