Received: from eggs.gnu.org ([2001:4830:134:3::10]:34072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUqhR-000202-I3
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUqhQ-0001AM-Hc
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:39:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dUqhQ-0001A8-8G
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:39:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3926EC04B92B
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:39:15 +0000 (UTC)
Date: Tue, 11 Jul 2017 10:39:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170711083911.GC4335@noname.str.redhat.com>
References: <20170710165827.4250-1-pbonzini@redhat.com>
	<20170710165827.4250-4-pbonzini@redhat.com>
	<20170711082451.GA4335@noname.str.redhat.com>
	<555a050c-46cb-72c3-e3c0-fb37fd23bdf4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555a050c-46cb-72c3-e3c0-fb37fd23bdf4@redhat.com>
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

Am 11.07.2017 um 10:33 hat Paolo Bonzini geschrieben:
> On 11/07/2017 10:24, Kevin Wolf wrote:
> > Am 10.07.2017 um 18:58 hat Paolo Bonzini geschrieben:
> >> QED's bdrv_invalidate_cache implementation would like to reuse functions
> >> that acquire/release the metadata locks.  Call it from coroutine context
> >> to simplify the logic.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> >> diff --git a/block/qcow2.c b/block/qcow2.c
> >> index b5de67d113..4ff7e89009 100644
> >> --- a/block/qcow2.c
> >> +++ b/block/qcow2.c
> >> @@ -1854,7 +1854,8 @@ static void qcow2_close(BlockDriverState *bs)
> >>      qcow2_free_snapshots(bs);
> >>  }
> >>  
> >> -static void qcow2_invalidate_cache(BlockDriverState *bs, Error **errp)
> >> +static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
> >> +                                                   Error **errp)
> >>  {
> >>      BDRVQcow2State *s = bs->opaque;
> >>      int flags = s->flags;
> >> @@ -1877,7 +1878,9 @@ static void qcow2_invalidate_cache(BlockDriverState *bs, Error **errp)
> >>      options = qdict_clone_shallow(bs->options);
> >>  
> >>      flags &= ~BDRV_O_INACTIVE;
> >> +    qemu_co_mutex_lock(&s->lock);
> >>      ret = qcow2_do_open(bs, options, flags, &local_err);
> >> +    qemu_co_mutex_unlock(&s->lock);
> >>      QDECREF(options);
> >>      if (local_err) {
> >>          error_propagate(errp, local_err);
> > 
> > How useful is this lock really? If we expect any requests while this
> > function is running (we don't, it would break horribly), it should
> > probably cover qcow2_close(), too.
> 
> In the case of QED, this was needed because qed_read_table drops
> s->table_lock.  Here I just copied the idiom.

Ok, makes sense.

> However, I think it's cleaner to define which functions are called
> with which lock held.  Sometimes it leads to taking a lock
> unnecessarily, but it's clearer and it can also help once we annotate
> the source and let the compiler do static analysis (see clang's
> -Wthread-safety).

Can you just add a comment to this effect to qcow2/qed_do_open() then?

> > Or maybe the cleaner way would be bdrv_drained_begin/end() around
> > everything directly in bdrv_co_invalidate_cache().

Should we do this anyway? Or assert that no requests are in flight?

Kevin
