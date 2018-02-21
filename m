Received: from eggs.gnu.org ([2001:4830:134:3::10]:56519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoRfI-0002oC-M3
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoRfH-00025b-J1
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:30:20 -0500
Date: Wed, 21 Feb 2018 11:29:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180221102954.GA4196@localhost.localdomain>
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-12-kwolf@redhat.com>
	<ab90d9c1-ea99-9a21-7303-e26af2796d22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab90d9c1-ea99-9a21-7303-e26af2796d22@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/27] block: x-blockdev-create QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

Am 15.02.2018 um 20:58 hat Eric Blake geschrieben:
> On 02/08/2018 01:23 PM, Kevin Wolf wrote:
> > This adds a synchronous x-blockdev-create QMP command that can create
> > qcow2 images on a given node name.
> > 
> > We don't want to block while creating an image, so this is not the final
> > interface in all aspects, but BlockdevCreateOptionsQcow2 and
> > .bdrv_co_create() are what they actually might look like in the end. In
> > any case, this should be good enough to test whether we interpret
> > BlockdevCreateOptions as we should.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> 
> > @@ -3442,6 +3442,18 @@
> >     } }
> >   ##
> > +# @x-blockdev-create:
> > +#
> > +# Create an image format on a given node.
> > +# TODO Replace with something asynchronous (block job?)
> 
> We've learned our lesson - don't commit to the final name on an interface
> that we have not yet experimented with.
> 
> > +#
> > +# Since: 2.12
> > +##
> > +{ 'command': 'x-blockdev-create',
> > +  'data': 'BlockdevCreateOptions',
> > +  'boxed': true }
> > +
> 
> Lots of code packed in that little description ;)
> 
> 
> > +++ b/include/block/block_int.h
> > @@ -130,6 +130,8 @@ struct BlockDriver {
> >       int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
> >                             Error **errp);
> >       void (*bdrv_close)(BlockDriverState *bs);
> > +    int coroutine_fn (*bdrv_co_create)(BlockdevCreateOptions *opts,
> > +                                       Error **errp);
> 
> I know we haven't been very good in the past, but can you add a comment here
> on the contract that drivers are supposed to obey when implementing this
> callback?

Anything specific you want to see here?

Essentially the meaning of BlockdevCreateOptions depends on the driver
and is documented in the QAPI schema, how Error works is common
knowledge, and I don't see much else to explain here.

I mean, I can add something like "Creates an image. See the QAPI
documentation for BlockdevCreateOptions for details." if you think this
is useful. But is it?

> > +    /* Call callback if it exists */
> > +    if (!drv->bdrv_co_create) {
> > +        error_setg(errp, "Driver does not support blockdev-create");
> 
> Should this error message refer to 'x-blockdev-create' in the short term?

Hm, it would be more correct. On the other hand, I'm almost sure we'd
forget to rename it back when we remove the x- prefix...

Kevin
