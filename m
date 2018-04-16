Received: from eggs.gnu.org ([2001:4830:134:3::10]:37928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rlp-0004en-3b
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rlo-0001oY-0T
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:13:21 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:44609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rln-0001np-SL
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:13:19 -0400
Received: by mail-qt0-x244.google.com with SMTP id j26so13582779qtl.11
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 17:13:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-15-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb0138a2-0143-b44e-9c4e-c44d380154d2@amsat.org>
Date: Sun, 15 Apr 2018 21:13:15 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 14/24] tests/tcg/i386: fix test-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, cota@braap.org

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> The test-i386 test case is a little special as it includes assembler
> files. Add the additional compile magic to assemble these bits and
> link them to the final binary.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/tcg/i386/Makefile.target | 19 +++++++++++++++++++
>  tests/tcg/i386/test-i386.c     |  1 -
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
> index 7dbb7992e7..1df69e0dab 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -8,3 +8,22 @@ ifdef CROSS_CC_GUEST_CFLAGS
>  CFLAGS+=$(CROSS_CC_GUEST_CFLAGS)
>  endif
>  endif
> +
> +#
> +# test-386 includes a couple of additional objects that need to be linked together
> +#
> +
> +TEST_I386_DEPS=test-i386-code16.o test-i386-vm86.o
> +
> +# override the default compile and link in one go rule
> +test-i386.o: test-i386.c
> +	$(CC) $(CFLAGS) -c $< -o $@
> +
> +# and provide a rule to compile .S files
> +%.o: %.S
> +	$(CC) $(CFLAGS) -c $< -o $@
> +
> +test-i386: LDFLAGS+=-lm -lc
> +test-i386: test-i386.o $(TEST_I386_DEPS)
> +	$(LD) -melf_i386 $(LDFLAGS) $< $(TEST_I386_DEPS) -o $@
> +
> diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
> index 9599204895..cae6a7773a 100644
> --- a/tests/tcg/i386/test-i386.c
> +++ b/tests/tcg/i386/test-i386.c
> @@ -17,7 +17,6 @@
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  #define _GNU_SOURCE
> -#include "qemu/compiler.h"
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
> 
