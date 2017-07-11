Received: from eggs.gnu.org ([2001:4830:134:3::10]:59044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUqTb-0003D3-Ql
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUqTY-0003Sj-Nm
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:24:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dUqTY-0003RJ-Gs
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:24:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6955F3DE3E
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:24:55 +0000 (UTC)
Date: Tue, 11 Jul 2017 10:24:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170711082451.GA4335@noname.str.redhat.com>
References: <20170710165827.4250-1-pbonzini@redhat.com>
	<20170710165827.4250-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170710165827.4250-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] block: convert bdrv_invalidate_cache
 callback to coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Am 10.07.2017 um 18:58 hat Paolo Bonzini geschrieben:
> QED's bdrv_invalidate_cache implementation would like to reuse functions
> that acquire/release the metadata locks.  Call it from coroutine context
> to simplify the logic.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> diff --git a/block/qcow2.c b/block/qcow2.c
> index b5de67d113..4ff7e89009 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1854,7 +1854,8 @@ static void qcow2_close(BlockDriverState *bs)
>      qcow2_free_snapshots(bs);
>  }
>  
> -static void qcow2_invalidate_cache(BlockDriverState *bs, Error **errp)
> +static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
> +                                                   Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      int flags = s->flags;
> @@ -1877,7 +1878,9 @@ static void qcow2_invalidate_cache(BlockDriverState *bs, Error **errp)
>      options = qdict_clone_shallow(bs->options);
>  
>      flags &= ~BDRV_O_INACTIVE;
> +    qemu_co_mutex_lock(&s->lock);
>      ret = qcow2_do_open(bs, options, flags, &local_err);
> +    qemu_co_mutex_unlock(&s->lock);
>      QDECREF(options);
>      if (local_err) {
>          error_propagate(errp, local_err);

How useful is this lock really? If we expect any requests while this
function is running (we don't, it would break horribly), it should
probably cover qcow2_close(), too.

Or maybe the cleaner way would be bdrv_drained_begin/end() around
everything directly in bdrv_co_invalidate_cache().

Kevin
