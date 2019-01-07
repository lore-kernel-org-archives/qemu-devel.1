Received: from eggs.gnu.org ([209.51.188.92]:33047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggZOk-0006k3-K5
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggZOj-0006pk-KV
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:13:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ggZOj-0006pK-Bc
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:13:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-16-fli@suse.com>
Date: Mon, 07 Jan 2019 19:13:10 +0100
In-Reply-To: <20181225140449.15786-16-fli@suse.com> (Fei Li's message of "Tue,
	25 Dec 2018 22:04:48 +0800")
Message-ID: <87k1jgjpzd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 15/16] qemu_thread: supplement
 error handling for touch_all_pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, lifei1214@126.com

Fei Li <fli@suse.com> writes:

> Supplement the error handling for touch_all_pages: add an Error
> parameter for it to propagate the error to its caller to do the
> handling in case it fails.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  util/oslib-posix.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 251e2f1aea..afc1d99093 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -431,15 +431,17 @@ static inline int get_memset_num_threads(int smp_cpus)
>  }
>  
>  static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
> -                            int smp_cpus)
> +                            int smp_cpus, Error **errp)
>  {
>      size_t numpages_per_thread;
>      size_t size_per_thread;
>      char *addr = area;
>      int i = 0;
> +    int started_thread = 0;
>  
>      memset_thread_failed = false;
>      memset_num_threads = get_memset_num_threads(smp_cpus);
> +    started_thread = memset_num_threads;
>      memset_thread = g_new0(MemsetThread, memset_num_threads);
>      numpages_per_thread = (numpages / memset_num_threads);
>      size_per_thread = (hpagesize * numpages_per_thread);
> @@ -448,14 +450,18 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>          memset_thread[i].numpages = (i == (memset_num_threads - 1)) ?
>                                      numpages : numpages_per_thread;
>          memset_thread[i].hpagesize = hpagesize;
> -        /* TODO: let the callers handle the error instead of abort() here */
> -        qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
> -                           do_touch_pages, &memset_thread[i],
> -                           QEMU_THREAD_JOINABLE, &error_abort);
> +        if (!qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
> +                                do_touch_pages, &memset_thread[i],
> +                                QEMU_THREAD_JOINABLE, errp)) {
> +            memset_thread_failed = true;
> +            started_thread = i;
> +            goto out;

break rather than goto, please.

> +        }
>          addr += size_per_thread;
>          numpages -= numpages_per_thread;
>      }
> -    for (i = 0; i < memset_num_threads; i++) {
> +out:
> +    for (i = 0; i < started_thread; i++) {
>          qemu_thread_join(&memset_thread[i].pgthread);
>      }

I don't like how @started_thread is computed.  The name suggests it's
the number of threads started so far.  That's the case when you
initialize it to zero.  But then you immediately set it to
memset_thread().  It again becomes the case only when you break the loop
on error, or when you complete it successfully.

There's no need for @started_thread, since the number of threads created
is readily available as @i:

       memset_num_threads = i;
       for (i = 0; i < memset_num_threads; i++) {
           qemu_thread_join(&memset_thread[i].pgthread);
       }

Rest of the function:

>      g_free(memset_thread);
       memset_thread = NULL;

       return memset_thread_failed;
   }

If do_touch_pages() set memset_thread_failed(), we return false without
setting an error.  I believe you should

       if (memset_thread_failed) {
           error_setg(errp, "os_mem_prealloc: Insufficient free host memory "
               "pages available to allocate guest RAM");
           return false;
       }
       return true;

here, and ...

> @@ -471,6 +477,7 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
>      struct sigaction act, oldact;
>      size_t hpagesize = qemu_fd_getpagesize(fd);
>      size_t numpages = DIV_ROUND_UP(memory, hpagesize);
> +    Error *local_err = NULL;
>  
>      memset(&act, 0, sizeof(act));
>      act.sa_handler = &sigbus_handler;
> @@ -484,9 +491,9 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
>      }
>  
>      /* touch pages simultaneously */
> -    if (touch_all_pages(area, hpagesize, numpages, smp_cpus)) {
> -        error_setg(errp, "os_mem_prealloc: Insufficient free host memory "
> -            "pages available to allocate guest RAM");
> +    if (touch_all_pages(area, hpagesize, numpages, smp_cpus, &local_err)) {
> +        error_propagate_prepend(errp, local_err, "os_mem_prealloc: Insufficient"
> +            " free host memory pages available to allocate guest RAM: ");
>      }

... not mess with the error message here, i.e.

       touch_all_pages(area, hpagesize, numpages, smp_cpus), errp);

>  
>      ret = sigaction(SIGBUS, &oldact, NULL);
