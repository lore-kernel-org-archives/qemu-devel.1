Received: from eggs.gnu.org ([2001:4830:134:3::10]:43076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH1P4-0008Qg-Bp
	for qemu-devel@nongnu.org; Fri, 11 May 2018 02:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH1P3-0000gD-Jc
	for qemu-devel@nongnu.org; Fri, 11 May 2018 02:19:42 -0400
Date: Fri, 11 May 2018 14:19:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180511061932.GA28054@lemon.usersys.redhat.com>
References: <20180509145815.3330-1-famz@redhat.com>
	<20180509145815.3330-3-famz@redhat.com>
	<da5810e5-805b-2d07-f63c-269a4ef3075b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5810e5-805b-2d07-f63c-269a4ef3075b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/9] raw: Implement copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 05/09 10:17, Eric Blake wrote:
> On 05/09/2018 09:58 AM, Fam Zheng wrote:
> > Just pass down to ->file.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   block/raw-format.c | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> > 
> > diff --git a/block/raw-format.c b/block/raw-format.c
> > index a378547c99..febddf00c0 100644
> > --- a/block/raw-format.c
> > +++ b/block/raw-format.c
> > @@ -482,6 +482,24 @@ static int raw_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
> >       return bdrv_probe_geometry(bs->file->bs, geo);
> >   }
> > +static int coroutine_fn raw_co_copy_range_from(BlockDriverState *bs,
> > +                                               BdrvChild *src, uint64_t src_offset,
> > +                                               BdrvChild *dst, uint64_t dst_offset,
> > +                                               uint64_t bytes, BdrvRequestFlags flags)
> > +{
> > +    return bdrv_co_copy_range_from(bs->file, src_offset, dst, dst_offset,
> > +                                   bytes, flags);
> 
> Bug - this fails to take into account s->offset, which occurs when opening a
> raw format protocol over a subset of the overall format protocol.

Good catch. I'll fix it in v4. Thanks.

Fam
