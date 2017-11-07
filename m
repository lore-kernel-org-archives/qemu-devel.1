Received: from eggs.gnu.org ([2001:4830:134:3::10]:51995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eBtaV-0007e1-MQ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eBtaU-0005Iu-Lo
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:26:03 -0500
Date: Mon, 6 Nov 2017 21:25:53 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171107022553.GB18521@localhost.localdomain>
References: <cover.1509368614.git.jcody@redhat.com>
	<e3abcb61ba8cdc2bb236368ab14a9037cbe7729b.1509368614.git.jcody@redhat.com>
	<20171103110500.GM5078@stefanha-x1.localdomain>
	<5d2d57d5-6bac-72df-362c-996a6873ec9b@openvz.org>
	<20171106202343.GA18521@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106202343.GA18521@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/3] block/parallals: Do
 not update header or truncate image when INMIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-block@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On Mon, Nov 06, 2017 at 03:23:43PM -0500, Jeff Cody wrote:
> On Fri, Nov 03, 2017 at 02:08:13PM +0300, Denis V. Lunev wrote:
> > On 11/03/2017 02:05 PM, Stefan Hajnoczi wrote:
> > > On Mon, Oct 30, 2017 at 02:10:27PM +0100, Jeff Cody wrote:
> > >> If we write or modify the image file while the QEMU run state is
> > >> INMIGRATE, then the BDRV_O_INACTIVE BDS flag is set.  This will cause
> > >> an assert, since the image is marked inactive.  Make sure we obey this
> > >> flag.
> > >>
> > >> Signed-off-by: Jeff Cody <jcody@redhat.com>
> > >> ---
> > >>  block/parallels.c | 7 ++-----
> > >>  1 file changed, 2 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/block/parallels.c b/block/parallels.c
> > >> index 2b6c6e5709..7b7a3efa1d 100644
> > >> --- a/block/parallels.c
> > >> +++ b/block/parallels.c
> > >> @@ -708,7 +708,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
> > >>          s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
> > >>      }
> > >>  
> > >> -    if (flags & BDRV_O_RDWR) {
> > >> +    if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_INACTIVE)) {
> > >>          s->header->inuse = cpu_to_le32(HEADER_INUSE_MAGIC);
> > >>          ret = parallels_update_header(bs);
> > >>          if (ret < 0) {
> > > Where do we ensure that HEADER_INUSE_MAGIC is set on the destination?
> > good point. it should be set in invalidate_cache following QCOW2 scheme.
> > Thus we should add that callback with this patch.
> > 
> 
> 
> Do we (intentionally) support migration with parallels?  I guess so, since
> it doesn't have migration blockers.

Hmm, I hit send prematurely...

Despite not having migration blockers, obviously nobody is using migration
with parallels; from v2.6.0 to now, attempting to do so causes QEMU to
assert due to the bug fixed in this patch.

Rather than implement .bdrv_invalidate_cache() in this series, I am going to
set a migration blocker in a separate patch (in this series), so that
migration is not supported.  Whenever .bdrv_invalidate_cache() is
implemented, then the blocker can be removed.

-Jeff
