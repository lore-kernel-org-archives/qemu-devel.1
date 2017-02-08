Received: from eggs.gnu.org ([2001:4830:134:3::10]:33990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbTjN-0001vj-3y
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 10:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbTjK-0007hu-27
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 10:00:25 -0500
Date: Wed, 8 Feb 2017 23:00:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170208150008.GD22807@lemon.lan>
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-16-famz@redhat.com>
	<20d35345-34de-db04-d6d4-59a0babda81e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d35345-34de-db04-d6d4-59a0babda81e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 15/16] qcow2: Force "no other writer"
 lock on bs->file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, qemu-block@nongnu.org

On Wed, 02/08 15:33, Max Reitz wrote:
> On 23.01.2017 13:30, Fam Zheng wrote:
> > Writing to the same qcow2 file from two QEMU processes at the same time
> > will never work correctly, so disable it even when the caller specifies
> > BDRV_O_RDWR.
> > 
> > Other formats are less vulnerable because they don't have internal
> > snapshots thus qemu-img is less often misused to create live snapshot.
> 
> Hm, OK, reasonable. Also reasonable since we can just wait with those
> until we have op blockers.
> 
> Which brings me to the op blocker point. I don't know the exact
> influence Kevin's patches will have on this series, but I'd imagine they
> mostly change where the BDRV_O_SHARE_RW flag comes from or whether we
> need that flag at all. Therefore, I personally don't mind the order in
> which your series land in master.

I agree. I believe BDRV_O_SHARE_RW is replaced by op blocker primitives but I've
not checked yet. Tomorrow I'll take a look at Kevin's branch and see if it is
easy enough to softly base on top of it.

> 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/qcow2.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 96fb8a8..879361a 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -1177,6 +1177,17 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
> >          }
> >      }
> >  
> > +    if ((flags & BDRV_O_SHARE_RW) && (flags & BDRV_O_RDWR)) {
> > +        /* Shared write is never a good idea for qcow2, override it.
> > +         * XXX: Use permission propagation and masking mechanism in op blockers
> > +         * API once it's there. */
> > +        ret = bdrv_reopen(bs->file->bs, flags & ~BDRV_O_SHARE_RW, &local_err);
> > +        if (ret) {
> > +            error_propagate(errp, local_err);
> > +            goto fail;
> > +        }
> > +    }
> > +
> 
> Good in principle, but I don't think it should be at the bottom of this
> function, especially not after "Repair image if dirty". I think it would
> be good to put this right at the start of qcow2_open(), actually.

Sounds good!

Fam
