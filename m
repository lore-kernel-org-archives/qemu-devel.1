Received: from eggs.gnu.org ([2001:4830:134:3::10]:46951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dD7vY-0000j4-3i
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dD7vT-0000cu-7l
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:24:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dD7vT-0000cO-1k
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:24:31 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170522154501.GA2925@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 22 May 2017 16:45:01 +0100")
References: <CAGKXQyeuP6Oqar4R3Yuy2Y2O=Bg-=wM+wsxmaZGLt9=7fdSmmg@mail.gmail.com>
	<20170522154501.GA2925@stefanha-x1.localdomain>
Reply-To: quintela@redhat.com
Date: Tue, 23 May 2017 13:24:26 +0200
Message-ID: <87k25795p1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: ali saeedi <ali.saeedi56@gmail.com>, qemu-devel@nongnu.org, pbonzini@gapps.redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, May 22, 2017 at 06:00:12PM +0430, ali saeedi wrote:
>> does this code 'atomic_rcu_read(&migration_bitmap_rcu)->bmap' return bitmap
>> of dirty blocks or bitmap of pages?
>
> This code changed recently.  Please refer to qemu.git/master when asking
> questions on qemu-devel.
>
> I think you're asking about what is now RAMBlock->bmap.  This bitmap
> describes pages (each page is TARGET_PAGE_SIZE bytes).
>
> This comment looks outdated, I don't think it returns a byte offset:
>
> /**
>  * migration_bitmap_find_dirty: find the next dirty page from start
>  *
>  * Called with rcu_read_lock() to protect migration_bitmap
>  *
>  * Returns the byte offset within memory region of the start of a dirty page
>  *
>  * @rs: current RAM state
>  * @rb: RAMBlock where to search for dirty pages
>  * @start: page where we start the search
>  */
> static inline
> unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>                                           unsigned long start)
>
> Evidence:
>
> static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
> {
>     pss->page = migration_bitmap_find_dirty(rs, pss->block, pss->page);
>     ...
>     if ((pss->page << TARGET_PAGE_BITS) >= pss->block->used_length) {
>
> Stefan

Oops, thanks you are right.

We used to have a global dirty bitmap.  As far as I know, it has always
worked on pages.  TARGET_PAGE_SIZE to be exact.  Since 2.10 open out, we
moved to a bitmap by RAMBlock.  It used to return an absolute page
number, now it returns a page number relative to the start of the block.

Later, Juan.
