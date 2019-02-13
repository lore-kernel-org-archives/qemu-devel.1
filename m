Received: from eggs.gnu.org ([209.51.188.92]:60978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtvDc-0006hR-WB
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtv8f-0003JZ-OM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:03:55 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtv8d-00036x-Kc
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:03:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id t18so2648146wrx.2
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 06:03:43 -0800 (PST)
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
	<CAJ+F1CJLHPa3LtviMGQuuwjv-PMzeeR4tJGoHHOz_JqfRR927A@mail.gmail.com>
	<9336d69b-8896-4a19-c580-b6ce5aefec2d@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <9336d69b-8896-4a19-c580-b6ce5aefec2d@redhat.com>
Date: Wed, 13 Feb 2019 14:03:40 +0000
Message-ID: <87imxniy4j.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>, Philippe =?utf-8?Q?M?= =?utf-8?Q?athieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>


Thomas Huth <thuth@redhat.com> writes:

> On 2019-02-13 13:06, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Wed, Feb 13, 2019 at 12:55 PM Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> This is very convenient for people like me who store their QEMU git tre=
es
>>> on gitlab.com: Automatic CI pipelines are now run for each branch that =
is
>>> pushed to the server - useful for some extra-testing before sending PUL=
L-
>>> requests for example. Since the runtime of the jobs is limited to 1h, t=
he
>>> jobs are distributed into multiple pipelines - this way everything fini=
shs
>>> fine within time (ca. 30 minutes currently).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  An example can be seen here: https://gitlab.com/huth/qemu/pipelines/
>>>
>>>  I'd really like to get this into the main QEMU repository, so that I d=
on't
>>>  have to cherry-pick this patch onto my testing branches anymore each t=
ime
>>>  I want to test before sending a PULL request...
>>>
>>>  .gitlab-ci.yml | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>>  MAINTAINERS    |  5 ++++
>>>  2 files changed, 78 insertions(+)
>>>  create mode 100644 .gitlab-ci.yml
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> new file mode 100644
>>> index 0000000..79d02cf
>>> --- /dev/null
>>> +++ b/.gitlab-ci.yml
>>> @@ -0,0 +1,73 @@
>>> +before_script:
>>> + - apt-get update -qq
>>> + - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev ge=
nisoimage
>>> +
>>> +build-system1:
>>> + script:
>>> + - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard=
-dev
>>> +      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev
>>> + - ./configure --enable-werror --target-list=3D"aarch64-softmmu alpha-=
softmmu
>>> +      cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazee=
l-softmmu
>>> +      mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-=
softmmu"
>>> + - make -j2
>>
>> Have you tried $(nproc) ?
>
> The containers are only single CPU there. I'm using -j2 just in case one
> of the processes is blocked by waiting for IO, the other one can still
> continue compiling.
>
>> Despite the duplication of CI files, which is not really a problem imho,
>>
>> lgtm,
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Thanks!
>
> And yes, I also think the duplication of the CI files should not really
> be a problem - it's rather a plus since we also got test variations this
> way. I already found some bugs with this here that were not detected by
> the other CI setups yet (e.g. since one of the pipelines uses
> --disable-replication and other --disable-xxx flags).

Sure I'm happy to have a thousand flowers bloom in this regard.

Do you know if gitlab does build status buttons like the others?

--
Alex Benn=C3=A9e
