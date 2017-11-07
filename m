Received: from eggs.gnu.org ([2001:4830:134:3::10]:33511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eC6la-0002aY-8j
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eC6lZ-0000Ov-61
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:30:22 -0500
Date: Tue, 7 Nov 2017 17:30:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171107163010.GD4706@localhost.localdomain>
References: <20171107030236.23633-1-eblake@redhat.com>
	<20171107030236.23633-4-eblake@redhat.com>
	<4f8868da-db64-b203-130d-d3fce3bd5ba2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8868da-db64-b203-130d-d3fce3bd5ba2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] raw: Reflect read-only protocol layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

Am 07.11.2017 um 12:00 hat Paolo Bonzini geschrieben:
> On 07/11/2017 04:02, Eric Blake wrote:
> > We forbid operations like a zero-length write zero or a discard
> > at the protocol layer when it is marked read-only, but those
> > same operations were succeeding at the format layer because the
> > raw format was not reflecting the underlying read-only status
> > to the block layer, which then took short circuit paths on
> > zero-length operations.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  block/raw-format.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/block/raw-format.c b/block/raw-format.c
> > index 830243a8e4..717b8eff65 100644
> > --- a/block/raw-format.c
> > +++ b/block/raw-format.c
> > @@ -418,6 +418,12 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
> >          bs->file->bs->supported_write_flags;
> >      bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
> >          bs->file->bs->supported_zero_flags;
> > +    if (bdrv_is_read_only(bs->file->bs)) {
> > +        ret = bdrv_set_read_only(bs, true, errp);
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> > +    }
> > 
> >      if (bs->probed && !bdrv_is_read_only(bs)) {
> >          fprintf(stderr,
> > 
> 
> Kevin, perhaps this should be done straight in block.c?

No, I just discussed this with Eric on IRC, and it shouldn't be done
anywhere.

Basically, the way qemu works with read-only images is that you need to
be explicit about it and specify read-only=on. Drivers are not supposed
to magically set the read-only flag if the user didn't request it.

So what NBD needs to do is to error out if you try to open a read-write
connection to a read-only NBD server.


There's a second part, related specifically to this patch, that was a
bit surprising to me at first, but it actually makes sense. I can
successfully create a read-write raw node on top of a read-only
file-posix node:

    -blockdev driver=file,filename=/tmp/test.qcow2,node-name=proto,read-only=on
    -blockdev driver=raw,file=proto,node-name=format

This is because in this state without a user, the raw node doesn't
actually want to write to the file-posix node. However, if I add a disk:

    -device ide-hd,drive=format

That will actually request write permissions throughout the whole chain
and cause an error:

    qemu-system-x86_64: -device ide-hd,drive=format: Block node is read-only

Somewhat surprising at first, but it does make sense.

Kevin
