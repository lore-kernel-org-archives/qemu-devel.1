Received: from eggs.gnu.org ([2001:4830:134:3::10]:36363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcMf1-0005wc-OH
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 22:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcMey-0006Vt-IV
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 22:11:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcMey-0006U8-CV
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 22:11:48 -0400
Date: Tue, 1 Aug 2017 10:11:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170801021137.GA15697@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-2-git-send-email-peterx@redhat.com>
	<20170731163414.GB2122@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170731163414.GB2122@work-vm>
Subject: Re: [Qemu-devel] [RFC 01/29] migration: fix incorrect postcopy
 recved_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Mon, Jul 31, 2017 at 05:34:14PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > The bitmap setup during postcopy is incorrectly when the pgaes are huge
> > pages. Fix it.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/postcopy-ram.c | 2 +-
> >  migration/ram.c          | 8 ++++++++
> >  migration/ram.h          | 2 ++
> >  3 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 276ce12..952b73a 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -578,7 +578,7 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> >          ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> >      }
> >      if (!ret) {
> > -        ramblock_recv_bitmap_set(host_addr, rb);
> > +        ramblock_recv_bitmap_set_range(rb, host_addr, pagesize / getpagesize());
> 
> isn't that   pagesize / qemu_target_page_size() ?
> 
> Other than that it looks OK.

Yes, I should have fixed this before.

I guess Alexey will handle this change (along with the copied bitmap
series)?  Anyway, I'll fix it as well in my series, until Alexey post
the new version that I can rebase to.  Thanks,

-- 
Peter Xu
