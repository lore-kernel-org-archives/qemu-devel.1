Received: from eggs.gnu.org ([2001:4830:134:3::10]:50638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eOHgV-0004pA-4e
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eOHgP-0007wJ-TC
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:35:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eOHgP-0007vq-KN
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:35:21 -0500
Date: Mon, 11 Dec 2017 14:35:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171211063511.GA18868@xz-mi>
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-6-pbonzini@redhat.com>
	<20171208151306.GC8998@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171208151306.GC8998@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 5/5] thread-pool: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On Fri, Dec 08, 2017 at 03:13:06PM +0000, Stefan Hajnoczi wrote:

[...]

> > @@ -330,7 +326,7 @@ void thread_pool_free(ThreadPool *pool)
> >  
> >      assert(QLIST_EMPTY(&pool->head));
> >  
> > -    qemu_mutex_lock(&pool->lock);
> > +    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
> >  
> >      /* Stop new threads from spawning */
> >      qemu_bh_delete(pool->new_thread_bh);
> > @@ -344,7 +340,7 @@ void thread_pool_free(ThreadPool *pool)
> >          qemu_cond_wait(&pool->worker_stopped, &pool->lock);
> >      }
> >  
> > -    qemu_mutex_unlock(&pool->lock);
> > +    qemu_lock_guard_unlock(&pool_guard);
> 
> Here too.  I don't see the advantage of replacing a single lock/unlock
> with QEMU_LOCK_GUARD/unlock, if it cannot be made shorter/safer then
> it's fine to use QemuMutex directly.

Agree.

For such use cases (and maybe mostly the cases that can use
QEMU_ADOPT_LOCK, QEMU_RETURN_LOCK, QEMU_TAKEN_LOCK) for me I would
still prefer the old ways, which is clearer to me (and faster?).  But
I do think the guard can really help for the specific case when
e.g. we need to take the lock at the entry of the function but need to
make sure it's released before leaving, especially when the function
contains multiple return points.

Maybe we can do this incrementally?  Say, we can at least start to use
it in new codes, and replace some obvious scenarios where proper.
After all it sounds good to have such an API that QEMU code can use
directly.

Thanks,

-- 
Peter Xu
