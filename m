Received: from eggs.gnu.org ([2001:4830:134:3::10]:37115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDUyt-0006TL-NW
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDUyp-0005fs-2J
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50073)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dDUyo-0005eE-Qi
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:01:31 -0400
Date: Wed, 24 May 2017 20:01:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170524120047.GM3873@pxdev.xzpeter.org>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113130eucas1p1babac9d8659c10abe22ddc7d5b9526ab@eucas1p1.samsung.com>
	<1495539071-12995-8-git-send-email-a.perevalov@samsung.com>
	<20170524065736.GF3873@pxdev.xzpeter.org>
	<20170524075637.GB12925@aperevalov-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170524075637.GB12925@aperevalov-ubuntu>
Subject: Re: [Qemu-devel] [PATCH V6 07/10] migration: add bitmap for copied
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey <a.perevalov@samsung.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org, dgilbert@redhat.com

On Wed, May 24, 2017 at 10:56:37AM +0300, Alexey wrote:
> On Wed, May 24, 2017 at 02:57:36PM +0800, Peter Xu wrote:
> > On Tue, May 23, 2017 at 02:31:08PM +0300, Alexey Perevalov wrote:
> > > This patch adds ability to track down already copied
> > > pages, it's necessary for calculation vCPU block time in
> > > postcopy migration feature and maybe for restore after
> > > postcopy migration failure.
> > > 
> > > Functions which work with RAMBlock are placed into ram.c,
> > > due to TARGET_WORDS_BIGENDIAN is poisoned int postcopy-ram.c -
> > > hardware independed code.
> > > 
> > > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > > ---
> > >  include/migration/migration.h | 16 +++++++++++
> > >  migration/postcopy-ram.c      | 22 ++++++++++++---
> > >  migration/ram.c               | 63 +++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 97 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/migration/migration.h b/include/migration/migration.h
> > > index 449cb07..4e05c83 100644
> > > --- a/include/migration/migration.h
> > > +++ b/include/migration/migration.h
> > > @@ -101,6 +101,20 @@ struct MigrationIncomingState {
> > >      LoadStateEntry_Head loadvm_handlers;
> > >  
> > >      /*
> > > +     * bitmap indicates whether page copied,
> > > +     * based on ramblock offset
> > > +     * now it is using only for blocktime calculation in
> > > +     * postcopy migration, so livetime of this entry:
> > > +     * since user requested blocktime calculation,
> > > +     * till the end of postcopy migration
> > > +     * as an example it could represend following memory map
> > > +     * ___________________________________
> > > +     * |4k pages | hugepages | 4k pages
> > 
> > Can we really do this?
> 
> > 
> > The problem is AFAIU migration stream is sending pages only in target
> > page size, even for huge pages... so even for huge pages we should
> > still need per TARGET_PAGE_SIZE bitmap?
> sending maybe, but copying to userfault fd is doing in hugepage size

Yes you are right. :)

> in case of hugetlbfs memory backend.
> > 
> > (Please refer to ram_state_init() on init of RAMBlock.bmap)
> I thought to use bitmap per ramblock, but I decided to not do it,
> because of following reasons:
> 	1. There is only 4k ramblocks, for such ramblock it's not
> 	optimal

Could you explain what do you mean by "there is only 4k ramblocks"?

> 	2. copied pages bitmap - it's attribute of incoming migration,
> 	but ramblock it's general structure, although bmap it's about
> 	dirty pages of precopy migrations, hmm, but RAMBlock also
> 	contains unsentmap and it's for postcopy.

I thought you mean that copied pages are specific fields for incoming
so not suitable for RAMBlock struct? But the last sentence seems to
not support that idea... Hmm... Actually it sounds like a good idea to
me to put it into RAMBlock (but I maybe wrong).

Thanks,

-- 
Peter Xu
