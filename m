Received: from eggs.gnu.org ([2001:4830:134:3::10]:54233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7sxC-0005oK-2q
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7sx8-0005nM-VI
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:29:10 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7sx8-0005nD-QY
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:29:06 -0400
Received: by mail-qk0-x241.google.com with SMTP id d74so829056qkg.4
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 18:29:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-19-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7d53a9d6-fa6f-1f5d-4c4c-af6533826a0e@amsat.org>
Date: Sun, 15 Apr 2018 22:28:55 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 18/24] tests/tcg/arm: fix hello-arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: famz@redhat.com, cota@braap.org

Hi Alex,

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> As hello-arm is a bare bones syscall test it needs specific compiler
> flags so it doesn't try and link against glibc.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/arm/Makefile.target | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 tests/tcg/arm/Makefile.target
> 
> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
> new file mode 100644
> index 0000000000..b7c146c88e
> --- /dev/null
> +++ b/tests/tcg/arm/Makefile.target
> @@ -0,0 +1,6 @@
> +# -*- Mode: makefile -*-
> +#
> +# ARM specific tweaks

                    ... (Thumb mode explicitly disabled)

> +
> +hello-arm: CFLAGS+=-marm -ffreestanding
> +hello-arm: LDFLAGS+=-nostdlib

What about enforcing ARM mode for the swi call by the _syscallX()
functions with:

-- >8 --
 #define _syscall0(type,name) \
+__attribute__((target("arm"))) \
 type name(void) { \
   long __res; \
   __asm__ __volatile__ (\
--
(and so for _syscall[1..5])

So main() Thumb mode can also be tested.

tested with the following tests/tcg/arm/Makefile.include:

-- >8 --
DOCKER_IMAGE=debian-armel-cross
DOCKER_CROSS_COMPILER=arm-linux-gnueabi-gcc
--

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
