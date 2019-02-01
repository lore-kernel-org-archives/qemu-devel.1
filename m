Received: from eggs.gnu.org ([209.51.188.92]:44801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shirley17fei@gmail.com>) id 1gpRZv-0007Jf-Oq
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shirley17fei@gmail.com>) id 1gpRZs-0007Z2-5p
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:41:25 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
	id 1gpRZq-0007Yt-Re
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:41:23 -0500
Received: by mail-pf1-x442.google.com with SMTP id r136so2617811pfc.6
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 21:41:22 -0800 (PST)
References: <20190201052551.53359-1-lifei1214@126.com>
From: Fei Li <shirley17fei@gmail.com>
Message-ID: <a84d9009-a1fe-ed19-6379-90e0a07927f5@gmail.com>
Date: Fri, 1 Feb 2019 13:41:18 +0800
MIME-Version: 1.0
In-Reply-To: <20190201052551.53359-1-lifei1214@126.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 11/11] qemu_thread: supplement
 error handling for touch_all_pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

It seems that this poor patch is left alone. :(
I sent all, but this patch failed to join them, so sorry for that..
Could we just let it be?

Have a nice day, thanks

Fei

ÔÚ 2019/2/1 ÏÂÎç1:25, Fei Li Ð´µÀ:
> From: Fei Li <fli@suse.com>
>
> Supplement the error handling for touch_all_pages: add an Error
> parameter for it to propagate the error to its caller to do the
> handling in case it fails.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>   util/oslib-posix.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index b6c2ee270d..b4dd3d8970 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -435,7 +435,7 @@ static inline int get_memset_num_threads(int smp_cpus)
>   }
>   
>   static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
> -                            int smp_cpus)
> +                            int smp_cpus, Error **errp)
>   {
>       size_t numpages_per_thread;
>       size_t size_per_thread;
> @@ -452,20 +452,29 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>           memset_thread[i].numpages = (i == (memset_num_threads - 1)) ?
>                                       numpages : numpages_per_thread;
>           memset_thread[i].hpagesize = hpagesize;
> -        /* TODO: let the callers handle the error instead of abort() here */
> -        qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
> -                           do_touch_pages, &memset_thread[i],
> -                           QEMU_THREAD_JOINABLE, &error_abort);
> +        if (qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
> +                               do_touch_pages, &memset_thread[i],
> +                               QEMU_THREAD_JOINABLE, errp) < 0) {
> +            memset_thread_failed = true;
> +            break;
> +        }
>           addr += size_per_thread;
>           numpages -= numpages_per_thread;
>       }
> +
> +    memset_num_threads = i;
>       for (i = 0; i < memset_num_threads; i++) {
>           qemu_thread_join(&memset_thread[i].pgthread);
>       }
>       g_free(memset_thread);
>       memset_thread = NULL;
>   
> -    return memset_thread_failed;
> +    if (memset_thread_failed) {
> +        error_append_hint(errp, "os_mem_prealloc: Insufficient free host "
> +                          "memory pages available to allocate guest RAM");
> +        return false;
> +    }
> +    return true;
>   }
>   
>   void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
> @@ -488,10 +497,7 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
>       }
>   
>       /* touch pages simultaneously */
> -    if (touch_all_pages(area, hpagesize, numpages, smp_cpus)) {
> -        error_setg(errp, "os_mem_prealloc: Insufficient free host memory "
> -            "pages available to allocate guest RAM");
> -    }
> +    touch_all_pages(area, hpagesize, numpages, smp_cpus, errp);
>   
>       ret = sigaction(SIGBUS, &oldact, NULL);
>       if (ret) {
