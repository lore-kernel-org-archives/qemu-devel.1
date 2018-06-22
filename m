Received: from eggs.gnu.org ([2001:4830:134:3::10]:54579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWSkY-0002r0-Ks
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWSkV-0005cx-Ft
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:33:42 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:46908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWSkV-0005co-BG
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:33:39 -0400
Received: by mail-qk0-x241.google.com with SMTP id o2-v6so4387803qkc.13
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 13:33:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622140223.26056-1-f4bug@amsat.org>
	<CAMo8Bf+_bSYrz_grbvHgpFsNmA7pJDOzjLUhLq2YfmV8FdoXkQ@mail.gmail.com>
	<878t76vlal.fsf@linaro.org>
	<CAMo8Bf+OfMyORPN69vROMBMUDF9ucNVMCOHF7EFfXFO7Qpnr1g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c721aacc-6ee9-28e3-a8f9-c3c836d42355@amsat.org>
Date: Fri, 22 Jun 2018 17:33:34 -0300
MIME-Version: 1.0
In-Reply-To: <CAMo8Bf+OfMyORPN69vROMBMUDF9ucNVMCOHF7EFfXFO7Qpnr1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add fedora-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 06/22/2018 03:45 PM, Max Filippov wrote:
> On Fri, Jun 22, 2018 at 9:27 AM, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Max Filippov <jcmvbkbc@gmail.com> writes:
>>> On Fri, Jun 22, 2018 at 7:02 AM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>> As of this commit:
>>>>
>>>>   $ xtensa-linux-gnu-as -v
>>>>   GNU assembler version 2.29.1 (xtensa-linux-gnu) using BFD version version 2.29.1-1.fc27
>>>>
>>>>   $ xtensa-linux-gnu-gcc -v
>>>>   Target: xtensa-linux-gnu
>>>>   gcc version 7.2.1 20170915 (Red Hat Cross 7.2.1-1) (GCC)
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>  tests/docker/dockerfiles/fedora-xtensa-cross.docker | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>  create mode 100644 tests/docker/dockerfiles/fedora-xtensa-cross.docker
>>>>
>>>> diff --git a/tests/docker/dockerfiles/fedora-xtensa-cross.docker b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
>>>> new file mode 100644
>>>> index 0000000000..6f9521520c
>>>> --- /dev/null
>>>> +++ b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
>>>> @@ -0,0 +1,7 @@
>>>> +FROM fedora:latest
>>>> +ENV PACKAGES \
>>>> +    binutils-xtensa-linux-gnu \
>>>> +    gcc-xtensa-linux-gnu
>>>
>>> Generic binutils and gcc for xtensa only (partially) make sense for
>>> build testing.
>>
>> OK
>>
>>> Built binaries will not work.
>>
>> Why?
> 
> The default toolchain does not generate code for any real xtensa CPU
> configuration or for any configuration supported by the QEMU.
> The xtensa configuration overlay for a specific CPU must be applied
> to the toolchain source in order to build a toolchain capable of
> producing code that would work on that CPU.
> There's FSF xtensa CPU configuration in QEMU that is compatible with
> very old (older than 2.19 IIRC) binutils.

While the Fedora binutils supports dual endianness, the compiler only
works for big-endian:

$ docker run --rm -it qemu:fedora-xtensa-cross xtensa-linux-gnu-objcopy
xtensa-linux-gnu-objcopy: supported targets: elf32-xtensa-le
elf32-xtensa-be elf32-little elf32-big

$ docker run --rm -it qemu:fedora-xtensa-cross bash -c \
  'echo -e "__XTENSA_EL__\n__XTENSA_EB__" | \
  xtensa-linux-gnu-gcc -E - | grep -v "\#"'
__XTENSA_EL__
1

> xtensa TCG tests (at least
> some of them) are written for the dc232b xtensa CPU. The configuration

I learned that the hard way :(

I took the only big-endian CPU available: FSF, however

- the linkscript expect the unavailable XTENSA_HAVE_BE definition,
- core-isa.h misses the following definitions:

#define XCHAL_KERNEL_VECOFS             0x00000200 /* XXX ??? */
#define XCHAL_INTLEVEL2_VECOFS          0x00000180 /* XXX ??? */
#define XCHAL_INTLEVEL3_VECOFS          0x00000240 /* XXX ??? */
#define XCHAL_INTLEVEL4_VECOFS          0x00000520 /* XXX ??? */

So this is a dead-end.

> overlay for that CPU is available here:
> 
>   https://github.com/jcmvbkbc/xtensa-toolchain-build/blob/master/overlays/xtensa_dc232b.tar.gz
> 
> The following toolchain may be used to build working tests for xtensa:
> 
>   https://github.com/foss-xtensa/toolchain/releases/download/2018.02/x86_64-2018.02-xtensa-dc232b-elf.tar.gz

Thanks for the links, I'll continue with DC232B next week.

Alex: Can you dequeue this patch please?

Regards,

Phil.
