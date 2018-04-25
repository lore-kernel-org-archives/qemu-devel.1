Received: from eggs.gnu.org ([2001:4830:134:3::10]:55420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBG1A-0008I7-Mx
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBG16-0006MD-L8
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:43:12 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:52669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBG16-0006Lj-Bl
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:43:08 -0400
Received: by mail-wm0-x230.google.com with SMTP id w195so5712913wmw.2
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 01:43:08 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-24-alex.bennee@linaro.org>
	<39980aff-713f-0fcb-006f-13f74846bfa0@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <39980aff-713f-0fcb-006f-13f74846bfa0@amsat.org>
Date: Wed, 25 Apr 2018 09:43:06 +0100
Message-ID: <87lgdbllr9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 23/46] tests/tcg/x86_64: add
 Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 04/24/2018 12:23 PM, Alex Benn=C3=A9e wrote:
>> The sources for x86_64 are shared in the i386 directory which will be
>> included thanks to TARGET_BASE_ARCH. However not all sources build so
>> we need to filter out the ones we can't build in the 64 bit world.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/i386/Makefile.target   |  2 +-
>>  tests/tcg/x86_64/Makefile.target | 15 +++++++++++++++
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>  create mode 100644 tests/tcg/x86_64/Makefile.target
>>
>> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.ta=
rget
>> index 80ccad3d7b..27086c3f2b 100644
>> --- a/tests/tcg/i386/Makefile.target
>> +++ b/tests/tcg/i386/Makefile.target
>> @@ -7,7 +7,7 @@ VPATH 		+=3D $(I386_SRC)
>>
>>  I386_SRCS=3D$(notdir $(wildcard $(I386_SRC)/*.c))
>>  I386_TESTS=3D$(I386_SRCS:.c=3D)
>> -
>> +I386_ONLY_TESTS=3D$(filter-out test-i386-ssse3, $(I386_TESTS))
>>  # Update TESTS
>>  TESTS+=3D$(I386_ONLY_TESTS)
>>
>> diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefil=
e.target
>> new file mode 100644
>> index 0000000000..74f170b9ed
>> --- /dev/null
>> +++ b/tests/tcg/x86_64/Makefile.target
>> @@ -0,0 +1,15 @@
>> +# -*- Mode: makefile -*-
>> +#
>> +# x86_64 tests - included from tests/tcg/Makefile.target
>> +#
>> +# Currently we only build test-x86_64 and test-i386-ssse3 from
>> +# $(SRC)/tests/tcg/i386/
>> +#
>> +
>> +X86_64_TESTS=3D$(filter-out $(I386_ONLY_TESTS), $(TESTS))
>> +X86_64_TESTS+=3Dtest-x86_64
>
> The linux-test is taking looooong... I canceled it after ~15min on a i7
> 2GHz. Maybe it also belongs to the "BROKEN TEST" series on x86_64?
> Currently it is only skipped if $(TARGET_NAME) =3D=3D i386.

Hmm it runs pretty quickly for me:

time ./qemu-x86_64 ./tests/linux-test
0.02user 0.03system 0:00.08elapsed 72%CPU (0avgtext+0avgdata 7384maxresiden=
t)k
0inputs+0outputs (0major+1207minor)pagefaults 0swaps

I wonder if the failure mode you are seeing is the same as the others
which basically hang, which is why I added them to the broken test patch.

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>> +TESTS:=3D$(X86_64_TESTS)
>> +
>> +test-x86_64: LDFLAGS+=3D-lm -lc
>> +test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv=
.h
>> +	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
>>
>
> $ make run-tcg-tests-x86_64-linux-user
>   RUN-TESTS for x86_64
>   TEST    test-mmap (default) on x86_64
>   TEST    test-mmap (8k pages) on x86_64
> ASAN:DEADLYSIGNAL
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D5717=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x7fcba4=
7fc000
> (pc 0x7fcba8a3bf4d bp 0x7ffd19d74700 sp 0x7ffd19d73e88 T0)
> =3D=3D5717=3D=3DThe signal is caused by a WRITE memory access.
>     #0 0x7fcba8a3bf4c  (/lib/x86_64-linux-gnu/libc.so.6+0x159f4c)
>     #1 0x7fcbab33f891  (/usr/lib/x86_64-linux-gnu/libasan.so.4+0x5c891)
>     #2 0x55dd3ae4a7e0 in mmap_frag /source/qemu/linux-user/mmap.c:189
>     #3 0x55dd3ae4bbce in target_mmap /source/qemu/linux-user/mmap.c:533
>     #4 0x55dd3ae4b8cb in target_mmap /source/qemu/linux-user/mmap.c:501
>     #5 0x55dd3ae3895c in do_syscall /source/qemu/linux-user/syscall.c:9448
>     #6 0x55dd3adfaa57 in cpu_loop /source/qemu/linux-user/main.c:258
>     #7 0x55dd3ae005f5 in main /source/qemu/linux-user/main.c:5147
>     #8 0x7fcba8903a86 in __libc_start_main
> (/lib/x86_64-linux-gnu/libc.so.6+0x21a86)
>     #9 0x55dd3ad34a89 in _start
> (/source/qemu/build/full/x86_64-linux-user/qemu-x86_64+0x350a89)
> AddressSanitizer can not provide additional info.
> SUMMARY: AddressSanitizer: SEGV (/lib/x86_64-linux-gnu/libc.so.6+0x159f4c)
> =3D=3D5717=3D=3DABORTING
> make[2]: ***
> [/home/phil/source/qemu/tests/tcg/multiarch/Makefile.target:27:
> run-test-mmap] Error 1
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This is only with ASAN enabled right?

--
Alex Benn=C3=A9e
