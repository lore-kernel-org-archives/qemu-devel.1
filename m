Received: from eggs.gnu.org ([2001:4830:134:3::10]:51461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBed-0001ZP-62
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBeY-00089A-FC
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:03:39 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBeY-00088K-9j
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:03:34 -0400
Received: by mail-qk0-x243.google.com with SMTP id b131so17280966qkg.2
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 21:03:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-24-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <39980aff-713f-0fcb-006f-13f74846bfa0@amsat.org>
Date: Wed, 25 Apr 2018 01:03:29 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Bennée wrote:
> The sources for x86_64 are shared in the i386 directory which will be
> included thanks to TARGET_BASE_ARCH. However not all sources build so
> we need to filter out the ones we can't build in the 64 bit world.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/i386/Makefile.target   |  2 +-
>  tests/tcg/x86_64/Makefile.target | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/x86_64/Makefile.target
> 
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
> index 80ccad3d7b..27086c3f2b 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -7,7 +7,7 @@ VPATH 		+= $(I386_SRC)
>  
>  I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
>  I386_TESTS=$(I386_SRCS:.c=)
> -
> +I386_ONLY_TESTS=$(filter-out test-i386-ssse3, $(I386_TESTS))
>  # Update TESTS
>  TESTS+=$(I386_ONLY_TESTS)
>  
> diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
> new file mode 100644
> index 0000000000..74f170b9ed
> --- /dev/null
> +++ b/tests/tcg/x86_64/Makefile.target
> @@ -0,0 +1,15 @@
> +# -*- Mode: makefile -*-
> +#
> +# x86_64 tests - included from tests/tcg/Makefile.target
> +#
> +# Currently we only build test-x86_64 and test-i386-ssse3 from
> +# $(SRC)/tests/tcg/i386/
> +#
> +
> +X86_64_TESTS=$(filter-out $(I386_ONLY_TESTS), $(TESTS))
> +X86_64_TESTS+=test-x86_64

The linux-test is taking looooong... I canceled it after ~15min on a i7
2GHz. Maybe it also belongs to the "BROKEN TEST" series on x86_64?
Currently it is only skipped if $(TARGET_NAME) == i386.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +TESTS:=$(X86_64_TESTS)
> +
> +test-x86_64: LDFLAGS+=-lm -lc
> +test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
> +	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
> 

$ make run-tcg-tests-x86_64-linux-user
  RUN-TESTS for x86_64
  TEST    test-mmap (default) on x86_64
  TEST    test-mmap (8k pages) on x86_64
ASAN:DEADLYSIGNAL
=================================================================
==5717==ERROR: AddressSanitizer: SEGV on unknown address 0x7fcba47fc000
(pc 0x7fcba8a3bf4d bp 0x7ffd19d74700 sp 0x7ffd19d73e88 T0)
==5717==The signal is caused by a WRITE memory access.
    #0 0x7fcba8a3bf4c  (/lib/x86_64-linux-gnu/libc.so.6+0x159f4c)
    #1 0x7fcbab33f891  (/usr/lib/x86_64-linux-gnu/libasan.so.4+0x5c891)
    #2 0x55dd3ae4a7e0 in mmap_frag /source/qemu/linux-user/mmap.c:189
    #3 0x55dd3ae4bbce in target_mmap /source/qemu/linux-user/mmap.c:533
    #4 0x55dd3ae4b8cb in target_mmap /source/qemu/linux-user/mmap.c:501
    #5 0x55dd3ae3895c in do_syscall /source/qemu/linux-user/syscall.c:9448
    #6 0x55dd3adfaa57 in cpu_loop /source/qemu/linux-user/main.c:258
    #7 0x55dd3ae005f5 in main /source/qemu/linux-user/main.c:5147
    #8 0x7fcba8903a86 in __libc_start_main
(/lib/x86_64-linux-gnu/libc.so.6+0x21a86)
    #9 0x55dd3ad34a89 in _start
(/source/qemu/build/full/x86_64-linux-user/qemu-x86_64+0x350a89)
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV (/lib/x86_64-linux-gnu/libc.so.6+0x159f4c)
==5717==ABORTING
make[2]: ***
[/home/phil/source/qemu/tests/tcg/multiarch/Makefile.target:27:
run-test-mmap] Error 1

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
