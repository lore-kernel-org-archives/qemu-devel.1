Received: from eggs.gnu.org ([2001:4830:134:3::10]:35394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJhHM-0000qC-Jf
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJhHL-0001wf-ID
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:26:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-27-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <578dacec-2d74-6e6d-fbd2-091e46e21803@amsat.org>
Date: Fri, 18 May 2018 12:26:30 -0300
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-27-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 26/49] tests/tcg: move ARM specific
 tests into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, Peter Maydell <peter.maydell@linaro.org>Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On 05/17/2018 02:46 PM, Alex Bennée wrote:
> These only need to be built for ARM guests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> v2
>   - do VPATH manipulation in tests/tcg/arm/Makefile.target
>   - merge with fix hello-arm test
> v4
>   - update MAINTAINERS
> ---
>  MAINTAINERS                           |  1 +
>  tests/tcg/README                      |  9 ---------
>  tests/tcg/arm/Makefile.target         | 13 +++++++++++++
>  tests/tcg/arm/README                  | 11 +++++++++++
>  tests/tcg/{ => arm}/hello-arm.c       |  0
>  tests/tcg/{ => arm}/test-arm-iwmmxt.s |  0
>  6 files changed, 25 insertions(+), 9 deletions(-)
>  create mode 100644 tests/tcg/arm/Makefile.target
>  create mode 100644 tests/tcg/arm/README
>  rename tests/tcg/{ => arm}/hello-arm.c (100%)
>  rename tests/tcg/{ => arm}/test-arm-iwmmxt.s (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 17b9fc0fbe..4e331c4db4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -135,6 +135,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: target/arm/
> +F: tests/tcg/arm/
>  F: hw/arm/
>  F: hw/cpu/a*mpcore.c
>  F: include/hw/cpu/a*mpcore.h
> diff --git a/tests/tcg/README b/tests/tcg/README
> index 469504c4cb..625f2326e6 100644
> --- a/tests/tcg/README
> +++ b/tests/tcg/README
> @@ -5,15 +5,6 @@ or they are architecture specific.
>  
>  
>  
> -ARM
> -===
> -
> -hello-arm
> ----------
> -
> -test-arm-iwmmxt
> ----------------
> -
>  MIPS
>  ====
>  
> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
> new file mode 100644
> index 0000000000..bc6962ecc6
> --- /dev/null
> +++ b/tests/tcg/arm/Makefile.target
> @@ -0,0 +1,13 @@
> +# -*- Mode: makefile -*-
> +#
> +# ARM - included from tests/tcg/Makefile.target
> +#
> +
> +ARM_SRC=$(SRC_PATH)/tests/tcg/arm
> +
> +# Set search path for all sources
> +VPATH 		+= $(ARM_SRC)
> +
> +
> +hello-arm: CFLAGS+=-marm -ffreestanding

So we are only testing the ARMv7, but linux-user provides ARMv5 and
ARMv6 cpus.

There are still boards shipped with those cpus, so I think QEMU will
still be useful nowadays with those older archs.
Can we consider add tests for them?
If so, I volunteer to prepare Docker cross images :)

arm-linux-user/tests$ ../qemu-arm -cpu arm926 -d in_asm,op sha1
----------------
IN:
0x000102ec:  f04f 0b00  mov.w    fp, #0

OP:
 ld_i32 tmp5,env,$0xffffffffffffffec
 movi_i32 tmp6,$0x0
 brcond_i32 tmp5,tmp6,lt,$L0

 ---- 000102ec 00000000 00000000
 movi_i32 pc,$0x102ec
 movi_i32 tmp5,$0x1
 movi_i32 tmp6,$0x2000000
 movi_i32 tmp7,$0x1
 call exception_with_syndrome,$0x0,$0,env,tmp5,tmp6,tmp7
 set_label $L0
 exit_tb $0x563aed6cc043

qemu: uncaught target signal 4 (Illegal instruction) - core dumped
Illegal instruction

> +hello-arm: LDFLAGS+=-nostdlib
> diff --git a/tests/tcg/arm/README b/tests/tcg/arm/README
> new file mode 100644
> index 0000000000..e6307116e2
> --- /dev/null
> +++ b/tests/tcg/arm/README
> @@ -0,0 +1,11 @@
> +These are ARM specific guest programs
> +
> +hello-arm
> +---------
> +
> +A very simple inline assembly, write syscall based hello world
> +
> +test-arm-iwmmxt
> +---------------
> +
> +A simple test case for older iwmmxt extended ARMs
> diff --git a/tests/tcg/hello-arm.c b/tests/tcg/arm/hello-arm.c
> similarity index 100%
> rename from tests/tcg/hello-arm.c
> rename to tests/tcg/arm/hello-arm.c
> diff --git a/tests/tcg/test-arm-iwmmxt.s b/tests/tcg/arm/test-arm-iwmmxt.s
> similarity index 100%
> rename from tests/tcg/test-arm-iwmmxt.s
> rename to tests/tcg/arm/test-arm-iwmmxt.s
> 
