Received: from eggs.gnu.org ([2001:4830:134:3::10]:58265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezQMW-0000kW-Is
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezQMT-0006HZ-LF
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:20:20 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezQMT-0006H2-A6
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:20:17 -0400
Received: by mail-qk0-x243.google.com with SMTP id 132so13666001qkd.5
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 10:20:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180323131715.29739-1-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c7a7949f-1b75-edef-f91f-04ea9ee8ca39@amsat.org>
Date: Fri, 23 Mar 2018 14:20:13 -0300
MIME-Version: 1.0
In-Reply-To: <20180323131715.29739-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: fix timers test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>

Hi Max,

On 03/23/2018 10:17 AM, Max Filippov wrote:
> Change frequency of the core used in tests so that clock cycle takes
> exactly 64ns. Change icount power used in tests to 6, so that each
> instruction takes exactly 1 clock cycle. With these changes the
> assumptions of the xtensa timers test are correct and the test must
> always pass.
> 
> Longer story:
>   http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04326.html

Would be great to have it in this commit message.

> 
> Cc: Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/core-dc232b.c | 2 +-
>  tests/tcg/xtensa/Makefile   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
> index aa07018af4e7..8846336f5cfa 100644
> --- a/target/xtensa/core-dc232b.c
> +++ b/target/xtensa/core-dc232b.c
> @@ -47,7 +47,7 @@ static XtensaConfig dc232b __attribute__((unused)) = {
>          }
>      },
>      .isa_internal = &xtensa_modules,
> -    .clock_freq_khz = 10000,
> +    .clock_freq_khz = 15625,

What about using self-explicit:

       .clock_freq_khz = (NANOSECONDS_PER_SECOND / 64) / 1000;

>      DEFAULT_SECTIONS
>  };
>  
> diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
> index 2882c431e4a9..091518c05583 100644
> --- a/tests/tcg/xtensa/Makefile
> +++ b/tests/tcg/xtensa/Makefile
> @@ -5,7 +5,7 @@ CROSS=xtensa-$(CORE)-elf-
>  
>  ifndef XT
>  SIM = ../../../xtensa-softmmu/qemu-system-xtensa
> -SIMFLAGS = -M sim -cpu $(CORE) -nographic -semihosting -icount 7 $(EXTFLAGS) -kernel
> +SIMFLAGS = -M sim -cpu $(CORE) -nographic -semihosting -icount 6 $(EXTFLAGS) -kernel
>  SIMDEBUG = -s -S
>  else
>  SIM = xt-run
> 

Regards,

Phil.
