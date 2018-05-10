Received: from eggs.gnu.org ([2001:4830:134:3::10]:36241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGmv1-00069I-SR
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGmv1-0006Bu-75
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:51:43 -0400
Date: Thu, 10 May 2018 22:51:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180510145132.GE4492@lemon.usersys.redhat.com>
References: <20180509145815.3330-1-famz@redhat.com>
	<20180509145815.3330-4-famz@redhat.com>
	<20180510092550.GL1296@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510092550.GL1296@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 3/9] qcow2: Implement copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>

On Thu, 05/10 10:25, Stefan Hajnoczi wrote:
> On Wed, May 09, 2018 at 10:58:09PM +0800, Fam Zheng wrote:
> > +static int qcow2_co_copy_range_from(BlockDriverState *bs,
> > +                                    BdrvChild *src, uint64_t src_offset,
> > +                                    BdrvChild *dst, uint64_t dst_offset,
> > +                                    uint64_t bytes, BdrvRequestFlags flags)
> > +{
> > +    BDRVQcow2State *s = bs->opaque;
> > +    int offset_in_cluster;
> > +    int ret;
> > +    unsigned int cur_bytes; /* number of bytes in current iteration */
> > +    uint64_t cluster_offset = 0;
> > +    BdrvChild *child = NULL;
> > +
> > +    assert(!bs->encrypted);
> > +    qemu_co_mutex_lock(&s->lock);
> > +
> > +    while (bytes != 0) {
> > +
> > +        /* prepare next request */
> > +        cur_bytes = MIN(bytes, INT_MAX);
> > +
> > +        ret = qcow2_get_cluster_offset(bs, src_offset, &cur_bytes, &cluster_offset);
> > +        if (ret < 0) {
> > +            goto out;
> > +        }
> > +
> > +        offset_in_cluster = offset_into_cluster(s, src_offset);
> > +
> > +        switch (ret) {
> > +        case QCOW2_CLUSTER_UNALLOCATED:
> > +            if (bs->backing) {
> > +                child = bs->backing;
> > +            } else {
> > +                flags |= BDRV_REQ_ZERO_WRITE;
> > +            }
> > +            break;
> 
> Do we need a special case if the backing file is shorter than this
> image?

Yes, we should take the BDRV_REQ_ZERO_WRITE path if the range is fully beyond
EOF, otherwise clip cur_bytes at the backing image offset.

Fam
