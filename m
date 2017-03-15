Received: from eggs.gnu.org ([2001:4830:134:3::10]:43197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coClb-00052F-B6
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coCla-0003ep-F0
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:31:19 -0400
Date: Wed, 15 Mar 2017 17:31:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170315173108.GB2701@work-vm>
References: <1489549053-31728-1-git-send-email-jemmy858585@gmail.com>
	<20170315111021.GD3088@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315111021.GD3088@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v2] migration/block: Avoid invoking
 blk_drain too frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Lidong Chen <jemmy858585@gmail.com>, qemu-devel@nongnu.org, stefanha@redhat.com, quintela@redhat.com, qemu-block@nongnu.org

* Fam Zheng (famz@redhat.com) wrote:
> On Wed, 03/15 11:37, Lidong Chen wrote:
> > Increase bmds->cur_dirty after submit io, so reduce the frequency
> > involve into blk_drain, and improve the performance obviously
> > when block migration.
> > 
> > The performance test result of this patch:
> > 
> > During the block dirty save phase, this patch improve guest os IOPS
> > from 4.0K to 9.5K. and improve the migration speed from
> > 505856 rsec/s to 855756 rsec/s.
> > 
> > Signed-off-by: Lidong Chen <jemmy858585@gmail.com>
> > ---
> >  migration/block.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/migration/block.c b/migration/block.c
> > index 6741228..7734ff7 100644
> > --- a/migration/block.c
> > +++ b/migration/block.c
> > @@ -576,6 +576,9 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
> >              }
> >  
> >              bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
> > +            sector += nr_sectors;
> > +            bmds->cur_dirty = sector;
> > +
> >              break;
> >          }
> >          sector += BDRV_SECTORS_PER_DIRTY_CHUNK;
> > -- 
> > 1.8.3.1
> > 
> 
> Nice catch above all, thank you!
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>

Are you taking that via a block pull?

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
