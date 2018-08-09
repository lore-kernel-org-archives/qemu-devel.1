Received: from eggs.gnu.org ([2001:4830:134:3::10]:55669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fnl1b-0006dO-CF
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fnl1a-0006lN-Ey
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:30:47 -0400
Date: Thu, 9 Aug 2018 15:30:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180809133038.GC4320@localhost.localdomain>
References: <20180806141322.14427-1-berto@igalia.com>
	<20180806150541.GE4631@localhost.localdomain>
	<w51mutzo730.fsf@maestria.local.igalia.com>
	<20180806155840.GF4631@localhost.localdomain>
	<w51mutvbsak.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51mutvbsak.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Release dirty entries with
 cache-clean-interval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 09.08.2018 um 15:09 hat Alberto Garcia geschrieben:
> On Mon 06 Aug 2018 05:58:41 PM CEST, Kevin Wolf wrote:
> > Am 06.08.2018 um 17:20 hat Alberto Garcia geschrieben:
> >> On Mon 06 Aug 2018 05:05:41 PM CEST, Kevin Wolf wrote:
> >> > Am 06.08.2018 um 16:13 hat Alberto Garcia geschrieben:
> >> >> -static inline bool can_clean_entry(Qcow2Cache *c, int i)
> >> >> +static inline bool can_clean_entry(BlockDriverState *bs, Qcow2Cache *c, int i)
> >> >>  {
> >> >>      Qcow2CachedTable *t = &c->entries[i];
> >> >> -    return t->ref == 0 && !t->dirty && t->offset != 0 &&
> >> >> -        t->lru_counter <= c->cache_clean_lru_counter;
> >> >> +    if (t->ref || !t->offset || t->lru_counter > c->cache_clean_lru_counter) {
> >> >> +        return false;
> >> >> +    }
> >> >> +
> >> >> +    if (qcow2_cache_entry_flush(bs, c, i) < 0) {
> >> >> +        return false;
> >> >> +    }
> >> >
> >> > We're not in coroutine context here, so qcow2_cache_entry_flush() will
> >> > be blocking. I don't think that's acceptable in a timer callback.
> >> >
> >> > On the other hand, if we made it non-blocking by moving it into a
> >> > coroutine that could yield, we would have to consider races with other
> >> > parts of the code and at least take s->lock and implement
> >> > .bdrv_co_drain_begin/end callbacks.
> >> 
> >> Oh, I see... it's probably not worth complicating the code for this then.
> >
> > On second thoughts, I actually think we can do without the drain
> > callbacks if we just add a bdrv_inc/dec_in_flight() pair around
> > qcow2_cache_clean_unused().
> >
> > We'd still have to create a coroutine in cache_clean_timer_cb() and take
> > the lock, but that sounds more managable.
> 
> When we're waiting for a cache entry to flush and the coroutine yields,
> can the previous (already checked) cache entries become dirty?

qcow2_cache_entry_mark_dirty() should only ever be called under s->lock,
so as long as you take the lock, I don't think so.

Kevin
