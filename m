Received: from eggs.gnu.org ([209.51.188.92]:55370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzUNx-0006IK-QQ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzUNv-0006zE-Ur
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:42:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gzUNv-0006qA-5J
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:42:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id z84so10483527wmg.4
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 14:42:11 -0800 (PST)
References: <20190228202537.4638-1-alex.bennee@linaro.org>
	<20190228202537.4638-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c3a65d4b-8720-2957-1394-032823a78760@redhat.com>
Date: Thu, 28 Feb 2019 23:42:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190228202537.4638-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/16] tests/tcg/mips: fix hello-mips
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, qemu-arm@nongnu.org, jcmvbkbc@gmail.com

Hi Alex,

On 2/28/19 9:25 PM, Alex Bennée wrote:
> The compilation flags for proper building are in the source tree. We
> also fix exit to 0 so the result is counted as a success.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/mips/Makefile.target | 11 ++++-------
>  tests/tcg/mips/hello-mips.c    |  2 +-
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
> index 086625f533..1a994d5525 100644
> --- a/tests/tcg/mips/Makefile.target
> +++ b/tests/tcg/mips/Makefile.target
> @@ -8,15 +8,12 @@ MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
>  # Set search path for all sources
>  VPATH 		+= $(MIPS_SRC)
>  
> +# hello-mips is 32 bit only

Correct.

> +ifeq ($(findstring 64,$(TARGET_NAME)),)
>  MIPS_TESTS=hello-mips
>  
>  TESTS += $(MIPS_TESTS)
>  
> -hello-mips: CFLAGS+=-ffreestanding
> +hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -mabi=32

As suggested in the header.

>  hello-mips: LDFLAGS+=-nostdlib
> -
> -# For MIPS32 and 64 we have a bunch of extra tests in sub-directories
> -# however they are intended for system tests.
> -
> -run-hello-mips: hello-mips
> -	$(call skip-test, $<, "BROKEN")
> +endif
> diff --git a/tests/tcg/mips/hello-mips.c b/tests/tcg/mips/hello-mips.c
> index c7052fdf2e..4e1cf501af 100644
> --- a/tests/tcg/mips/hello-mips.c
> +++ b/tests/tcg/mips/hello-mips.c
> @@ -60,5 +60,5 @@ static inline int write(int fd, const char *buf, int len)
>  void __start(void)
>  {
>      write (1, "Hello, World!\n", 14);
> -    exit1 (42);

I understand 42 is to check SYS_exit1 worked, and this is not another
qemu-user exit. But we were previously never checked the exit code for
42. Neither are we checking 'Hello, World' on stdout.

> +    exit1(0);
>  }
> 
