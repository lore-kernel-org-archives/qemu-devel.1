Received: from eggs.gnu.org ([2001:4830:134:3::10]:50409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2uuX-0006sD-EP
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2uuR-0003YI-Ot
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:01:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e2uuR-0003XG-IH
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:01:31 -0400
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-5-anatol.pomozov@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d62aadd6-875e-b269-89f4-c40195d78e2f@redhat.com>
Date: Fri, 13 Oct 2017 10:01:26 +0200
MIME-Version: 1.0
In-Reply-To: <20171012235439.19457-5-anatol.pomozov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] multiboot: make tests work with clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, ehabkost@redhat.com, agraf@suse.de, pbonzini@redhat.com, rth@twiddle.net

On 13.10.2017 01:54, Anatol Pomozov wrote:
>  * clang 3.8 enables SSE even for 32bit code. Generate code for pentium
>    CPU to make sure no new instructions are used.
>  * add memset() implementation. Clang implements array zeroing in
>    print_num() via memset() function call.
> ---
>  tests/multiboot/Makefile    | 2 +-
>  tests/multiboot/libc.c      | 9 +++++++++
>  tests/multiboot/libc.h      | 2 ++
>  tests/multiboot/run_test.sh | 1 +
>  4 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/multiboot/Makefile b/tests/multiboot/Makefile
> index b6a5056347..79dfe85afc 100644
> --- a/tests/multiboot/Makefile
> +++ b/tests/multiboot/Makefile
> @@ -1,5 +1,5 @@
>  CC=gcc
> -CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin
> +CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin -march=pentium
>  ASFLAGS=-m32
>  
>  LD=ld
> diff --git a/tests/multiboot/libc.c b/tests/multiboot/libc.c
> index 6df9bda96d..512fccd7fa 100644
> --- a/tests/multiboot/libc.c
> +++ b/tests/multiboot/libc.c
> @@ -33,6 +33,15 @@ void* memcpy(void *dest, const void *src, int n)
>  
>      return dest;
>  }
> +void *memset(void *s, int c, size_t n)

Add an empty line before the new function?

> +{
> +    size_t i;
> +    char *d = s;
> +    for (i = 0; i < n; i++) {

while (n-- > 0) ?

... that way you don't need the i variable.

> +        *d++ = c;
> +    }
> +    return s;
> +}

 Thomas
