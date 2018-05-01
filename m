Received: from eggs.gnu.org ([208.118.235.92]:42799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDXNw-0007aQ-HI
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDXNr-0005Rc-VW
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:40:08 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDXNr-0005RI-Ok
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:40:03 -0400
Received: by mail-wm0-x241.google.com with SMTP id a8so18299724wmg.5
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 08:40:03 -0700 (PDT)
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
	<20180501142222.19154-3-kbastian@mail.uni-paderborn.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180501142222.19154-3-kbastian@mail.uni-paderborn.de>
Date: Tue, 01 May 2018 16:40:01 +0100
Message-ID: <87efiv9yge.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 02/12] tests/tcg/tricore: Add build
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> this includes the Makefile and linker script to build all the tests.
>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  tests/tcg/tricore/Makefile | 30 +++++++++++++++++++++++
>  tests/tcg/tricore/link.ld  | 60 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 90 insertions(+)
>  create mode 100644 tests/tcg/tricore/Makefile
>  create mode 100644 tests/tcg/tricore/link.ld
>
> diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
> new file mode 100644
> index 0000000000..8c168d1062
> --- /dev/null
> +++ b/tests/tcg/tricore/Makefile
> @@ -0,0 +1,30 @@
> +AS :=3D tricore-as
> +LD :=3D tricore-ld

Where do these come from? Ideally we'd get these in a docker container
like the rest. It would actually be easier to use tricore-gcc if it
exists because at the moment my docker series only exposes a C compiler
to the make system.

> +HOST_CC =3D gcc
> +
> +LDFLAGS =3D -Tlink.ld
> +ASFLAGS =3D
> +
> +SIM =3D ../../../tricore-softmmu/qemu-system-tricore
> +SIMFLAGS =3D -M tricore_testboard -nographic -kernel
> +
> +all: build
> +
> +%.pS: %.S
> +	$(HOST_CC) -E -o $@ $<
> +
> +%.o: %.pS
> +	$(AS) $(ASFLAGS) -o $@ $<
> +
> +%.tst: %.o link.ld
> +	$(LD) $(LDFLAGS) $< -o $@
> +
> +build: $(TESTCASES)
> +
> +check: $(addprefix run-, $(TESTCASES))
> +
> +run-%.tst: %.tst
> +	$(SIM) $(SIMFLAGS) ./$<
> +
> +clean:
> +	$(RM) -fr $(TESTCASES) linker.ld
> diff --git a/tests/tcg/tricore/link.ld b/tests/tcg/tricore/link.ld
> new file mode 100644
> index 0000000000..364bcdc00a
> --- /dev/null
> +++ b/tests/tcg/tricore/link.ld
> @@ -0,0 +1,60 @@
> +/* Default linker script, for normal executables */
> +OUTPUT_FORMAT("elf32-tricore")
> +OUTPUT_ARCH(tricore)
> +ENTRY(_start)
> +
> +/* the internal ram description */
> +MEMORY
> +{
> +  text_ram (rx!p): org =3D 0x80000000, len =3D 15K
> +  data_ram (w!xp): org =3D 0xd0000000, len =3D 130K
> +}
> +/*
> + * Define the sizes of the user and system stacks.
> + */
> +__USTACK_SIZE =3D DEFINED (__USTACK_SIZE) ? __USTACK_SIZE : 1K ;
> +/*
> + * Define the start address and the size of the context save area.
> + */
> +__CSA_BEGIN =3D  0xd0000000 ;
> +__CSA_SIZE =3D  8k ;
> +__CSA_END =3D __CSA_BEGIN + __CSA_SIZE ;
> +
> +SECTIONS
> +{
> +  .text  :
> +  {
> +    *(.text)
> +    . =3D ALIGN(8);
> +  } > text_ram
> +
> +  .rodata :
> +  {
> +    *(.rodata)
> +    *(.rodata1)
> +  } > data_ram
> +
> +  .data :
> +  {
> +    . =3D ALIGN(8) ;
> +    *(.data)
> +    *(.data.*)
> +    . =3D ALIGN(8) ;
> +    __USTACK =3D . + __USTACK_SIZE -768;
> +
> +  } > data_ram
> +  /*
> +   * Allocate space for BSS sections.
> +   */
> +  .bss  :
> +  {
> +    BSS_BASE =3D . ;
> +    *(.bss)
> +    *(COMMON)
> +    . =3D ALIGN(8) ;
> +  } > data_ram
> +  /* Make sure CSA, stack and heap addresses are properly aligned.  */
> +  _. =3D ASSERT ((__CSA_BEGIN & 0x3f) =3D=3D 0 , "illegal CSA start addr=
ess") ;
> +  _. =3D ASSERT ((__CSA_SIZE & 0x3f) =3D=3D 0 , "illegal CSA size") ;
> +
> +}


--
Alex Benn=C3=A9e
