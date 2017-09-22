Received: from eggs.gnu.org ([2001:4830:134:3::10]:50870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dvL1A-000542-HZ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dvL14-0004fN-G4
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:17:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dvL14-0004em-72
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:17:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EBB04DAFA
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:17:00 +0000 (UTC)
Date: Fri, 22 Sep 2017 11:16:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170922101652.GF9243@stefanha-x1.localdomain>
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
	<1506070572-7549-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506070572-7549-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] iothread: provide helpers for internal
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On Fri, Sep 22, 2017 at 04:56:10PM +0800, Peter Xu wrote:
> IOThread is a general framework that contains IO loop environment and a
> real thread behind.  It's also good to be used internally inside qemu.
> Provide some helpers for it to create iothreads to be used internally.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/sysemu/iothread.h |  8 ++++++++
>  iothread.c                | 21 +++++++++++++++++++++
>  2 files changed, 29 insertions(+)
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
> index 44c8944..74e400c 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -354,3 +354,24 @@ GMainContext *iothread_get_g_main_context(IOThread *iothread)
>  
>      return iothread->worker_context;
>  }
> +
> +static Object *iothread_get_internal_parent(void)
> +{
> +    return container_get(object_get_root(), "/internal-iothreads");
> +}

Markus, please advise on the following QMP API design issue.

The query-iothreads QMP command lists IOThread objects.  This patch
introduces "internal" IOThreads whose lifetime is dictated by QEMU, not
the user's command-line or object-add command.

QMP clients might still want to know the thread IDs of internal
IOThreads for CPU affinity.  Clients may also want to tweak the
AioContext polling properties on the internal objects for performance
tuning.

I suggest adding internal IOThreads alongside user-created IOThreads
instead of hiding them.  IOThread also needs a bool user_created field
and a UserCreatableClass->can_be_deleted() function:

  static bool iothread_can_be_deleted(UserCreatable *uc)
  {
      return IOTHREAD(uc)->user_created;
  }

This way users cannot delete internal IOThreads.

But how should object ids be handled?  In theory existing -object
iothread,id=<id> users could use any name.  How can QEMU generate ids
for internal IOThreads without conflicting with existing users's ids?

> +
> +IOThread *iothread_create(const char *id, Error **errp)
> +{
> +    Object *obj;
> +
> +    obj = object_new_with_props(TYPE_IOTHREAD,
> +                                iothread_get_internal_parent(),
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
