Received: from eggs.gnu.org ([2001:4830:134:3::10]:51567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwhxv-0006h9-0M
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwhxu-0003Mg-8F
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:59:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dwhxu-0003M6-2S
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:59:26 -0400
Date: Tue, 26 Sep 2017 12:59:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170926045917.GD31924@lemon.lan>
References: <1506401532-25274-1-git-send-email-peterx@redhat.com>
	<1506401532-25274-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506401532-25274-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] iothread: provide helpers for
 internal use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Manos Pitsidianakis <el13635@mail.ntua.gr>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 09/26 12:52, Peter Xu wrote:
> IOThread is a general framework that contains IO loop environment and a
> real thread behind.  It's also good to be used internally inside qemu.
> Provide some helpers for it to create iothreads to be used internally.
> 
> Put all the internal used iothreads into the internal object container.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/sysemu/iothread.h |  8 ++++++++
>  iothread.c                | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
> index d2985b3..b07663f 100644
> --- a/include/sysemu/iothread.h
> +++ b/include/sysemu/iothread.h
> @@ -46,4 +46,12 @@ AioContext *iothread_get_aio_context(IOThread *iothread);
>  void iothread_stop_all(void);
>  GMainContext *iothread_get_g_main_context(IOThread *iothread);
>  
> +/*
> + * Helpers used to allocate iothreads for internal use.  These
> + * iothreads will not be seen by monitor clients when query using
> + * "query-iothreads".
> + */
> +IOThread *iothread_create(const char *id, Error **errp);
> +void iothread_destroy(IOThread *iothread);
> +
>  #endif /* IOTHREAD_H */
> diff --git a/iothread.c b/iothread.c
> index 44c8944..33f996e 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -354,3 +354,19 @@ GMainContext *iothread_get_g_main_context(IOThread *iothread)
>  
>      return iothread->worker_context;
>  }
> +
> +IOThread *iothread_create(const char *id, Error **errp)
> +{
> +    Object *obj;
> +
> +    obj = object_new_with_props(TYPE_IOTHREAD,
> +                                object_get_internal_root(),
> +                                id, errp, NULL);
> +
> +    return IOTHREAD(obj);
> +}
> +
> +void iothread_destroy(IOThread *iothread)
> +{
> +    object_unparent(OBJECT(iothread));
> +}
> -- 
> 2.7.4
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
