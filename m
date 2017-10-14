Received: from eggs.gnu.org ([2001:4830:134:3::10]:35892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e3Pge-0006bk-Tp
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 12:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e3Pgb-0003fM-Q7
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 12:53:20 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:43866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e3Pgb-0003fG-LG
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 12:53:17 -0400
Received: by mail-qk0-x242.google.com with SMTP id w134so8383618qkb.0
	for <qemu-devel@nongnu.org>; Sat, 14 Oct 2017 09:53:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171013054842.32120-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dacdf7e7-0b16-99a0-ab50-ea7a458e0ec6@amsat.org>
Date: Sat, 14 Oct 2017 13:53:13 -0300
MIME-Version: 1.0
In-Reply-To: <20171013054842.32120-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] oslib-posix: Fix compiler warning and
 some data types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hi Stefan,

On 10/13/2017 02:48 AM, Stefan Weil wrote:
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 80086c549f..beef148c96 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -59,8 +59,8 @@
>  
>  struct MemsetThread {
>      char *addr;
> -    uint64_t numpages;
> -    uint64_t hpagesize;
> +    size_t numpages;
> +    size_t hpagesize;
>      QemuThread pgthread;
>      sigjmp_buf env;
>  };
> @@ -301,11 +301,7 @@ static void sigbus_handler(int signal)
>  static void *do_touch_pages(void *arg)
>  {
>      MemsetThread *memset_args = (MemsetThread *)arg;
> -    char *addr = memset_args->addr;
> -    uint64_t numpages = memset_args->numpages;
> -    uint64_t hpagesize = memset_args->hpagesize;
>      sigset_t set, oldset;
> -    int i = 0;
>  
>      /* unblock SIGBUS */
>      sigemptyset(&set);
> @@ -315,6 +311,10 @@ static void *do_touch_pages(void *arg)
>      if (sigsetjmp(memset_args->env, 1)) {
>          memset_thread_failed = true;
>      } else {
> +        volatile char *addr = memset_args->addr;
> +        size_t numpages = memset_args->numpages;
> +        size_t hpagesize = memset_args->hpagesize;
> +        size_t i;
>          for (i = 0; i < numpages; i++) {
>              /*
>               * Read & write back the same value, so we don't
> @@ -328,7 +328,7 @@ static void *do_touch_pages(void *arg)
>               * don't need to write at all so we don't cause
>               * wear on the storage backing the region...
>               */
> -            *(volatile char *)addr = *addr;
> +            *addr = *addr;

I personally prefer the other form which is mostly self-explicit when
reviewing this code.

Declaring addr non volatile and using volatile cast here:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>              addr += hpagesize;
>          }
>      }
> @@ -351,7 +351,8 @@ static inline int get_memset_num_threads(int smp_cpus)
>  static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>                              int smp_cpus)
>  {
> -    uint64_t numpages_per_thread, size_per_thread;
> +    size_t numpages_per_thread;
> +    size_t size_per_thread;
>      char *addr = area;
>      int i = 0;
>  
> 
