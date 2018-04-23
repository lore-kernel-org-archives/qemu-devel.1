Received: from eggs.gnu.org ([2001:4830:134:3::10]:41611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAfsn-0000Nk-HG
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAfsk-0003NQ-AL
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:08:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fAfsk-0003ND-5X
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:08:06 -0400
Date: Mon, 23 Apr 2018 14:08:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180423180804.GA27690@flamenco>
References: <20180423053927.13715-1-peterx@redhat.com>
	<20180423053927.13715-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423053927.13715-3-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/4] qemu-thread: introduce
 qemu-thread-common.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Apr 23, 2018 at 13:39:25 +0800, Peter Xu wrote:
> Introduce some hooks for the shared part of qemu thread between POSIX
> and Windows implementations.  Note that in qemu_mutex_unlock_impl() we
> moved the call before unlock operation which should make more sense.
> And we don't need qemu_mutex_post_unlock() hook.
> 
> Currently the hooks only calls the tracepoints.
> 
> Put all these shared hooks into the header files.  It should be internal
> to qemu-thread but not for qemu-thread users, hence put into util/
> directory.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
(snip)
> @@ -92,11 +90,10 @@ void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line)
>      int err;
>  
>      assert(mutex->initialized);
> +    qemu_mutex_pre_unlock(mutex, file, line);
>      err = pthread_mutex_unlock(&mutex->lock);
>      if (err)
>          error_exit(err, __func__);
> -
> -    trace_qemu_mutex_unlock(mutex, file, line);
>  }
(snip)
> @@ -81,7 +80,7 @@ int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line)
>  void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line)
>  {
>      assert(mutex->initialized);
> -    trace_qemu_mutex_unlock(mutex, file, line);
> +    qemu_mutex_pre_unlock(mutex, file, line);
>      ReleaseSRWLockExclusive(&mutex->lock);
>  }

Note that in posix we're moving the unlock tracepoint before the actual
unlock happens. But that makes it consistent with that we're doing in win32,
and AFAICT it seems a better place to do it, so:

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		E.
