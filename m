Received: from eggs.gnu.org ([2001:4830:134:3::10]:49323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfKC-0004s6-B6
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 19:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfK9-0002v3-7x
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 19:44:40 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:35251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfK9-0002uK-33
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 19:44:37 -0400
Received: by mail-qt0-x22c.google.com with SMTP id x36so8383175qtx.2
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 16:44:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823192244.18914-1-anatol.pomozov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d76e1ae7-4fdd-4e21-4355-0be96142bce3@amsat.org>
Date: Wed, 23 Aug 2017 20:44:32 -0300
MIME-Version: 1.0
In-Reply-To: <20170823192244.18914-1-anatol.pomozov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 08/23/2017 04:22 PM, Anatol Pomozov wrote:
>   * explicitly disable SSE as clang enables it by default for 32bit code
>   * add memset() implementation. Clang complains that the function is
>     absent, gcc seems provides default built-in.
> ---
>   tests/multiboot/Makefile | 2 +-
>   tests/multiboot/libc.c   | 9 +++++++++
>   tests/multiboot/libc.h   | 2 ++
>   3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/multiboot/Makefile b/tests/multiboot/Makefile
> index 856e76682a..7fadbca33a 100644
> --- a/tests/multiboot/Makefile
> +++ b/tests/multiboot/Makefile
> @@ -1,5 +1,5 @@
>   CC=gcc
> -CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin
> +CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin -mno-sse

What about using -march=i586 instead? so no need to disable each next 
features clang decide to default enable.

Even cleaner IMHO, use -march=pentium in CFLAGS and add "-cpu pentium" 
in run_test.sh so we are sure the generated code matches, what do you think?

Regards,

Phil.

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
>   
>   /* stdarg.h */
> @@ -58,5 +59,6 @@ static inline void outb(uint16_t port, uint8_t data)
>   
>   void printf(const char *fmt, ...);
>   void* memcpy(void *dest, const void *src, int n);
> +void *memset(void *s, int c, size_t n);
>   
>   #endif
> 
