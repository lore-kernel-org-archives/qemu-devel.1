Received: from eggs.gnu.org ([2001:4830:134:3::10]:51284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ff3QM-0000eg-0y
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ff3QH-0004Ci-Tp
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:20:22 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:39539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ff3QH-0004CH-IS
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:20:17 -0400
Received: by mail-ua0-x241.google.com with SMTP id g18-v6so12027771uam.6
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 06:20:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180510204148.11687-1-babu.moger@amd.com>
	<20180510204148.11687-2-babu.moger@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <42cdb351-425b-edd2-a4b2-c8e5ffeeec76@amsat.org>
Date: Mon, 16 Jul 2018 10:20:09 -0300
MIME-Version: 1.0
In-Reply-To: <20180510204148.11687-2-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 1/8] i386: Helpers to encode cache
 information consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, ehabkost@redhat.com, mtosatti@redhat.com
Cc: rth@twiddle.net, geoff@hostfission.com, kash@tripleback.net, qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, aurelien@aurel32.net

Hi Eduardo,

On 05/10/2018 05:41 PM, Babu Moger wrote:
> From: Eduardo Habkost <ehabkost@redhat.com>
> 
> Instead of having a collection of macros that need to be used in
> complex expressions to build CPUID data, define a CPUCacheInfo
> struct that can hold information about a given cache.  Helper
> functions will take a CPUCacheInfo struct as input to encode
> CPUID leaves for a cache.
> 
> This will help us ensure consistency between cache information
> CPUID leaves, and make the existing inconsistencies in CPUID info
> more visible.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  target/i386/cpu.c | 495 ++++++++++++++++++++++++++++++++++------------
>  target/i386/cpu.h |  53 +++++
>  2 files changed, 424 insertions(+), 124 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a20fe26573..18835400f1 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
[...]
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 1b219fafc4..fa03e2ced4 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1044,6 +1044,59 @@ typedef enum TPRAccess {
>      TPR_ACCESS_WRITE,
>  } TPRAccess;
>  
> +/* Cache information data structures: */
> +
> +enum CacheType {
> +    DCACHE,

I just noticed this clashes on mips host:

mips-linux-gnu-gcc -iquote /tmp/qemu-test/build/. -iquote . -iquote
/tmp/qemu-test/src/tcg -iquote /tmp/qemu-test/src/tcg/mips
-I/tmp/qemu-test/src/linux-headers -I/tmp/qemu-test/build/linux-headers
-iquote . -iquote /tmp/qemu-test/src -iquote
/tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-test/src/include
-I/usr/include/pixman-1  -Werror -DHAS_LIBSSH2_SFTP_FSYNC -pthread
-I/usr/include/glib-2.0 -I/usr/lib/mips-linux-gnu/glib-2.0/include
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
-Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
-Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
-Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs
-Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
-Wignored-qualifiers -Wold-style-declaration -Wold-style-definition
-Wtype-limits -fstack-protector-strong -I/usr/include/p11-kit-1
-I/usr/include/libpng16  -I../linux-headers -iquote .. -iquote
/tmp/qemu-test/src/target/i386 -DNEED_CPU_H -iquote
/tmp/qemu-test/src/include -MMD -MP -MT exec.o -MF ./exec.d -O2
-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g   -c -o exec.o
/tmp/qemu-test/src/exec.c
In file included from /usr/include/mips-linux-gnu/sys/cachectl.h:26:0,
                 from /tmp/qemu-test/src/tcg/mips/tcg-target.h:202,
                 from /tmp/qemu-test/src/include/exec/cpu-defs.h:29,
                 from /tmp/qemu-test/src/target/i386/cpu.h:34,
                 from /tmp/qemu-test/src/exec.c:23:
/tmp/qemu-test/src/target/i386/cpu.h:1053:5: error: expected identifier
before '(' token
     DCACHE,
     ^
/tmp/qemu-test/src/rules.mak:69: recipe for target 'exec.o' failed
make[1]: *** [exec.o] Error 1
make[1]: Leaving directory '/tmp/qemu-test/build/x86_64-softmmu'
Makefile:481: recipe for target 'subdir-x86_64-softmmu' failed
make: *** [subdir-x86_64-softmmu] Error 2

$ fgrep -rn CACHE /usr/include/mips-linux-gnu/asm/cachectl.h
8:#ifndef _ASM_CACHECTL
9:#define _ASM_CACHECTL
14:#define ICACHE	(1<<0)		/* flush instruction cache	  */
15:#define DCACHE	(1<<1)		/* writeback and flush data cache */
16:#define BCACHE	(ICACHE|DCACHE) /* flush both caches		  */
23:#define CACHEABLE	0	/* make pages cacheable */
24:#define UNCACHEABLE	1	/* make pages uncacheable */
26:#endif	/* _ASM_CACHECTL */

The offending commit is 7e3482f8248 but eventually went unnoticed until
the "includes" refactor around 9edc19c9399?

> +    ICACHE,
> +    UNIFIED_CACHE
> +};
> +
> +typedef struct CPUCacheInfo {
> +    enum CacheType type;
> +    uint8_t level;
> +    /* Size in bytes */
> +    uint32_t size;
> +    /* Line size, in bytes */
> +    uint16_t line_size;
[...]
