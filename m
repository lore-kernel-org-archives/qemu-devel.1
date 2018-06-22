Received: from eggs.gnu.org ([2001:4830:134:3::10]:40602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWU1q-0007iI-QM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWU1n-0007RY-My
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:55:38 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:56231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWU1n-0007Qy-Bw
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:55:35 -0400
Received: by mail-wm0-x243.google.com with SMTP id v16-v6so3488308wmh.5
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 14:55:35 -0700 (PDT)
References: <20180622140223.26056-1-f4bug@amsat.org>
	<CAMo8Bf+_bSYrz_grbvHgpFsNmA7pJDOzjLUhLq2YfmV8FdoXkQ@mail.gmail.com>
	<878t76vlal.fsf@linaro.org>
	<CAMo8Bf+OfMyORPN69vROMBMUDF9ucNVMCOHF7EFfXFO7Qpnr1g@mail.gmail.com>
	<c721aacc-6ee9-28e3-a8f9-c3c836d42355@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <c721aacc-6ee9-28e3-a8f9-c3c836d42355@amsat.org>
Date: Fri, 22 Jun 2018 22:55:32 +0100
Message-ID: <87602av63v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add fedora-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 06/22/2018 03:45 PM, Max Filippov wrote:
>> On Fri, Jun 22, 2018 at 9:27 AM, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
>>> Max Filippov <jcmvbkbc@gmail.com> writes:
>>>> On Fri, Jun 22, 2018 at 7:02 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@am=
sat.org> wrote:
>>>>> As of this commit:
>>>>>
>>>>>   $ xtensa-linux-gnu-as -v
>>>>>   GNU assembler version 2.29.1 (xtensa-linux-gnu) using BFD version v=
ersion 2.29.1-1.fc27
>>>>>
>>>>>   $ xtensa-linux-gnu-gcc -v
>>>>>   Target: xtensa-linux-gnu
>>>>>   gcc version 7.2.1 20170915 (Red Hat Cross 7.2.1-1) (GCC)
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>> ---
>>>>>  tests/docker/dockerfiles/fedora-xtensa-cross.docker | 7 +++++++
>>>>>  1 file changed, 7 insertions(+)
>>>>>  create mode 100644 tests/docker/dockerfiles/fedora-xtensa-cross.dock=
er
>>>>>
>>>>> diff --git a/tests/docker/dockerfiles/fedora-xtensa-cross.docker b/te=
sts/docker/dockerfiles/fedora-xtensa-cross.docker
>>>>> new file mode 100644
>>>>> index 0000000000..6f9521520c
>>>>> --- /dev/null
>>>>> +++ b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
>>>>> @@ -0,0 +1,7 @@
>>>>> +FROM fedora:latest
>>>>> +ENV PACKAGES \
>>>>> +    binutils-xtensa-linux-gnu \
>>>>> +    gcc-xtensa-linux-gnu
>>>>
>>>> Generic binutils and gcc for xtensa only (partially) make sense for
>>>> build testing.
>>>
>>> OK
>>>
>>>> Built binaries will not work.
>>>
>>> Why?
>>
>> The default toolchain does not generate code for any real xtensa CPU
>> configuration or for any configuration supported by the QEMU.
>> The xtensa configuration overlay for a specific CPU must be applied
>> to the toolchain source in order to build a toolchain capable of
>> producing code that would work on that CPU.
>> There's FSF xtensa CPU configuration in QEMU that is compatible with
>> very old (older than 2.19 IIRC) binutils.
>
> While the Fedora binutils supports dual endianness, the compiler only
> works for big-endian:
>
> $ docker run --rm -it qemu:fedora-xtensa-cross xtensa-linux-gnu-objcopy
> xtensa-linux-gnu-objcopy: supported targets: elf32-xtensa-le
> elf32-xtensa-be elf32-little elf32-big
>
> $ docker run --rm -it qemu:fedora-xtensa-cross bash -c \
>   'echo -e "__XTENSA_EL__\n__XTENSA_EB__" | \
>   xtensa-linux-gnu-gcc -E - | grep -v "\#"'
> __XTENSA_EL__
> 1
>
>> xtensa TCG tests (at least
>> some of them) are written for the dc232b xtensa CPU. The configuration
>
> I learned that the hard way :(
>
> I took the only big-endian CPU available: FSF, however
>
> - the linkscript expect the unavailable XTENSA_HAVE_BE definition,
> - core-isa.h misses the following definitions:
>
> #define XCHAL_KERNEL_VECOFS             0x00000200 /* XXX ??? */
> #define XCHAL_INTLEVEL2_VECOFS          0x00000180 /* XXX ??? */
> #define XCHAL_INTLEVEL3_VECOFS          0x00000240 /* XXX ??? */
> #define XCHAL_INTLEVEL4_VECOFS          0x00000520 /* XXX ??? */
>
> So this is a dead-end.
>
>> overlay for that CPU is available here:
>>
>>   https://github.com/jcmvbkbc/xtensa-toolchain-build/blob/master/overlay=
s/xtensa_dc232b.tar.gz
>>
>> The following toolchain may be used to build working tests for xtensa:
>>
>>   https://github.com/foss-xtensa/toolchain/releases/download/2018.02/x86=
_64-2018.02-xtensa-dc232b-elf.tar.gz
>
> Thanks for the links, I'll continue with DC232B next week.
>
> Alex: Can you dequeue this patch please?

OK poor first choice for getting the system emulation patches working. I
wonder if the other fedora compilers will be useful for us?


> gcc-nios2-linux-gnu-7.1.1-3.fc27.i686.rpm
> gcc-microblaze-linux-gnu-7.1.1-3.fc27.i686.rpm
> gcc-tile-linux-gnu-7.1.1-3.fc27.i686.rpm
> gcc-cris-linux-gnu-7.1.1-3.fc27.i686.rpm


--
Alex Benn=C3=A9e
