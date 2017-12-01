Received: from eggs.gnu.org ([2001:4830:134:3::10]:44188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKnn6-0007Gh-AW
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKnmk-0006MJ-Bq
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:03:52 -0500
Date: Fri, 1 Dec 2017 13:24:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171201122420.GC4147@localhost.localdomain>
References: <20171129144956.11409-1-famz@redhat.com>
	<20171129172546.GG3753@localhost.localdomain>
	<20171130020359.GB16237@lemon>
	<20171130103135.GA4039@localhost.localdomain>
	<20171130143430.GA24067@lemon>
	<20171130151038.GE4039@localhost.localdomain>
	<02559c3a-0de0-df8c-4324-d326715b1f86@redhat.com>
	<20171201095120.GA11092@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201095120.GA11092@lemon>
Subject: Re: [Qemu-devel] [PATCH RFC 0/9] block: Rewrite block drain
 begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, jcody@redhat.com, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 01.12.2017 um 10:51 hat Fam Zheng geschrieben:
> On Thu, 11/30 17:04, Paolo Bonzini wrote:
> > On 30/11/2017 16:10, Kevin Wolf wrote:
> > >> Yes, I agree, but that (using CoMutex around graph change) requires
> > >> everything, especially the defer_to_main_loop_bh, runs in a coroutine
> > >> context, which is exactly what I mean by "introducing 'ubiquitous
> > >> coroutines'", because currently we don't have them.
> > > Is it hard to do, though? Instead of using a BH to switch to the main
> > > loop and outside of coroutine context, you could use aio_co_schedule()
> > > and yield, which would leave you in the main loop, but still in
> > > coroutine context.
> > 
> > Not that I think of, but just aio_co_schedule wouldn't work, because
> > "the coroutine must have yielded unless ctx is the context in which the
> > coroutine is running (i.e. the value of qemu_get_current_aio_context()
> > from the coroutine itself)".
> > 
> > So you'd have to use a bottom half that calls aio_co_schedule.  But that
> > would work.
> 
> We have QMP commands that can manupulate the graph which are all not coroutines.
> I think running QMP commands in coroutines has it merit especially regarding to
> the nested event loops.
> 
> Also the bdrv_close_all() and similar at the end of main() do draining too,
> which I'm not sure how to deal with. Maybe special case them and forget the
> draining CoMutex?

All of these cases have in common that they are the outermost layer with
respect to the block subsystem. This means that a nested event loop
there should be harmless because the callbacks called by it won't
influence callers further up in the call stack.

Kevin
