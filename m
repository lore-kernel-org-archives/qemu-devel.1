Received: from eggs.gnu.org ([2001:4830:134:3::10]:56445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDLr9-0007f9-AF
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDLr8-00043R-Gf
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:16:59 -0400
Date: Wed, 24 May 2017 10:16:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170524021648.GF12279@lemon.lan>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-3-famz@redhat.com>
	<20170511193216.GE24584@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511193216.GE24584@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 02/16] block-backend: Add
 blk_request_perm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, 05/11 15:32, Stefan Hajnoczi wrote:
> On Wed, Apr 19, 2017 at 05:43:42PM +0800, Fam Zheng wrote:
> > This function tries to request, if not granted yet, for the given
> > permissions.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/block-backend.c          | 12 ++++++++++++
> >  include/sysemu/block-backend.h |  1 +
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/block/block-backend.c b/block/block-backend.c
> > index 7405024..6bdd9ce 100644
> > --- a/block/block-backend.c
> > +++ b/block/block-backend.c
> > @@ -629,6 +629,18 @@ void blk_resume_after_migration(Error **errp)
> >      }
> >  }
> >  
> > +int blk_request_perm(BlockBackend *blk, uint64_t perm, Error **errp)
> > +{
> > +    uint64_t blk_perm, shared_perm;
> > +
> > +    blk_get_perm(blk, &blk_perm, &shared_perm);
> > +    if ((blk_perm & perm) == perm) {
> > +        return 0;
> > +    }
> > +    blk_perm |= perm;
> > +    return blk_set_perm(blk, blk_perm, shared_perm, errp);
> > +}
> 
> I'm slightly confused about why this function is needed.  blk_set_perm()
> doesn't do quite the right thing?

Sorry for the late reply!

I think blk_set_perm() always calls bs->drv->bdrv_check_perm() even when the
required perm bits are already acquired.

Fam
