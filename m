Received: from eggs.gnu.org ([2001:4830:134:3::10]:40354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLlc3-00053T-OI
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLlc0-00066f-HS
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:28:43 -0400
Date: Thu, 24 May 2018 16:28:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180524082825.GB12594@lemon.usersys.redhat.com>
References: <20180523030436.29097-1-famz@redhat.com>
	<20180523030436.29097-3-famz@redhat.com>
	<f2c6a98f-693b-8d60-3df5-fe0056c0b712@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2c6a98f-693b-8d60-3df5-fe0056c0b712@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/10] raw: Check byte range uniformly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 05/23 13:28, Eric Blake wrote:
> On 05/22/2018 10:04 PM, Fam Zheng wrote:
> > We don't verify the request range against s->size in the I/O callbacks
> > except for raw_co_pwritev. This is wrong (especially for
> > raw_co_pwrite_zeroes and raw_co_pdiscard), so fix them.
> 
> I'd also mention ...
> 
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   block/raw-format.c | 64 +++++++++++++++++++++++++++++++++---------------------
> >   1 file changed, 39 insertions(+), 25 deletions(-)
> 
> Should this cc: qemu-stable?
> 
> Do we have iotests coverage of this?

No for both questions.

This is not reachable from the user interface. In that sense "wrong" is not
accurate in the commit message, "inconsistent" or "confusing" might be more
appropriate.

Out of range requests can only reach us if blk_set_allow_write_beyond_eof(blk,
true) was called, which can only happen when creating image, where the I/O are
all generated internally.

So there is no behavior change in this patch. But verifying and returning error
is still better than asserting, IMO, since we don't want to assert how block
layer uses the driver callbacks. I'll tweak the commit message.

> 
> > 
> > diff --git a/block/raw-format.c b/block/raw-format.c
> > index fe33693a2d..b69a0674b3 100644
> > --- a/block/raw-format.c
> > +++ b/block/raw-format.c
> > @@ -167,16 +167,37 @@ static void raw_reopen_abort(BDRVReopenState *state)
> >       state->opaque = NULL;
> >   }
> > +/* Check and adjust the offset, against 'offset' and 'size' options. */
> > +static inline int raw_adjust_offset(BlockDriverState *bs, uint64_t *offset,
> > +                                    uint64_t bytes, bool is_write)
> > +{
> > +    BDRVRawState *s = bs->opaque;
> > +
> > +    if (s->has_size && (*offset > s->size || bytes > (s->size - *offset))) {
> > +        /* There's not enough space for the write, or the read request is
> > +         * out-of-range. Don't read/write anything to prevent leaking out of
> > +         * the size specified in options. */
> > +        return is_write ? -ENOSPC : -EINVAL;;
> > +    }
> > +
> > +    if (*offset > INT64_MAX - s->offset) {
> > +        return -EINVAL;
> 
> ...that this change to a 63-bit check...
> 
> > @@ -186,23 +207,11 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
> 
> > -    if (offset > UINT64_MAX - s->offset) {
> > -        ret = -EINVAL;
> > -        goto fail;
> > -    }
> 
> ...from a previous 64-bit check is intentional.

OK!

> 
> With improved commit message, and ideally with followup commits that add
> iotest coverage,
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

Fam
