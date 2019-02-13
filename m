Received: from eggs.gnu.org ([209.51.188.92]:39201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gttj5-0003rA-AB
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gttWr-00066C-94
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:20:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gttWm-00061k-5m
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:20:37 -0500
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
	<CAJ+F1CJLHPa3LtviMGQuuwjv-PMzeeR4tJGoHHOz_JqfRR927A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9336d69b-8896-4a19-c580-b6ce5aefec2d@redhat.com>
Date: Wed, 13 Feb 2019 13:20:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJLHPa3LtviMGQuuwjv-PMzeeR4tJGoHHOz_JqfRR927A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Add a gitlab-ci file for Continuous
 Integration testing on Gitlab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On 2019-02-13 13:06, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Feb 13, 2019 at 12:55 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> This is very convenient for people like me who store their QEMU git tr=
ees
>> on gitlab.com: Automatic CI pipelines are now run for each branch that=
 is
>> pushed to the server - useful for some extra-testing before sending PU=
LL-
>> requests for example. Since the runtime of the jobs is limited to 1h, =
the
>> jobs are distributed into multiple pipelines - this way everything fin=
ishs
>> fine within time (ca. 30 minutes currently).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  An example can be seen here: https://gitlab.com/huth/qemu/pipelines/
>>
>>  I'd really like to get this into the main QEMU repository, so that I =
don't
>>  have to cherry-pick this patch onto my testing branches anymore each =
time
>>  I want to test before sending a PULL request...
>>
>>  .gitlab-ci.yml | 73 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  MAINTAINERS    |  5 ++++
>>  2 files changed, 78 insertions(+)
>>  create mode 100644 .gitlab-ci.yml
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> new file mode 100644
>> index 0000000..79d02cf
>> --- /dev/null
>> +++ b/.gitlab-ci.yml
>> @@ -0,0 +1,73 @@
>> +before_script:
>> + - apt-get update -qq
>> + - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev g=
enisoimage
>> +
>> +build-system1:
>> + script:
>> + - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacar=
d-dev
>> +      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev
>> + - ./configure --enable-werror --target-list=3D"aarch64-softmmu alpha=
-softmmu
>> +      cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblaze=
el-softmmu
>> +      mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc=
-softmmu"
>> + - make -j2
>=20
> Have you tried $(nproc) ?

The containers are only single CPU there. I'm using -j2 just in case one
of the processes is blocked by waiting for IO, the other one can still
continue compiling.

> Despite the duplication of CI files, which is not really a problem imho=
,
>=20
> lgtm,
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!

And yes, I also think the duplication of the CI files should not really
be a problem - it's rather a plus since we also got test variations this
way. I already found some bugs with this here that were not detected by
the other CI setups yet (e.g. since one of the pipelines uses
--disable-replication and other --disable-xxx flags).

 Thomas
