Received: from eggs.gnu.org ([2001:4830:134:3::10]:48375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBKm-0004LX-86
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBKh-0002bo-U3
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:43:08 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBKh-0002bL-Oy
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:43:03 -0400
Received: by mail-qk0-x244.google.com with SMTP id p186so18836722qkd.1
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 20:43:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-22-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6470a208-c6e5-a8ba-ceb7-c3759c6ecd7b@amsat.org>
Date: Wed, 25 Apr 2018 00:42:58 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 21/46] tests/tcg/i386: fix
 test-i386-fprem
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
> Remove dependencies on QEMU's source tree and build directly.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/i386/test-i386-fprem.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/tcg/i386/test-i386-fprem.c b/tests/tcg/i386/test-i386-fprem.c
> index 1a71623204..66f5a9657d 100644
> --- a/tests/tcg/i386/test-i386-fprem.c
> +++ b/tests/tcg/i386/test-i386-fprem.c
> @@ -23,7 +23,10 @@
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -#include "qemu/osdep.h"
> +#include <stdio.h>
> +#include <stdint.h>
> +
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>  
>  /*
>   * Inspired by <ieee754.h>'s union ieee854_long_double, but with single
> @@ -39,7 +42,7 @@ union float80u {
>          unsigned int exponent:15;
>          unsigned int negative:1;
>          unsigned int empty:16;
> -    } QEMU_PACKED ieee;
> +    } __attribute__((packed)) ieee;
>  
>      /* This is for NaNs in the IEEE 854 double-extended-precision format.  */
>      struct {
> @@ -49,7 +52,7 @@ union float80u {
>          unsigned int exponent:15;
>          unsigned int negative:1;
>          unsigned int empty:16;
> -    } QEMU_PACKED ieee_nan;
> +    } __attribute__((packed)) ieee_nan;
>  };
>  
>  #define IEEE854_LONG_DOUBLE_BIAS 0x3fff
> @@ -229,6 +232,7 @@ static void test_fprem_cases(void)
>      do_fprem_stack_underflow();
>  
>      printf("= invalid operation =\n");
> +    do_fprem(q_nan.d, 1.0);
>      do_fprem(s_nan.d, 1.0);
>      do_fprem(1.0, 0.0);
>      do_fprem(pos_inf.d, 1.0);
> @@ -238,6 +242,8 @@ static void test_fprem_cases(void)
>      do_fprem(pos_denorm.d, 1.0);
>      do_fprem(1.0, pos_denorm.d);
>  
> +    do_fprem(smallest_positive_norm.d, smallest_positive_norm.d);
> +
>      /* printf("= underflow =\n"); */
>      /* TODO: Is there a case where FPREM raises underflow? */
>  }
> 

This test is disabled in tests/tcg/i386/Makefile.target and it would be
nice to be able to run it without having to modify the Makefile, like
running "make SLOW=1" or "SPEED=slow" like for iotests maybe?

This test is too verbose and I wonder if we should redirect stdout to
/dev/null even for V=1.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Enabled via tcg/i386/Makefile.target:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
