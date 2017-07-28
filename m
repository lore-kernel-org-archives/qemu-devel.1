Received: from eggs.gnu.org ([2001:4830:134:3::10]:40588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbF87-0001i7-Cc
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbF84-0004p6-Oz
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:57:15 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbF84-0004ou-Kz
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:57:12 -0400
Received: by mail-qk0-x243.google.com with SMTP id q66so22398766qki.1
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:57:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<2897c32f34b415aadcf43a5ae296cf5f6e15e757.1501280035.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9cf48d75-16da-9d54-5215-fda002f1f863@amsat.org>
Date: Fri, 28 Jul 2017 20:57:08 -0300
MIME-Version: 1.0
In-Reply-To: <2897c32f34b415aadcf43a5ae296cf5f6e15e757.1501280035.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] Convert single line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com

Hi Alistair,

On 07/28/2017 07:16 PM, Alistair Francis wrote:
> Convert any remaining uses of fprintf(stderr, "warning:"...
> to use warn_report() instead. This helps standardise on a single
> method of printing warnings to the user.
> 
> All of the warnings were changed using this command:
>    find ./* -type f -exec sed -i 's|fprintf(.*".*warning[,:] |warn_report("|Ig' {} +
> 
> The #include lines and chagnes to the test Makefile were manually
> updated to allow the code to compile.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>   tests/Makefile.include | 4 ++--
>   util/cutils.c          | 3 ++-
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7af278db55..4886caf565 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -560,8 +560,8 @@ tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
>   tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
>   tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
>   tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
> -tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
> +tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-qom-obj-y)

I don't understand what was not working in the previous line.

> -tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
> +tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-qom-obj-y)

Here adding $(util-obj-y) should be enough.

But I did not test it :P

Regards,

Phil.

>   tests/test-int128$(EXESUF): tests/test-int128.o
>   tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
>   tests/test-rcu-list$(EXESUF): tests/test-rcu-list.o $(test-util-obj-y)
> diff --git a/util/cutils.c b/util/cutils.c
> index 1534682083..b33ede83d1 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -30,6 +30,7 @@
>   #include "qemu/iov.h"
>   #include "net/net.h"
>   #include "qemu/cutils.h"
> +#include "qemu/error-report.h"
>   
>   void strpadcpy(char *buf, int buf_size, const char *str, char pad)
>   {
> @@ -601,7 +602,7 @@ int parse_debug_env(const char *name, int max, int initial)
>           return initial;
>       }
>       if (debug < 0 || debug > max || errno != 0) {
> -        fprintf(stderr, "warning: %s not in [0, %d]", name, max);
> +        warn_report("%s not in [0, %d]", name, max);
>           return initial;
>       }
>       return debug;
> 
