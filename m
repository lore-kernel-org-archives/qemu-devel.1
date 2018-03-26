Received: from eggs.gnu.org ([2001:4830:134:3::10]:51921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0XDl-000455-4g
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0XDj-0007dY-NX
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:51:53 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:32905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0XDj-0007dS-Ie
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:51:51 -0400
Received: by mail-qk0-x241.google.com with SMTP id d206so8903309qkb.0
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 11:51:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180326175657.13761-1-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b75a96ad-7674-3186-3b4e-82c660ba2820@amsat.org>
Date: Mon, 26 Mar 2018 15:51:48 -0300
MIME-Version: 1.0
In-Reply-To: <20180326175657.13761-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] target/xtensa: fix timers test
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

On 03/26/2018 02:56 PM, Max Filippov wrote:
> The value of CCOUNT special register is calculated as time elapsed
> since CCOUNT == 0 multiplied by the core frequency. In icount mode time
> increment between consecutive instructions that don't involve time
> warps is constant, but unless the result of multiplication of this
> constant by the core frequency is a whole number the CCOUNT increment
> between these instructions may not be constant. E.g. with icount=7 each
> instruction takes 128ns, with core clock of 10MHz CCOUNT values for
> consecutive instructions are:
> 
>   502: (128 * 502 * 10000000) / 1000000000 = 642.56
>   503: (128 * 503 * 10000000) / 1000000000 = 643.84
>   504: (128 * 504 * 10000000) / 1000000000 = 645.12
> 
> I.e.the CCOUNT increments depend on the absolute time. This results in
> varying CCOUNT differences for consecutive instructions in tests that
> involve time warps and don't set CCOUNT explicitly.
> 
> Change frequency of the core used in tests so that clock cycle takes
> exactly 64ns. Change icount power used in tests to 6, so that each
> instruction takes exactly 1 clock cycle. With these changes CCOUNT
> increments only depend on the number of executed instructions and that's
> what timer tests expect, so they work correctly.
> 
> Longer story:
>   http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04326.html
> 
> Cc: Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Changes v1->v2:
> - expand changelog;
> - replace clock_freq_khz initializer constant with a more meaningful
>   expression.

Thanks :)

> 
>  target/xtensa/core-dc232b.c | 2 +-
>  tests/tcg/xtensa/Makefile   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
> index aa07018af4e7..7331eeea2fb6 100644
> --- a/target/xtensa/core-dc232b.c
> +++ b/target/xtensa/core-dc232b.c
> @@ -47,7 +47,7 @@ static XtensaConfig dc232b __attribute__((unused)) = {
>          }
>      },
>      .isa_internal = &xtensa_modules,
> -    .clock_freq_khz = 10000,
> +    .clock_freq_khz = (NANOSECONDS_PER_SECOND / 64) / 1000,
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
