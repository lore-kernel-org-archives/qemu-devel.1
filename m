Received: from eggs.gnu.org ([2001:4830:134:3::10]:33698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcl8f-0006z6-Tt
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 01:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcl8f-0005zx-03
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 01:24:37 -0400
Date: Tue, 10 Jul 2018 13:24:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180710052423.GJ17581@lemon.usersys.redhat.com>
References: <20180705073701.10558-1-famz@redhat.com>
	<20180705073701.10558-9-famz@redhat.com>
	<bc82c67c-0907-c727-e881-2f4622aa1d96@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc82c67c-0907-c727-e881-2f4622aa1d96@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 8/9] block: Fix bdrv_co_truncate overlap
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, 07/06 17:09, Eric Blake wrote:
> On 07/05/2018 02:37 AM, Fam Zheng wrote:
> > If we are growing the image and potentially using preallocation for the
> > new area, we need to make sure that no write requests are made to the
> > "preallocated" area which [@old_size, @offset), not [@offset, offset * 2
> 
> s/which/which is/
> 
> > - @old_size).
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   block/io.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> > 
> > diff --git a/block/io.c b/block/io.c
> > index d07849fa96..ed18eb0ca3 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -3070,7 +3070,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
> >       }
> >       bdrv_inc_in_flight(bs);
> > -    tracked_request_begin(&req, bs, offset, new_bytes, BDRV_TRACKED_TRUNCATE);
> > +    tracked_request_begin(&req, bs, offset - new_bytes, new_bytes,
> > +                          BDRV_TRACKED_TRUNCATE);
> 
> Is it any more legible to do s/offset - new_bytes/old_size/, since those are
> equivalent?

No they are not. offset - new_bytes is either old_size (if expanding), or
smaller than old_size (if shrinking).

Fam

> 
> >       /* If we are growing the image and potentially using preallocation for the
> >        * new area, we need to make sure that no write requests are made to it
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
