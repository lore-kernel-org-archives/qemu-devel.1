Received: from eggs.gnu.org ([2001:4830:134:3::10]:43919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBYK-0006qW-5i
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBYE-0000SB-6y
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:35:00 -0400
Date: Wed, 27 Sep 2017 13:34:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170927123442.GF12223@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-6-berrange@redhat.com>
	<bca76897-ec7d-035e-9473-b304b63f5d7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bca76897-ec7d-035e-9473-b304b63f5d7b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: convert crypto driver to
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

On Sat, Sep 16, 2017 at 06:54:58PM +0200, Max Reitz wrote:
> On 2017-09-12 13:28, Daniel P. Berrange wrote:
> > Make the crypto driver implement the bdrv_co_preadv|pwritev
> > callbacks, and also use bdrv_co_preadv|pwritev for I/O
> > with the protocol driver beneath.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/crypto.c | 104 +++++++++++++++++++++++++++++++--------------------------
> >  1 file changed, 56 insertions(+), 48 deletions(-)
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
> Some notes below.
> 
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 49d6d4c058..d004e9cef4 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> 
> [...]
> 
> > @@ -410,37 +414,33 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
> >          goto cleanup;
> >      }
> >  
> > -    while (remaining_sectors) {
> > -        cur_nr_sectors = remaining_sectors;
> > +    while (bytes) {
> > +        cur_bytes = bytes;
> >  
> > -        if (cur_nr_sectors > BLOCK_CRYPTO_MAX_SECTORS) {
> > -            cur_nr_sectors = BLOCK_CRYPTO_MAX_SECTORS;
> > +        if (cur_bytes > (BLOCK_CRYPTO_MAX_SECTORS * sector_size)) {
> > +            cur_bytes = BLOCK_CRYPTO_MAX_SECTORS * sector_size;
> 
> It's a bit weird that now the bounce buffer's size is now no longer
> fixed at 1 MB but variable depending on the crypto driver's block size.
> It also doesn't seem too intentional when looking at the first patch's
> commit message...
> 
> In any case, that would be an issue in the previous patch, though.  In
> general, I'm wondering whether maybe you should squash this patch into
> the previous one...  Yes, that would make the for a larger patch, but it
> wouldn't leave some not-quite-right state in between where sector_size
> is generally assumed to be equal to BDRV_SECTOR_SIZE -- which it is in
> practice, but not necessarily in theory.

In the end i'm going with this approach - just dropping the previous
patch entirely, since 99% of what it does is then removed in this
patch and the next one.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
