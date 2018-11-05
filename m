Received: from eggs.gnu.org ([2001:4830:134:3::10]:40615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJhaM-0003QM-Kv
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJhVo-0002xw-AQ
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:14:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gJhVm-0002cu-AX
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:13:59 -0500
References: <20181105135538.28025-1-peter.maydell@linaro.org>
	<20181105135538.28025-3-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92532f5f-0314-c283-0e52-d8d3656dc9e6@redhat.com>
Date: Mon, 5 Nov 2018 10:13:25 -0600
MIME-Version: 1.0
In-Reply-To: <20181105135538.28025-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] util/qemu-thread-posix: Fix
 qemu_thread_atexit* for OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

On 11/5/18 7:55 AM, Peter Maydell wrote:
> Our current implementation of qemu_thread_atexit* is broken on OSX.
> This is because it works by cerating a piece of thread-specific

s/cerating/creating/

> data with pthread_key_create() and using the destructor function
> for that data to run the notifier function passed to it by
> the caller of qemu_thread_atexit_add(). The expected use case
> is that the caller uses a __thread variable as the notifier,
> and uses the callback to clean up information that it is
> keeping per-thread in __thread variables.
> 
> Unfortunately, on OSX this does not work, because on OSX
> a __thread variable may be destroyed (freed) before the
> pthread_key_create() destructor runs. (POSIX imposes no
> ordering constraint here; the OSX implementation happens
> to implement __thread variables in terms of pthread_key_create((),
> whereas Linux uses different mechanisms that mean the __thread
> variables will still be present when the pthread_key_create()
> destructor is run.)
> 
> Fix this by switching to a scheme similar to the one qemu-thread-win32
> uses for qemu_thread_atexit: keep the thread's notifiers on a
> __thread variable, and run the notifiers on calls to
> qemu_thread_exit() and on return from the start routine passed
> to qemu_thread_start(). We do this with the pthread_cleanup_push()
> API.
> 
> We take advantage of the qemu_thread_atexit_add() API
> permission not to run thread notifiers on process exit to
> avoid having to special case the main thread.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> qemu-thread-win32.c tries to handle the "main thread" case
> by using an atexit() handler to run its notifiers. I don't
> think this will work because the atexit handler may not run
> on the main thread, in which case notify callback functions
> which refer to __thread variables will get the wrong ones.
> ---
>   util/qemu-thread-posix.c | 44 ++++++++++++++++++----------------------
>   1 file changed, 20 insertions(+), 24 deletions(-)
> 

> @@ -501,7 +494,10 @@ static void *qemu_thread_start(void *args)
>   #endif
>       g_free(qemu_thread_args->name);
>       g_free(qemu_thread_args);
> -    return start_routine(arg);
> +    pthread_cleanup_push(qemu_thread_atexit_notify, NULL);
> +    r = start_routine(arg);
> +    pthread_cleanup_pop(1);
> +    return r;
>   }
>   
>   void qemu_thread_create(QemuThread *thread, const char *name,
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
