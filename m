Received: from eggs.gnu.org ([2001:4830:134:3::10]:40338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dimzi-00044p-Lf
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dimzf-00042W-HJ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:31:46 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dimzf-00042M-Ch
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:31:43 -0400
Received: by mail-qt0-x242.google.com with SMTP id 57so269828qtu.0
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 12:31:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1503077821.git.alistair.francis@xilinx.com>
	<2c94ac3bb116cc6b8ebbcd66a254920a69665515.1503077821.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b783771e-57b7-e5ee-2b20-01b67765e098@amsat.org>
Date: Fri, 18 Aug 2017 16:31:39 -0300
MIME-Version: 1.0
In-Reply-To: <2c94ac3bb116cc6b8ebbcd66a254920a69665515.1503077821.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] Convert remaining single line
 fprintf() to warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, armbru@redhat.com
Cc: alistair23@gmail.com, pbonzini@redhat.com

On 08/18/2017 03:47 PM, Alistair Francis wrote:
> Convert any remaining uses of fprintf(stderr, "warning:"...
> to use warn_report() instead. This helps standardise on a single
> method of printing warnings to the user.
> 
> All of the warnings were changed using this command:
>    find ./* -type f -exec sed -i 's|fprintf(.*".*warning[,:] |warn_report("|Ig' {} +
> 
> The #include lines and chagnes to the test Makefile were manually

line, changes

> updated to allow the code to compile.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> This was split out of my original series fixing QEMU warnings.
> 
>   tests/Makefile.include | 2 +-
>   util/cutils.c          | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 80527a8763..91d5a4544f 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -584,7 +584,7 @@ tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
>   tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
>   tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
>   tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
> -tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
> +tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-obj-y)
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
