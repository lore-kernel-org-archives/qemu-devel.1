Received: from eggs.gnu.org ([2001:4830:134:3::10]:42363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fijaz-0000W9-Kh
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fijay-00029m-L3
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:58:33 -0400
Date: Thu, 26 Jul 2018 18:58:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180726165823.GJ4215@localhost.localdomain>
References: <20180726113337.23144-1-kwolf@redhat.com>
	<605ad10a-13c0-7f62-1c71-a8afe9021ee6@redhat.com>
	<20180726150655.GG4215@localhost.localdomain>
	<6cdde651-acdc-e6eb-63fc-e7efe8136710@redhat.com>
	<20180726153356.GH4215@localhost.localdomain>
	<9eb742d5-42c7-29da-b06f-e41873d1d645@redhat.com>
	<CAMRbyyvWsSTCfNaDJDFwqECsErJHc3=Z+SEaRea0rro95AwUgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRbyyvWsSTCfNaDJDFwqECsErJHc3=Z+SEaRea0rro95AwUgA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0] file-posix: Fix write_zeroes with
 unmap on block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

Am 26.07.2018 um 18:46 hat Nir Soffer geschrieben:
> On Thu, Jul 26, 2018 at 7:10 PM Eric Blake <eblake@redhat.com> wrote:
> 
> > On 07/26/2018 10:33 AM, Kevin Wolf wrote:
> >
> > >
> > > As far as I know, the comment you quoted is accurate for BLKDISCARD and
> > > BLKZEROOUT, but not for the fallocate() flags.
> > >
> >
> > I sure wish the man pages were more explicit on what guarantees each
> > flag offers.
> >
> > >> Hmm - that thread also mentions FALLOC_FL_NO_HIDE_STALE, which is a new
> > flag
> > >> not present/documented on Fedora 28. I wonder if it helps, too.
> > >>
> > >>>
> > >>> FALLOC_FL_ZERO_RANGE in contrast implements write_zeroes without unmap.
> > >>
> > >> I thought the opposite: FALLOC_FL_ZERO_RANGE guarantees that you read
> > back
> > >> 0, using whatever is most efficient under the hood (in the case of block
> > >> devices, unmapping that reliably reads back as zero is favored).
> > >
> > > See the code I quoted above, FALLOC_FL_ZERO_RANGE calls
> > > blkdev_issue_zeroout() with BLKDEV_ZERO_NOUNMAP internally.
> >
> > Having to resort to reading the kernel code to learn what the guarantees
> > are is annoying (it's nice that GPL guarantees that we CAN do that, but
> > it means the man pages could use some TLC so that we don't have to).
> > Especially since the kernel code has changed over time.
> >
> > But your paste of current kernel code is rather hard to argue against.
> 
> I don't think we should depend on undocumented kernel code.

Yes, the man page says "filesystem blocks" instead of just "blocks". If
you're in a nit-picking mood, that excludes block devices. But I think
it's pretty obvious what the intended meaning is and how it consistently
extends to block devices, and the code confirms it.

That's by far not "undocumented kernel code" in my book.

Kevin
