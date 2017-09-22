Received: from eggs.gnu.org ([2001:4830:134:3::10]:40720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNi1-00037j-2F
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNhx-0005J3-PF
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvNhx-0005IF-Hl
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:09:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEA2C806CC
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 13:09:28 +0000 (UTC)
Date: Fri, 22 Sep 2017 21:09:22 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922130922.GF32000@lemon>
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
	<1506070572-7549-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506070572-7549-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] iothread: delay the context release to
 finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 09/22 16:56, Peter Xu wrote:
> When gcontext is used with iothread, the context will be destroyed
> during iothread_stop().  That's not good since sometimes we would like
> to keep the resources until iothread is destroyed, but we may want to
> stop the thread before that point.

Would be nice if you can also mention the glib bug that "required" this in the
commit message.

Reviewed-by: Fam Zheng <famz@redhat.com>

> 
> Delay the destruction of gcontext to iothread finalize.  Then we can do:
> 
>   iothread_stop(thread);
>   some_cleanup_on_resources();
>   iothread_destroy(thread);
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  iothread.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/iothread.c b/iothread.c
> index 894756b..b95369b 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -71,8 +71,6 @@ static void *iothread_run(void *opaque)
>              g_main_loop_unref(loop);
>  
>              g_main_context_pop_thread_default(iothread->worker_context);
> -            g_main_context_unref(iothread->worker_context);
> -            iothread->worker_context = NULL;
>          }
>      }
>  
> @@ -117,6 +115,10 @@ static void iothread_instance_finalize(Object *obj)
>      IOThread *iothread = IOTHREAD(obj);
>  
>      iothread_stop(iothread);
> +    if (iothread->worker_context) {
> +        g_main_context_unref(iothread->worker_context);
> +        iothread->worker_context = NULL;
> +    }
>      qemu_cond_destroy(&iothread->init_done_cond);
>      qemu_mutex_destroy(&iothread->init_done_lock);
>      if (!iothread->ctx) {
> -- 
> 2.7.4
> 
> 
