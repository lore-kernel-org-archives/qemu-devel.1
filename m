Received: from eggs.gnu.org ([2001:4830:134:3::10]:42321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAfvk-0001C9-55
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fAfvg-0004Dq-Tw
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:11:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36733)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fAfvg-0004Dl-PC
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:11:08 -0400
Date: Mon, 23 Apr 2018 14:11:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180423181107.GB27690@flamenco>
References: <20180423053927.13715-1-peterx@redhat.com>
	<20180423053927.13715-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423053927.13715-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/4] QemuMutex: support
 --enable-debug-mutex
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

On Mon, Apr 23, 2018 at 13:39:26 +0800, Peter Xu wrote:
> We have had some tracing tools for mutex but it's not easy to use them
> for e.g. dead locks.  Let's provide "--enable-debug-mutex" parameter
> when configure to allow QemuMutex to store the last owner that took
> specific lock.  It will be easy to use this tool to debug deadlocks
> since we can directly know who took the lock then as long as we can have
> a debugger attached to the process.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
(snip)
>  static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
>                                           const char *file, int line)
>  {
> +#ifdef CONFIG_DEBUG_MUTEX
> +    mutex->file = NULL;
> +    mutex->line = 0;
> +#endif
>      trace_qemu_mutex_unlock(mutex, file, line);
>  }

I'd also initialize to NULL/0 the file/line pair at
qemu_mutex_init time for both posix and win32. Other than that:

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		E.
