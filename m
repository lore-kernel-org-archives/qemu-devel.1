Received: from eggs.gnu.org ([2001:4830:134:3::10]:55349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfuv-0000WH-Q2
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfur-0004YT-Qd
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:22:37 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfur-0004Xk-Kr
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:22:33 -0400
Received: by mail-qt0-x244.google.com with SMTP id s11so994431qtk.0
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 17:22:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <d76e1ae7-4fdd-4e21-4355-0be96142bce3@amsat.org>
	<20170824000140.16812-1-anatol.pomozov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f579b065-c7be-13b9-65ca-f933f5f02a3e@amsat.org>
Date: Wed, 23 Aug 2017 21:22:28 -0300
MIME-Version: 1.0
In-Reply-To: <20170824000140.16812-1-anatol.pomozov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] multiboot: make tests work with clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com

Hi Anatol,

Next time use 'v2' for an updated patch (for the automated tracking 
tools), also no need to link it to the previous Message-Id it looks more 
messy and can get lost.

On 08/23/2017 09:01 PM, Anatol Pomozov wrote:
>   * clang 3.8 enables SSE even for 32bit code. Generate code for pentium
>     CPU to make sure no new instructions are used.
>   * add memset() implementation. Clang implements array zeroing in
>     print_num() via memset() function call.
> ---
>   tests/multiboot/Makefile    | 2 +-
>   tests/multiboot/libc.c      | 9 +++++++++
>   tests/multiboot/libc.h      | 2 ++
>   tests/multiboot/run_test.sh | 1 +
>   4 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/multiboot/Makefile b/tests/multiboot/Makefile
> index 856e76682a..2e015409dc 100644
> --- a/tests/multiboot/Makefile
> +++ b/tests/multiboot/Makefile
> @@ -1,5 +1,5 @@
>   CC=gcc
> -CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin
> +CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin -march=pentium

Now that I remark it, I think -ffreestanding is a better flag to 
multiboot than -fno-builtin.

>   ASFLAGS=-m32
>   
>   LD=ld
> diff --git a/tests/multiboot/libc.c b/tests/multiboot/libc.c
> index 6df9bda96d..512fccd7fa 100644
> --- a/tests/multiboot/libc.c
> +++ b/tests/multiboot/libc.c
> @@ -33,6 +33,15 @@ void* memcpy(void *dest, const void *src, int n)
>   
>       return dest;
>   }
> +void *memset(void *s, int c, size_t n)
> +{
> +    size_t i;
> +    char *d = s;
> +    for (i = 0; i < n; i++) {
> +        *d++ = c;
> +    }
> +    return s;
> +}
>   
>   static void print_char(char c)
>   {
> diff --git a/tests/multiboot/libc.h b/tests/multiboot/libc.h
> index 04c9922c27..44b71350dd 100644
> --- a/tests/multiboot/libc.h
> +++ b/tests/multiboot/libc.h
> @@ -36,6 +36,7 @@ typedef signed short int16_t;
>   typedef signed char int8_t;
>   
>   typedef uint32_t uintptr_t;
> +typedef uint32_t size_t;
>   

I'd also add here:

_Static_assert(sizeof(void *) == sizeof(uint32_t), "Expecting a 32-bit 
arch");

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   
>   /* stdarg.h */
> @@ -58,5 +59,6 @@ static inline void outb(uint16_t port, uint8_t data)
>   
>   void printf(const char *fmt, ...);
>   void* memcpy(void *dest, const void *src, int n);
> +void *memset(void *s, int c, size_t n);
>   
>   #endif
> diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
> index f04e35cbf0..38dcfef42c 100755
> --- a/tests/multiboot/run_test.sh
> +++ b/tests/multiboot/run_test.sh
> @@ -29,6 +29,7 @@ run_qemu() {
>       printf %b "\n\n=== Running test case: $kernel $* ===\n\n" >> test.log
>   
>       $QEMU \
> +        -cpu pentium \
>           -kernel $kernel \
>           -display none \
>           -device isa-debugcon,chardev=stdio \
> 
